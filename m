From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] rebase -i: drop, missing commits and static checks
Date: Tue, 30 Jun 2015 09:16:22 -0700
Message-ID: <xmqq7fql8949.fsf@gitster.dls.corp.google.com>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
	<1849903896.89424.1435676774069.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	antoine delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	sunshine@sunshineco.com
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:16:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9yD0-00082D-FY
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 18:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbF3QQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 12:16:26 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36641 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbF3QQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 12:16:25 -0400
Received: by igrv9 with SMTP id v9so54957583igr.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=vN59B/znnNEWYNthMJRu/dTGhDaeNmUpd3Dh2EqfAq8=;
        b=I567x/m5OoAzThdREghA0RKXXPhMMd/ObHqDDOmLhCjMX4t+LJa2y5Vs8WY4oicJLX
         XTd0kbDCbyLF6bLx74SWUWHvpS/DC2m3PRkKXwSU4uwvfb1MmylVEjJqyFuewLCjveQY
         Rf3hcPtwhj2G3HQ7vbbwv/Gsa5uBA3QVciuCbCEcAMEstGnQPboNtO0X/fjGgf7V7aHv
         pjL2AlrfWo4TBxjO5e8FZ5jkE6WjH3GHYwzGOv9V/6SGwrldhe6ltpVxDoCAIJJl5Obl
         c4EqCibb/bL9q0WRbNrHbnQmRoTDeNUaz+zxm/rGmyU0tuHjL+e0B6O52klrEcBcaGwR
         Va0A==
X-Received: by 10.43.178.195 with SMTP id ox3mr28737758icc.10.1435680984295;
        Tue, 30 Jun 2015 09:16:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id j3sm8036162ige.0.2015.06.30.09.16.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 09:16:23 -0700 (PDT)
In-Reply-To: <1849903896.89424.1435676774069.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Tue, 30 Jun 2015 17:06:14 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273078>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>> Shouldn't all the checking also be called in a 'rebase --continue',
>> considering that it can be called after a 'rebase --edit-todo' ?
>> (Right now it is only called after closing the editor in 'rebase -i'=
)
>
> What's your opinion on it?
>
> Short example:
>
> 'git rebase -i HEAD~2'
> 	pick commit_sha_1 commit_msg_1
> 	tick commit_sha_2 commit_msg_2
> An error is raised before anything is done.
> 'git rebase --edit-todo'
> 	pick commit_sha_1 commit_msg_1
> 	tick commit_sha_2 commit_msg_2
> (nothing changed)
> 'git rebase --continue'
> An error is raised after having picked the first commit.
>
> The same is relevent with bad sha and missing commits (in fact even
> more relevant with missing commits since that would be silent loss of
> information).

The place where an error can be introduced is (assuming that what
"rebase -i" writes out itself is perfect ;-) where we allow the user
to edit, so instead of checking before "--continue", I would expect
a sane design would check immediately after the editor we spawned
returns.

The codepath that allows the insn sheet getting edited and the
codepath that handles --edit-todo have to do many things the same
way (i.e. use collapse_todo_ids to prepare the file for editing,
spawn the editor, receive the result and use expand_todo_ids to
prepare the file to be used by us), and I would have expected for
these two to be using a single helper---and a sanity check like the
above can and should be done when we receive the result from the
editor, immediately before running expand_todo_ids perhaps.

If they are not using such a single helper right now, perhaps that
is the preliminary restructuring of the code that is needed?
