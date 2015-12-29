From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] worktree: stop supporting moving worktrees manually
Date: Tue, 29 Dec 2015 20:55:54 +0700
Message-ID: <CACsJy8ALc32ptP20_Mm+XDRXR6+b=Lam4saV77Kfrr1-3rHjfw@mail.gmail.com>
References: <xmqqmvuudfk6.fsf@gitster.mtv.corp.google.com> <1451187796-31138-1-git-send-email-pclouds@gmail.com>
 <20151228062206.GA4621@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Mike Rappazzo <rappazzo@gmail.com>,
	kyle@kyleam.com
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 14:56:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDulM-0002Hj-KO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 14:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbbL2N42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 08:56:28 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:32986 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbbL2N4Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2015 08:56:25 -0500
Received: by mail-lf0-f50.google.com with SMTP id p203so214635648lfa.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1TwVD8Ox/QW8Jx3+P3VspBaclfJ0CKdTcDJNLtH5dBI=;
        b=VpST6EXrRywkbEcOQnSq/JHska6GpHWvDnbZBXvUu+GOeqz/snoe0D1aw2BMAy8Wyg
         edqUq0d/gKbEUdEz+JcZhIHigVqu0N44dH4Ii1rAF+VNnqi/z5qJeiNehQ+q2wyBFNL/
         55MP8kpntt/QYvoH3aJ+vQ3h5QxAmeL/Y1qqQTfOkHniOOORmxj46vMnA62Nf+b/Y2nO
         9UsA5eu03YCrMREvNYdBf/i5j/aVIsY/ACwxPPa4OuC5MuG8oS4+lcTskBgzzC+WlwD+
         soWWXQ9hNT72/k+9kel7+ozaXiMFjSKrjGzzsx0unoWPQBEjc3Z7JYvSsVfVe+vD63ix
         Fn+Q==
X-Received: by 10.25.43.212 with SMTP id r203mr15269010lfr.162.1451397383679;
 Tue, 29 Dec 2015 05:56:23 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 29 Dec 2015 05:55:54 -0800 (PST)
In-Reply-To: <20151228062206.GA4621@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283131>

On Mon, Dec 28, 2015 at 1:22 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Sun, Dec 27, 2015 at 10:43:16AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> The current update_linked_gitdir() has a bug that can create "gitdir=
"
>> file in non-multi-worktree setup. Instead of fixing this, we step ba=
ck a
>> bit. The original design was probably not well thought out. For now,=
 if
>> the user manually moves a worktree, they have to fix up "gitdir" fil=
e
>> manually or the worktree will get pruned. In future, we probably wil=
l
>> add "git worktree mv" to support this use case.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-work=
tree.txt
>> @@ -33,10 +33,8 @@ The working tree's administrative files in the re=
pository (see
>>  If you move a linked working tree to another file system, or
>> -within a file system that does not support hard links, you need to =
run
>> -at least one git command inside the linked working tree
>> -(e.g. `git status`) in order to update its administrative files in =
the
>> -repository so that they do not get automatically pruned.
>> +within a file system that does not support hard links, you need to =
update
>
> Hmm, is this "hard links" feature implemented? If not, then this
> documentation is a bit outdated.

The prune logic is there. But this hard link is not created by
'worktree add'. I think calling link() was done at some point but then
it got dropped. Ah found it, it wasn't a big "no" so maybe we can
revive it at some point.

http://article.gmane.org/gmane.comp.version-control.git/243475

>> +$GIT_DIR/worktrees/<id>/gitdir so that they do not get automaticall=
y pruned.
>
> Following the example of af189b4 (Documentation/git-worktree: split
> technical info from general description, 2015-07-06), it might be a
> good idea to keep this high-level overview free of such low-level
> details and instead mention $GIT_DIR/worktrees/<id>/gitdir in the
> "DETAILS" section.
>
> Perhaps something like this, on top of your patch (assuming that the
> "hard links" feature is not implemented):

Looks good.

How about something like this at the end of the last new paragraph?
"alternatively if your file system supports hard link and the worktree
and $GIT_DIR are on the same file system, you can create a hard link
named "link" back to the .git file. See gitrepository-layout.txt for
more information".

>
> --- 8< ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-workt=
ree.txt
> index 4814f48..62c76c1 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -32,9 +32,9 @@ The working tree's administrative files in the repo=
sitory (see
>  `git worktree prune` in the main or any linked working tree to
>  clean up any stale administrative files.
>
> -If you move a linked working tree to another file system, or
> -within a file system that does not support hard links, you need to u=
pdate
> -$GIT_DIR/worktrees/<id>/gitdir so that they do not get automatically=
 pruned.
> +If you move a linked working tree, you need to manually update the
> +administrative files so that they do not get pruned automatically. S=
ee
> +section "DETAILS" for more information.
>
>  If a linked working tree is stored on a portable device or network s=
hare
>  which is not always mounted, you can prevent its administrative file=
s from
> @@ -135,6 +135,13 @@ thumb is do not make any assumption about whethe=
r a path belongs to
>  $GIT_DIR or $GIT_COMMON_DIR when you need to directly access somethi=
ng
>  inside $GIT_DIR. Use `git rev-parse --git-path` to get the final pat=
h.
>
> +If you move a linked working tree, you need to update the 'gitdir' f=
ile
> +in the entry's directory. For example, if a linked working tree is m=
oved
> +to `/newpath/test-next` and its `.git` file points to
> +`/path/main/.git/worktrees/test-next`, then update
> +`/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/=
test-next`
> +instead.
> +
>  To prevent a $GIT_DIR/worktrees entry from being pruned (which
>  can be useful in some situations, such as when the
>  entry's working tree is stored on a portable device), add a file nam=
ed
> --- 8< ---



--=20
Duy
