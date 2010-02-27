From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix compilation of test programs under MinGW
 environment
Date: Sat, 27 Feb 2010 13:31:56 -0800
Message-ID: <7vy6ietlf7.fsf@alter.siamese.dyndns.org>
References: <1267304969-1924-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 22:32:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlUGk-0002ro-AZ
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 22:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936008Ab0B0VcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 16:32:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935866Ab0B0VcE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 16:32:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D473B9DC5C;
	Sat, 27 Feb 2010 16:32:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=keQSOx1nYwNn8jT1oZeZqK9884U=; b=XqMcKk
	wy/QC4b2QISfsqI/8OMY5t46RI+pgoFuOx+vOmzZFbZf7+uE1Hmak8NM5rZljoE4
	rPlym+vfQrjZ/Ppw6qMpHVbhXf1YFDkXoCNipblybIcqoNGWzpFYLoC5044WUAN7
	Po80imSKHhPhiUmNoNnd5JVd5i/r4KLCu5xrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kiuuVsmTNOcRhdZM0sRrug8vV+tl4mVK
	UuKc2L+FXyYzWvS5D5ZG8CbESA5zhURpnwCt0qeSD+KobcEWIR47xKQeh1hZBHdI
	tSZiU/fpih5mDU9V7nXEQT8tn9UCYJLB1qWLMpuUmtNfa6UqlYm6y4KKQGIZB7Wk
	2LM5DtKII6Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B06F69DC58;
	Sat, 27 Feb 2010 16:32:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18E169DC56; Sat, 27 Feb
 2010 16:31:57 -0500 (EST)
In-Reply-To: <1267304969-1924-1-git-send-email-michael.lukashov@gmail.com>
 (Michael Lukashov's message of "Sat\, 27 Feb 2010 21\:09\:29 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A2B43B6-23E7-11DF-AD48-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141229>

Michael Lukashov <michael.lukashov@gmail.com> writes:

> Commit 225f78c8 (Merge branch 'master' of git://repo.or.cz/alt-git
> into jn/autodep, 2010-01-26) changed Makefile in such a way that
> the following error occurs when trying to compile Git under MinGW environment:
>
>   make: *** No rule to make target `test-chmtime', needed by `all'.  Stop.
>
> Under Linux it seems there's no difference between two variants.

> -TEST_PROGRAMS := $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
> +TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))

If the difference were on the RHS of this definition, which does involve
$X that is different between the two platforms, I would understand, but
your patch looks like it is addressing difference between := vs =, and
that is more like a difference of other parts of the Makefile than
difference between Linux and mingw compilation environment.

Does mingw build add other instances of TEST_PROGRAMS definition to the
Makefile, or perhaps have other means (e.g. ./build.sh runs make with
TEST_PROGRAMS set to something else) to affect it?

Or somewhere other than the main makefile, do you have an explicit "make
test-chmtime" (not "make test-chmtime.exe") that tries to make sure that
the build is done?
