Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C705C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiKVA5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKVA5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 19:57:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D89AE0772
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:57:15 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x66so4290178pfx.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCbHo70AaF4BDm4dw6hgc5lRuN4UxU+f1EprOZpnsVY=;
        b=XJIjo5DUIGqm7mIUnNJmK6mtrRKHZP9t3UOhhvcEobD4A/s70+zR12xvfcXK1R4Et3
         dQ0KZ3+puSYZXWOAHwgMhb0kftWR8z6S4ee4zZmsFPQIEBN18R/FIlcbiIita+Nn4F0U
         EpDsoViQmnA0a142dSfkztPGOfqj+chu2TDGOJCPIGuY1WuZ9/iWJ6kZp9GO4ymEN9VD
         Qnxbsyf5vpyLge7ExgXnJ7HgqWEzVnKAW0knqPbit2QC618nq3Alpy6BIAgg5VLLtOkk
         jtiZEj9+/+scvroLBvHTSZ0xzhU9cUVn5A05XRATas7/iw5737Vq/5o7TXMavw1yI33R
         TQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eCbHo70AaF4BDm4dw6hgc5lRuN4UxU+f1EprOZpnsVY=;
        b=wGoPRSxd+f8h4FK8yoZw+c+MFhPwFgITC9fMY9FiYST+kJ17YOH8mHOKKFE0wk9IGH
         S7+uD+YLK3aXOg0jZ20pO7v93RUq585CxYLkSjYnjB1o7WGqzZ6N6B4qA5I6Z3IFNARW
         rVxSXkPTGqpx853oGeROC/iuaUbUnMOpLbnd4YagD1uk8Fnq1IsC7FhBvDrd7NDiKba2
         xKX2uR6gjjSmFbOD2DNFTMNuE+5uGCPrQb3uXjpe8BLf0EHrqq12lLCeohhaUlAzSZ5l
         SW6hhhXXTEwHA/4FcuKHEXlhfUIToVG7QX7MoG/AQeK3itmY+Rd6lz7O8o417s88sTBS
         FPJQ==
X-Gm-Message-State: ANoB5pl2aCgfRzhonM9strNn79lrliigFa+jKYPf9/MJbbsnZ8OZyAVa
        IRjufu7MqhZUZ3EgWLVzpN4vy8PAti4W/g==
X-Google-Smtp-Source: AA0mqf6lptB7x+HvJQ1QPWiyGiGtEVq5E1Ke2r4LllFOSg89K7jcr9uyoEySsna6PJ9eCvFoj42rsg==
X-Received: by 2002:a05:6a00:408b:b0:56b:ca57:ba8c with SMTP id bw11-20020a056a00408b00b0056bca57ba8cmr2536136pfb.43.1669078634840;
        Mon, 21 Nov 2022 16:57:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902768100b00187197c4999sm10369711pll.167.2022.11.21.16.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 16:57:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without
 ellipsis, options
References: <20221102120853.2013-1-philipoakley@iee.email>
        <20221112143616.1429-1-philipoakley@iee.email>
        <xmqqfsedywli.fsf@gitster.g>
        <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email>
Date:   Tue, 22 Nov 2022 09:57:13 +0900
In-Reply-To: <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email> (Philip Oakley's
        message of "Mon, 21 Nov 2022 18:10:48 +0000")
Message-ID: <xmqqedtvu7py.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> As a design question, what should "Trunc" do in such a case now?  I
>> do not think we can still call it "hard truncate" if the feature
>> gives "[][]" (i.e. fill only 4 display columns, resulting in a
>> string that is not wide enough) or "[][][]" (i.e. exceed 5 columns
>> that are given), but of course chomping a letter in the middle is
>> not acceptable behaviour, so ...
> The design had already covered those cases. The author already had those
> thoughts

Sorry, I was saying that none of

 * giving only [][] to fill only 4 display columns, without filling
   the given 5 display columns,

 * giving [][][] to fill 6 display columns, exceeding the given 5
   display columns,

 * giving [][][ that chomps a letter in the middle, in a failed
   attempt to fill exactly 5 displya columns.

would be a sensible design of the behaviour for "Trunc", so I am not
sure what "had already covered" really mean...

