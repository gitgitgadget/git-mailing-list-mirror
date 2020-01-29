Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE174C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 21:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10632071E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 21:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CLRR0VIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA2Vmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:42:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56736 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2Vmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 16:42:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A17642B85;
        Wed, 29 Jan 2020 16:42:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z/22MgpH5DUlfz7GzbkAtOjiLT8=; b=CLRR0V
        IwdH7lpv29/uX/GlbeJEkDPEjl6SYuCAIyoPpO0X9vIDj0K5FJ0Yj7FHVIYl4BP6
        2sM1+/TbbQ6PHBuzY0Y+y3+pRsSBoqEdYXBqxDCRVCiB1hh3FanDPvtSv58PlOR0
        GkG4y2rcNZv+hboSvngV8h8yPRIV2lxKuKIkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rSGjkPDwE3OC+9RdWwmqJNBX4BQXrTU8
        jkLftay9LI6IEeffM/Sx+LFJYFLAUbapXkOsSXW4uvmc/KakZ1+zzCOYMLPuB4G2
        5Y7+fYFPUlaOL9aoqiNsV7Hn18QBNxCILqPC3HaioZrKdD+MJSSqrZQl1BsevVVb
        HyAEehR6+hM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 221B342B83;
        Wed, 29 Jan 2020 16:42:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8835642B82;
        Wed, 29 Jan 2020 16:42:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David =?utf-8?Q?Burstr=C3=B6m?= <davidburstrom@spotify.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] sha1-name: mark get_oid() error messages for translation
References: <20200125000542.GA566779@coredump.intra.peff.net>
        <20200125001301.GC567109@coredump.intra.peff.net>
        <xmqqpnf2dk6m.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 29 Jan 2020 13:42:50 -0800
In-Reply-To: <xmqqpnf2dk6m.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 29 Jan 2020 13:30:57 -0800")
Message-ID: <xmqqimkudjmt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CBC1D48-42E0-11EA-8E19-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> +			die(_("path '%s' exists, but not '%s'\n"
>> +			    "hint: Did you mean '%.*s:%s' aka '%.*s:./%s'?"),
>> ...
>
> The above is meant to be localizable, but...
>
>> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
>> index f49fc770d6..c2b5125c12 100755
>> --- a/t/t1506-rev-parse-diagnosis.sh
>> +++ b/t/t1506-rev-parse-diagnosis.sh
>> @@ -9,8 +9,8 @@ exec </dev/null
>>  test_did_you_mean ()
>>  {
>>  	cat >expected <<-EOF &&
>> -	fatal: Path '$2$3' $4, but not ${5:-$SQ$3$SQ}.
>> -	Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
>> +	fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
>> +	hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
>>  	EOF
>>  	test_cmp expected error
>
> ...this obviously would not allow GIT_TEST_GETTEXT_POISON test to
> pass.  And ...
>
>>  test_expect_success 'incorrect file in sha1:path' '
>>  	test_must_fail git rev-parse HEAD:nothing.txt 2>error &&
>> -	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist in '"'"'HEAD'"'"'" error &&
>> +	test_i18ngrep "path .nothing.txt. does not exist in .HEAD." error &&
>>  	test_must_fail git rev-parse HEAD:index-only.txt 2>error &&
>> -	grep "fatal: Path '"'"'index-only.txt'"'"' exists on disk, but not in '"'"'HEAD'"'"'." error &&
>> +	test_i18ngrep "path .index-only.txt. exists on disk, but not in .HEAD." error &&
>>  	(cd subdir &&
>>  	 test_must_fail git rev-parse HEAD:file2.txt 2>error &&
>>  	 test_did_you_mean HEAD subdir/ file2.txt exists )
>>  '
>
> ... the last step executed in "subdir" does not seem to pass.

I'll queue this band-aid on top before making my last pushout for
the day.  Even with poisoned i18n/l10n, die(_(msg)) gives "fatal:"
prefix at the beginning, so that is what test_did_you_mean would
expect to see from a passing test under GIT_TEST_GETTEXT_POISON.

The other hunk is about a test that greps in "error".

 t/t1506-rev-parse-diagnosis.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 2d26d2267e..f28a35c84e 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -8,11 +8,16 @@ exec </dev/null
 
 test_did_you_mean ()
 {
-	cat >expected <<-EOF &&
-	fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
-	hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
-	EOF
-	test_cmp expected error
+	if ! test_have_prereq C_LOCALE_OUTPUT
+	then
+		grep "^fatal: " error
+	else
+		cat >expected <<-EOF &&
+		fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
+		hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
+		EOF
+		test_cmp expected error
+	fi
 }
 
 HASH_file=
@@ -149,7 +154,7 @@ test_expect_success 'relative path not found' '
 	(
 		cd subdir &&
 		test_must_fail git rev-parse HEAD:./nonexistent.txt 2>error &&
-		grep subdir/nonexistent.txt error
+		test_i18ngrep subdir/nonexistent.txt error
 	)
 '
 
