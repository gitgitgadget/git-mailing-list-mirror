Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111413DDA3
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722551162; cv=none; b=NrQJAGm8zWR9vN5pXlS/Yg6P9Z40om+vCR8nsl81z2cgK2CqCe3rgjIatmkz/o1j7knB6Ek6TVSTu+weqzdmpzjdOVaJndeH9UDnRLiF25p+lvf70ay5JpmpZ0xmGJGNwqEUgO9q6E5Fs0WucTZniT53Kkr3l3HEmtxA2NE1c8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722551162; c=relaxed/simple;
	bh=NVtclRJrr/lEk3ZZyNYkLXSg3n+9x0OIv3oXR/93IgI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dkfvcf3zdV0agNQd1hXx2L6P5VPXAgt+xmtnhfwTq1ZDf/NEhVrEvzrq5AdNdArNc1VojJq1JWyrho2QHoP1Afl+5JDbAl6m1ZdpDys7a9StTeDW7EtXuhu20OqmWP2HJ54lP2vapllYTQABnS8Pz44UvpcJlDUm80ByUGIdMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471MPvdf3542753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 22:25:57 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>
Cc: <git@vger.kernel.org>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com> <ZqvgmYl8BTYvsSa0@nand.local>
In-Reply-To: <ZqvgmYl8BTYvsSa0@nand.local>
Subject: RE: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Date: Thu, 1 Aug 2024 18:25:51 -0400
Organization: Nexbridge Inc.
Message-ID: <032201dae461$c7bcc9d0$57365d70$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIp93LlMAXo5OzQ9HEGtsfRK+e3MwGmTwJBsWd0wMA=

On Thursday, August 1, 2024 3:23 PM, Taylor Blau wrote:
>On Thu, Aug 01, 2024 at 02:03:31PM -0400, rsbecker@nexbridge.com wrote:
>> Hi Team,
>>
>> I think this is low priority but would like to understand the
>> situation. It only happens on NonStop ia64 (consistently), not x86.
>>
>> The t7701.09 subtest fails missing files:
>
>Hmm. Script t7701 only has 8 sub-tests, but I think you're referring to
>t7704.9

Yes, t7704.9. Sorry.

>> Total 3 (delta 0), reused 3 (delta 0), pack-reused 0 (from 0)
>> ls: cannot access '.git/objects/pack/pack-*.mtimes': No such file or
>> directory
>> test_line_count: line count for cruft.after !=3D 2 not ok 9 -
>> --max-cruft-size with pruning
>>
>> The test directory contains:
>> ./.git/objects/pack
>> ./.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
>> =
./.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
>> ./.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.rev
>
>Interesting. Can you attach the full -vx output of this test, as well =
as a ls -la from
>$GIT_DIR/objects/pack?
>
>I suspect that this is a mtime resolution issue in whatever filesystem =
is in use in your
>ia64 environment, but the full logs will help us confirm that, or at =
least point is in a
>better direction.

Here is the output as requested, with ls following. This is using =
OpenSSL 3.0 - OpenSSL 1.0.2 is further down with slightly different =
results.

++ git init max-cruft-size-prune
Initialized empty Git repository in /home/ituglib/randall/git/t/trash =
directory.t7704-repack-cruft/max-cruft-size-prune/.git/
++ cd max-cruft-size-prune
++ test_commit base
++ local notick=3D
++ local echo=3Decho
++ local append=3D
++ local author=3D
++ local signoff=3D
++ local indir=3D
++ local tag=3Dlight
++ test 1 '!=3D' 0
++ case "$1" in
++ break
++ indir=3D
++ local file=3Dbase.t
++ test -n ''
++ echo base
++ git add -- base.t
++ test -z ''
++ test_tick
++ test -z ''
++ test_tick=3D1112911993
++ GIT_COMMITTER_DATE=3D'1112911993 -0700'
++ GIT_AUTHOR_DATE=3D'1112911993 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m base
[master (root-commit) d1ff1c9] base
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 base.t
++ case "$tag" in
++ git tag base
+++ generate_random_blob foo 1048576
+++ test-tool genrandom foo 1048576
+++ git hash-object -w -t blob blob
+++ rm blob
++ foo=3D4f336f3df31054eabc05ac05f98bc024c8e05423
+++ generate_random_blob bar 1048576
+++ test-tool genrandom bar 1048576
+++ git hash-object -w -t blob blob
+++ rm blob
++ bar=3Dbd44d8aa2d22eb47ff70cef4b0bb45d1549ee49c
+++ generate_random_blob baz 1048576
+++ test-tool genrandom baz 1048576
+++ git hash-object -w -t blob blob
+++ rm blob
++ baz=3Dad16bed54cc61cf036075879deeff95ae977514b
+++ test_oid_to_path 4f336f3df31054eabc05ac05f98bc024c8e05423
+++ local basename=3D336f3df31054eabc05ac05f98bc024c8e05423
+++ echo 4f/336f3df31054eabc05ac05f98bc024c8e05423
++ test-tool chmtime -10000 =
.git/objects/4f/336f3df31054eabc05ac05f98bc024c8e05423
++ git repack -d --cruft --max-cruft-size=3D1M
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Enumerating cruft objects: 6, done.
Counting objects: 100% (3/3), done.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
++ ls =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes =
.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.mtimes =
.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.mtimes
++ sort
+++ cat cruft.before
++ for cruft in $(cat cruft.before)
+++ test-tool chmtime --get -10000 =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes
++ mtime=3D1722540725
++ echo =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes =
1722540725
++ for cruft in $(cat cruft.before)
+++ test-tool chmtime --get -10000 =
.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.mtimes
++ mtime=3D1722540723
++ echo =
.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.mtimes =
1722540723
++ for cruft in $(cat cruft.before)
+++ test-tool chmtime --get -10000 =
.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.mtimes
++ mtime=3D1722540726
++ echo =
.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.mtimes =
1722540726
++ git repack -d --cruft --max-cruft-size=3D1M =
--cruft-expiration=3D10.seconds.ago
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 3 (delta 0), pack-reused 0 (from 0)
++ ls '.git/objects/pack/pack-*.mtimes'
++ sort
ls: cannot access '.git/objects/pack/pack-*.mtimes': No such file or =
directory
+++ cat cruft.after
++ test_line_count =3D 3 cruft.before
++ test 3 '!=3D' 3
+++ wc -l
++ test 3 =3D 3
++ test_line_count =3D 2 cruft.after
++ test 3 '!=3D' 3
+++ wc -l
++ test 0 =3D 2
++ echo 'test_line_count: line count for cruft.after !=3D 2'
test_line_count: line count for cruft.after !=3D 2
++ cat cruft.after
++ return 1
error: last command exited with $?=3D1
not ok 9 - --max-cruft-size with pruning

ls output with second resolution is here - the file system does not have =
nanosecond resolution despite showing zeros:

/home/ituglib/randall/git/t/trash =
directory.t7704-repack-cruft/max-cruft-size-prune/.git/objects/pack: ls =
-la --full-time
total 11
drwxrwxrwx 1 ITUGLIB.RANDALL ITUGLIB 4096 2024-08-01 16:18:55.000000000 =
-0600 .
drwxrwxrwx 1 ITUGLIB.RANDALL ITUGLIB 4096 2024-08-01 16:18:48.000000000 =
-0600 ..
-r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB 1156 2024-08-01 16:18:52.000000000 =
-0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
-r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB  217 2024-08-01 16:18:52.000000000 =
-0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
-r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB   64 2024-08-01 16:18:52.000000000 =
-0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.rev


When running with OpenSSL 1.0.2, the failure is different:
++ git init max-cruft-size-prune
Initialized empty Git repository in =
/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/t/trash =
directory.t7704-repack-cruft/max-cruft-size-prune/.git/
++ cd max-cruft-size-prune
++ test_commit base
++ local notick=3D
++ local echo=3Decho
++ local append=3D
++ local author=3D
++ local signoff=3D
++ local indir=3D
++ local tag=3Dlight
++ test 1 '!=3D' 0
++ case "$1" in
++ break
++ indir=3D
++ local file=3Dbase.t
++ test -n ''
++ echo base
++ git add -- base.t
++ test -z ''
++ test_tick
++ test -z ''
++ test_tick=3D1112911993
++ GIT_COMMITTER_DATE=3D'1112911993 -0700'
++ GIT_AUTHOR_DATE=3D'1112911993 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m base
[master (root-commit) d1ff1c9] base
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 base.t
++ case "$tag" in
++ git tag base
+++ generate_random_blob foo 1048576
+++ test-tool genrandom foo 1048576
+++ git hash-object -w -t blob blob
+++ rm blob
++ foo=3D4f336f3df31054eabc05ac05f98bc024c8e05423
+++ generate_random_blob bar 1048576
+++ test-tool genrandom bar 1048576
+++ git hash-object -w -t blob blob
+++ rm blob
++ bar=3Dbd44d8aa2d22eb47ff70cef4b0bb45d1549ee49c
+++ generate_random_blob baz 1048576
+++ test-tool genrandom baz 1048576
+++ git hash-object -w -t blob blob
+++ rm blob
++ baz=3Dad16bed54cc61cf036075879deeff95ae977514b
+++ test_oid_to_path 4f336f3df31054eabc05ac05f98bc024c8e05423
+++ local basename=3D336f3df31054eabc05ac05f98bc024c8e05423
+++ echo 4f/336f3df31054eabc05ac05f98bc024c8e05423
++ test-tool chmtime -10000 =
.git/objects/4f/336f3df31054eabc05ac05f98bc024c8e05423
++ git repack -d --cruft --max-cruft-size=3D1M
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Enumerating cruft objects: 6, done.
Counting objects: 100% (3/3), done.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
++ ls =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes =
.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.mtimes =
.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.mtimes
++ sort
+++ cat cruft.before
++ for cruft in $(cat cruft.before)
+++ test-tool chmtime --get -10000 =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes
++ mtime=3D1722531262
++ echo =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes =
1722531262
++ for cruft in $(cat cruft.before)
+++ test-tool chmtime --get -10000 =
.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.mtimes
++ mtime=3D1722531261
++ echo =
.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.mtimes =
1722531261
++ for cruft in $(cat cruft.before)
+++ test-tool chmtime --get -10000 =
.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.mtimes
++ mtime=3D1722531263
++ echo =
.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.mtimes =
1722531263
++ git repack -d --cruft --max-cruft-size=3D1M =
--cruft-expiration=3D10.seconds.ago
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 3 (delta 0), pack-reused 0 (from 0)
Enumerating cruft objects: 1, done.
Traversing cruft objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), done.
Total 1 (delta 0), reused 1 (delta 0), pack-reused 0 (from 0)
++ ls =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes
++ sort
+++ cat cruft.after
++ for cruft in $(cat cruft.after)
+++ grep =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes =
mtimes
+++ cut '-d ' -f2
++ old_mtime=3D1722531262
+++ test-tool chmtime --get =
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes
++ new_mtime=3D1722541267
++ test 1722531262 -lt 1722541267
++ test_line_count =3D 3 cruft.before
++ test 3 '!=3D' 3
+++ wc -l
++ test 3 =3D 3
++ test_line_count =3D 2 cruft.after
++ test 3 '!=3D' 3
+++ wc -l
++ test 1 =3D 2
++ echo 'test_line_count: line count for cruft.after !=3D 2'
test_line_count: line count for cruft.after !=3D 2
++ cat cruft.after
.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.mtimes
++ return 1
error: last command exited with $?=3D1
not ok 9 - --max-cruft-size with pruning

