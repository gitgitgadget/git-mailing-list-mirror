From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] worktree: stop supporting moving worktrees manually
Date: Mon, 28 Dec 2015 01:22:06 -0500
Message-ID: <20151228062206.GA4621@flurp.local>
References: <xmqqmvuudfk6.fsf@gitster.mtv.corp.google.com>
 <1451187796-31138-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	peff@peff.net, rappazzo@gmail.com, kyle@kyleam.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 07:23:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDRCr-0000f8-TC
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 07:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbbL1GWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2015 01:22:19 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:33461 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbbL1GWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 01:22:18 -0500
Received: by mail-io0-f169.google.com with SMTP id q21so13500893iod.0
        for <git@vger.kernel.org>; Sun, 27 Dec 2015 22:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gydVuhmwg1RSLt+P/wN/i4fQMErNylYwmt01V7Emipc=;
        b=kKLiSWS+njmC0rJMkcMf5spYop/MBkp6kg3FG1MPS8zFkRIxOgGQuFWvPF0KRdkWjg
         o23Nj1E2rJPBPgoD4dxs+UK/30qmPC40R0zK2f9c/1NBYIEGNAWxDzleOpEQvS1VHTBR
         pIrfidpfflQf/BB6uVRE6JvnB9eKuxf+T6ZCjPw/QWUNWLP9nnNI9hebkJYIKD62PPUZ
         PRzdr7wBBC+ri15eXLep80mFzDoDG+KsoyeAq3PXbju2n5b8ehzFnXcUIz6TRykL5G0C
         KlKwS7zJ/goz4rf6yQVF86x27GJnZumnG6F+eWe27zMl8iemdloMu6mPCP31Hup6hnVh
         yK1g==
X-Received: by 10.107.40.200 with SMTP id o191mr53480289ioo.160.1451283737930;
        Sun, 27 Dec 2015 22:22:17 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id z15sm19323725igg.20.2015.12.27.22.22.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Dec 2015 22:22:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1451187796-31138-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283029>

On Sun, Dec 27, 2015 at 10:43:16AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> The current update_linked_gitdir() has a bug that can create "gitdir"
> file in non-multi-worktree setup. Instead of fixing this, we step bac=
k a
> bit. The original design was probably not well thought out. For now, =
if
> the user manually moves a worktree, they have to fix up "gitdir" file
> manually or the worktree will get pruned. In future, we probably will
> add "git worktree mv" to support this use case.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-workt=
ree.txt
> @@ -33,10 +33,8 @@ The working tree's administrative files in the rep=
ository (see
>  If you move a linked working tree to another file system, or
> -within a file system that does not support hard links, you need to r=
un
> -at least one git command inside the linked working tree
> -(e.g. `git status`) in order to update its administrative files in t=
he
> -repository so that they do not get automatically pruned.
> +within a file system that does not support hard links, you need to u=
pdate

Hmm, is this "hard links" feature implemented? If not, then this
documentation is a bit outdated.

> +$GIT_DIR/worktrees/<id>/gitdir so that they do not get automatically=
 pruned.

=46ollowing the example of af189b4 (Documentation/git-worktree: split
technical info from general description, 2015-07-06), it might be a
good idea to keep this high-level overview free of such low-level
details and instead mention $GIT_DIR/worktrees/<id>/gitdir in the
"DETAILS" section.

Perhaps something like this, on top of your patch (assuming that the
"hard links" feature is not implemented):

--- 8< ---
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 4814f48..62c76c1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -32,9 +32,9 @@ The working tree's administrative files in the reposi=
tory (see
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
=20
-If you move a linked working tree to another file system, or
-within a file system that does not support hard links, you need to upd=
ate
-$GIT_DIR/worktrees/<id>/gitdir so that they do not get automatically p=
runed.
+If you move a linked working tree, you need to manually update the
+administrative files so that they do not get pruned automatically. See
+section "DETAILS" for more information.
=20
 If a linked working tree is stored on a portable device or network sha=
re
 which is not always mounted, you can prevent its administrative files =
from
@@ -135,6 +135,13 @@ thumb is do not make any assumption about whether =
a path belongs to
 $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
=20
+If you move a linked working tree, you need to update the 'gitdir' fil=
e
+in the entry's directory. For example, if a linked working tree is mov=
ed
+to `/newpath/test-next` and its `.git` file points to
+`/path/main/.git/worktrees/test-next`, then update
+`/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/te=
st-next`
+instead.
+
 To prevent a $GIT_DIR/worktrees entry from being pruned (which
 can be useful in some situations, such as when the
 entry's working tree is stored on a portable device), add a file named
--- 8< ---
