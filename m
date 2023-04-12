Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF0C77B6C
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 21:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDLVsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLVsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 17:48:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687740E1
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:48:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c3so14037590pjg.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681336102; x=1683928102;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROOuy8QvZcnwe9ZI8zzftPl3qC9t067U9P1OO7xCyZI=;
        b=LlBkB1i0uQ6VOF01DRPToksngHEn3JHrYbEq6l15YRXGtcJGQ7bZOz7+zkS1T/VY2b
         +J8JG4id1HKgxB7lTTcfDl2SNJfe2EHLLS61TnIVBtri/Tw+3SaMw+eDvAaGA9IKQ+ig
         EbjUjQ6vTLd3TzT9p3mD2AJ4pXVIdo/2hIPufw1jTg2qqxApa+uhY9WD4RJX8ySOlw3s
         ArwyHEM4Uhst8HWAuZstNiRCjqvypJcuiMGqZVZa0JAXhpNDRlgynV4IrvxViuT2gdaK
         1df0OstL3i7W1VBgT6xItcgyASXd0nD5u5hI9z3t7VP/DwImRF2Yzl7ON0Nu3/TTPx9Y
         fFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336102; x=1683928102;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ROOuy8QvZcnwe9ZI8zzftPl3qC9t067U9P1OO7xCyZI=;
        b=Uv9orpqEsDGFVglCfIKK8Ysl8Kf+1PwrMKKQ1IvPxWFzfxP0dWk0EACE5rBUrr/vJP
         4as/VI1b0GbfnTS6ZPZzIvgeozGfX2EMugQOS0DkUzIkJRwx1zC6hxV8HCmWCnCysgzs
         Bj+IuPVG4iz0cHp+OUtDKtjpRnIrVZmewupoarArpsezCy8rYDYLFXiONXJPkp/354+Y
         A6StjRjwZ+F/8HzmStLuHr6z1ie+9Qt0QpGiQeOq+KxrGxgIvZwe68djln8x1ecSEYAh
         SHls82xqiZ38GHi4z5Shr0aWoBSEM9IWN9IeLNNpRBgLl8JI17f2D+eZO4LGWORFOpPN
         ZCMA==
X-Gm-Message-State: AAQBX9dLw1GOKiii+SkbCBvx959FYPVEY6T0n8Hvd7bIRdKX/6xhMBQN
        0t0pD2C3HpWvQLufasdNGs8=
X-Google-Smtp-Source: AKy350bIaUfh71M+O6GX664gF46WS/j/ovSexHJ58mgbEd7qW65OOlAwUcvYHZLIG4zfOgfoVZYueQ==
X-Received: by 2002:a17:902:f545:b0:1a6:61ad:9d03 with SMTP id h5-20020a170902f54500b001a661ad9d03mr245572plf.65.1681336102001;
        Wed, 12 Apr 2023 14:48:22 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id o29-20020a634e5d000000b00513092bdca1sm57550pgl.73.2023.04.12.14.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:48:21 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Jarry <robin@jarry.cc>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH v2] send-email: export patch counters in validate
 environment
References: <20230411114723.89029-1-robin@jarry.cc>
        <20230412095434.140754-1-robin@jarry.cc> <xmqqfs957zs4.fsf@gitster.g>
Date:   Wed, 12 Apr 2023 14:48:21 -0700
In-Reply-To: <xmqqfs957zs4.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        12 Apr 2023 10:53:31 -0700")
Message-ID: <xmqqsfd46aca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Overall, a very well crafted patch, even though little details and
> some design choices can be improved.

One thing I forgot to mention.  We probably want some test, perhaps
adding something like the following to t9001 after we already test
for --validate.

Thanks.

----------- >8 ---------------------- >8 ---------------------- >8 -----------
expected_file_counter_output () {
	total=$1
	count=0
	while test $count -ne $total
	do
		count=$((count + 1)) &&
		echo "$count/$total" || return
	done
}

test_expect_success $PREREQ '--validate hook allows counting of messages' '
	test_when_finished "rm my-hooks.log" &&
	test_config core.hooksPath "my-hooks" &&

	write_script my-hooks/sendemail-validate <<-\EOF &&
		num=$GIT_SENDEMAIL_FILE_COUNTER &&
		tot=$GIT_SENDEMAIL_FILE_TOTAL &&
		echo "$num/$tot" >>my-hooks.log || exit 1
	EOF

	>my-hooks.log &&
	expected_file_counter_output 1 >expect &&
	git send-email \
		--from="Example <from@example.com>" \
		--to=nobody@example.com \
		--smtp-server="$(pwd)/fake.sendmail" \
		--validate $patches &&
	test_cmp expect my-hooks.log
'
