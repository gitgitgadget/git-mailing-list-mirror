Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC768C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 08:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F8F61412
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 08:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFOIYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhFOIYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 04:24:13 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B70AC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 01:22:08 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so13510673otl.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EiRqwyvTD4XCZIPHqpgfm8SL3hzheAhrfTTMGjs/U9E=;
        b=Z55PaaPrqeKawgSA7QqZi77uK8VWpCoq0Y6Qzc1Sznh+wkwOHd8WmoVaRS2z4TFvOD
         KVMQnWC6GTS/zUapqX4GbCr49rnpnqwEPl6O4XGW0VPxVbMJ3kTTbLL+MRn7On0374AC
         muqKWXbFmIZgak8n6VBdInj9D3AT3KNhe/CH0O//h9A8T5jAQVslaFCf5ZaQzoYDjN04
         tVKvvpvg3LN205ZAXp12JxfvnEWH17mUhbHZD1THI1lEjEyM7uUC3fqQOoWEzhBjd3Fe
         1omYlMpNX6ZVM+1oFIzsLkrrrM41CULNiWBaQSh/hH1UAt+a1d8buFLfSSQeJi7QUzTq
         vVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EiRqwyvTD4XCZIPHqpgfm8SL3hzheAhrfTTMGjs/U9E=;
        b=BDgbNR7xf16gQaPBXfMkjFi4O6aZxfJIGlDE3d29enMpCOVw7qPtsXlU1ImGpM1Txj
         wfUFZrH5ZdyjG2rXUKyWibHb8i0L+m6gDePLxKgGVXflligkYjaYNV0PteB1XdqxE0km
         iDsX4VYQk8kC5wdeKYM+TAUkGEXMy39OgwpDW28kmE3CDqxAPuN0DO2TnpUe1yu8SHHw
         46X5aqIpIwQVPrFy2p72VUVMUsuJhfj1pnRkrUYX5pWtblvmQOVIP+4IePBFOzowrz2j
         ixACx8pXn04QsAHAYwzQHlj45pU4UxLPLrMu1FqhMgnUdpN1GRtoG00b9Afdf2kgbEb4
         wA/g==
X-Gm-Message-State: AOAM530yDXIde6tHof85HCDqZhVgkhU31Nr8OmVEjNmgSBk6psVfKj7n
        FSmVfVtmGto+/Xyfve64jkE=
X-Google-Smtp-Source: ABdhPJyKtpr0NOIaOGWypf6Bt3mtd9cVvio/4M6Qje7YMJeAmAyqqft6MoCUxEggfw4qpKtHl7s9wA==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr16283495otl.70.1623745327294;
        Tue, 15 Jun 2021 01:22:07 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o2sm3620364oom.26.2021.06.15.01.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 01:22:06 -0700 (PDT)
Date:   Tue, 15 Jun 2021 03:22:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Message-ID: <60c8632d60027_e633208db@natae.notmuch>
In-Reply-To: <xmqqbl87zyra.fsf@gitster.g>
References: <20210613063702.269816-1-felipe.contreras@gmail.com>
 <xmqqbl87zyra.fsf@gitster.g>
Subject: Re: [PATCH 0/2] Trivial cleanups
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > These perfeclty good patches from 2014 weren't picked with no good
> > reason.
> 
> These are safe no-op changes, but that does not mean they are good
> patches.

They are not good patches because they are no-op, they are good changes
because they correct the flow of the code to match the flow in which
most people think.

  18 is younger than Mary

is not a sentence most people would agree make sense.

> It goes against Documentation/CodingGuidelines to bring it
> back again now, which is a good enough reason not to look at them.

These are not style issues. Refactoring code to make it easier to
understand goes beyond style.

Refactoring this:

	static int is_same_remote(struct remote *remote)
	{
		struct remote *fetch_remote = remote_get(NULL);
		return (!fetch_remote || fetch_remote == remote);
	}

	int same_remote = is_same_remote(remote);

To this:

	int same_remote = remote == remote_get(NULL);

Is more than just style.

But suit yourself. Sooner or later somebody is going to fix these
glaring mistakes. And they are mistakes [1].

  Yoda conditions are widely criticized for compromising readability by
  increasing the cognitive load of reading the code.

Cheers.

[1] https://en.wikipedia.org/wiki/Yoda_conditions#Criticism

-- 
Felipe Contreras
