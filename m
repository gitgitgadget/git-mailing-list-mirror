From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push rejected (non-fast-forward)
Date: Tue, 25 Nov 2014 11:16:41 -0800
Message-ID: <xmqqsih7rsyu.fsf@gitster.dls.corp.google.com>
References: <C2E11014-CFE8-490E-A21A-DB42CC8E4175@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: debugging data <debugging.data@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 20:16:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtLba-0002VN-OI
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 20:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbaKYTQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 14:16:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751602AbaKYTQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 14:16:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8541205F7;
	Tue, 25 Nov 2014 14:16:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=83IQBXsnjJLjxevRTY9xta8Lwxc=; b=wTTm/o
	eslXqnJv7e853OueeVljR5dE2P2JukrFFVOS41vtGDgIOWMzZO5D9XRI69R7E3XO
	VN6B9bTZBw4LViT+/V+VgPH6+zuyYsvCI1Y8Lq3cK8nwVVPuCa3O3/ZrQBzeemoQ
	M/8hWmN3CL2Vz998+NtTWXS+3i9fPtM8zgpoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uRFwHGkXrr5+Rqow4faIxyCgxR7D9s+5
	fMiIW3t4kIthX8eIii7Sp64bFqXiIXu5aT42B7IxrZWjAijbcKPpeJPrIvgTV6f8
	6M7z48irw5ucVjdcfOgG4blKtLOrfPFFNtcF4DZNxtp2Mx/8wUguPQKutrPHINgM
	YlR5DsgD618=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD47D205F6;
	Tue, 25 Nov 2014 14:16:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4070A205F5;
	Tue, 25 Nov 2014 14:16:43 -0500 (EST)
In-Reply-To: <C2E11014-CFE8-490E-A21A-DB42CC8E4175@gmail.com> (debugging
	data's message of "Tue, 25 Nov 2014 12:45:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9746B940-74D7-11E4-99A1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260237>

debugging data <debugging.data@gmail.com> writes:

> $ git push origin so-much-foo
> To git@github.com:user-two/project.git
>  ! [rejected]        so-much-foo -> so-much-foo (non-fast-forward)
> error: failed to push some refs to 'git@github.com:user-two/project.git'
> hint: Updates were rejected because the tip of your current branch is behind
> hint: its remote counterpart. Integrate the remote changes (e.g.
> hint: 'git pull ...') before pushing again.
>
>
> It doesn't look like the tip is behind though:
>
>
> /project$ git log
> commit dd240b6ba15d27d074726e9b1b0e665e3507a2fd
> Author: User Two <debugging.data+user2@gmail.com>
> ...
> Date:   Mon Nov 24 22:43:08 2014 +0000
>
>     file-one.txt with contents "file one"

I do not think anybody can say "It doesn't look like the tip is
behind" by looking only at the above.  I am assuming that you are on
your "so-much-foo" branch, but that shows only your state.  You are
not inspecting what is actually on the remote branch you are pushing
to, so...

After the failed "git push origin so-much-foo", try "git fetch
origin so-much-foo", which will make the tip of the so-much-foo
branch over there temporarily available in your FETCH_HEAD.  And
then do something like:

    $ git show-branch FETCH_HEAD so-much-foo

and see how they have diverged.  If you want to merge your work with
the updated origin, you can do

    $ git merge FETCH_HEAD

after that, or follow the hint given by the failed push, i.e.

> hint: its remote counterpart. Integrate the remote changes (e.g.
> hint: 'git pull ...') before pushing again.

and do

    $ git pull origin so-much-foo

(which by the way can be done without the "git fetch origin ..."
and "git show-branch ..." steps above).
