Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E05C77B75
	for <git@archiver.kernel.org>; Fri,  5 May 2023 21:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjEEVTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 17:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjEEVTU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 17:19:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88112525D
        for <git@vger.kernel.org>; Fri,  5 May 2023 14:19:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643ac91c51fso627658b3a.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683321559; x=1685913559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtML5XACb/1CiZUZrKEh0jfKKw2LjfRqLzBpdkuc2JQ=;
        b=CROi8Lbawao5TdGKWuJw1/AJ3QFjuF8yT1IJoIZZi46TQSDme/fFb7jH9QU+Bks0OZ
         0QQviGXRevDYUiv/z9D2aM+6ybm2NiUvoNxenNTka2170J9xET1CQpD9evEvfw+T/DPe
         91tdgclzZ6UBHcaRxXVZSZOEMD+1dPNzLFbOuW5tQ6wmqbbrqkNhRfrc6edGq2ZoThE6
         Z02IGF7L5zAQanSnygBKrVachhH/Jge/4t8vWza3wZOPVPQBO5TlK0Aicup5dmvVlUjN
         5FHa5fXTn+FGq2Bh89k2i9c6/QGvW/huROu/Eys90gD4JEz/lObvej987YzfSue7S0WX
         AB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321559; x=1685913559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZtML5XACb/1CiZUZrKEh0jfKKw2LjfRqLzBpdkuc2JQ=;
        b=Q1pY1Tdi+KFsucvF+p5GDiJryOjosUjSfjEBXZKedtrSqDjAHp4FKew3xx1NPocgBg
         yveidQFO3cQQIA0Cb4TEoKTiCXNGyntyj6EW//KTZDQEKER3swSKSjZCCt99aFTv45Jr
         fSC22Tie2TOpjI8ja2ZXCspUrvH4XouymtFGW+YHrBw7Dif4gkLPL068cjWyaoQYhH+p
         cHQjhPPP5r1mfvmnI4i8wePO8qaGQHIN9aUXy6p28HrL40ZqNz1aFE9L2Gl2bS/BeIew
         AwamZDcUgauDBN6kKgiY0Uy87d7Ml2uup4tsd7ZieKu/POnpLaez6Jj5EpsqS7eMA1jR
         NWrw==
X-Gm-Message-State: AC+VfDxzCXKV5M/npAjNp6Uu1HQoRM9HrGQbHJKmyZIgGRRZqA/tIgLU
        wMhITPcSwLAxhSzNWYIbK8DIwZYWH38=
X-Google-Smtp-Source: ACHHUZ6cF0dnbMYCnCghclSOsFEWTTY559uJDP67DDyXXjsAxijuHTiXHLGmsQqWtoZq82v4RVqUjQ==
X-Received: by 2002:a05:6a21:7890:b0:f5:39bd:3023 with SMTP id bf16-20020a056a21789000b000f539bd3023mr3533020pzc.26.1683321558576;
        Fri, 05 May 2023 14:19:18 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b0062d859a33d1sm2008191pfm.84.2023.05.05.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:19:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] dirstat: leakfix
Date:   Fri,  5 May 2023 14:19:15 -0700
Message-ID: <20230505211917.2746751-1-gitster@pobox.com>
X-Mailer: git-send-email 2.40.1-476-g69c786637d
In-Reply-To: <20230505165952.335256-1-gitster@pobox.com>
References: <20230505165952.335256-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  t/t4000-diff-format.sh         | 34 +++++++++++++++++++++++++++++++++-
> ...
> +for format in stat raw numstat shortstat summary \
> +	dirstat cumulative dirstat-by-file \
> +	patch-with-raw patch-with-stat compact-summary

Unfortunately, because t4000 is marked as passing with leak
sanitizer on, even though this series does not introduce any new
leaks (in fact, there is nothing in the series that allocates pieces
of memory at all), the CI will fail with the sanitizer job.

Needless to say, I hate the current arrangement of these tests.
Those who happen to use tools or features that have nothing to do
with the topic being developed that introduces no new leaks are
punished by a test failure.

Here are a pair of patches that plug leaks in dirstat code.  This
allows the "fix interaction between -s and others" patch that adds
a test that exercises --dirstat in t4000 to be queued without
breaking the leak sanitizer.

Also t4047 that is about dirstat can now be marked as leak free.

Junio C Hamano (2):
  diff: refactor common tail part of dirstat computation
  diff: plug leaks in dirstat

 diff.c                  | 34 ++++++++++++++++++++--------------
 t/t4047-diff-dirstat.sh |  2 ++
 2 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.40.1-476-g69c786637d

