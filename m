Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FFEC678DB
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjCGSX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjCGSXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:23:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C548998847
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:18:51 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y11so15100322plg.1
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678213131;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRarPfLmapnv+ejEAjP06wyA+X8OGAmkh99tLzqxkls=;
        b=O0GDiu1v7l5h2NagM1tjKFiTSM3UK8uuELAqSm8PrRgpMz4LRpp9i8pvWqrMN9autx
         uFgjliic+TVmrfdKo6BUkgr2X00pHh28ZBtxoBqFp8lAuJ7RFfa7MAJpeNddCOAIGBTY
         kqNaSTRhvuL9pd0V1H1/IV/ri4PXHzbaWq7vERqf1DLiL0BKLfFqfip6AYgL6z0t8ol7
         ADWoukQZ5fRv9zcQsA646K5iRujD/LLNrpbxBpGhRGx+4VnAcPOkCsANoho+3NhtraZ+
         8P3C4Me5rHrx6flsKv9ZODNyG7an0IcK11lvT/c8dYsQCLfrN+ymlQKuj6NzL5JE+zU/
         0KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213131;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IRarPfLmapnv+ejEAjP06wyA+X8OGAmkh99tLzqxkls=;
        b=6Rn4BqtJaryN5Qiz1XnvqFcnnOWUiREHGyVkzyYCypRb6wQpq4b+wm8HFfCVV08ciz
         V1Aj6cUkUz23P0VPdeFWmZLRadL+FJ0ueGTZcOgMwyDdfWq8xwhEjzy82m1oH1Xdmwfc
         PfwkqY+2GaEmVhs46nlckM6d3ZefjOIMiVvr2s+yKlhCSguqqBJfSO3HLSLv7FnN8rxn
         Ow7kA8MdcWd9ImqxZg4+wON5jHFsHmzIfpl+IlBxZ55jlQ59DJpM50wYMh+6UdRG2iTl
         /j2bjQXoOmQQ3uI46dFM9CnFyxmQwcs9MWpWjrwcqxmOb9RX8oX3K216M5pwRLZsAcJw
         aenA==
X-Gm-Message-State: AO0yUKUkUs7JGRbr4kFBNhVV+H+pcWxph701BGVAr2vr/oTlKVOpihVd
        6riCRnfW8aoMF41zU7CBMRY=
X-Google-Smtp-Source: AK7set827z/ptD3Sxpfu04XYH08ByqnwYhaxR6ytPp5XU+PNmeVRrPdU5XHDBEqtYrezC+1+gpiZsA==
X-Received: by 2002:a17:902:e5d2:b0:19a:75b8:f50c with SMTP id u18-20020a170902e5d200b0019a75b8f50cmr19525664plf.31.1678213130719;
        Tue, 07 Mar 2023 10:18:50 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kr8-20020a170903080800b0019ac7319ed1sm4826113plb.126.2023.03.07.10.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:18:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
        <230307.861qm0235d.gmgdl@evledraar.gmail.com>
        <xmqqttyw1ndr.fsf@gitster.g>
Date:   Tue, 07 Mar 2023 10:18:50 -0800
In-Reply-To: <xmqqttyw1ndr.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        07 Mar 2023 09:29:04 -0800")
Message-ID: <xmqqjzzszaph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> redo its thing" must not be done only in reprepare_packed_git(), and

Oops, "must be done only", of course.  Sorry.
