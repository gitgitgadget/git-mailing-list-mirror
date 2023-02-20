Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2780C636D6
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 21:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjBTVhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 16:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjBTVhF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 16:37:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876E821954
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:36:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l15so4057902pls.1
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc4D15doFjv8OFvKs3eBuzJu5aoE3cq5IeMN3n44sPs=;
        b=ghc7IPkA5iddVmOQIYnzJzlY3uJqgxwb9bX6BGGcndKzcMZ+hwrSZdf0tvLa7ct4Zz
         ANlZmQhSmkJrSJBSAE5GgFdyBMxRp8GZ5xsg08bRm6BOhd5SVJo8Ky0cIho9PiuwR4jz
         94PrqlZKLD2Jwf/+rJPICSN5TAI9YQmZgVhEqDJgq2dys/h1VDThHTm4LAmISa3WsCUE
         4Tx786sVWvk23Lm6wsZA/OnNl+q2SERfeRMv/mfeatB+9b1eBzdz36BCpO6J5B46oJyY
         Wdf/NJnJP18nQ8asCyesoVd7+Rr9EHDziAkhTtmicNlsmRALrKIsfM2XT0yb/oW9dwVx
         5d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nc4D15doFjv8OFvKs3eBuzJu5aoE3cq5IeMN3n44sPs=;
        b=d3R5YOD4IeQJTsrSDvlPZm50q9PZDq5wjtBFHO+vrQPnqiSzMbV7ElsaLAnMsWue1M
         lf49v84UjUv8Y5mKWWXvcjlICFS8BkfSWa0uA3THKJ1MkJF7ynJ0fRK6BP7goa2iBRTu
         zDMKnVzzHOAsVgXVubxCCE9QYvlyDUMIUkZg4lNsB2xCvoB+EcreUR33aFOUkQiZlrOz
         rnm8MV9G36fhOoVwdbiAj+huNpFnDRYbKlbjVCYSsNH4Wph8CDkrurpkn/TPNlRoy5k7
         dIXxYN7MDeHTPYa0wmj1HHzmLN0fUV2Ijva9F9LTIxkYT2Vucy4pOWIFSR1IEJxIpN4x
         o9ww==
X-Gm-Message-State: AO0yUKWy4mg9wJ98AIs7KW+Aidr3lgHXEwdHXUExDwTnoR6JPebMl7wA
        WbzqeeoTappwKbVixF7jQ3ScRlE2NJ0=
X-Google-Smtp-Source: AK7set8+DTL0xtdkjOiF3ok3oVmpHWP5lov+/8VlI33HMYhjddWywZRNMfG92C8TzKYSdYyKbqvnOQ==
X-Received: by 2002:a17:90a:7642:b0:234:ae7a:6f05 with SMTP id s2-20020a17090a764200b00234ae7a6f05mr3102749pjl.36.1676929015875;
        Mon, 20 Feb 2023 13:36:55 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090acb0400b00234a2f6d9c0sm1750707pjt.57.2023.02.20.13.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 13:36:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] log: omit tag prefix for color decoration
References: <20230219174631.1040-1-andy.koppe@gmail.com>
Date:   Mon, 20 Feb 2023 13:36:54 -0800
In-Reply-To: <20230219174631.1040-1-andy.koppe@gmail.com> (Andy Koppe's
        message of "Sun, 19 Feb 2023 17:46:30 +0000")
Message-ID: <xmqqv8jwggsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> Omit the "tag: " prefix for tags in commit decorations when coloring is
> enabled. The prefix isn't necessary as such when tags are distinguished
> by color already, and omitting it saves a bit of space and visual noise.

As somebody whose color perception is weaker than other people, I am
torn about this line of changes.  Accessibiilty folks often warn us
against designing UI that differentiates two things only by painting
them in two different colors "to be inclusive", and the above goes
directly against their guidelines.

The only saving grace in this case is that I expect that tags are
named very differently from topics in well managed projects, and
users can tell withotu "tag:" prefix even in the output without
colors, and that si why I said "I am torn", not I am not outright
100% negative, but still I doubt that the upside of shortening 4
display spaces is worth going directly against inclusion advocates.

So...
