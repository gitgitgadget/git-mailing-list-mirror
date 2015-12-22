From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Rebase Issue
Date: Tue, 22 Dec 2015 11:25:52 -0800
Message-ID: <xmqqwps6cmkf.fsf@gitster.mtv.corp.google.com>
References: <39E7EE9D306F544FAD3A0D16B7B7CAAD2C1E819D@mtlsvrmxwv02.A2M.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Pierre-Luc Loyer <Pierre-Luc.Loyer@bhvr.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 20:26:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBSZK-0002Uh-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 20:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbbLVTZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 14:25:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751315AbbLVTZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 14:25:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD47D35DFB;
	Tue, 22 Dec 2015 14:25:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yJaR2zgQXU37rJrqkb7Ja6Qlz0g=; b=usQfnU
	t8perlie4EMG243iCOHpXzNFjteCaMLPG1fdybXaFInYHZQSuk9Ns2s6Ehgavo+a
	oPtGx4WOM80up11/cszsex6Z/HBBhdGAByDCnsNznjz7KzFbJh7I9PbIjF2449zd
	ruqdv/pboBDzLj0NJekE+Q/pSWeC34DlNH4so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HzzRgYCXA4dw3swDR3Ioka7WLqo3Qc1J
	BaEt0ivDlkkETgx9d/WTzVaBG8ijYQcpPOe9Ac5OWkWg+z01eltp67q9H+HuyfSX
	9qS3mFnpiPcaVexbHAHJZ2KyONoEV6Ng0JI1tLgtsO99jPM9uC5zdAjmwG0tan+s
	DDv5A8bSETY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D41C335DFA;
	Tue, 22 Dec 2015 14:25:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 59B2435DF9;
	Tue, 22 Dec 2015 14:25:53 -0500 (EST)
In-Reply-To: <39E7EE9D306F544FAD3A0D16B7B7CAAD2C1E819D@mtlsvrmxwv02.A2M.com>
	(Pierre-Luc Loyer's message of "Tue, 22 Dec 2015 17:53:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1188402-A8E1-11E5-B3C9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282902>

Pierre-Luc Loyer <Pierre-Luc.Loyer@bhvr.com> writes:

> From the documentation it says that <branch> (which is HEAD) will be checked out before doing anything and that upon completion, <branch> will be the current branch. However, this doesn't seem to happen. In fact, it seems more like the following is happening during the rebase:
> 1) detach HEAD
> 2) rebase
> 3) reattach to <branch>

You do not have to say "HEAD" for "<branch>", if you are rebasing
the current branch.  Either leave it unsaid, or name the branch.

Passing "HEAD" (or any of its variants that names the exact commit
at the tip of the current branch, without using the name of the
current branch, e.g. "master^0") as the "branch to rebase" is an
advanced technique to use when you want to avoid messing with the
branch itself.  It is deliberate that the HEAD is left detached.

You'd (once you learn Git sufficently and got comfortable with
working on a detached HEAD, that is) often find yourself doing
things like this:

1. rebase temporarily on detached HEAD

    $ git rebase -i HEAD~2 HEAD ;# amend the tip two

2. double check the result and convince yourself that it is better
   than the original

    $ git diff master HEAD

    $ git log master.. >updated
    $ git log -2 master >original
    $ diff -u original updated

3-a. once satisfied, update the branch

    $ git checkout -B master

3-b. or abandon if the result is undesirable.

    $ git checkout master
