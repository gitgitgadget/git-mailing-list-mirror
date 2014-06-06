From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
Date: Fri, 06 Jun 2014 09:35:55 -0700
Message-ID: <xmqqmwdqq9lg.fsf@gitster.dls.corp.google.com>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
	<1401874256-13332-1-git-send-email-judge.packham@gmail.com>
	<xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com>
	<20140604194216.GA4636@sandbox-ub> <539020D1.1090601@gmail.com>
	<20140606055430.GC77405@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jun 06 18:36:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsx7m-0006Le-1x
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 18:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbaFFQgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 12:36:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56825 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbaFFQgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 12:36:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 34A891AF13;
	Fri,  6 Jun 2014 12:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uEjMQYIrF5PiQIY4qqXs1xb9hUA=; b=KQcT5x
	ICuV6Ls9E0xstLxZKzazX8EJr14Ytq/lzuCA2dUH0afCA6e1RZC7x2gRH6DxIvux
	uhnMx1246IeMB1FPF54o/1HwAGqJMI+HUxg6nA4YxJo14OS87G38e3vlucGojYjr
	N4eYbAFt7augq0MmLUyDCf2cl+3NJZqVOHaWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CXI1y4xjzL/KDFPLFZFgO4Z4DfPjlnZf
	pRg7swRDr7eiggeQBQDapUBKhTEd1T2xBT/vU76wvow9doPuf7uvqQZOrTsp5QkD
	XHnljt1F0TIj+/7OQfWzRocU98s1PiDYMhKltuzXdUY8MyVIzffG7WnqFGpoczWu
	rhQPScUrcds=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B5641AF12;
	Fri,  6 Jun 2014 12:36:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A61341AF0E;
	Fri,  6 Jun 2014 12:35:57 -0400 (EDT)
In-Reply-To: <20140606055430.GC77405@book.hvoigt.net> (Heiko Voigt's message
	of "Fri, 6 Jun 2014 07:54:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A302EA2C-ED98-11E3-AAC0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250947>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Thu, Jun 05, 2014 at 07:48:33PM +1200, Chris Packham wrote:
> ...
>> I'm a little confused at how autoclone and autoinit differ. Aren't they
>> the same? i.e. when this module appears grab it by default. I see
>> autoupdate as a little different meaning update it if it's been
>> initialised. Also does autoinit imply autoupdate?
>
> autoclone is about cloning the history of submodules. So e.g. when a
> submodule first appears in the superprojects history whether it should
> automatically be cloned to .git/modules.
>
> autoinit is all about the checkout phase. When a commit with a new
> submodule is checked out: Should that new submodule be automatically
> initialised?
>
> As far as autoupdate is concerned: Maybe autoinit can imply that it is
> enabled, yes. But I guess we still need autoupdate for the case of big
> submodules that cause to much performance trouble if updated by every
> checkout.

> So its actually three values: autoclone, autoinit, autoupdate. Damn,
> these configurations become more complicated everytime.

I suspect that as an end-user you do not need to set all three in
most cases.  Just like an unspecified autoupdate can default to
whatever autoinit setting for the submodule is, because it is less
likely that a user wants to have a submodule checked out *and* leave
it stale, an unspecified autoinit can default to the autoclone
setting, because it is less likely that a user who does not want to
have a checkout would want to spend network bandwidth to clone it.
