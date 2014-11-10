From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sun, 9 Nov 2014 18:46:01 -0800
Message-ID: <CAO2U3Qh4w8aeMBVMJrVqmBwEVoobpQ=5BraEwENzfymyn=ezow@mail.gmail.com>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
 <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com>
 <545FC8D1.1040803@web.de> <CAO2U3QgpyxqmDWmN7v8W742hNpj-kzhuFEJjO6mZrSRHK9jvoA@mail.gmail.com>
 <545FDFDF.7070102@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 03:46:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnezs-0005du-8j
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 03:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbaKJCqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 21:46:22 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:38192 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbaKJCqV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 21:46:21 -0500
Received: by mail-oi0-f44.google.com with SMTP id h136so4820095oig.3
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 18:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=w6DltzopKtvexdrHp/Bt4zC/zxP02AGAYW4KeeGUciY=;
        b=Ta9M+zkZtGVMWbMV4R0ZEKNbauxj27S7hkGISTN2UdZGfEYT6pt64QJUZWCLfzgt2m
         HkcsW/9UtiHUYIMtT0pXlRN8Asr/OG1wUSm52lqJp61Jqp76oAZcBaOhCVnQ9zivO1Gc
         6sUGxTCS6chtKkKRPZiwQq8uEoZdbu/NRMtAyaNywPQutpuvCM/ZaQlqPi0+we5aMzyp
         2PqyYUEss/mIZv+WXHTx5BgoAa6nOx4/DagPukPgYgmBANTvxOE9X4Y/at0Y4FoOot10
         bH1lwTS4FqvxoRQPArEjb5ycqsj7KWb059vwnK2e0Mb4TngZcbkaEVgAUIbLOi/BdEbP
         axNQ==
X-Received: by 10.60.173.39 with SMTP id bh7mr24627205oec.32.1415587581304;
 Sun, 09 Nov 2014 18:46:21 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Sun, 9 Nov 2014 18:46:01 -0800 (PST)
In-Reply-To: <545FDFDF.7070102@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, with that I have a different test failure on the pu branch --
please tell me if I'm spamming the list or if there's some other
protocol I should be using to report issues on pu.

$ ./t4213-log-remerge-diff.sh -v
Initialized empty Git repository in
/Users/michael.blume/workspace/git/t/trash
directory.t4213-log-remerge-diff/.git/
expecting success:
test_commit A file original &&
test_commit B file change &&
git checkout -b side A &&
test_commit C file side &&
git checkout -b delete A &&
git rm file &&
test_commit D &&
git checkout -b benign master &&
test_must_fail git merge C &&
test_commit M1 file merged &&
git checkout -b evil B &&
test_must_fail git merge C &&
test_commit M2 file change &&
git checkout -b dm C &&
test_must_fail git merge D &&
test_commit M3 file resolved &&
git checkout -b unrelated A &&
test_commit unrelated_file &&
git merge C &&
test_tick &&
git tag M4 &&
git checkout -b dir A &&
mkdir sub &&
test_commit dir sub/file &&
git checkout -b file A &&
test_commit file sub &&
git checkout -b dirfile tags/dir &&
test_must_fail git merge tags/file &&
git rm --cached sub &&
test_commit M5 sub/file resolved &&
git checkout -b filedir tags/file &&
test_must_fail git merge tags/dir &&
git rm --cached sub/file &&
rm -rf sub &&
test_commit M6 sub resolved &&
git branch -D master side delete dir file

[master (root-commit) aca07f6] A
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file
[master a3cd1bc] B
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
Switched to a new branch 'side'
[side 61d2ae1] C
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
Switched to a new branch 'delete'
rm 'file'
[delete 63d1471] D
 Author: A U Thor <author@example.com>
 2 files changed, 1 insertion(+), 1 deletion(-)
 create mode 100644 D.t
 delete mode 100644 file
Switched to a new branch 'benign'
Merging:
a3cd1bc B
virtual C
found 1 common ancestor:
aca07f6 A
Auto-merging file
CONFLICT (content): Merge conflict in file
Automatic merge failed; fix conflicts and then commit the result.
[benign 19968bc] M1
 Author: A U Thor <author@example.com>
Switched to a new branch 'evil'
Merging:
a3cd1bc B
virtual C
found 1 common ancestor:
aca07f6 A
Auto-merging file
CONFLICT (content): Merge conflict in file
Automatic merge failed; fix conflicts and then commit the result.
[evil 93e9c1d] M2
 Author: A U Thor <author@example.com>
Switched to a new branch 'dm'
Merging:
61d2ae1 C
virtual D
found 1 common ancestor:
aca07f6 A
CONFLICT (modify/delete): file deleted in D and modified in HEAD.
Version HEAD of file left in tree.
Automatic merge failed; fix conflicts and then commit the result.
[dm 35c618f] M3
 Author: A U Thor <author@example.com>
Switched to a new branch 'unrelated'
[unrelated c19dbae] unrelated_file
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 unrelated_file.t
Merging:
c19dbae unrelated_file
virtual C
found 1 common ancestor:
aca07f6 A
Merge made by the 'recursive' strategy.
 file | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
Switched to a new branch 'dir'
[dir 8ac24b8] dir
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 sub/file
Switched to a new branch 'file'
[file 36416b6] file
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 sub
Switched to a new branch 'dirfile'
Merging:
8ac24b8 dir
virtual tags/file
found 1 common ancestor:
aca07f6 A
Adding sub/file
CONFLICT (directory/file): There is a directory with name sub in HEAD.
Adding sub as sub~tags_file
Automatic merge failed; fix conflicts and then commit the result.
sub: needs merge
rm 'sub'
[dirfile f0a64c3] M5
 Author: A U Thor <author@example.com>
Switched to a new branch 'filedir'
Merging:
36416b6 file
virtual tags/dir
found 1 common ancestor:
aca07f6 A
Adding sub/file
Removing sub to make room for subdirectory

CONFLICT (file/directory): There is a directory with name sub in
tags/dir. Adding sub as sub~HEAD
Automatic merge failed; fix conflicts and then commit the result.
rm 'sub/file'
[filedir 7182a02] M6
 Author: A U Thor <author@example.com>
Deleted branch master (was a3cd1bc).
Deleted branch side (was 61d2ae1).
Deleted branch delete (was 63d1471).
Deleted branch dir (was 8ac24b8).
Deleted branch file (was 36416b6).
ok 1 - setup

expecting success:
git log -p --cc unrelated >expected &&
git log -p --remerge-diff unrelated >actual &&
test_cmp expected actual

ok 2 - unrelated merge: without conflicts

expecting success:
git log -1 -p --remerge-diff benign >output &&
clean_output <output >actual &&
test_cmp expected actual

--- expected 2014-11-10 02:43:34.000000000 +0000
+++ actual 2014-11-10 02:43:34.000000000 +0000
@@ -1,12 +1,12 @@
 commit benign
-Merge:
+Merge: a3cd1bc 61d2ae1
 Author: A U Thor <author@example.com>
-Date:
+Date:   Thu Apr 7 15:17:13 2005 -0700

     M1

 diff --git a/file b/file
-index
+index cc073fb..20b117f 100644
 --- a/file
 +++ b/file
 @@ -1,5 +1 @@
not ok 3 - benign merge: conflicts resolved
#
# git log -1 -p --remerge-diff benign >output &&
# clean_output <output >actual &&
# test_cmp expected actual
#

expecting success:
git log -1 --remerge-diff -p evil >output &&
clean_output <output >actual &&
test_cmp expected actual

--- expected 2014-11-10 02:43:34.000000000 +0000
+++ actual 2014-11-10 02:43:34.000000000 +0000
@@ -1,12 +1,12 @@
 commit evil
-Merge:
+Merge: a3cd1bc 61d2ae1
 Author: A U Thor <author@example.com>
-Date:
+Date:   Thu Apr 7 15:18:13 2005 -0700

     M2

 diff --git a/file b/file
-index
+index cc073fb..0835e4f 100644
 --- a/file
 +++ b/file
 @@ -1,5 +1 @@
not ok 4 - evil merge: changes ignored
#
# git log -1 --remerge-diff -p evil >output &&
# clean_output <output >actual &&
# test_cmp expected actual
#

expecting success:
git log -1 --remerge-diff -p dm >output &&
clean_output <output >actual &&
test_cmp expected actual

--- expected 2014-11-10 02:43:34.000000000 +0000
+++ actual 2014-11-10 02:43:34.000000000 +0000
@@ -1,12 +1,12 @@
 commit dm
-Merge:
+Merge: 61d2ae1 63d1471
 Author: A U Thor <author@example.com>
-Date:
+Date:   Thu Apr 7 15:19:13 2005 -0700

     M3

 diff --git a/file b/file
-index
+index dd79d22..2ab19ae 100644
 --- a/file
 +++ b/file
 @@ -1,4 +1 @@
not ok 5 - delete/modify conflict
#
# git log -1 --remerge-diff -p dm >output &&
# clean_output <output >actual &&
# test_cmp expected actual
#

expecting success:
git log -1 --remerge-diff -p dirfile >output &&
clean_output <output >actual &&
test_cmp expected actual

--- expected 2014-11-10 02:43:35.000000000 +0000
+++ actual 2014-11-10 02:43:35.000000000 +0000
@@ -1,12 +1,12 @@
 commit dirfile
-Merge:
+Merge: 8ac24b8 36416b6
 Author: A U Thor <author@example.com>
-Date:
+Date:   Thu Apr 7 15:24:13 2005 -0700

     M5

 diff --git a/sub/file b/sub/file
-index
+index 0d2ecd7..2ab19ae 100644
 --- a/sub/file
 +++ b/sub/file
 @@ -1 +1 @@
@@ -14,7 +14,7 @@
 +resolved
 diff --git a/sub~tags/file b/sub~tags/file
 deleted file mode 100644
-index
+index f73f309..0000000
 --- a/sub~tags/file
 +++ /dev/null
 @@ -1 +0,0 @@
not ok 6 - file/directory conflict resulting in directory
#
# git log -1 --remerge-diff -p dirfile >output &&
# clean_output <output >actual &&
# test_cmp expected actual
#

checking known breakage:
git log -1 --remerge-diff -p filedir >output &&
clean_output <output >actual &&
test_cmp expected actual

--- expected 2014-11-10 02:43:35.000000000 +0000
+++ actual 2014-11-10 02:43:35.000000000 +0000
@@ -1,21 +1,28 @@
 commit filedir
-Merge:
+Merge: 36416b6 8ac24b8
 Author: A U Thor <author@example.com>
-Date:
+Date:   Thu Apr 7 15:25:13 2005 -0700

     M6

 diff --git a/sub b/sub
-index
---- a/sub
+new file mode 100644
+index 0000000..2ab19ae
+--- /dev/null
 +++ b/sub
-@@ -1 +1 @@
--file
+@@ -0,0 +1 @@
 +resolved
 diff --git a/sub/file b/sub/file
 deleted file mode 100644
-index
+index 0d2ecd7..0000000
 --- a/sub/file
 +++ /dev/null
 @@ -1 +0,0 @@
 -dir
+diff --git a/sub~tags/file b/sub~tags/file
+deleted file mode 100644
+index f73f309..0000000
+--- a/sub~tags/file
++++ /dev/null
+@@ -1 +0,0 @@
+-file
not ok 7 - file/directory conflict resulting in file # TODO known break=
age

# still have 1 known breakage(s)
# failed 4 among remaining 6 test(s)
1..7

On Sun, Nov 9, 2014 at 1:42 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 2014-11-09 22.36, Michael Blume wrote:
>> Actually I have a build break in pu on my mac right now. Seems to
>> build fine in ubuntu, but:
>>
>> progress.c:66:15: error: use of undeclared identifier 'CLOCK_MONOTON=
IC'
>>         timer_create(CLOCK_MONOTONIC, &sev, &progress_timer);
> That is not an unkown issue.
> You need to revert one commit (this is my copy of pu from today)
>
>  Revert "use timer_settime() for new platforms"
>
>  This reverts commit 0950f08806208b4e3d0aff5f4f7d497637ba4cab.
>
