Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEFD28D
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012427; cv=none; b=hL9DL5R/CiPjIIIWIVExv+AUSbd17RbYoqT5vhWMz3DYO9LQkVHEhTFx7jKEeRnlTwanmyRklpfvHhif4p1Ogw7Snx9WW6IMNhk4/2UqoHNiD/WttYvYju1qytqVcovQ5EEjknJS4OywzkC+3q4aAHJlEXdICCaYQWEuogoer7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012427; c=relaxed/simple;
	bh=qts+IkHvYSX4mCrTz+dpR2mRvwlcvwNVAbv4rfokGOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u8wHgAKuUUVL3cH+L2zcWZAOWIUxFxj8VmRWOhmFylHsFHyANexim97WbRBFRcI3NZUXEUm9JY/esKmr1NRojX3jQlZIXNtrKyECTev7qhzU0XQW3D+NpgQGa9zzLEOjzMGm/5MazWNjgH2pEwDIrngjMnek7pyxi/bp2StIAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tpx/ZFH1; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tpx/ZFH1"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 37DC01D9B38;
	Mon,  1 Apr 2024 19:00:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qts+IkHvYSX4mCrTz+dpR2mRvwlcvwNVAbv4rf
	okGOg=; b=tpx/ZFH1I3CPDPGpNihMR9KZ/H/EGaQbSXJEzgMXymddB3WGNFpmbu
	ebvE30uuRazl2z1udBA4iHk5XUAVtfeELZCO3v6XOq+g+GNg5x5y9xnUvpn5fQxH
	P0a+ZWnmuX3keZXjap7+tawteeKPy6rtDgYcykgX4B0mMSFDpc1W8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E64A1D9B37;
	Mon,  1 Apr 2024 19:00:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 898391D9B36;
	Mon,  1 Apr 2024 19:00:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  chris.torek@gmail.com
Subject: Re: [PATCH 1/2] update-ref: use {old,new}-oid instead of
 {old,new}value
In-Reply-To: <CAOLa=ZQRw1Cu9rcKYoxzsL8V3LWjyMKuOkcutzqRJb+cpyBNTA@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 1 Apr 2024 15:38:52 -0700")
References: <20240401144542.88027-1-knayak@gitlab.com>
	<20240401144542.88027-2-knayak@gitlab.com>
	<xmqqo7as957h.fsf@gitster.g>
	<CAOLa=ZQRw1Cu9rcKYoxzsL8V3LWjyMKuOkcutzqRJb+cpyBNTA@mail.gmail.com>
Date: Mon, 01 Apr 2024 16:00:22 -0700
Message-ID: <xmqqr0fo7kop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9F16BC72-F07B-11EE-9A47-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> Did you run t1400 after this update?  There may be other tests that
>> the message update is breaking but that was the first one I noticed.
>
> I definitely didn't. It totally slipped my mind, I was thinking that I
> only modified the *.txt files. I will send in a new version after
> ensuring all tests are fixed.

Here is what I have.

Subject: [PATCH] fixup! update-ref: use {old,new}-oid instead of {old,new}value

---
 t/t1400-update-ref.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6ebc3ef945..d59ee1ab4a 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -622,7 +622,7 @@ test_expect_success 'stdin fails create with no ref' '
 test_expect_success 'stdin fails create with no new value' '
 	echo "create $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $a: missing <newvalue>" err
+	grep "fatal: create $a: missing <new-oid>" err
 '
 
 test_expect_success 'stdin fails create with too many arguments' '
@@ -640,7 +640,7 @@ test_expect_success 'stdin fails update with no ref' '
 test_expect_success 'stdin fails update with no new value' '
 	echo "update $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $a: missing <newvalue>" err
+	grep "fatal: update $a: missing <new-oid>" err
 '
 
 test_expect_success 'stdin fails update with too many arguments' '
@@ -765,21 +765,21 @@ test_expect_success 'stdin update ref fails with wrong old value' '
 test_expect_success 'stdin update ref fails with bad old value' '
 	echo "update $c $m does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
+	grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with bad new value' '
 	echo "create $c does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
+	grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with zero new value' '
 	echo "create $c " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c: zero <newvalue>" err &&
+	grep "fatal: create $c: zero <new-oid" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -803,7 +803,7 @@ test_expect_success 'stdin delete ref fails with wrong old value' '
 test_expect_success 'stdin delete ref fails with zero old value' '
 	echo "delete $a " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete $a: zero <oldvalue>" err &&
+	grep "fatal: delete $a: zero <old-oid>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -1027,7 +1027,7 @@ test_expect_success 'stdin -z fails create with no ref' '
 test_expect_success 'stdin -z fails create with no new value' '
 	printf $F "create $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $a: unexpected end of input when reading <newvalue>" err
+	grep "fatal: create $a: unexpected end of input when reading <new-oid>" err
 '
 
 test_expect_success 'stdin -z fails create with too many arguments' '
@@ -1045,27 +1045,27 @@ test_expect_success 'stdin -z fails update with no ref' '
 test_expect_success 'stdin -z fails update with too few args' '
 	printf $F "update $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
+	grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z emits warning with empty new value' '
 	git update-ref $a $m &&
 	printf $F "update $a" "" "" >stdin &&
 	git update-ref -z --stdin <stdin 2>err &&
-	grep "warning: update $a: missing <newvalue>, treating as zero" err &&
+	grep "warning: update $a: missing <new-oid>, treating as zero" err &&
 	test_must_fail git rev-parse --verify -q $a
 '
 
 test_expect_success 'stdin -z fails update with no new value' '
 	printf $F "update $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a: unexpected end of input when reading <newvalue>" err
+	grep "fatal: update $a: unexpected end of input when reading <new-oid>" err
 '
 
 test_expect_success 'stdin -z fails update with no old value' '
 	printf $F "update $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
+	grep "fatal: update $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z fails update with too many arguments' '
@@ -1083,7 +1083,7 @@ test_expect_success 'stdin -z fails delete with no ref' '
 test_expect_success 'stdin -z fails delete with no old value' '
 	printf $F "delete $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a: unexpected end of input when reading <oldvalue>" err
+	grep "fatal: delete $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z fails delete with too many arguments' '
@@ -1101,7 +1101,7 @@ test_expect_success 'stdin -z fails verify with too many arguments' '
 test_expect_success 'stdin -z fails verify with no old value' '
 	printf $F "verify $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: verify $a: unexpected end of input when reading <oldvalue>" err
+	grep "fatal: verify $a: unexpected end of input when reading <old-oid>" err
 '
 
 test_expect_success 'stdin -z fails option with unknown name' '
@@ -1160,7 +1160,7 @@ test_expect_success 'stdin -z update ref fails with wrong old value' '
 test_expect_success 'stdin -z update ref fails with bad old value' '
 	printf $F "update $c" "$m" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update $c: invalid <oldvalue>: does-not-exist" err &&
+	grep "fatal: update $c: invalid <old-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -1178,14 +1178,14 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 	git update-ref -d "$c" &&
 	printf $F "create $c" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c: invalid <newvalue>: does-not-exist" err &&
+	grep "fatal: create $c: invalid <new-oid>: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c: missing <newvalue>" err &&
+	grep "fatal: create $c: missing <new-oid>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -1209,7 +1209,7 @@ test_expect_success 'stdin -z delete ref fails with wrong old value' '
 test_expect_success 'stdin -z delete ref fails with zero old value' '
 	printf $F "delete $a" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a: zero <oldvalue>" err &&
+	grep "fatal: delete $a: zero <old-oid>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
-- 
2.44.0-448-gc2cbfbd2e2

