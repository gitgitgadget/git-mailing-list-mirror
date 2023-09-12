Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84860CA0ECE
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 03:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbjILDYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 23:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbjILDYU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 23:24:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA723AD3F
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 20:03:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fb5bd8f02so1718003b3a.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 20:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694487838; x=1695092638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OisMIXpupQROdVqJbE3xzV9GGeeY7cY3zNKOKil2XY8=;
        b=uRKbRUPTM1vzYkI2lkg6tqJPs9apwPVHLZVVTrjNL1m/eELrNrq1FhgnrLu3+C5xMu
         +BIeK7bFHwvru1Vb4V2H8GdXwhC1JLi+7ipu/Oiv6BzjRrqcqxu8EczdSQiIq8DBov+I
         sZvZAd2c5WmVIVP+L9TCxyCqP1cehddQPx6fhG9wRsfzqBWSXLZbDOaJdhI6eKL6KGBU
         3mMNE/F1X6Ae/pt3rzR/5Jsp/WiREv8be5F0Q6NO5vm/jZK/xb7zj6ka/wxmsaYwy0wF
         KAAlVKk/scX2cTiWMakkTBS88SVh45NobVHaxE73MVc4SDtQ84DbfFOdl74rs7vmTOzq
         IG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694487838; x=1695092638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OisMIXpupQROdVqJbE3xzV9GGeeY7cY3zNKOKil2XY8=;
        b=JZ+LFTFoRcwXFCy8u70M6Cc9cBABEWtU3xHQDYzmJ0cyMz7a/OjcIwF4QrlaZcaqU9
         wPgAB+UvsL334j0ThT5Atw2l+JqmkWdKBoEnqiI3VMWZLxK6KP0GE1Tr2HN97TfMf2Su
         eVU1q3VhCLFltlN+eZOCwQSHopBu9PBLpPW28fAdKAbVNLe30tg/D5fPi8nRPO1wd4lA
         phWw4RIc0FInKkoKOskVXk8X5sLTH2F6VDLyaZLWFQqcg+3AQXosrDgDRDIIEuX71Mvn
         2JZ9QwYcvGxwqc4FHciTAjlqVtnQTR1+PF8r3IOpzMCSMvDZr/Qb5a7p95k0bUBrwY6a
         vK7g==
X-Gm-Message-State: AOJu0YxHfhQB6TSzXs0k7Z9LLDMpRMSJDN/Y1D/3uDy+y/C+k5HnAyTw
        eucr89c23aZnv+XQVZ0RWhTH+wLdrTQbpMWJRCvI5/4pmpRmNXS9ejF+UQ==
X-Google-Smtp-Source: AGHT+IHi8o0NvS/PZWCPGhrHOc/SlZ1TM2msB+W8M47zv7hLrzQQFxtoacf8ZuYyq1BYD0Akv4eY6UnpciBmlPuFQYc=
X-Received: by 2002:a05:6a20:1442:b0:14e:a1f0:a8ea with SMTP id
 a2-20020a056a20144200b0014ea1f0a8eamr11459626pzi.3.1694487838179; Mon, 11 Sep
 2023 20:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230906060241.944886-2-sokcevic@google.com> <20230911170901.49050-2-sokcevic@google.com>
 <xmqqsf7ks4nn.fsf@gitster.g>
In-Reply-To: <xmqqsf7ks4nn.fsf@gitster.g>
From:   Josip Sokcevic <sokcevic@google.com>
Date:   Mon, 11 Sep 2023 20:03:47 -0700
Message-ID: <CAJiyOijMvqK184wFgoXFyX5kmURkX3k2OmuiBpArikj26iHpMA@mail.gmail.com>
Subject: Re: [PATCH v3] diff-lib: Fix check_removed when fsmonitor is on
To:     Junio C Hamano <gitster@pobox.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 3:53=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> This certainly is more "complete" if simpler than the previous one
> ;-)
>
> In the longer term, we would probably want to enable optimization
> using what fsmonitor knows, but as we have seen in the review on
> the previous round, this code needs a bit more work than the
> original we are reverting here to get it right, and in the shorter
> term, hopefully this would do.

Yes, I agree we should optimize this in a follow up. One thing I'm not
sure about is if we should try to construct `struct stat` using
`cache_index`, or we should check for `CE_FSMONITOR_VALID` in a way
that `stat` would no longer be needed for those code paths.


--=20
Josip Sokcevic
