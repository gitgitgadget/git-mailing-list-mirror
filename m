Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9117C81
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EwGQMEld"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A4631E3DC6;
	Fri, 12 Jan 2024 12:58:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZOV0+pjoYcbB3QGDtFjwLnQIKs6lPlBKHZRNoe
	btLmI=; b=EwGQMEldoqu88tX69c8xH5zl65+9/f0RbFpA4N2Yi/wF/HAyAHlKG3
	/XT2cFaUq9Kb/AFgvRlP6UkdsCxmRqQYcKtnZNzfocShu7kWo6nF9kktQyzHO5Zb
	1RzN1HozZPT46zi6FXuPkZ3P1xR5fpqoyCH5iQatpcRIimY+N6TCc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 22E481E3DC5;
	Fri, 12 Jan 2024 12:58:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83FCC1E3DC4;
	Fri, 12 Jan 2024 12:58:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 2/2] t5541: remove lockfile creation
In-Reply-To: <20240112070356.GE618729@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 12 Jan 2024 02:03:56 -0500")
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
	<pull.1634.v2.git.1705004670.gitgitgadget@gmail.com>
	<f953a668c6a7e0a57adcee77ceee2d578970065e.1705004670.git.gitgitgadget@gmail.com>
	<20240112070356.GE618729@coredump.intra.peff.net>
Date: Fri, 12 Jan 2024 09:58:08 -0800
Message-ID: <xmqqo7dqbfin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2552FC16-B174-11EE-A4F3-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Jan 11, 2024 at 08:24:30PM +0000, Justin Tobler via GitGitGadget wrote:
>
>> -	# the new branch should not have been created upstream
>> -	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
>> -
>> -	# upstream should still reflect atomic2, the last thing we pushed
>> -	# successfully
>> -	git rev-parse atomic2 >expected &&
>> -	# ...to other.
>> -	git -C "$d" rev-parse refs/heads/other >actual &&
>> -	test_cmp expected actual &&
>> -
>> -	# the new branch should not have been created upstream
>> +	# The atomic and other branches should be created upstream.
>>  	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
>> +	test_must_fail git -C "$d" show-ref --verify refs/heads/other &&
>
> This last comment should say "should not be created", I think?
>
> Other than that, both patches look good to me.

Thanks.  Will queue with the following and "Acked-by: peff".

diff --git c/t/t5541-http-push-smart.sh w/t/t5541-http-push-smart.sh
index 9a8bed6c32..71428f3d5c 100755
--- c/t/t5541-http-push-smart.sh
+++ w/t/t5541-http-push-smart.sh
@@ -242,7 +242,7 @@ test_expect_success 'push --atomic fails on server-side errors' '
 	# --atomic should cause entire push to be rejected
 	test_must_fail git push --atomic "$up" atomic other 2>output  &&
 
-	# The atomic and other branches should be created upstream.
+	# The atomic and other branches should not be created upstream.
 	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
 	test_must_fail git -C "$d" show-ref --verify refs/heads/other &&
 

