From: Steffen Nurpmeso <sdaoden@yandex.com>
Subject: Re: `ab | (cd cd && git apply -)' fails with v2.0.0
Date: Fri, 25 Jul 2014 12:31:51 +0200
Message-ID: <20140725113151.1k4Xqb6C%sdaoden@yandex.com>
References: <20140724142945.iERQ798d%sdaoden@yandex.com>
 <53D116B9.3050809@drmicha.warpmail.net>
 <xmqqegxaad3r.fsf@gitster.dls.corp.google.com>
 <53D1FDE2.8030309@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 12:32:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAcnU-0002kq-J9
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 12:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760128AbaGYKcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 06:32:16 -0400
Received: from forward12.mail.yandex.net ([95.108.130.94]:37893 "EHLO
	forward12.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760122AbaGYKcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2014 06:32:15 -0400
Received: from smtp14.mail.yandex.net (smtp14.mail.yandex.net [95.108.131.192])
	by forward12.mail.yandex.net (Yandex) with ESMTP id 590EDC218C9;
	Fri, 25 Jul 2014 14:31:58 +0400 (MSK)
Received: from smtp14.mail.yandex.net (localhost [127.0.0.1])
	by smtp14.mail.yandex.net (Yandex) with ESMTP id E5B6C1B610B9;
	Fri, 25 Jul 2014 14:31:57 +0400 (MSK)
Received: from unknown (unknown [89.204.155.37])
	by smtp14.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id iKdoIieDgl-Vuu4VgkT;
	Fri, 25 Jul 2014 14:31:56 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 2bc487bf-bcaf-4b4d-9b0b-c7602b4a1bfd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail; t=1406284317;
	bh=wI86/D1Gf2nfdRffLr9M54/bFo/tDvMaivOS2Mi7QQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=ZOzhflRMe0UZ6BJptDZ7VJCuAAELXxRETvgu1UIgyEgWLC3qhPBuSwkiWFHkvy6jT
	 yrOfIb0/Jiz5nrcSLXq9FsJsRSbsdZt9sGhwZBJVuWGJDqhGYxfGGDx8e/ub2tH4e0
	 53Vi9I7EYx+EVtSc7k/kkgVFhPsbi5ZB8iH8lePM=
Authentication-Results: smtp14.mail.yandex.net; dkim=pass header.i=@yandex.com
In-Reply-To: <53D1FDE2.8030309@drmicha.warpmail.net>
User-Agent: s-nail v14.7.4-3-g32d76ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254202>

Hello and good morning,

Michael J Gruber <git@drmicha.warpmail.net> wrote:
 |Junio C Hamano venit, vidit, dixit 24.07.2014 19:19:
 |> Michael J Gruber <git@drmicha.warpmail.net> writes:
 |>> Steffen Nurpmeso venit, vidit, dixit 24.07.2014 15:29:
 |>>> Hello (again, psssssst, after a long time),
 |>>>
 |>>> it happened yesterday that i needed to do
 |>>>
 |>>>   $ git diff HEAD:FILE COMMIT:SAME-FILE |
 |>>>> (cd src && git apply -) 
 |>>> ...
 |>>
 |>> Ah little more context would help. Are you diffing files in the subdir
 |>> src, or a file at the root which happens to be present in the subdir src
 |>> as well?
 |> 
 |> As the <treeish>:<path> form is not meant to produce "git apply"
 |> applicable patch in the first place, I am not sure what the OP is
 |> trying to achieve in the first place.  Not just "how many leading
 |> levels to strip?" but "which file is being modified?" does not
 |> appear in a usable form.  For example, here is what you would see:
 |> 
 |>     $ git diff HEAD:GIT-VERSION-GEN maint:GIT-VERSION-GEN
 |>     diff --git a/HEAD:GIT-VERSION-GEN b/maint:GIT-VERSION-GEN
 |>     index 40adbf7..0d1a86c 100755
 |>     --- a/HEAD:GIT-VERSION-GEN
 |>     +++ b/maint:GIT-VERSION-GEN
 |>     @@ -1,7 +1,7 @@
 |>     ...
 |> 
 |> and neither "HEAD:GIT-VERSION-GEN" nor "maint:GIT-VERSION-GEN" is
 |> the file being modified ("GIT-VERSION-GEN" is).
 |
 |I thought "git apply" knows how to strip the rev part.

That would brighten the sky of the glorious future.  Perfect!

 |> I would understand if the upstream of the pipe were
 |> 
 |>     $ git diff HEAD maint -- GIT-VERSION-GEN | ...
 |> 
 |> though.

Yes, in this case it applies the patch.

 |> Needless to say, if the place "cd" goes is not a worktree controlled
 |> by git, then "git apply" would not know where the top-level of the
 |> target tree is, so even though the input with the corrected command
 |> on the upstream side of the pipe tells it which file is being
 |> modified, it needs to be told with the proper -p<n> parameter how
 |> many leading levels to strip.
 |
 |I think it's a common mistake to think of "git apply" as some sort of
 |magic extension of "patch" which can do anything that "patch" does and
 |more, and can be fed anything that "git diff" produces", figuring out by
 |itself what to do with it :)

This was indeed my mistake.
But regardless i think the current behaviour sucks:

  ?0[steffen@sherwood x.git]$ git diff HEAD:XY 5d0d74:XY |
  > (cd src && patch -p4)
  can't find file to patch at input line 5
  Perhaps you used the wrong -p or --strip option?
  The text leading up to this was:
  ?130[steffen@sherwood x.git]$ git diff HEAD:XY 5d0d74:XY |
  > (cd src && git apply -p4)
  ?0[steffen@sherwood x.git]$

and

  ?0[steffen@sherwood groff.git]$ git diff HEAD:XY 5d0d74:XY |
  > (cd src && git apply -p2)
  ?0[steffen@sherwood groff.git]$ git diff HEAD:XY 5d0d74:XY |
  > (cd src && patch -p2)
  patching file XY
  ?0[steffen@sherwood groff.git]$ 

The number after `?' is the exit status of the last command, btw.
Ciao (and yes, thanks a lot for git(1)!)

--steffen
