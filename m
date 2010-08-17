From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] commit: add parse_commit_repl() to replace
 commits at parsing time
Date: Tue, 17 Aug 2010 14:18:39 -0700
Message-ID: <7vbp91aqfk.fsf@alter.siamese.dyndns.org>
References: <20100817015901.5592.25471.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 23:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlTYe-0007zx-0W
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 23:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863Ab0HQVSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 17:18:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab0HQVSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 17:18:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C21CE753;
	Tue, 17 Aug 2010 17:18:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9zjWpdbDYzrm/ulEAIyUDPbOMcI=; b=UK5Q4R
	FQpAyvyChUs2Axr/VEoXCtDQ4lVB1YRr/SCWbfpWudKBrCk70s4CdE0QkgzoUdgo
	k25Q1RBaiy0BKyFsnfVwBO7EPPHkUaTZbmOGjcIECdlHkk5RV9s1rvm/bbIPXJVj
	9SKGzbEldxmZsYh9cVAbi0QSZP2XJTtQnxiJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FDaQZmL9jEOJeuu7fQZ+07N9u4YpFaAa
	1S8ElXINV+AkyllTMNRuK1PZVWHMYnRJXf3YiSm3QgvbuniosPYF5PmA1TtviEOG
	MyEgGlT5ztyqsDitbuXprUKzzAIjemWKKdy6hpCsTkQon/YGNIHHgT3qnUPFn7qP
	PUUBV1hWE64=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 810A6CE752;
	Tue, 17 Aug 2010 17:18:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8995CE751; Tue, 17 Aug
 2010 17:18:41 -0400 (EDT)
In-Reply-To: <20100817015901.5592.25471.chriscool@tuxfamily.org> (Christian
 Couder's message of "Tue\, 17 Aug 2010 03\:58\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 04D49CC8-AA45-11DF-8584-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153779>

Christian Couder <chriscool@tuxfamily.org> writes:

> The function parse_commit() is not safe regarding replaced commits
> because it uses the buffer of the replacement commit but the object
> part of the commit struct stay the same. Especially the sha1 is not
> changed so it doesn't match the content of the commit.

This all sounds backwards to me, if I am reading the discussion correctly.

If a replace record says commit 0123 is replaced by commit 4567 (iow, 0123
was a mistake, and pretend that its content is what is recorded in 4567),
and when we are honoring the replace records (iow, we are not fsck),
shouldn't read_sha1("0123") give us a piece of memory that stores what is
recorded in 4567, parse_object("0123") return a struct commit whose buffer
points at a block of memory that has what is recorded in 4567 _while_ its
object.sha1[] say "0123"?

What problem are you trying to solve?
