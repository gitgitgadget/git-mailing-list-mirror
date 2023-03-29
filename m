Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A43C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 12:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjC2MGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 08:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjC2MGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 08:06:47 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CD64ED0
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 05:06:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id d10so9105356pgt.12
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 05:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680091580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBOgXlj+t7MsMa6vbSf7YxMhZhdByXOzRvKuPQjr4Eg=;
        b=M5xcDl1xY8pWLhs7+LacBaOAvRnjlYXHM2SotbG0/6ILYpogNN35qerSrN38JwSH2Q
         AlLqRovOC2Ha32II7ELOwoGWFsGMsGsdROzs/dMbTKFeKD1Q0QRJEgP0OrfHUbOqGaJM
         WGUv/iiUfEdj+X/Su8lFQ6cPDauPg6KK4GBDZKZkeCWCTaeM0hIegkDak2asjnGCDdrS
         ghKN2MKM7TvnEiiOe/srpNyGBjrYj+OgphLmn1IWaIV0acGf/D6Vwa05sclc32b/ci4Z
         7bth/VfaQjVwo57r8jFrln6TWWOPVX7vDCGE39gRVYS5/eJ9BUYXtY3PEDKRuK05GcJ2
         AIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680091580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBOgXlj+t7MsMa6vbSf7YxMhZhdByXOzRvKuPQjr4Eg=;
        b=HXngRih4Q7VcB7oZDJ7304dfKL0ZNa9bK46n5LCgCygoio92Rhi74dTsL4SZm3/qbj
         6OiVkSXI//mO/qtmJ4Zc+wLNr83EUyuRPdAm7JyNIwbITaPKso0eugSWPYjsJVPnUbFy
         zgO2mBP5KiTQS50LHAsoaSn3SjwNdVygqj5aI8Cf9/1vfvOgGxc/wEwN8lpGMmbI889j
         heLwwp9WWDRz6vzWaKf19Ll17/OCl3u4w6nJyUgf6futeEI+YX7gY5tiWQVVCLgUf2MK
         A85xLTTgetwe/yjvJI23qQcQyWq1eg6oGi9RvhaQD7WuhkRkcmNeS/1L+9POrsnHwT7X
         pPZg==
X-Gm-Message-State: AO0yUKU2zc8VdfwqxkS8TG+/3rmREeZmufuueRxG7R3qQb3GEOzxRhm3
        7tDMXFHSt2BBw3hPFVUtrUI=
X-Google-Smtp-Source: AKy350bBK+S3Sc80OXnsjDBZtwnPoIsXG3y4CnzJjhhiixcKDTaYV7m0Q9FtKwq5GOYhhwFTHt+Q+A==
X-Received: by 2002:a62:65c4:0:b0:5a8:b07b:82dc with SMTP id z187-20020a6265c4000000b005a8b07b82dcmr14675628pfb.0.1680091580307;
        Wed, 29 Mar 2023 05:06:20 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.54])
        by smtp.gmail.com with ESMTPSA id w5-20020aa78585000000b005a8dd86018dsm17775341pfn.64.2023.03.29.05.06.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Mar 2023 05:06:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 4/4] notes.c: don't do stripespace when parse file arg
Date:   Wed, 29 Mar 2023 20:06:13 +0800
Message-Id: <20230329120613.11415-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.rc2.4.gb9d12f0c
In-Reply-To: <xmqqsfdog9d1.fsf@gitster.g>
References: <xmqqsfdog9d1.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> > The file maybe is a binary and it could contains multiple line
>
> "could contain"?

Will fix.

> > breaks, if we do the stripespace on it's content, the notes will
>
> "stripspace"?

Will fix, also in the commit subject.

> If a file is "binary" then by definition there is no "line" and no
> "line break" in it, so while I can see what you are trying to say,
> this needs a bit rephrasing to make it easier to follow for future
> readers.  Perhaps something like...
>
>     The file given to the "-F" option could be binary, in which case
>     we want to store it verbatim without corrupting its contents.

Thanks, the phrasing is obviously better.

> But I do not necessarily agree with the logic here, regardless of
> how it is phrased.  Existing users are used to seeing the contents
> fed from "-F <file>" get cleaned up, and to them, this unconditional
> removal of stripspace() will be a regression.  Besides, don't they
> expect that
>
> 	-m="$(cat file)"
>
> be equivalent to
>
> 	-F file

> for their text file?

Yes, for text file. I agree and I actually notice it will be
a regression, because I didn't figure out when user might
store a binary file's content in notes, so I'd like to discuss
about this issue.

> A --binary-file=<file> option that is incompatible with -m/-F and
> "append" action may make sense if we really want to have a feature
> to help those who want to attach binary contents as a note to
> objects.

Actually, -m/-F/-c/-C in 'git notes add' is quite like the
options in 'git commit', rather than "--binary-file=", I think
maybe '--[no-]stripspace' is a bit better.  Defaults to
'--stripspace' which keeps old logic (stripspace the string fed by
-m/-F). If specifying '--no-stripspace', we do not stripespace.

Thanks.
