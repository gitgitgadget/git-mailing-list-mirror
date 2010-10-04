From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/4] Add testcases for the --detect-dir-renames
 diffcore flag.
Date: Mon, 4 Oct 2010 15:32:41 -0500
Message-ID: <20101004203241.GF6466@burratino>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <1286138529-6780-3-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 22:36:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2rm1-0005lz-Q0
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 22:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679Ab0JDUgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 16:36:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48837 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574Ab0JDUgB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 16:36:01 -0400
Received: by gye5 with SMTP id 5so1690684gye.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zYwz04jqzk3o2s4yGOdC2U72ZJZ2kutaKo7xYYnatrM=;
        b=FZW2n0A+/YWHLVn5BYRs+wGWOLWwjGnj8UAbxfYQnTuXtHuTZRpBTx5Cc9eP15l5aP
         XZ9hZ+Vm3Bz9362sdMpAYdR6pNa9sN2VgBPI1tCJmpdG+cyVrhX5uBiCMTD/wz1gZz+B
         VSKAlfVdSEFPAqTZwSRiDEjsRoKmEdakShH/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=flGje2Zn2GtSADHUldmVHn6PagiFbN4q8k8KaIRC+zNIWXbvm0XWhk2xbe8HRSbB6z
         1N3wMku1aIPq8c8fHKU7eT59u1CXm+v+yKSK5QFIELzg+WRCrANCuAJlsJ9m0EKYh7/5
         cJMlfAnBDQzZGovhjqLSv4PARwbZRhyEtr9nQ=
Received: by 10.103.134.11 with SMTP id l11mr1366347mun.65.1286224558759;
        Mon, 04 Oct 2010 13:35:58 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm2161419vcr.18.2010.10.04.13.35.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 13:35:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286138529-6780-3-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158109>

Yann Dirson wrote:

> From: Yann Dirson <ydirson@free.fr>
> Subject: Add testcases for the --detect-dir-renames diffcore flag

Probably better for the test to be squashed with the patch that adds
that option.

> --- /dev/null
> +++ b/t/t4046-diff-rename-factorize.sh
> @@ -0,0 +1,326 @@
[...]
> +test_expect_success \
> +    'commit the index.'  \
> +    'git update-ref HEAD $(echo "original empty commit" | git commit-tree $(git write-tree))'

Nit:

Now test assertions tend to be written as

	test_expect_success '...' '
		command &&
		command &&
		...
	'

The tabs to indent and opening ' at the end of the first line means
less fuss in lining things up.  Making each test assertion include its
setup means tests don't pass if something gets messed up in the setup,
and using multiline test assertions with && means there is no
confusion about what the tests were written to test.

As you mentioned, this has the unfortunate downside of messing with
syntax highlighting.  Maybe the common text editors need a new mode
for git-style test scripts?  Or maybe it would make sense to implement

	test_begin_expecting_success '...'
	...
	test_end

--- it would certainly make quoting easier.

It might make sense to compute the tree, commit, etc one at a time
instead of this long one-liner.

> +
> +mkdir a
> +echo >a/path0 'Line 1
> +Line 2
> +Line 3
> +Line 4
> +Line 5
> +Line 6
> +Line 7
> +Line 8
> +Line 9
> +Line 10
> +line 11
> +Line 12
> +Line 13
> +Line 14
> +Line 15
> +'

To avoid quoting troubles and since these are innocuous commands, it
could be nice to put this before the first test assertion.  Or even
better:

	mkdir a &&
	printf "Line %s\n" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 >a/path0 &&
	...

[...]
> +test_expect_success \
> +    'git diff-index --detect-dir-renames after directory move.' \
> +    'git diff-index --detect-dir-renames HEAD >current'
> +grep -v "^\[DBG\] " <current >current.filtered
> +cat >expected <<\EOF
> +:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
> +:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	b/path0
> +:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
> +:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/path2
> +:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	b/path3
> +EOF

Nit: although compare_diff_patch ensures the result is not dependent
on the hash function, these hard-coded hashes are still hard for a
human to read.  Could they be computed instead?

(Sorry, no thoughts about the actual content yet...)
---
diff --git a/t/t4046-diff-rename-factorize.sh b/t/t4046-diff-rename-factorize.sh
index 51b0b0b..1e7badb 100755
--- a/t/t4046-diff-rename-factorize.sh
+++ b/t/t4046-diff-rename-factorize.sh
@@ -15,312 +15,246 @@ test_description='Test rename factorization in diff engine.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-test_expect_success \
-    'commit the index.'  \
-    'git update-ref HEAD $(echo "original empty commit" | git commit-tree $(git write-tree))'
-
-mkdir a
-echo >a/path0 'Line 1
-Line 2
-Line 3
-Line 4
-Line 5
-Line 6
-Line 7
-Line 8
-Line 9
-Line 10
-line 11
-Line 12
-Line 13
-Line 14
-Line 15
+test_expect_success 'setup' '
+	zeroes=0000000000000000000000000000000000000000 &&
+
+	tree=$(git write-tree) &&
+	commit=$(echo "original empty commit" | git commit-tree $tree) &&
+	git update-ref HEAD $commit &&
+
+	mkdir a &&
+	printf "Line %s\n" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 >a/path0 &&
+	sed <a/path0 >a/path1 s/Line/Record/ &&
+	sed <a/path0 >a/path2 s/Line/Stuff/ &&
+	sed <a/path0 >a/path3 s/Line/Blurb/ &&
+
+	git update-index --add a/path* &&
+	tree=$(git write-tree) &&
+	commit=$(echo "original set of files" | git commit-tree $tree) &&
+	git update-ref HEAD $commit &&
+
+	path0_id=$(git rev-parse HEAD:a/path0) &&
+	path1_id=$(git rev-parse HEAD:a/path1) &&
+	path2_id=$(git rev-parse HEAD:a/path2) &&
+	path3_id=$(git rev-parse HEAD:a/path3) &&
+
+	: rename the directory &&
+	mv a b &&
+	git update-index --add --remove a/path0 a/path1 a/path2 a/path3 b/path*
 '
-sed <a/path0 >a/path1 s/Line/Record/
-sed <a/path0 >a/path2 s/Line/Stuff/
-sed <a/path0 >a/path3 s/Line/Blurb/
-
-test_expect_success \
-    'update-index --add file inside a directory.' \
-    'git update-index --add a/path*'
-
-test_expect_success \
-    'commit the index.'  \
-    'git update-ref HEAD $(echo "original set of files" | git commit-tree $(git write-tree))'
-
-mv a b
-test_expect_success \
-    'renamed the directory.' \
-    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 b/path*'
-
-test_expect_success \
-    'git diff-index --detect-dir-renames after directory move.' \
-    'git diff-index --detect-dir-renames HEAD >current'
-grep -v "^\[DBG\] " <current >current.filtered
-cat >expected <<\EOF
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	b/path0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/path2
-:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	b/path3
-EOF
-
-test_expect_success \
-    'validate the output for directory move.' \
-    'compare_diff_patch expected current.filtered'
-
-# now test non-100% renames
-
-echo 'Line 16' >> b/path0
-mv b/path2 b/2path
-rm b/path3
-echo anything > b/path100
-test_expect_success \
-    'edited dir contents.' \
-    'git update-index --add --remove b/* b/path2 b/path3'
-
-test_expect_success \
-    'git diff-index --detect-dir-renames after directory move and content changes.' \
-    'git diff-index --detect-dir-renames HEAD >current'
-grep -v "^\[DBG\] " <current >current.filtered
-cat >expected <<\EOF
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
-:100644 000000 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a 0000000000000000000000000000000000000000 D	a/path3
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/2path
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 4db595d12886f90e36765fc1732c17bccb836663 R093	a/path0	b/path0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
-:000000 100644 0000000000000000000000000000000000000000 1ba4650885513e62386fd3e23aeb45beeb67d3bb A	b/path100
-EOF
-
-test_expect_success \
-    'validate the output for directory move and content changes.' \
-    'compare_diff_patch expected current.filtered'
-
-git reset -q --hard
-
-# now test bulk moves that are not directory moves (get consensus before going further ?)
-
-mkdir c
-for i in 0 1 2; do cp a/path$i c/apath$i; done
-test_expect_success \
-    'add files into a new directory.' \
-    'git update-index --add c/apath*'
-
-test_expect_success \
-    'commit all this.'  \
-    'git commit -m "first set of changes"'
-
-mv c/* a/
-test_expect_success \
-    'move all of the new dir contents into a preexisting dir.' \
-    'git update-index --add --remove a/* c/apath0 c/apath1 c/apath2'
-
-test_expect_success \
-    'git diff-index --detect-dir-renames without full-dir rename.' \
-    'git diff-index --detect-dir-renames HEAD >current'
-grep -v "^\[DBG\] " <current >current.filtered
-cat >expected <<\EOF
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	c/*	a/
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	c/apath0	a/apath0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	c/apath1	a/apath1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	c/apath2	a/apath2
-EOF
-
-test_expect_failure \
-    'validate the output for bulk rename without full-dir rename.' \
-    'compare_diff_patch expected current.filtered'
-
-git reset -q --hard
-
-# now test moves to toplevel
-
-mv c/* .
-test_expect_success \
-    'move all of the new dir contents into toplevel.' \
-    'git update-index --add --remove apath* c/apath0 c/apath1 c/apath2'
-
-test_expect_success \
-    'git diff-index --detect-dir-renames files bulk-moved to toplevel.' \
-    'git diff-index --detect-dir-renames HEAD >current'
-grep -v "^\[DBG\] " <current >current.filtered
-cat >expected <<\EOF
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	c/*	./
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	c/apath0	apath0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	c/apath1	apath1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	c/apath2	apath2
-EOF
-
-test_expect_failure \
-    'validate the output for files bulk-moved to toplevel.' \
-    'compare_diff_patch expected current.filtered'
 
-git reset -q --hard
-
-# now test renaming with subdirs (does not take subdirs into account)
-
-mv c a/
-test_expect_success \
-    'move the new dir as subdir of another.' \
-    'git update-index --add --remove a/c/* c/apath0 c/apath1 c/apath2'
-
-test_expect_success \
-    'commit all this.'  \
-    'git commit -m "move as subdir"'
-
-mv a b
-echo foo >> b/c/apath0
-test_expect_success \
-    'rename the directory with some changes.' \
-    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 a/c/apath0 a/c/apath1 a/c/apath2 b/path* b/c/apath*'
-
-test_expect_success \
-    'git diff-index --detect-dir-renames on a move including a subdir.' \
-    'git diff-index --detect-dir-renames HEAD >current'
-grep -v "^\[DBG\] " <current >current.filtered
-cat >expected <<\EOF
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 00084e5ea68b5ae339b7c4b429e4a70fe25d069b R096	a/c/apath0	b/c/apath0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/c/apath1	b/c/apath1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/c/apath2	b/c/apath2
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	b/path0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/path2
-:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	b/path3
-EOF
-
-test_expect_failure \
-    'validate the output for a move including a subdir.' \
-    'compare_diff_patch expected current.filtered'
+test_expect_success 'diff-index --detect-dir-renames after directory move.' '
+	cat >expected <<-EOF &&
+	:040000 040000 $zeroes $zeroes R100	a/	b/
+	:100644 100644 $path0_id $path0_id R100	a/path0	b/path0
+	:100644 100644 $path1_id $path1_id R100	a/path1	b/path1
+	:100644 100644 $path2_id $path2_id R100	a/path2	b/path2
+	:100644 100644 $path3_id $path3_id R100	a/path3	b/path3
+	EOF
+	git diff-index --detect-dir-renames HEAD >current &&
+	grep -v "^\[DBG\] " <current >current.filtered &&
+	compare_diff_patch expected current.filtered
+'
 
-git reset -q --hard
+test_expect_success 'setup non-100% rename' '
+	echo "Line 16" >>b/path0 &&
+	mv b/path2 b/2path &&
+	rm b/path3 &&
+	echo anything >b/path100 &&
+	git update-index --add --remove b/* b/path2 b/path3
+'
 
-# now check that moving all files but not subdirs is not mistaken for dir move
+test_expect_success 'diff-index --detect-dir-renames after content changes.' '
+	path0_id2=$(git rev-parse :b/path0) &&
+	path100_id=$(git rev-parse :b/path100) &&
+	cat >expected <<-EOF &&
+	:040000 040000 $zeroes $zeroes R100	a/	b/
+	:100644 000000 $path3_id $zeroes D	a/path3
+	:100644 100644 $path2_id $path2_id R100	a/path2	b/2path
+	:100644 100644 $path0_id $path0_id2 R093	a/path0	b/path0
+	:100644 100644 $path1_id $path1_id R100	a/path1	b/path1
+	:000000 100644 $zeroes $path100_id A	b/path100
+	EOF
+	git diff-index --detect-dir-renames HEAD >current &&
+	grep -v "^\[DBG\] " <current >current.filtered &&
+	compare_diff_patch expected current.filtered
+'
 
-mkdir b
-mv a/path* b/
-test_expect_success \
-    'rename files in the directory but not subdir.' \
-    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 b/path*'
+test_expect_success 'setup bulk move that is not directory move' '
+	git reset -q --hard &&
+
+	mkdir c &&
+	(
+		for i in 0 1 2
+		do
+			cp a/path$i c/apath$i ||
+			exit
+		done
+	) &&
+	git update-index --add c/apath* &&
+	git commit -m "first set of changes" &&
+
+	mv c/* a/ &&
+	git update-index --add --remove a/* c/apath0 c/apath1 c/apath2
+'
 
-test_expect_success \
-    'git diff-index --detect-dir-renames on a move without a subdir.' \
-    'git diff-index --detect-dir-renames HEAD >current'
-grep -v "^\[DBG\] " <current >current.filtered
-cat >expected <<\EOF
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	b/path0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/path2
-:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	b/path3
-EOF
+test_expect_failure 'diff-index --detect-dir-renames without full-dir rename.' '
+	cat >expected <<-EOF &&
+	:040000 040000 $zeroes $zeroes R100	c/*	a/
+	:100644 100644 $path0_id $path0_id R100	c/apath0	a/apath0
+	:100644 100644 $path1_id $path1_id R100	c/apath1	a/apath1
+	:100644 100644 $path2_id $path2_id R100	c/apath2	a/apath2
+	EOF
+	git diff-index --detect-dir-renames HEAD >current
+	grep -v "^\[DBG\] " <current >current.filtered &&
+	compare_diff_patch expected current.filtered
+'
 
-test_expect_success \
-    'validate the output for a move without a subdir.' \
-    'compare_diff_patch expected current.filtered'
+test_expect_success 'setup bulk move to toplevel' '
+	git reset -q --hard &&
+	mv c/* . &&
+	git update-index --add --remove apath* c/apath0 c/apath1 c/apath2
+'
 
-git reset -q --hard
+test_expect_failure 'diff-index --detect-dir-renames bulk move to toplevel.' '
+	cat >expected <<-EOF &&
+	:040000 040000 $zeroes $zeroes R100	c/*	./
+	:100644 100644 $path0_id $path0_id R100	c/apath0	apath0
+	:100644 100644 $path1_id $path1_id R100	c/apath1	apath1
+	:100644 100644 $path2_id $path2_id R100	c/apath2	apath2
+	EOF
+	git diff-index --detect-dir-renames HEAD >current &&
+	grep -v "^\[DBG\] " <current >current.filtered &&
+	compare_diff_patch expected current.filtered
+'
 
-# now check that moving subdirs into one dir and files into another is not mistaken for dir move
-# (well, clearly it is ...)
+test_expect_success 'setup move including a subdir, with some content changes' '
+	git reset -q --hard &&
+	mv c a/ &&
+	git update-index --add --remove a/c/* c/apath0 c/apath1 c/apath2 &&
+	git commit -m "move as subdir" &&
 
-mv a/c b
-mv a d
-test_expect_success \
-    'rename subdir and files into different places.' \
-    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 a/c/apath0 a/c/apath1 a/c/apath2 d/path* b/apath*'
+	mv a b &&
+	echo foo >>b/c/apath0 &&
+	git update-index --add --remove a/path0 a/path1 a/path2 a/path3 \
+			a/c/apath0 a/c/apath1 a/c/apath2 b/path* b/c/apath*
+'
 
-test_expect_success \
-    'git diff-index --detect-dir-renames on a split of subdir and files into different places.' \
-    'git diff-index --detect-dir-renames HEAD >current'
-grep -v "^\[DBG\] " <current >current.filtered
-cat >expected <<\EOF
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/c/	b/
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/c/apath0	b/apath0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/c/apath1	b/apath1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/c/apath2	b/apath2
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	d/path0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	d/path1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	d/path2
-:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	d/path3
-EOF
+test_expect_failure 'diff-index --detect-dir-renames on a move including a subdir.' '
+	path0_id2=$(git rev-parse :b/c/apath0) &&
+	cat >expected <<-EOF &&
+	:040000 040000 $zeroes $zeroes R100	a/	b/
+	:100644 100644 $path0_id $path0_id2 R096	a/c/apath0	b/c/apath0
+	:100644 100644 $path1_id $path1_id R100	a/c/apath1	b/c/apath1
+	:100644 100644 $path2_id $path2_id R100	a/c/apath2	b/c/apath2
+	:100644 100644 $path0_id $path0_id R100	a/path0	b/path0
+	:100644 100644 $path1_id $path1_id R100	a/path1	b/path1
+	:100644 100644 $path2_id $path2_id R100	a/path2	b/path2
+	:100644 100644 $path3_id $path3_id R100	a/path3	b/path3
+	EOF
+	git diff-index --detect-dir-renames HEAD >current &&
+	grep -v "^\[DBG\] " <current >current.filtered &&
+	compare_diff_patch expected current.filtered
+'
 
-test_expect_failure \
-    'validate the output for a split of subdir and files into different places.' \
-    'compare_diff_patch expected current.filtered'
+test_expect_success 'setup move without a subdir' '
+	git reset -q --hard &&
+	mkdir b &&
+	mv a/path* b/ &&
+	: rename files in the directory but not subdir. &&
+	git update-index --add --remove a/path0 a/path1 a/path2 a/path3 b/path*
+'
 
-# now test moving a dir with no files but only subdirs
-# (only factorizes lowest-level directories - not a big deal, just not perfect)
+test_expect_success 'moving files but not subdirs is not mistaken for dir move' '
+	cat >expected <<-EOF &&
+	:100644 100644 $path0_id $path0_id R100	a/path0	b/path0
+	:100644 100644 $path1_id $path1_id R100	a/path1	b/path1
+	:100644 100644 $path2_id $path2_id R100	a/path2	b/path2
+	:100644 100644 $path3_id $path3_id R100	a/path3	b/path3
+	EOF
+	git diff-index --detect-dir-renames HEAD >current &&
+	grep -v "^\[DBG\] " <current >current.filtered &&
+	compare_diff_patch expected current.filtered
+'
 
-git reset -q --hard
-mkdir a/b
-mv a/path* a/b/
-test_expect_success \
-    'setup the directory with only subdirs, no direct child files.' \
-    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 a/b/path*'
-test_expect_success \
-    'commit all this.'  \
-    'git commit -m "move all toplevel files down one level"'
+test_expect_success 'setup move of files and subdirs to different places' '
+	git reset -q --hard &&
+	mv a/c b &&
+	mv a d &&
+	git update-index --add --remove a/path0 a/path1 a/path2 a/path3 \
+		a/c/apath0 a/c/apath1 a/c/apath2 d/path* b/apath*
+'
 
-test_expect_success \
-    'move this dir.'  \
-    'git mv a z'
+test_expect_failure 'moving subdirs into one dir and files into another is not mistaken for dir move' '
+	cat >expected <<-EOF &&
+	:040000 040000 $zeroes $zeroes R100	a/c/	b/
+	:100644 100644 $path0_id $path0_id R100	a/c/apath0	b/apath0
+	:100644 100644 $path1_id $path1_id R100	a/c/apath1	b/apath1
+	:100644 100644 $path2_id $path2_id R100	a/c/apath2	b/apath2
+	:100644 100644 $path0_id $path0_id R100	a/path0	d/path0
+	:100644 100644 $path1_id $path1_id R100	a/path1	d/path1
+	:100644 100644 $path2_id $path2_id R100	a/path2	d/path2
+	:100644 100644 $path3_id $path3_id R100	a/path3	d/path3
+	EOF
+	git diff-index --detect-dir-renames HEAD >current &&
+	grep -v "^\[DBG\] " <current >current.filtered &&
+	compare_diff_patch expected current.filtered
+'
 
-test_expect_success \
-    'git diff-index --detect-dir-renames with only subdirs' \
-    'git diff-index --detect-dir-renames HEAD >current'
-grep -v "^\[DBG\] " <current >current.filtered
-cat >expected <<\EOF
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	z/
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/b/	z/b/
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/c/	z/c/
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/b/path0	z/b/path0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/b/path1	z/b/path1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/b/path2	z/b/path2
-:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/b/path3	z/b/path3
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/c/apath0	z/c/apath0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/c/apath1	z/c/apath1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/c/apath2	z/c/apath2
-EOF
+test_expect_success 'setup move of dir with only subdirs' '
+	git reset -q --hard &&
+	mkdir a/b &&
+	mv a/path* a/b/ &&
+	git update-index --add --remove a/path0 a/path1 a/path2 a/path3 a/b/path* &&
+	git commit -m "move all toplevel files down one level" &&
 
-test_expect_failure \
-    'validate the output for a move with only subdirs.' \
-    'compare_diff_patch expected current.filtered'
+	git mv a z
+'
 
+test_expect_failure 'moving a dir with no files' '
+	cat >expected <<-EOF &&
+	:040000 040000 $zeroes $zeroes R100	a/	z/
+	:040000 040000 $zeroes $zeroes R100	a/b/	z/b/
+	:040000 040000 $zeroes $zeroes R100	a/c/	z/c/
+	:100644 100644 $path0_id $path0_id R100	a/b/path0	z/b/path0
+	:100644 100644 $path1_id $path1_id R100	a/b/path1	z/b/path1
+	:100644 100644 $path2_id $path2_id R100	a/b/path2	z/b/path2
+	:100644 100644 $path3_id $path3_id R100	a/b/path3	z/b/path3
+	:100644 100644 $path0_id $path0_id R100	a/c/apath0	z/c/apath0
+	:100644 100644 $path1_id $path1_id R100	a/c/apath1	z/c/apath1
+	:100644 100644 $path2_id $path2_id R100	a/c/apath2	z/c/apath2
+	EOF
+	git diff-index --detect-dir-renames HEAD >current &&
+	grep -v "^\[DBG\] " <current >current.filtered &&
+	compare_diff_patch expected current.filtered
+'
 # now test moving all files from toplevel into subdir (does not hides file moves) (needs consensus on syntax)
 # Note: this is a special case of move of a dir into one of its own subdirs, which in
 # turn is a variant of new files/dirs being added into a dir after all its contents
 # are moved away
 
-git reset -q --hard HEAD~3
+test_expect_success 'setup move from toplevel to subdir' '
+	git reset -q --hard HEAD~3 &&
+	mv a/* . &&
+	git update-index --add --remove a/path0 a/path1 a/path2 a/path3 path* &&
+	git commit -m "move all files to toplevel" &&
 
-mv a/* .
-test_expect_success \
-    'rename the directory with some changes.' \
-    'git update-index --add --remove a/path0 a/path1 a/path2 a/path3 path*'
+	mkdir z &&
+	mv path* z/ &&
+	git update-index --add --remove path0 path1 path2 path3 z/path*
+'
 
-test_expect_success \
-    'commit all this.'  \
-    'git commit -m "move all files to toplevel"'
-
-mkdir z
-mv path* z/
-test_expect_success \
-    'rename the directory with some changes.' \
-    'git update-index --add --remove path0 path1 path2 path3 z/path*'
-
-test_expect_success \
-    'git diff-index --detect-dir-renames everything from toplevel.' \
-    'git diff-index --detect-dir-renames HEAD >current'
-grep -v "^\[DBG\] " <current >current.filtered
-cat >expected <<\EOF
-:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	./*	z/
-:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	path0	z/path0
-:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	path1	z/path1
-:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	path2	z/path2
-:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	path3	z/path3
-EOF
-
-test_expect_failure \
-    'validate the output for a move of everything from toplevel.' \
-    'compare_diff_patch expected current.filtered'
+test_expect_failure '--detect-dir-renames everything from toplevel.' '
+	cat >expected <<-EOF &&
+	:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	./*	z/
+	:100644 100644 $path0_id $path0_id R100	path0	z/path0
+	:100644 100644 $path1_id $path1_id R100	path1	z/path1
+	:100644 100644 $path2_id $path2_id R100	path2	z/path2
+	:100644 100644 $path3_id $path3_id R100	path3	z/path3
+	EOF
+	git diff-index --detect-dir-renames HEAD >current &&
+	grep -v "^\[DBG\] " <current >current.filtered &&
+	compare_diff_patch expected current.filtered
+'
 
 test_done
-- 
