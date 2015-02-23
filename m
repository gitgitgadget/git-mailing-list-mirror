From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Salvaging borked project history
Date: Mon, 23 Feb 2015 11:36:21 -0800
Message-ID: <xmqq7fv8to7e.fsf@gitster.dls.corp.google.com>
References: <54EB5DD7.7050202@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Mason <slash.tmp@free.fr>
X-From: git-owner@vger.kernel.org Mon Feb 23 20:36:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPyoD-0000UW-KH
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 20:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076AbbBWTgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 14:36:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753057AbbBWTge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 14:36:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DA3039A12;
	Mon, 23 Feb 2015 14:36:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cZrAFn592lZY1Un6EePo26L+w4s=; b=RpfgsJ
	9g6aisOaMeYMVeTZ6OxAzeMOT6/OypbKALiBKWcvsXkbf8j7afsNX4fwVQFtZ9l2
	fPPAD/y9qyMYSQR3+QM9FR4gFezVIE554CcxZkIYlYHKn/6XwRmg03ZoUH6GL9iR
	U8UfS4hM60CN8ADBgNsMtFxY2iOUXnd6FKDLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dq0MqFmUCZuOO0OdZpGsLUr5wpRxqsFE
	cjp6obGYXXtZvdmXF0GI2HSM0qBpwWHPDCmNz5/desfOmp61HC1Is3c3Ku5MUl6j
	Xl4MpopaZLh+/K8TDQSevmwzN55KEpsn1uS4JXa+jcZM4LGOeVpt4joh8Ajdmf08
	faRp0xcFlus=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1310C39A11;
	Mon, 23 Feb 2015 14:36:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC5D739A08;
	Mon, 23 Feb 2015 14:36:23 -0500 (EST)
In-Reply-To: <54EB5DD7.7050202@free.fr> (Mason's message of "Mon, 23 Feb 2015
	18:05:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 400DB892-BB93-11E4-BF83-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264290>

Mason <slash.tmp@free.fr> writes:

> But 'git am' just gave up. Small sample of errors:
>
> error: patch failed: drivers/block/Kconfig:411
> error: drivers/block/Kconfig: patch does not apply
> error: drivers/tty/serial/8250/8250.c: does not exist in index
> error: patch failed: drivers/tty/serial/8250/8250_early.c:121
> error: drivers/tty/serial/8250/8250_early.c: patch does not apply
> error: patch failed: drivers/video/Kconfig:101
> error: drivers/video/Kconfig: patch does not apply
> ...
> Patch failed at 0001 Commit for supporting Sigma Designs' SoCs.
> The copy of the patch that failed is found in:
>    .git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> How do I "resolve this problem".

You look at .git/rebase-apply/patch and drivers/block/Kconfig in
your editor, and edit the former to make it apply (i.e. adjust the
common context lines that begin with SP and preimage lines that
begin with '-' to match what you see in the drivers/block/Kconfig
where the change wants to go).  You do so for all the other files.

And then run "git am" again without any argument, until the patch
applies.

One way to "edit .git/rebase-apply/patch and make it apply" that is
often necessary when you are applying to codebase that is way more
ahead than where you took the original patches is to hand-edit the
working tree files (e.g. drivers/block/Kconfig) that the patch wants
to touch and change it in the way the patch wants to, while viewing
the original .git/rebase-apply/patch in your pager (you do not
directly edit this original patch---you only use it as a guide to
discern what the patch wants to do).  Once the working tree files
are in a state that the patch would have wanted to make if it were
taken based on the new codebase, overwrite .git/rebase-apply/patch
with the output from "git diff HEAD".  After that (i.e. you have
"edited" .git/rebase-apply/patch, with the help with your editor,
the working tree files and "git diff"), do "git reset --hard".

Which brings you to the same state just after "git am" gave up and
you correctly edited ".git/rebase-apply/patch:" to make it apply.

So you run "git am" again without any argument.  This time the patch
would apply and continue.

But I personally think "git am -3" may be easier to handle.
