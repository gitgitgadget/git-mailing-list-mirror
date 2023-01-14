Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD7C6379F
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 16:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjANQGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 11:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjANQGv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 11:06:51 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFFA93C3
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:06:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w2so2772350pfc.11
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE2M3/DZxMhe5kS5F9ZCSLYziMRM20vS6EZtfQD11ug=;
        b=jL1mLW3dPu2yq6fhVHMqw6z0dXXsDGSwC2z6ROuU5czGOaUy7qrmEQ3W1Kr5/pEuIV
         foijJ1VwetI2WU4Dj/OykEV4O5nG9BbmhL5KZHGkyv36uqq+goXTqxr+pjTZJ1EBR9AM
         /0wHTzduo7Ez6slg1bYJcex+58GkJDgPGjzVzGRKqN1pCrLztrE2BLzPtKfMBuBxxXhO
         vgfA9KhkPMW0gxyOg02sQU/BGdS21c1SwuJmrEPD2PXTKPggUoBPVyJtSbs1suw8AlkM
         o42QsLA5iFPsVZQ45nxWxqhM+xpM+Fp/1ww6+Cmz3vCrnM1kb75g1oSYvSgKC8Olqvps
         Ogeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rE2M3/DZxMhe5kS5F9ZCSLYziMRM20vS6EZtfQD11ug=;
        b=euuIBqyD3LLep141VRQRtDdq4cTfZRXaYtn6j++mMKqyuaboQRjyCljR//SzHhsC2B
         MtRtFLQGW2YbUhyiOjTxoXdLPehKiGBramwnqfxocEP2tvi+gKTDHYozFp2kfQ4ke6Y+
         gPEiciLkzOuTRUdtk9D3LzDPpMrmAY+d2+ySbYJwRCoxwDfkR4ASL9QThyX0jKDcGZhd
         jgftDfYZTq3jWhceVwMT/WTA3ZhTcRF/J1IJe0G++UL9D1RPCHdC1EJTE9dVlKoybl3X
         2fI8d/f1UrxA0XZ+PLd4+fM5DbmsXT795d9dJmM+mvGvnDEXf3kkgQ4mGLkv/JV+PetH
         i0hQ==
X-Gm-Message-State: AFqh2krue5M4CHn0NzwqqHbjQc9jP9h+5Oi1B7TBxWj8ve4od1bEA+vN
        cWzrBNjLF6DrC9TCrlqo3RkxMR3nMTk=
X-Google-Smtp-Source: AMrXdXsoSaQGVJQGV5bn0+fJCx6ZCZW2flQwAfoUojnb611np27LepUX0T/w+vq6xE/mQ7p/TDGMug==
X-Received: by 2002:a05:6a00:d77:b0:587:102b:edb6 with SMTP id n55-20020a056a000d7700b00587102bedb6mr24921241pfv.17.1673712410566;
        Sat, 14 Jan 2023 08:06:50 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 3-20020a621503000000b00581c741f95csm13599971pfv.46.2023.01.14.08.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 08:06:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
        <20230110211452.2568535-3-michael.strawbridge@amd.com>
        <xmqqedrxm7bn.fsf@gitster.g>
Date:   Sat, 14 Jan 2023 08:06:50 -0800
In-Reply-To: <xmqqedrxm7bn.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        14 Jan 2023 08:03:56 -0800")
Message-ID: <xmqqa62lm76t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Strawbridge, Michael" <Michael.Strawbridge@amd.com> writes:
>
>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>> +	test_when_finished "rm my-hooks.ran" &&
>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>> +	filesize=$(stat -c%s "$2")
>
> That "stat -c" is a GNU-ism, I think.  macOS CI jobs at GitHub do
> not seem to like it.
>
>> +	if [ "$filesize" != "0" ]; then
>
> Also, please see Documentation/CodingGuidelines to learn the subset
> of shell script syntax and style we adopted for this project.

Sorry, forgot to say that if you are merely interested to react to
the fact that a file has non-empty contents,

	if test -s "$2"
	then
		... file $2 is not empty ...
	fi &&
	...

should be a way to do so.

Thanks.




