Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C4C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 19:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjDQTKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDQTKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 15:10:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68611FF3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:49 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id by8so27443118ljb.13
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681758647; x=1684350647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfv6vNIM+5tdt1iXSSS5+QYNUMy/T7y+TThYUXRQzV0=;
        b=dBPxUfZpBxxTe4ft1bpflFFshP0K8/3ohVGZyXa7ofVbm8S88wegAuuZ8qCLMAV17Q
         2+jkfjHtUNsA7+ethLiT/dE1iI1t5BW48oWWnehtdyQ9GQ+I08gi8rjbZ5KzhtoxrfeO
         H+WnFu2QO6Fl38h8kXA1w03xVyOVNIApFdHfr1Cj2GDTih7v8+53zGV90NkYyQkAu5u/
         7ToAb1/M2hygJ9Lh+78gOSKo+nMzISwmRA0pEnzRiuxCfiYaKJFb6wkEBXLNl3T7aE6B
         +uHLn85zJGGpWfqQYBNqZyMHetwwp2XsZ2ZHGno/yvso7qFy4O5Mbsf+ysFVq0JbkjJ7
         ry0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758647; x=1684350647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfv6vNIM+5tdt1iXSSS5+QYNUMy/T7y+TThYUXRQzV0=;
        b=KulYFS0NGuBC36C/x0bng3n2QPuMQR2scaD/aDud3Seu9iNo850L4YbeRTjY3zIe/6
         R0DcBuERjrVft0Ah1S6YqyfQXcePFHiYur6FQe+Bjtk5BPXPeqejHa7oIq2P3Ygfx57r
         T6VWB9TbQYa9cdER3ZiEY56zb7u2wGwFWGNn+CUD6NHRhJL9vuL+ocd2RHP+4ZSC2+V4
         gBfXiBCrGTRhMIGSdl34e05iZ2NyqQxD9vMba/a6brbcvawpJazui2j1tlX6kzveVXJy
         HtuvMvw0psL47K5jz259DqGJt1nGwS45xo9kBg/Ou6nYXR2RwcAcV8QW9z6UHatg/Hob
         I7rg==
X-Gm-Message-State: AAQBX9dgbHVdP8rFUQL8YOkhoyJHbwNpfLADmSBMYq+2RQzUbaoG4UZz
        8zf69NLWu4kA0WwaPLDxbrFmxIl1ch40nw==
X-Google-Smtp-Source: AKy350YwXMih7UFYYLPJo3NtCtOEN5FTd3NF4jPpEoK/T+L0FNoR74YaBqsYkKjbbi+rmeCEC3Xhug==
X-Received: by 2002:a2e:92d7:0:b0:2a7:80ff:86cd with SMTP id k23-20020a2e92d7000000b002a780ff86cdmr4413768ljh.53.1681758647461;
        Mon, 17 Apr 2023 12:10:47 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9c81000000b002a76e600228sm2304319lji.47.2023.04.17.12.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:10:47 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/6] t: fix unused files, part 2
Date:   Mon, 17 Apr 2023 21:10:38 +0200
Message-Id: <20230417191044.909094-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403223338.468025-1-rybak.a.v@gmail.com>
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Creation of files from redirecting output of Git commands in tests has been
removed for files which aren't being used for assertions.  CC'ed are authors of
the affected tests.

v1 cover letter:
  https://lore.kernel.org/git/20230401212858.266508-1-rybak.a.v@gmail.com/
v2 cover letter:
  https://lore.kernel.org/git/20230403223338.468025-1-rybak.a.v@gmail.com/

Changes since v2:

  - Added "Acked-by" of Øystein Walle to patch 5/6
    Cf. https://lore.kernel.org/git/CAFaJEqug4bghEMnEQzGDN10EqM8e8iSf5i12AvOm+NZzDCQKOw@mail.gmail.com/

Range diff:

1:  828bb18bd7 = 1:  828bb18bd7 t0300: don't create unused file
2:  a5b299a0c6 = 2:  a5b299a0c6 t1300: fix config file syntax error descriptions
3:  806df16415 = 3:  806df16415 t1300: don't create unused files
4:  6742c957e5 = 4:  6742c957e5 t1450: don't create unused files
5:  6c173a5c46 ! 5:  19ac488922 t1502: don't create unused files
    @@ Commit message
         Don't redirect standard output of "git rev-parse" to file "out" in
         t1502-rev-parse-parseopt.sh to avoid creating unnecessary files.

    +    Acked-by: Øystein Walle <oystwa@gmail.com>
         Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>

      ## t/t1502-rev-parse-parseopt.sh ##
6:  d508c1def3 = 6:  c41657be88 t2019: don't create unused files

Andrei Rybak (6):
  t0300: don't create unused file
  t1300: fix config file syntax error descriptions
  t1300: don't create unused files
  t1450: don't create unused files
  t1502: don't create unused files
  t2019: don't create unused files

 t/t0300-credentials.sh            |  2 +-
 t/t1300-config.sh                 | 10 +++++-----
 t/t1450-fsck.sh                   |  5 +----
 t/t1502-rev-parse-parseopt.sh     |  6 +++---
 t/t2019-checkout-ambiguous-ref.sh |  4 ++--
 5 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.40.0

