Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E980154C1D
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760965; cv=none; b=q2IwzSMNNabGPHOCNxGP+n7LXFn9OrJtoPxcGBuOrpMlyw8WkJTEN7x9zrUn94NKPxDxsyiQrojGTeEb5O3zf75zQwzNHIJFP2Eb6NzLDM6yEFzxKc1Tn1M/G7FuRRjnTffCoWoQQ2Ee4RwSTrLoGOG794oR9zmVFNN2K8IljoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760965; c=relaxed/simple;
	bh=qg6g6DwNzjxpaPqxlIHJFS1/wrg4cJrWx8WqX+T9Tt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZFFU8DBf2MUnETNAoFpBZwQSgED7xbqcgmcO32fnyjuGIiuDP79rEEjsDFUoH1niujnQ9NifGv8EyB+JcE8iTwCBk1lVkBuGSLgPsuWxCj3Pswqi27W1/oCIFtmngv+nzMsrrp0/iMZ6WlYv37e474EbwhINLDm12QtJyyAK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NOjnexDj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NOjnexDj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4633B2618A;
	Thu, 15 Aug 2024 18:29:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qg6g6DwNzjxpaPqxlIHJFS1/wrg4cJrWx8WqX+
	T9Tt0=; b=NOjnexDjyUDjSwWJD6UBDgMtv8HtIUB/KB0XBW+ca3N84Y4plKpLVQ
	5LJsAP64J7g81cw76b0TZ104QHrgFJj4uCsWVZeHwknjzGhSVBcv1q2ws/nnyloG
	ZmHw2q/p8MBQamnq/IMJj3WciKKbp4or0IT7wvEuLZndjG0x9rsNo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CC6226189;
	Thu, 15 Aug 2024 18:29:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CDA926188;
	Thu, 15 Aug 2024 18:29:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  phillip.wood@dunelm.org.uk,  James Liu <james@jamesliu.io>
Subject: Re: [PATCH v2 5/7] builtin/gc: add a `--detach` flag
In-Reply-To: <xmqq34n5txcj.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	15 Aug 2024 12:11:40 -0700")
References: <cover.1723533091.git.ps@pks.im> <cover.1723712608.git.ps@pks.im>
	<ca78d3dc7c0270b434ee4ca4ef618212c7dc1d5b.1723712608.git.ps@pks.im>
	<xmqq34n5txcj.fsf@gitster.g>
Date: Thu, 15 Aug 2024 15:29:20 -0700
Message-ID: <xmqqttflqv27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D17A6746-5B55-11EF-AFEC-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> +test_expect_success '--detach overrides gc.autoDetach=false' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +
>> +		# Prepare the repository such that git-gc(1) ends up repacking.
>> +		test_commit "$(test_oid blob17_1)" &&
>> +		test_commit "$(test_oid blob17_2)" &&
>> +		git config gc.autodetach false &&
>> +		git config gc.auto 2 &&
>> +
>> +		cat >expect <<-EOF &&
>> +		Auto packing the repository in background for optimum performance.
>> +		See "git help gc" for manual housekeeping.
>> +		EOF
>> +		GIT_PROGRESS_DELAY=0 git gc --auto --detach 2>actual &&
>> +		test_cmp expect actual
>> +	)
>> +'
>
> If the gc/maintenance is going to background itself, it is possible
> that it still is running, possibly with files under repo/.git/ open
> and the process running in repo directory, when the test_when_finished
> clean-up trap goes in effect?
>
> I am wondering where this comes from:
>
>   https://github.com/git/git/actions/runs/10408467351/job/28825980833#step:6:2000
>
> where "rm -rf repo" dies with an unusual
>
>   rm: can't remove 'repo/.git': Directory not empty
>
> and my theory is that after "rm -rf" _thinks_ it removed everything
> underneath, before it attempts to rmdir("repo/.git"), the repack
> process in the background has created a new pack, and "rm -rf" does
> not go back and try to create such a new cruft.
>
> The most robust way to work around such a "race" is to wait for the
> backgrounded process before cleaning up, or after seeing that the
> message we use as a signal that the "gc" has backgrounded itself,
> kill that backgrounded process before exiting the test and causing
> the clean-up to trigger.

There already is a clue left by those who worked on this test the
last time at the end of the script.  It says:

    # DO NOT leave a detached auto gc process running near the end of the
    # test script: it can run long enough in the background to racily
    # interfere with the cleanup in 'test_done'.

immediately before "test_done".

In the meantime, I am wondering something simple and silly like the
attached is sufficient.  The idea is that we expect the "oops we
couldn't clean" code not to trigger most of the time, but if it
does, we just wait (with back off) a bit and retry.


 t/t6500-gc.sh | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git c/t/t6500-gc.sh w/t/t6500-gc.sh
index 737c99e0f8..4a991e087a 100755
--- c/t/t6500-gc.sh
+++ w/t/t6500-gc.sh
@@ -396,8 +396,22 @@ test_expect_success 'background auto gc respects lock for all operations' '
 	test_cmp expect actual
 '
 
+wait_to_clean () {
+	count=10 sleep=1
+	until rm -rf "$1" && ! test -d "$1"
+	do
+		if test $count = 0
+		then
+			return 1
+		fi
+		count=$(( count - 1 ))
+		sleep=$(( sleep + sleep ))
+		sleep $sleep
+	done
+}
+
 test_expect_success '--detach overrides gc.autoDetach=false' '
-	test_when_finished "rm -rf repo" &&
+	test_when_finished "wait_to_clean repo" &&
 	git init repo &&
 	(
 		cd repo &&
@@ -418,7 +432,7 @@ test_expect_success '--detach overrides gc.autoDetach=false' '
 '
 
 test_expect_success '--no-detach overrides gc.autoDetach=true' '
-	test_when_finished "rm -rf repo" &&
+	test_when_finished "wait_to_clean repo" &&
 	git init repo &&
 	(
 		cd repo &&

