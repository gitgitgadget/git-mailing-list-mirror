Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDBEC636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 21:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBUVbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBUVbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 16:31:35 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA0518B
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:31:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id pt11so7216306pjb.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmUH0J/KI9A0EUF1mIOfrWRYM/bAEVL0XiJ9wUXDMtM=;
        b=ZnpcU7i87B5jApubdnf3sSA9b/6lTnOlBYTsEEeiFTTGQNrGyC8Ftm/apQp8tF4fH/
         IQDgF4pCKzHz8bFrt96z8XmCyBCbqbTGEmuCraZBM1s/PcAOe7rOKAnhmDgHsm9RaEdw
         PtNUpmvbcy4Mm4ChvCTWMePHumcyVW38qcbLIYhHfSJ1COG6JA5tfVCu2Lz3NIiKmYIv
         /c5xDFFJMwA5tNvZGtu9T6KKupLuKdzAooVDTMpP3IQu9rqMF/6IPRDHJZ1xoSPag1uz
         XzA79oj/h7i2B+UsN+kaDPvYVuaCHwx2FpPSnsS5LdZGpE84ofQfTR1T1fLvs7klTdHW
         bZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BmUH0J/KI9A0EUF1mIOfrWRYM/bAEVL0XiJ9wUXDMtM=;
        b=COPmsz/55SABkxoLoSfAfhh32EAnU1kp+MleY1Dw8M4RTT8ObDXpO7O2DZcRBsLBOv
         3f1UH/WaD6HQhL+RC7DOCK69iQlXl256cQjar62B+m4IBkJEuwF8NYP9t69S4nojwcLi
         3TXuM7zlczf2tKmhto6jFTirMpl4APBvkds7HgeOUYq6SZ4FJidBHsmRiLcv91piVntB
         6o5RLbCZl1Ai6hkVWs3G04Uo1BwTzKlN+BvsHuSbe44Vf2spl5lDe6RLGgmOUq82/HPl
         5/UMCWyp9TuYkJiE9dt7jlfrAP7cicL6X9eByxAbL5qMtkObULIpapUygj4BtaKmxb+e
         RkAQ==
X-Gm-Message-State: AO0yUKU3ka+pfYliENR+6X94dd+N4/q2yOT9J1oa4VL+78ruclT9CgAf
        W10xF7gdPAjR0eG5DmbLL1WJbfIbQVs=
X-Google-Smtp-Source: AK7set/jb/m6E19z6z/07RrAzuAlk930zczzmDnC6EAnEtadzRTNi5PAHU7DFfOejXdPQoBQeGfOhA==
X-Received: by 2002:a17:90b:33d0:b0:234:b35b:f8ee with SMTP id lk16-20020a17090b33d000b00234b35bf8eemr6339671pjb.0.1677015093586;
        Tue, 21 Feb 2023 13:31:33 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id n18-20020a17090ade9200b0022bee398e09sm2872789pjv.4.2023.02.21.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 13:31:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 3/3] notes.c: introduce "--separator" option
References: <xmqq7cwhnql3.fsf@gitster.g>
        <20230220140046.16986-1-tenglong.tl@alibaba-inc.com>
Date:   Tue, 21 Feb 2023 13:31:32 -0800
In-Reply-To: <20230220140046.16986-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Mon, 20 Feb 2023 22:00:46 +0800")
Message-ID: <xmqq4jreemdn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>> > In addition, if a user specifies multple "-m" with "--separator", the
>> > separator should be inserted between the messages too, so we use
>> > OPT_STRING_LIST instead of OPT_CALLBACK_F to parse "-m" option, make
>> > sure the option value of "--separator" been parsed already when we need
>> > it.
>>
>> This is hard to grok.  Is it an instruction to whoever is
>> implementing this new feature, or is it an instruct to end-users
>> telling that they need to give --separator before they start giving
>> -m <msg>, -F <file>, -c <object>, etc.?
>
> No, it's not the order of the user give, but the backend we deal.
>
> We use "parse_msg_arg" as a callback when parsing "-m " by OPT_CALLBACK_F,
> so if we have to read the separator before we parse it, so we could insert
> it correctly between the messages, So I use OPT_STRING_LIST instead.

That is an implementation detail of how you chose to implement the
feature, and not an inherent limitation, is it?  It makes a lame
excuse to give users a hard-to-use UI.

For example, we could parse all the command line parameters without
making any action other than recording the strings given to -m and
contents of files given via -F in the order they appeared on the
command line, all in a single string list, while remembering the
last value of --separator you got, and then at the end concatenate
these strings using the final value of the separator, no?
