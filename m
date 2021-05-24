Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95CEC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A084B61411
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhEXSrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 14:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEXSrE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 14:47:04 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8354C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 11:45:35 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so26121871oth.8
        for <git@vger.kernel.org>; Mon, 24 May 2021 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zACjv6Zyr/6MHciQoOyuHtRTfVLD4ITxLQ1NKfqYVGg=;
        b=nFOjmuRmmMxUUyUviXgeIb7IgxDo/Rj7XT9hn7Qm6veOvZ8NsVuCsPBhp1IAWojnq2
         A0B6Q1eObp8ViRCJUmueOF+ChbFqRluYQ4RY5/4iZ/Qq9r4D1tgEKiLstK9lwcmfcyIS
         30hNu8j0Jcup42xpOvy9cUO0haJ6WsqruR/mG7/fNqfdqWDhKksKsvGSYz6luk3Wv+1w
         +kuiWWFdcCmsdWPT3DoWZsVl6U6iJe27P7w/D6447N7N8wsTG5zb269jdgmxiOxInQAR
         XqzxhinLKH5BvhCNQAf1wH82Dboc3YwiIj6/nmuWKj2alH7i7BsfBrwAMkqg1RpoDPt7
         sstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zACjv6Zyr/6MHciQoOyuHtRTfVLD4ITxLQ1NKfqYVGg=;
        b=HIMV/e17ZASPQTIkWCaXlTSUA7hW5o25EuW5rW0zrZKVRclhZQ1kxQBTT4M+TTepoF
         IN3WiqrxrKnwZl+UxxQGy8GR8p1ozOR7Gh4sIYSIVWgtfE3mMcW/wC9XgVtk3Y6ZmKOT
         MeySZQyVrUNc1Yq1C4107IK1IaCdMZmng+a/1B5HnRX9BSGzCsHnAfCLd/UfWH50mkPj
         vZzFLJTU7TIk33n2/Nb9yVWZyeW8O6QPrkKK/9xVE3LGdsdPIRHds+RY0anKUHoJtY98
         q+h0XAQP9wG8MDrcqYdaNr43iJmCUQBBwQ1hjVHLJ9KxkWqRfyRnkSA0TyWwnkFpOuID
         FLtg==
X-Gm-Message-State: AOAM531VjZe5jTKTADTYu7pAlz5zhvywDZSyGVPQyA/YrAVpCsgZy2r4
        88LJHIGTd37brXJmWQICCA8=
X-Google-Smtp-Source: ABdhPJxo7ME8JZe6kIDjl9rrQkVSETMsoek1pvSXt4qiHy4+6NDCwrTeUxiloXlm0dsi65SQ0AjMeA==
X-Received: by 2002:a9d:560a:: with SMTP id e10mr20478111oti.353.1621881935191;
        Mon, 24 May 2021 11:45:35 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r24sm83476otk.50.2021.05.24.11.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:45:34 -0700 (PDT)
Date:   Mon, 24 May 2021 13:45:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60abf44d9057d_1b20920861@natae.notmuch>
In-Reply-To: <60abf32038579_1b209208d2@natae.notmuch>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
 <20210521222941.525901-4-felipe.contreras@gmail.com>
 <xmqqcztgj9za.fsf@gitster.g>
 <60abf32038579_1b209208d2@natae.notmuch>
Subject: Re: [PATCH v3 3/5] doc: remove unnecessary rm instances
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Junio C Hamano wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:

> > > Comments-by: Jeff King <peff@peff.net>
> > 
> > This is curious.  I understand what other kinds of trailers like
> > Helped-by and Suggested-by people sometimes use mean, but this one
> > does not tell anything other than that this person had some comments
> > on an earlier rounds, does not tell us what kind of comments they
> > were and if something was done to address those comments or the
> > comments were totally ignored or what.
> 
> If they were ignored they would not be part of the commit. It is
> understood the comments were incorporated.

Oh, and there are some instances already in the history:

7a9b0b802e (git-clean: add colors to interactive git-clean, 2013-06-25)
1b8fd46732 (git-clean: show items of del_list in columns, 2013-06-25)
52fd972d59 (git-completion: fix regression in zsh support, 2011-05-10)

Although one of those is mine.

Cheers.

-- 
Felipe Contreras
