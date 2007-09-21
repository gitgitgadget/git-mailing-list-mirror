From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Fri, 21 Sep 2007 16:52:52 -0700
Message-ID: <7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
References: <20070921214346.GF97288@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Sat Sep 22 01:53:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYsIx-0000RD-Fn
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 01:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758512AbXIUXw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 19:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757838AbXIUXw6
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 19:52:58 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758454AbXIUXw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 19:52:57 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 183C0139979;
	Fri, 21 Sep 2007 19:53:16 -0400 (EDT)
In-Reply-To: <20070921214346.GF97288@void.codelabs.ru> (Eygene Ryabinkin's
	message of "Sat, 22 Sep 2007 01:43:46 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58894>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Good day.
>
> I had found that FreeBSD's /bin/sh refuses to work with git 1.5.3.2.
> correctly: no flags are recognized.  The details and fix are below.
> I don't currently know if the Bash's behaviour is POSIXly correct
> or the 'case' statement semantics is not very well defined.   But
> the following patch fixes the things for the FreeBSD.
>
> Here we go.
>
> -----
>
> Option parsing in the Git shell scripts uses the construct 'while
> case "$#" in 0) break ;; esac; do ... done'.  This is neat, because
> it needs no external commands invocation.  But in the case when
> /bin/sh is not GNU Bash (for example, on FreeBSD) this cycle will
> not be executed at all.

I do not doubt that "while case $# in 0) break ;; esac" does not
work for your shell.  But I think the above comment is grossly
misleading.

Don't mention bash there.  You sound as if you are blaming
bashism, but the thing is, your shell is simply broken.

You have other choices than bash on BSD don't you?

My quick test shows that ksh, pdksh and dash seem to work
correctly.  This idiom is what I picked up around late 80's from
somebody, and kept using on many variants of Unices.  I would
find quite surprising that something that claims to be a shell
does not work correctly.  Even /bin/sh that comes with Solaris
seems to work correctly, which should tell you something.

OpenBSD's /bin/sh seems to be Ok; I do not know whose shell they
use, but it seems to be hard-linked to /bin/ksh which is pdksh.
