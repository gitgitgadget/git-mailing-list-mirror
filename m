From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Add repos but not as normal files, not submodule
Date: Wed, 14 Apr 2010 15:13:08 -0500
Message-ID: <20100414201308.GA4118@progeny.tock>
References: <BFCA0C1E-FBE0-4CE6-8018-704BC5E0ACA6@gmail.com>
 <20100414093603.GA29065@progeny.tock>
 <7118B4DB-A95F-424F-87EF-035B36E578FB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Antony Stubbs <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:13:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O28xd-0005d2-S6
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525Ab0DNUNR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 16:13:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34469 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289Ab0DNUNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:13:16 -0400
Received: by pva18 with SMTP id 18so380362pva.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RI64XL2gsnxc7C9sUOvx+IyV/BG6ygDktJ0fheCLLPA=;
        b=PU9vvX0VVRlQjhDzxHDYK/SDtNMgqNh/I+hgV7vshwS2ndEhNXWgRxbhf4YebtmF+C
         K9ldV03Ga1SMl7oIZ2X0nRoChrC1L/iOXFM9TalPsQj6EX4WAVt+//E1xI00GLmbVIKo
         i/r9w4xE/C/v+daeCdM9t+QIiOKO4SlCsV2QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MatuRwE2gpceaamkn6sGHze2JwZUumQ5ZZg5z+5oa4BMDgSyshcGaD2k9lV666zZ9L
         msXmhQKATn/I9gfTYZYjl1UZGpBVqZ2UpcD4R7iPun4UWnekfPl9eZTlGqGF9Pl0U3CD
         R0hvKeNA1tmxHoZTxtMoCj3rH327oCT9FoCFU=
Received: by 10.141.90.11 with SMTP id s11mr4274900rvl.152.1271275995549;
        Wed, 14 Apr 2010 13:13:15 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h11sm264868rvm.21.2010.04.14.13.13.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 13:13:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7118B4DB-A95F-424F-87EF-035B36E578FB@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144903>

Antony Stubbs wrote:

>> I=E2=80=99d suggest
>> writing a simple script to build the test repository from scratch.
>
> Yup - will probably go down this route.

Ah, good.

>> You can also try using repositories not named .git if you are carefu=
l.
>> I don=E2=80=99t really encourage this.
>
> Didn't realize this was possible.

 ; git init foo
 ; git init --bare foo/bar.git
 ; cd foo
 ; git add bar.git

or

 ; git init foo
 ; git init foo/bar
 ; mv foo/bar/.git foo/bar.git
 ; git add bar bar.git
 ; cd bar
 ; GIT_DIR=3D$(pwd)/../bar.git git status
 ; (ln -s ../bar.git .git && git status && rm .git)

Please, don=E2=80=99t do this.  For all I know, some git command will e=
nd
up chdir()ing into bar.git and getting confused.

> Any pointers? Links?

I=E2=80=99m not aware of the relevant rules being documented anywhere. =
 How
much of the current behavior do we want to commit to continuing to
support?

Here=E2=80=99s a (very rough) start.  Thoughts?

-- 8< --
Subject: Documentation/update-index: indicate what the index can contai=
n

Based on cache.h.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-update-index.txt |   37 ++++++++++++++++++++++++++++=
++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 68dc187..3f74938 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -29,6 +29,12 @@ Modifies the index or directory cache. Each file men=
tioned is updated
 into the index and any 'unmerged' or 'needs updating' state is
 cleared.
=20
+Paths that do not represent directories, regular files, or symlinks
+are ignored (though other file types may be supported in future
+versions of git).  Files and directories named .git are ignored except
+for the sake of detecting subrepositories.  See the "Content model"
+section below for more about what the index can track.
+
 See also linkgit:git-add[1] for a more user-friendly way to do some of
 the most common operations on the index.
=20
@@ -159,6 +165,37 @@ you will need to handle the situation manually.
 	cleaner names.
 	The same applies to directories ending '/' and paths with '//'
=20
+Content model
+-------------
+Roughly speaking, the index represents the state of the working tree
+at some moment.  Each entry indicates the name of a file, its mode,
+the name of a blob or tree object representing its content (0 for a
+removed file or directory), a stage number, flags, and some lstat(2)
+information that can be used to check if the entry is up-to-date.
+
+Filenames are relative to the top level of the working tree and
+contain no empty path components or path components named ., ..,
+or .git, or symbolic link path components.
+
+Modes are based on the octal values as returned by lstat(2):
+
+. `100644` (regular file)
+. `100755` (executable)
+. `120000` (symbolic link)
+. `040000` (directory)
+. `160000` (git submodule)
+
+All other file types are either reduced to one of these five or
+ignored.
+
+See linkgit:git-read-tree(1) for a description of the stages in
+the index.  When a merge is not in progress, all entries have stage
+number 0.
+
+There are currently three boolean flags that can be set.  See
+the descriptions of the `--asumed-unchanged` and `--skip-worktree`
+options above and the `--intent-to-add` option to linkgit:git-add[1].
+
 Using --refresh
 ---------------
 '--refresh' does not calculate a new sha1 file or bring the index
--=20
1.7.1.rc1
