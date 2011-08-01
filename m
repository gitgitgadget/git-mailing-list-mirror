From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Mon, 1 Aug 2011 12:21:47 +0700
Message-ID: <CACsJy8DZ8WW0g-3Cmobft8FtfciYrGYA+eqA4ogkX9BktukWZg@mail.gmail.com>
References: <4E362F8E.1050105@gmail.com> <CACsJy8CdfRCssfrMVOjRn2a_=vZPLyG_uEd4fS2WxzQXKZGn3w@mail.gmail.com>
 <4E36321E.2040409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 07:22:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnkxR-00038O-2R
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 07:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab1HAFWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 01:22:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55657 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1HAFWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 01:22:18 -0400
Received: by fxh19 with SMTP id 19so4190084fxh.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YRuVvTQoMdVwp4Qhb+8BKORnTgR0ol1UnQomsDfUFfo=;
        b=BxGzgRb17e0mpn6uriFdhMxmbaBjB//IE4/Neycmge5tcgXPXQg5Vg1nTNbuT4JBNr
         OmYKr4L7LI0/Ki/4lRDk/U78/IsCPeZGrKdRPncJXoqYRYzt1onRkLnMEZTK2dm7a+d2
         74ZQLQsEuD5JzYQ42vBhCxHwrrjgs87wVM1W0=
Received: by 10.204.141.75 with SMTP id l11mr1087980bku.209.1312176137161;
 Sun, 31 Jul 2011 22:22:17 -0700 (PDT)
Received: by 10.204.52.77 with HTTP; Sun, 31 Jul 2011 22:21:47 -0700 (PDT)
In-Reply-To: <4E36321E.2040409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178321>

On Mon, Aug 1, 2011 at 11:57 AM, Jon Forrest <nobozo@gmail.com> wrote:
> On 7/31/2011 9:50 PM, Nguyen Thai Ngoc Duy wrote:
>
>> Are you sure this does not break any tests? t3508.2 for example
>> hardcodes "1 insertions" and does textual compare. I have not run the
>> tests but I suspect it will fail.
>
> I ran the tests. The only result in red that I saw that
> didn't appear to be caused "by breakage" was
>
> not ok - 3 mktemp to unwritable directory prints filename
>
> Since I didn't do anything relating to mktemp I thought
> this was probably bogus.
>
> I'm new to this so I don't know how to find the t3508.2.
> If you can give me a hint I'd be glad to look at this in
> more detail.

Your patch is line-wrapped. Please see
Documentation/SubmittingPatches, it may help.

I manually applied your patch and run t3508 alone. t3508.2 is the
second test in t3502, by the way. t/README gives more information on
tests of git.

pclouds@do ~/w/git/t $ ./t3508-cherry-pick-many-commits.sh  -v
Initialized empty Git repository in /home/pclouds/w/git/t/trash
directory.t3508-cherry-pick-many-commits/.git/
expecting success:
	echo first > file1 &&
	git add file1 &&
	test_tick &&
	git commit -m "first" &&
	git tag first &&

	git checkout -b other &&
	for val in second third fourth
	do
		echo $val >> file1 &&
		git add file1 &&
		test_tick &&
		git commit -m "$val" &&
		git tag $val
	done

[master (root-commit) 0c72e4f] first
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
 create mode 100644 file1
[other 453a047] second
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
[other e85abe2] third
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
[other 94d3184] fourth
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
ok 1 - setup

expecting success:
	cat <<-\EOF >expected &&
	[master OBJID] second
	 Author: A U Thor <author@example.com>
	 1 files changed, 1 insertions(+), 0 deletions(-)
	[master OBJID] third
	 Author: A U Thor <author@example.com>
	 1 files changed, 1 insertions(+), 0 deletions(-)
	[master OBJID] fourth
	 Author: A U Thor <author@example.com>
	 1 files changed, 1 insertions(+), 0 deletions(-)
	EOF

	git checkout -f master &&
	git reset --hard first &&
	test_tick &&
	git cherry-pick first..fourth >actual &&
	git diff --quiet other &&
	git diff --quiet HEAD other &&

	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
	test_cmp expected actual.fuzzy &&
	check_head_differs_from fourth

HEAD is now at 0c72e4f first
--- expected	2011-08-01 05:13:03.000000000 +0000
+++ actual.fuzzy	2011-08-01 05:13:04.000000000 +0000
@@ -1,9 +1,9 @@
 [master OBJID] second
  Author: A U Thor <author@example.com>
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+), 0 deletions(-)
 [master OBJID] third
  Author: A U Thor <author@example.com>
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+), 0 deletions(-)
 [master OBJID] fourth
  Author: A U Thor <author@example.com>
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+), 0 deletions(-)
not ok - 2 cherry-pick first..fourth works
#	
#		cat <<-\EOF >expected &&
#		[master OBJID] second
#		 Author: A U Thor <author@example.com>
#		 1 files changed, 1 insertions(+), 0 deletions(-)
#		[master OBJID] third
#		 Author: A U Thor <author@example.com>
#		 1 files changed, 1 insertions(+), 0 deletions(-)
#		[master OBJID] fourth
#		 Author: A U Thor <author@example.com>
#		 1 files changed, 1 insertions(+), 0 deletions(-)
#		EOF
#	
#		git checkout -f master &&
#		git reset --hard first &&
#		test_tick &&
#		git cherry-pick first..fourth >actual &&
#		git diff --quiet other &&
#		git diff --quiet HEAD other &&
#	
#		sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
#		test_cmp expected actual.fuzzy &&
#		check_head_differs_from fourth
#	

expecting success:
	cat <<-\EOF >expected &&
	Trying simple merge.
	[master OBJID] second
	 Author: A U Thor <author@example.com>
	 1 files changed, 1 insertions(+), 0 deletions(-)
	Trying simple merge.
	[master OBJID] third
	 Author: A U Thor <author@example.com>
	 1 files changed, 1 insertions(+), 0 deletions(-)
	Trying simple merge.
	[master OBJID] fourth
	 Author: A U Thor <author@example.com>
	 1 files changed, 1 insertions(+), 0 deletions(-)
	EOF

	git checkout -f master &&
	git reset --hard first &&
	test_tick &&
	git cherry-pick --strategy resolve first..fourth >actual &&
	git diff --quiet other &&
	git diff --quiet HEAD other &&
	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
	test_cmp expected actual.fuzzy &&
	check_head_differs_from fourth

HEAD is now at 0c72e4f first
--- expected	2011-08-01 05:13:04.000000000 +0000
+++ actual.fuzzy	2011-08-01 05:13:04.000000000 +0000
@@ -1,12 +1,12 @@
 Trying simple merge.
 [master OBJID] second
  Author: A U Thor <author@example.com>
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+), 0 deletions(-)
 Trying simple merge.
 [master OBJID] third
  Author: A U Thor <author@example.com>
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+), 0 deletions(-)
 Trying simple merge.
 [master OBJID] fourth
  Author: A U Thor <author@example.com>
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+), 0 deletions(-)
not ok - 3 cherry-pick --strategy resolve first..fourth works
#	
#		cat <<-\EOF >expected &&
#		Trying simple merge.
#		[master OBJID] second
#		 Author: A U Thor <author@example.com>
#		 1 files changed, 1 insertions(+), 0 deletions(-)
#		Trying simple merge.
#		[master OBJID] third
#		 Author: A U Thor <author@example.com>
#		 1 files changed, 1 insertions(+), 0 deletions(-)
#		Trying simple merge.
#		[master OBJID] fourth
#		 Author: A U Thor <author@example.com>
#		 1 files changed, 1 insertions(+), 0 deletions(-)
#		EOF
#	
#		git checkout -f master &&
#		git reset --hard first &&
#		test_tick &&
#		git cherry-pick --strategy resolve first..fourth >actual &&
#		git diff --quiet other &&
#		git diff --quiet HEAD other &&
#		sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
#		test_cmp expected actual.fuzzy &&
#		check_head_differs_from fourth
#	

expecting success:
	git checkout -f master &&
	git reset --hard first &&
	test_tick &&
	git cherry-pick --ff first..fourth &&
	git diff --quiet other &&
	git diff --quiet HEAD other &&
	check_head_equals fourth

HEAD is now at 0c72e4f first
ok 4 - cherry-pick --ff first..fourth works

expecting success:
	git checkout -f master &&
	git reset --hard first &&
	test_tick &&
	git cherry-pick -n first..fourth &&
	git diff --quiet other &&
	git diff --cached --quiet other &&
	git diff --quiet HEAD first

HEAD is now at 0c72e4f first
ok 5 - cherry-pick -n first..fourth works

expecting success:
	git checkout -f master &&
	git reset --hard fourth &&
	test_tick &&
	git revert first..fourth &&
	git diff --quiet first &&
	git diff --cached --quiet first &&
	git diff --quiet HEAD first

HEAD is now at 94d3184 fourth
[master c20509a] Revert "fourth"
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 1 deletion(-)
[master 5c15a57] Revert "third"
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 1 deletion(-)
[master 76d1a2e] Revert "second"
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 1 deletion(-)
ok 6 - revert first..fourth works

expecting success:
	git checkout -f master &&
	git reset --hard fourth &&
	test_tick &&
	git revert ^first fourth &&
	git diff --quiet first &&
	git diff --cached --quiet first &&
	git diff --quiet HEAD first

HEAD is now at 94d3184 fourth
[master aa52aa6] Revert "fourth"
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 1 deletion(-)
[master 7128690] Revert "third"
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 1 deletion(-)
[master 2b0bc01] Revert "second"
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 1 deletion(-)
ok 7 - revert ^first fourth works

expecting success:
	git checkout -f master &&
	git reset --hard fourth &&
	test_tick &&
	git revert fourth fourth~1 fourth~2 &&
	git diff --quiet first &&
	git diff --cached --quiet first &&
	git diff --quiet HEAD first

HEAD is now at 94d3184 fourth
[master e7406a3] Revert "fourth"
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 1 deletion(-)
[master 0039f72] Revert "third"
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 1 deletion(-)
[master 6fceae4] Revert "second"
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 1 deletion(-)
ok 8 - revert fourth fourth~1 fourth~2 works

expecting success:
	git checkout -f master &&
	git reset --hard first &&
	test_tick &&
	git cherry-pick -3 fourth &&
	git diff --quiet other &&
	git diff --quiet HEAD other &&
	check_head_differs_from fourth

HEAD is now at 0c72e4f first
[master de54420] second
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
[master 5fbc3d8] third
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
[master 0f9850f] fourth
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
ok 9 - cherry-pick -3 fourth works

expecting success:
	git checkout -f master &&
	git reset --hard first &&
	test_tick &&
	git rev-list --reverse first..fourth | git cherry-pick --stdin &&
	git diff --quiet other &&
	git diff --quiet HEAD other &&
	check_head_differs_from fourth

HEAD is now at 0c72e4f first
[master 058f589] second
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
[master 013cb83] third
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
[master 79f9008] fourth
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 0 deletions(-)
ok 10 - cherry-pick --stdin works

# failed 2 among 10 test(s)
1..10

-- 
Duy
