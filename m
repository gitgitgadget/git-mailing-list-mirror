Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7050C77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 10:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjETK7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 06:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjETK7U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 06:59:20 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B114DBA
        for <git@vger.kernel.org>; Sat, 20 May 2023 03:59:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-530638a60e1so3880089a12.2
        for <git@vger.kernel.org>; Sat, 20 May 2023 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684580359; x=1687172359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhz30tj47pL/OlrJf9ijFt9gGa58WtNt/lW63wk73Ms=;
        b=aVZzTPb7Mn9gZjQdoKpxMe6fCel80qbr3m7U0s01Ay8T7qELK4A0LgpYwYs7A4ZME/
         LCFOqScZrD78KZCAo1bJgIhskJKPXSlLqik9u1RXzI9+o2+OnjmjgfNKTRErvdOF1co+
         QrJLkrvzPs99vGK1KuUHDPIgjG+zR6PA9kmLFk+QjRwR6yQo9l1QV9kU6hYvhL8qPywt
         14dasJtGMf8FWunxrRgc5Vz3GSNSyUpi9mWTsNfD7dJbNEnMHRmVcP5EeSn1XvsTaFje
         BiPhGa+9FhE2TwcxMrVd10AkugspSrEVQsndN0IxDv22yMmTBKq586OVAqOBSL9U8r8s
         TsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684580359; x=1687172359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhz30tj47pL/OlrJf9ijFt9gGa58WtNt/lW63wk73Ms=;
        b=WyW/PqzY4wyX+VNpwNxRkOkMWxH2zOuuS3vfryVWRZB9mN/TOBMEoiKFQt+M3E99Et
         JaCa7XStKaBZbQGXYw/ea043kkyEmbXifAXHqXe89CD67KsZJTEOxGVXq3ybs3MyHwpr
         1vlzttLnmdCJu2JPCoQdEPqPk2pyLCIU4TOPPOjTjBRnzyjbhLDMHF4aWxxZsXoUr19B
         zBSpDAtpA2eAIOriXsq5FcxLDYafo18Kcl9W9zNF4L5tMcBulVqaDFe5H5SCanFVZ88r
         +YrZVFl9zN7aOdY6HxYRO8avYVEAcNUBP+a2MknkhzSKEQK2m4rKQPFigUAIuEVmVs/x
         GHhw==
X-Gm-Message-State: AC+VfDyuNSf0Yp184a/u9eD+XGtowUYCjajFCvpx9+Hi4E33sPiXsCSC
        PI7UgGsRQVH9uozQQn/oqiOBtvtlKZ8nLRUOUaA=
X-Google-Smtp-Source: ACHHUZ4wYnaFaLH+8+2/XoHN60AM5PtkBdXKMkZvpjzoxiYwq2REdMupR+TzCEZdOyJPFD89jovTMQ==
X-Received: by 2002:a17:903:22cd:b0:1a6:71b1:a0b9 with SMTP id y13-20020a17090322cd00b001a671b1a0b9mr6055028plg.47.1684580359093;
        Sat, 20 May 2023 03:59:19 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.54])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902a50300b001a1d41d1b8asm1217114plq.194.2023.05.20.03.59.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2023 03:59:18 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 0/6] notes.c: introduce "--separator" option
Date:   Sat, 20 May 2023 18:59:12 +0800
Message-ID: <20230520105912.54001-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.356.g67a1c1d0
In-Reply-To: <xmqqfs7tvfc7.fsf@gitster.g>
References: <xmqqfs7tvfc7.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> > From: Teng Long <dyroneteng@gmail.com>
> >
> > Diff since v9:
> >
> > 1. [4/6] support `--no-separator` which means not to add any paragraph-breaks.
> > 2. [4/6] Fix the problems by the Junio's suggestion [1]
> >
> > [1] https://public-inbox.org/git/xmqqsfcjbuud.fsf@gitster.g/
> 
> Thanks for an update, but it was a bit unexpected to see a full
> reroll instead of a new patch to add --no-separator support on top
> of what has already been queued in 'next' for the past 10+ days.

Sorry, so if the topic already queued in 'next', make new patch
base on it is preferred, if not queued yet, wo should work on
keeping commit be atomic on it's duty.

Thanks.
