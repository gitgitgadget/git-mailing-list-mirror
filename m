Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A4C64EC4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 08:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjBVIRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 03:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjBVIRW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 03:17:22 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CAE36FE5
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 00:17:17 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id p5so3724165pgh.11
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 00:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqvjDCWjmeqdxANekgLHwKWqRvW/c/e2uMzQHnqi9Lo=;
        b=GG6PTvbOZQoi1uBADUfGaQDQLvK7M/r80jXBu7rZRPoKWOdcAfW5RIABEws9ReWNhu
         SnvdslTZ/Fb39vQAQomKUb6+SUEpuOquMImJ54pcX7L2hW+en7967Z09zinmYaOIYGug
         3eDcmHfUgEBh1Z3RpUqYTgzatgQetNBIxagTy6Kg0RT9om0KO9NeaDB0wAZt0A8a1bQI
         I7Z0zkOM8ukKnxAwKR4N4McCvPT+eRjAZp8xpmd1l6uvIRZW3/NTgvRsG0wTtJF+QgB1
         VtOSw+5b+LTQb8n30gqNgfOqi/3CcwQeNMcQ1sJtJcmwk162ff3ErxKjnUlIn+mJ4N7K
         I5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqvjDCWjmeqdxANekgLHwKWqRvW/c/e2uMzQHnqi9Lo=;
        b=MwQG+O+vZRil/QdBdfbepYK4pDrz0DsvwMucK9zgF16F8DCnZiX/ZF3Vror2nUsEK/
         02rMCkaI4vjtcNzptFNtAoyLIf8kqE5hYubMPbHtawY4KX3KI208+MKoqWTGkGu1q5B1
         79tvyID5qxBO3vz1LLJh05HS0XbPW0AJY412p51QiqMMuSPMr2vKs+RWkoFWRs7TAZET
         +qmpupYxmGUsW1XdEpFQKB9rKW/ODwq+27IdL+QuqMd2VqrPdTbiBtG66T6dtyT3T2wW
         D/IekrFkX3tEVYPczkmQpHxylEPgzd3OCyDa7M2c3xGqKoTXHB9BObdKoqLcWwVfQBl5
         AYXA==
X-Gm-Message-State: AO0yUKWQCTD53jrbshQPp59OKedxLfsWL2upUIw9tFIZLpem05P6rhEV
        swIgb6vjcRIofq6xtc0hbeU=
X-Google-Smtp-Source: AK7set/IC2UYBKIs1IhZa2UPB7xUiFNrSkFwNsVtOX8eN8ZlYVn3bDAsfNV3Ai6wsAHOKTQvGKRAOw==
X-Received: by 2002:a05:6a00:cd:b0:5d6:138f:5599 with SMTP id e13-20020a056a0000cd00b005d6138f5599mr941342pfj.26.1677053836104;
        Wed, 22 Feb 2023 00:17:16 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b005a8b4dcd213sm290012pfh.78.2023.02.22.00.17.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:17:15 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 3/3] notes.c: introduce "--separator" option
Date:   Wed, 22 Feb 2023 16:17:08 +0800
Message-Id: <20230222081708.8010-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.2.459.g1d9d282d.dirty
In-Reply-To: <xmqq4jreemdn.fsf@gitster.g>
References: <xmqq4jreemdn.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> > We use "parse_msg_arg" as a callback when parsing "-m " by OPT_CALLBACK_F,
> > so if we have to read the separator before we parse it, so we could insert
> > it correctly between the messages, So I use OPT_STRING_LIST instead.
>
> That is an implementation detail of how you chose to implement the
> feature, and not an inherent limitation, is it?  It makes a lame
> excuse to give users a hard-to-use UI.

> For example, we could parse all the command line parameters without
> making any action other than recording the strings given to -m and
> contents of files given via -F in the order they appeared on the
> command line, all in a single string list, while remembering the
> last value of --separator you got, and then at the end concatenate
> these strings using the final value of the separator, no?

Yes, please let'me clarify it, we shouldn't to give users a hard-to-use UI, so:

     1. order of "-m" and "-F" matters, it determine the order of the paragraphs
     (remain the same as before, which I need to fix in next patch).

     2. order of "-m""-F" and "--separator" doesn't matter.

Thanks.
