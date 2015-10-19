From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add ls-files --eol-staged, --eol-worktree
Date: Sun, 18 Oct 2015 23:32:14 -0700
Message-ID: <xmqqvba39xn5.fsf@gitster.mtv.corp.google.com>
References: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de>
	<xmqq4mhoatna.fsf@gitster.mtv.corp.google.com> <56247E3F.40804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, philipoakley@iee.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 19 08:32:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo3zb-0007gC-Dw
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 08:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbbJSGcT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2015 02:32:19 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36781 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbbJSGcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 02:32:18 -0400
Received: by pacfv9 with SMTP id fv9so85344907pac.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=NVIepsGoPmwHZG8hiSYDCkb3j/jF1fEiiunplUCE+2o=;
        b=m1jrQKbW/qBESplWtgm53UOmR9G6BGRCAmCuFAge540XwI8dOZX8cUTx2nNWt7g1Zu
         kqFMVzlSQ6JV1K0ffejjdiu2Z0yyCYQa8DAzi0dfWx1OV+SDumAG0ykNm5PFcvdCxOYy
         AiYMPkovJg7EZsRefYNd0Nk55jm5XXNGNxqG1xZzBAvoE6mKNrMafP2FOY6auohmLveg
         ilSuqDhITRSdy2qHOmnMYrnZusK9tCVo6t31j7U2sddtI9oo1HGloAPQeVhShnJNXUsD
         O6QwvxSJVpE+5LQPqsKUBcEMpH2KgAzG8y1ISX3OsGutwVSWcshi6FtTAseZxW0O5TuO
         haMw==
X-Received: by 10.67.5.66 with SMTP id ck2mr32714582pad.137.1445236337705;
        Sun, 18 Oct 2015 23:32:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id qa5sm34125681pbc.70.2015.10.18.23.32.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 23:32:15 -0700 (PDT)
In-Reply-To: <56247E3F.40804@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Mon, 19 Oct 2015 07:23:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279829>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I like this idea:
>
> binary
> text
> crlf
> mixed
> lf

If you really like it, it would mean that my attempt to use Socratic
method to enlighten you why the above is not a good idea failed X-<.

> ----------------
> $ git ls-files --eol-staged -s
>  [snip]
>  100644 981f810e80008d878d6a5af1331c89dc093c5927 0       txt-lf workt=
ree.c

Does it even make sense to give --eol-worktree in this case?

> My understanding is that the eol options work togther with the existi=
ng option,
> as long as it makes sense (but see below)
>
> "git check-attr" will even report attributes for a file, that doesn't=
 even exist.

Both "ls-files -o/-i" talk about untracked paths, so that is not a
very useful and valid objection, is it?

> "git ls-files is a command which by default operates on the staged
> area, unless I mis-understand it.

It is even worse than that.  It is true that "ls-files [-s]" is
about "--cached" and there is no equivalent to show the working tree
version.  But "-t", "-d", etc. are not about the state in the index
nor the state in the working tree.  They are about the relationship
between these two states.

What the new operation wants to do, if I understand correctly, is
either check the blob contents in the working tree or in the index,
which is not a good fit with what the rest of "ls-files" does for
exactly that reason.  The inability to mix -s with --eol-worktree
is another natural consequence of this.

> I was thinking about adding "git check-eol", but didn't want to
> introduce just another command,

Between adding a new command that does one thing well and whose user
interaction is coherent with the rest of the system, and adding a
new operation mode to an existing command and makes the user
interaction of that existing command more incoherent by introducing
two variants --foo and --foo-worktree when there is no existing
option that has similar variant pair, I'd say we prefer to see a new
command.

The -z output, and --stdin input are what we would want to have for
the new command, but I do not think we want it to know -o, -x or -X.
You would instead pipe output from ls-files with these options to
the new command run with the --stdin option.
