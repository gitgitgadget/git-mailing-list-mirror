Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0034B697
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763552090; cv=none; b=QOnPv0ni9eu8KBtGG84VE9YWJqbVsF7JEUOsOxhJON5yaHPx+BjkKsn3g/nEjB/OlMlKWKxwpKvuA2CajdSUXMpId8QIXb4+aWJCMqbeY9rLOqtLTJoU2QlzbMJBiYnnTRtjKFKpO5X9WaHhnnxc/tZRMM2Qpk7f6kCMJd3lPsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763552090; c=relaxed/simple;
	bh=t6bT3fqhZIPkAna9G3n1WGIyjC1JaFXTOppP4J1lehM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iFtvT1xf/akmB1Hz8ChdMFufgd3+U1NAZhYFJf8ddFkGTWjZBU6+cBeiFGqTC4j6IhX3b5tRxirj+DbtU0aG7XxPK7pTgtVoVf0GMDEac0VLbZ8PZKZ1ZsPF4GB9YzM28k7+2m0yvmc3POvRoqlvwbKiCBOIapAyOeMJLWVm2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gRJ5YreA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gRJ5YreA"
Received: from [192.168.9.110] (157-131-184-197.fiber.dynamic.sonic.net [157.131.184.197])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AJBYQK9000473
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 19 Nov 2025 06:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763552070; bh=R3b/BGcm9d5i4oqnR4UWJ3nF0pkdt8hNgcitBU0f800=;
	h=Message-ID:Date:MIME-Version:Subject:From:Content-Type;
	b=gRJ5YreATXGBjcLUYTmlmgu3fypv5ekEmLUX+JrjtnS5UaCsmAE+UY1+kLW3Yzs50
	 xc7YVGy2l4PsM2rvr08m3HJssQSxXoFXKtaxa+Jh676m8pEi+0driCwDRNLQiqWxXV
	 4+50fVcd1i8MzGgn167KShbQB6dZGtC4mexQ0r2UcR1IyJijnRUTbRNPOYDW5FNZsQ
	 kYt/yr+6m7tDR16fJHDTp+1HaZeJ+UwldXxxB88kcgXmJuu06m2f/Kh0oXQaPLLCHr
	 MhbORaSgkVuEEmlZ/32SUGNh1Idzlhjpwyj8x8BFuEuRyLIyir4m27IB0LUwX1gSfu
	 0AY9eak9XMvCA==
Message-ID: <4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu>
Date: Wed, 19 Nov 2025 03:34:26 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: t8020-last-modified.sh failure on s390x (Re: [PATCH v4]
 last-modified: implement faster algorithm)
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
References: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
 <20251103154726.26592-1-toon@iotcl.com>
Content-Language: en-US
From: "Anders Kaseorg" <andersk@mit.edu>
In-Reply-To: <20251103154726.26592-1-toon@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

t8020-last-modified.sh is broken on the s390x platform in v2.52.0. 
Bisection implicates commit 2a04e8c293766a4976ceceb4c663dd2963e0339e 
“last-modified: implement faster algorithm” [1].

$ uname -m
s390x

$ ./t8020-last-modified.sh
ok 1 - setup
ok 2 - cannot run last-modified on two trees
ok 3 - last-modified non-recursive
ok 4 - last-modified recursive
ok 5 - last-modified recursive with show-trees
ok 6 - last-modified non-recursive with show-trees
ok 7 - last-modified subdir
ok 8 - last-modified subdir recursive
ok 9 - last-modified from non-HEAD commit
ok 10 - last-modified from subdir defaults to root
ok 11 - last-modified from subdir uses relative pathspecs
ok 12 - limit last-modified traversal by count
ok 13 - limit last-modified traversal by commit
ok 14 - only last-modified files in the current tree
ok 15 - subdirectory modified via merge
not ok 16 - cross merge boundaries in blaming
#	
#		git checkout HEAD^0 &&
#		git rm -rf . &&
#		test_commit m1 &&
#		git checkout HEAD^ &&
#		git rm -rf . &&
#		test_commit m2 &&
#		git merge m1 &&
#		check_last_modified <<-\EOF
#		m2 m2.t
#		m1 m1.t
#		EOF
#	
ok 17 - last-modified merge for resolved conflicts
ok 18 - last-modified merge ignores content from branch
not ok 19 - last-modified merge undoes changes
#	
#		git checkout HEAD^0 &&
#		git rm -rf . &&
#		test_commit b1 file A &&
#		test_commit b2 file B &&
#		test_commit b3 file C &&
#		test_commit b4 file D &&
#		git checkout b2 &&
#		test_commit b5 file2 2 &&
#		git checkout b4 &&
#		git merge --no-commit --no-ff b5 &&
#		git checkout b2 -- file &&
#		git merge --continue &&
#		check_last_modified <<-\EOF
#		b5 file2
#		b2 file
#		EOF
#	
ok 20 - last-modified complains about unknown arguments
# failed 2 among 20 test(s)
1..20

$ ./t8020-last-modified.sh --verbose
[…]

expecting success of 8020.16 'cross merge boundaries in blaming':
	git checkout HEAD^0 &&
	git rm -rf . &&
	test_commit m1 &&
	git checkout HEAD^ &&
	git rm -rf . &&
	test_commit m2 &&
	git merge m1 &&
	check_last_modified <<-\EOF
	m2 m2.t
	m1 m1.t
	EOF

Note: switching to 'HEAD^0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

   git switch -c <new-branch-name>

Or undo this operation with:

   git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 08525b6 remove a
rm 'file'
[detached HEAD 53e7187] m1
  Author: A U Thor <author@example.com>
  2 files changed, 1 insertion(+), 1 deletion(-)
  delete mode 100644 file
  create mode 100644 m1.t
Previous HEAD position was 53e7187 m1
HEAD is now at 08525b6 remove a
rm 'file'
[detached HEAD 9b81a41] m2
  Author: A U Thor <author@example.com>
  2 files changed, 1 insertion(+), 1 deletion(-)
  delete mode 100644 file
  create mode 100644 m2.t
Merge made by the 'ort' strategy.
  m1.t | 1 +
  1 file changed, 1 insertion(+)
  create mode 100644 m1.t
--- expect	2025-11-19 11:28:57.966106204 +0000
+++ actual	2025-11-19 11:28:58.110112543 +0000
@@ -1,2 +1,2 @@
+ac29b6e974b49803f1c6ec5a705d1bf7dbfa7d2f m1.t
  m2 m2.t
-m1 m1.t
not ok 16 - cross merge boundaries in blaming
#	
#		git checkout HEAD^0 &&
#		git rm -rf . &&
#		test_commit m1 &&
#		git checkout HEAD^ &&
#		git rm -rf . &&
#		test_commit m2 &&
#		git merge m1 &&
#		check_last_modified <<-\EOF
#		m2 m2.t
#		m1 m1.t
#		EOF
#	

[…]

expecting success of 8020.19 'last-modified merge undoes changes':
	git checkout HEAD^0 &&
	git rm -rf . &&
	test_commit b1 file A &&
	test_commit b2 file B &&
	test_commit b3 file C &&
	test_commit b4 file D &&
	git checkout b2 &&
	test_commit b5 file2 2 &&
	git checkout b4 &&
	git merge --no-commit --no-ff b5 &&
	git checkout b2 -- file &&
	git merge --continue &&
	check_last_modified <<-\EOF
	b5 file2
	b2 file
	EOF

HEAD is now at 7b0602a Merge tag 'a4' into HEAD
rm 'file'
[detached HEAD c48d0f6] b1
  Author: A U Thor <author@example.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
[detached HEAD ee27b37] b2
  Author: A U Thor <author@example.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
[detached HEAD c90ce7d] b3
  Author: A U Thor <author@example.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
[detached HEAD 317a439] b4
  Author: A U Thor <author@example.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
Previous HEAD position was 317a439 b4
HEAD is now at ee27b37 b2
[detached HEAD 5526d49] b5
  Author: A U Thor <author@example.com>
  1 file changed, 1 insertion(+)
  create mode 100644 file2
Previous HEAD position was 5526d49 b5
HEAD is now at 317a439 b4
Automatic merge went well; stopped before committing as requested
[detached HEAD da1857e] Merge tag 'b5' into HEAD
  Author: A U Thor <author@example.com>
--- expect	2025-11-19 11:29:03.492349022 +0000
+++ actual	2025-11-19 11:29:03.648355864 +0000
@@ -1,2 +1,2 @@
-b5 file2
-b2 file
+da1857e0652b6f264c0038d684ddecddc273e506 file2
+da1857e0652b6f264c0038d684ddecddc273e506 file
not ok 19 - last-modified merge undoes changes
#	
#		git checkout HEAD^0 &&
#		git rm -rf . &&
#		test_commit b1 file A &&
#		test_commit b2 file B &&
#		test_commit b3 file C &&
#		test_commit b4 file D &&
#		git checkout b2 &&
#		test_commit b5 file2 2 &&
#		git checkout b4 &&
#		git merge --no-commit --no-ff b5 &&
#		git checkout b2 -- file &&
#		git merge --continue &&
#		check_last_modified <<-\EOF
#		b5 file2
#		b2 file
#		EOF
#	

Anders

[1] https://lore.kernel.org/git/20251103154726.26592-1-toon@iotcl.com/

