Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328713B294
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546223; cv=none; b=OsONt9wHOKKsswswe/+5/vIEThqO6FLVuKE/gexO5O/ZDXdU4Lp7HzM41iN5L+ndnbLCMia6UTYWZZl2JW5i8dPmwHtn3z7/sPolNRxUJdKMeQ/WCFG43bgMuNSEvfVR++Td0ArJfrGwezJ+W/jDVD7z/T1kRhAojrvzszshDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546223; c=relaxed/simple;
	bh=rMkmy58qV2epmQW89FAY1Fzuw5W3+pXJrStvWJn+Sx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ALBpkoBXB+bX8IVo2yLqVdBmSgCI2NN4Wai5puUcZDd3rbW3y+cheCOHbe7K7Lk9rN8ZZY0nka9slm1O7d+mHYXt7WE9+d8n1XAioliKU6/wfCC+yN+TP5YDhtBAO8chASxT6xGdYCE0Niy2+Ji6ijfcxALQDfXvinNtS0UAZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Doh40qr4; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Doh40qr4"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 37E301EF270;
	Fri, 19 Apr 2024 13:03:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rMkmy58qV2epmQW89FAY1Fzuw5W3+pXJrStvWJ
	n+Sx4=; b=Doh40qr4LmQbcYUJrX3mqNdD6dBov0yz3rYZi9r6AZJsf2AnRDivwk
	YjTFn7aA9f1VWIvxR8JIwUKzJWXpPPnbFUoQbKcKXQ7pgb8WoNWy3ubGR0zlIBbS
	c/odEAoXIPeH0+Sq5OvaaPFU/5f5ap+vf7lR4k2nP/dBKXef47pMw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F3271EF26F;
	Fri, 19 Apr 2024 13:03:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 917EC1EF26E;
	Fri, 19 Apr 2024 13:03:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH] format-patch: allow --rfc to optionally take a value,
 like --rfc=WIP
In-Reply-To: <9f846a3d-5244-43ec-b392-156665be0929@gmail.com> (Phillip Wood's
	message of "Fri, 19 Apr 2024 15:09:54 +0100")
References: <xmqqzftqnuxq.fsf@gitster.g>
	<9f846a3d-5244-43ec-b392-156665be0929@gmail.com>
Date: Fri, 19 Apr 2024 10:03:36 -0700
Message-ID: <xmqq1q71l1xz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C39344F2-FE6E-11EE-97DB-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> -		   [--rfc] [--subject-prefix=<subject-prefix>]
>> +		   [--rfc[=<rfc>]] [--subject-prefix=<subject-prefix>]
>
> Nit: in the documentation we use "<rfc>" for the placeholder but in
> the code we use "<extra>"

You're right.  Will fix.

>> @@ -1932,7 +1944,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>   			    N_("mark the series as Nth re-roll")),
>>   		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
>>   			    N_("max length of output filename")),
>> -		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
>> +		OPT_CALLBACK_F(0, "rfc", &rfc, N_("extra"),
>> +			       N_("add <extra> (default 'RFC') before 'PATCH'"),
>> +			       PARSE_OPT_NONEG|PARSE_OPT_OPTARG, rfc_callback),
>
> This is a change in behavior as it looks like we previously accepted
> "--no-rfc" is that deliberate?

I just matched the subject-prefix without thinking.  Will fix.

Here is what I plan to squash in, but we are about to enter the
pre-release stabilization period, so the progress on this new
feature will have to slow down.

Thanks.

 builtin/log.c           | 10 +++++-----
 t/t4014-format-patch.sh | 16 ++++++++++++----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git i/builtin/log.c w/builtin/log.c
index 2d6e0f3688..0e9c84e51d 100644
--- i/builtin/log.c
+++ w/builtin/log.c
@@ -1499,10 +1499,10 @@ static int rfc_callback(const struct option *opt, const char *arg,
 {
 	struct strbuf *rfc;
 
-	BUG_ON_OPT_NEG(unset);
 	rfc = opt->value;
 	strbuf_reset(rfc);
-	strbuf_addstr(rfc, arg ? arg : "RFC");
+	if (!unset)
+		strbuf_addstr(rfc, arg ? arg : "RFC");
 	return 0;
 }
 
@@ -1944,9 +1944,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("mark the series as Nth re-roll")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
-		OPT_CALLBACK_F(0, "rfc", &rfc, N_("extra"),
-			       N_("add <extra> (default 'RFC') before 'PATCH'"),
-			       PARSE_OPT_NONEG|PARSE_OPT_OPTARG, rfc_callback),
+		OPT_CALLBACK_F(0, "rfc", &rfc, N_("rfc"),
+			       N_("add <rfc> (default 'RFC') before 'PATCH'"),
+			       PARSE_OPT_OPTARG, rfc_callback),
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
diff --git i/t/t4014-format-patch.sh w/t/t4014-format-patch.sh
index 905858da35..645c4189f9 100755
--- i/t/t4014-format-patch.sh
+++ w/t/t4014-format-patch.sh
@@ -1368,22 +1368,30 @@ test_expect_success 'empty subject prefix does not have extra space' '
 	test_cmp expect actual
 '
 
-test_expect_success '--rfc' '
+test_expect_success '--rfc and --no-rfc' '
 	cat >expect <<-\EOF &&
 	Subject: [RFC PATCH 1/1] header with . in it
 	EOF
 	git format-patch -n -1 --stdout --rfc >patch &&
 	grep "^Subject:" patch >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	git format-patch -n -1 --stdout --rfc --no-rfc >patch &&
+	sed -e "s/RFC //" expect >expect-raw &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect-raw actual
 '
 
-test_expect_success '--rfc=WIP' '
+test_expect_success '--rfc=WIP and --rfc=' '
 	cat >expect <<-\EOF &&
 	Subject: [WIP PATCH 1/1] header with . in it
 	EOF
 	git format-patch -n -1 --stdout --rfc=WIP >patch &&
 	grep "^Subject:" patch >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	git format-patch -n -1 --stdout --rfc --rfc= >patch &&
+	sed -e "s/WIP //" expect >expect-raw &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect-raw actual
 '
 
 test_expect_success '--rfc does not overwrite prefix' '
