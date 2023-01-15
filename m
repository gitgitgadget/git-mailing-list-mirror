Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA65C63797
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 03:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjAODeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 22:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAODeT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 22:34:19 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BD1B74A
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 19:34:18 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g205so1674227pfb.6
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 19:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QvVPqt70keS8vwz+NSHhIu/rHD7hUDx7nuevtIBaK8=;
        b=Yf+ZH9ViCm34iWTDYJgo4I/kSq8yXW5CexGr9my6Bcoh+62prATQLyDsyI9/3DIimZ
         dl1QqyJ4bs3Q5cKueYVhCA/Cc6hH1tDqgODmZnBu5taneze2ddXv4+a9mNBVnfr8swx4
         lpwTDX1yzQ679bPUYmR/Gy6H+spnnHy/DsPV7gXpgvrYgWqGE/DSBwp7UxM3U4Vi3lAD
         q+CpybEsWwYE0LNplahVCfe45D2ESBn7rDTN+P/T/bhz4ilUTdFMUJ0TsLoTVQe619H1
         qJb2PFQdIlQEG+eRrnhWAAQf92ajGYT70b5HkWif12fz4+xvLeV6FrvUpmO2ZDI3ljTE
         olNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8QvVPqt70keS8vwz+NSHhIu/rHD7hUDx7nuevtIBaK8=;
        b=Nnc8FaifhLkbs9iepdUPv/UrTpV10hIBXpcL8Vzs04WCL5pms/XjTz3MDEyaeLbByH
         1gEHFmSQagBKgGVVnoAZvRPtJ4p0ZOh3/S2nvH45SS3sWbn1MRd4nJptQu0Zs86gtu4n
         Plcer7P/mnvFxMj2Nd00hOMqbLzcspGmbP5OCBOA+w1MOf1l/Wh4K/bRzhlBYJGdEUXa
         bpyGp0DXdDt1FIMMikNQ5ON0CbpHll8mp70FV4NBLYdVJvKvsVDQ0WBkm/QlmgJPmdsb
         ugaJUtCUL4HMBZ5GAPiwEArc4x20qem3d85zAwIEwVXeT98eqa8PKwJf3QT5Xwmyqd+B
         YJ7w==
X-Gm-Message-State: AFqh2kozI8XCqYif6mOd3kZzlGS9S5fhK+jiljsJYlJDyrmUJdczhZIj
        4WWsjEPizy+LLcSwK60CWvs=
X-Google-Smtp-Source: AMrXdXushcaDNWAeqBz8HNYeuPt4LNe4yfxAaUsOkXNMoawawiIoMlHqnw0ygeO7MHy9vTWWVIW0XA==
X-Received: by 2002:a05:6a00:26e3:b0:58b:c4b4:86e3 with SMTP id p35-20020a056a0026e300b0058bc4b486e3mr4995966pfw.24.1673753657837;
        Sat, 14 Jan 2023 19:34:17 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m190-20020a6258c7000000b005821c109cebsm11228648pfb.199.2023.01.14.19.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 19:34:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
        <20230110211452.2568535-3-michael.strawbridge@amd.com>
        <xmqqedrxm7bn.fsf@gitster.g> <xmqqa62lm76t.fsf@gitster.g>
Date:   Sat, 14 Jan 2023 19:34:17 -0800
In-Reply-To: <xmqqa62lm76t.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        14 Jan 2023 08:06:50 -0800")
Message-ID: <xmqqfsccii86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Strawbridge, Michael" <Michael.Strawbridge@amd.com> writes:
>>
>>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>>> +	test_when_finished "rm my-hooks.ran" &&
>>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>>> +	filesize=$(stat -c%s "$2")
>>
>> That "stat -c" is a GNU-ism, I think.  macOS CI jobs at GitHub do
>> not seem to like it.
>>
>>> +	if [ "$filesize" != "0" ]; then
>>
>> Also, please see Documentation/CodingGuidelines to learn the subset
>> of shell script syntax and style we adopted for this project.

I'll tentatively queue this as a fix-up on top of the topic, but is
this testing the right thing?  Should we inspect "$2" and verify
that it gives us what we expect, not just it being non-empty?

 t/t9001-send-email.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git c/t/t9001-send-email.sh w/t/t9001-send-email.sh
index f02b1eba16..b19997cbbc 100755
--- c/t/t9001-send-email.sh
+++ w/t/t9001-send-email.sh
@@ -568,9 +568,10 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 test_expect_success $PREREQ "--validate hook supports header argument" '
 	test_when_finished "rm my-hooks.ran" &&
 	write_script my-hooks/sendemail-validate <<-\EOF &&
-	filesize=$(stat -c%s "$2")
-	if [ "$filesize" != "0" ]; then
-	>my-hooks.ran
+	rm -f my-hooks.ran
+	if test -s "$2"
+	then
+		>my-hooks.ran
 	fi
 	exit 1
 	EOF
