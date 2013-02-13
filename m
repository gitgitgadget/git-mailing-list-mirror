From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: don't run rm without any files
Date: Wed, 13 Feb 2013 12:01:14 -0800
Message-ID: <7vehgk6l11.fsf@alter.siamese.dyndns.org>
References: <1360771068-505-1-git-send-email-kraai@ftbfs.org>
 <7vtxpg9mxq.fsf@alter.siamese.dyndns.org> <20130213170028.GA410@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 21:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5iWT-00022y-CC
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 21:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720Ab3BMUBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 15:01:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756093Ab3BMUBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 15:01:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DC7EC024;
	Wed, 13 Feb 2013 15:01:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JenO7MYRhYKFjQYiE8zEAaFWmEg=; b=P3qcCA
	wJrPsL6MdNv7Rh2AteqkCAqbFi7ooR10zkg0RpYKXvFblUosCphuTCgAMGaSRbaz
	dIPHGeTCGxSy8U6HegkNRipEklaQo1cj1w+u7Jh6csMKibyG7LVQIdn/TGWUtsVh
	pmgOcWgLG1l7RrUR4k+lKpxaYR0+fR/jz7Lgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ruDSqkxStLNin1gng2qdZhWJMhuure1U
	ZA8obhH8aA1PRYn3ZYf4jih3YVtrff52yr5Fa3jng4qRKBuoICfotCkQ7pRTJs+9
	c6haBka5Oj1rI28xMLF1RORuI8y9zyulWg64yWpfihQNl8yPmmckNt4uZN+tA2fu
	IJXwIuqXuSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7272CC022;
	Wed, 13 Feb 2013 15:01:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB562C01F; Wed, 13 Feb 2013
 15:01:15 -0500 (EST)
In-Reply-To: <20130213170028.GA410@ftbfs.org> (Matt Kraai's message of "Wed,
 13 Feb 2013 09:00:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FBE9C72-7618-11E2-922B-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216281>

Matt Kraai <kraai@ftbfs.org> writes:

> I don't set COMPUTE_HEADER_DEPENDENCIES, so it defaults to "auto".
> The automatic detection determines that the compiler doesn't support
> it, so it's then set to "no".  CHECK_HEADER_DEPENDENCIES isn't set
> either, so about 20 lines below the dep_dirs assignment you quoted,
> dep_dirs is cleared:
>
>  ifneq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
>  ifndef CHECK_HEADER_DEPENDENCIES
>  dep_dirs =
>  ...
>
> Should I submit an updated patch with a different commit message?

I amended the log message like so:

commit bd9df384b16077337fffe9836c9255976b0e7b91
Author: Matt Kraai <matt.kraai@amo.abbott.com>
Date:   Wed Feb 13 07:57:48 2013 -0800

    Makefile: don't run rm without any files
    
    When COMPUTE_HEADER_DEPENDENCIES is set to "auto" and the compiler
    does not support it, $(dep_dirs) becomes empty.  "make clean" runs
    "rm -rf $(dep_dirs)", which fails in such a case.
    
    Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
