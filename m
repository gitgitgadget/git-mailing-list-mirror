Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C35FC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 01:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7158820734
	for <git@archiver.kernel.org>; Fri, 15 May 2020 01:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FblVL7zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgEOBeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgEOBeD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 21:34:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA111C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 18:34:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r22so212597pga.12
        for <git@vger.kernel.org>; Thu, 14 May 2020 18:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvWUKMRKrszTKjHK7Wj+MX4WhKViRWim+dxt/xtMaPE=;
        b=FblVL7zGCG3L97RsiXDjPcudlGUQSFi/ggW+BeX94QfRR5VDRSNTXtg2Fw0LeyMDx2
         mKuVYkkvsekd3v39Yo7KZT+to2gZRafUeY/cQDKQoDQJx0ZdRDitVK5IFIbYoiPWkfjo
         lYVb9GCxc3eGION9qmUbLOmJPRQg5P9qcIbmhAnjQp3wq/1aqHrgN5Hdu4VBIilEpYHd
         QC0RE7JQGZvgJqvLhwQqtnAuRLqsiZoSLUgAONiCqsHj35SdoDqdzCjjy7iZCkylJ4NI
         c2soTE9aqaBnuYbvvlFvykg6hyX5tWQ4Dwl2x3e8dQ+8gON2t5RHQQB5bim5ofk1YfgL
         fdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvWUKMRKrszTKjHK7Wj+MX4WhKViRWim+dxt/xtMaPE=;
        b=CzoY4u4Bc33fJt73LIIU0cqfW8/rA9dvLv5EKUiRhrdZLd5XtbpyHEwBAJWCm4eKjH
         8vx372R3DO2Ars9xXA3Bvy8MzMmdeR4/HzDY8JbWenO8ErzhQT0ygr6OzPKuJSw2vZai
         SwegSny+7uAdJyaDV7WyDEbhm1SG982rUkkb1mp9LMKhUab2pZqpomtgs7INPr6TMw7G
         yX1+DucQgRk6wDKnlBytEDroeApJnD7T1PZN3BRaaF1/Ys9N7wjFZp5byBh+YrhP4R0U
         JgmPaFZ9IE3Y38IqrsV9BanFHDCvjpX7gAelRAsB/rGtJyjOClnpsS/jGkqIUIGaFSss
         2YCg==
X-Gm-Message-State: AOAM5324BeWxQUeh6dyYg191cOHJkD87CEygIH8QCAvk/zOBrUnkcWVB
        FC4VjxUqVkvHqppPPZyxa93gwbCTEts=
X-Google-Smtp-Source: ABdhPJyDJobplmmtNLksZNRsWfexQU8X4bNfEg8sKRhw+DzAQkPq6uQwsLp3HGZ/Sa2r6my54uvnVA==
X-Received: by 2002:a63:5642:: with SMTP id g2mr876365pgm.211.1589506440961;
        Thu, 14 May 2020 18:34:00 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.5])
        by smtp.gmail.com with ESMTPSA id c63sm402666pfc.2.2020.05.14.18.33.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 18:34:00 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [L10N] Kickoff for Git 2.27.0 round #1
Date:   Fri, 15 May 2020 09:33:28 +0800
Message-Id: <20200515013328.67388-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.1.120.g98702cf3e9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi,

Git v2.27.0-rc0 has been released, and it's time to start new round of git l10n.
This time there are 72 updated messages need to be translated since last update:


    l10n: git.pot: v2.27.0 round 1 (72 new, 37 removed)
    
    Generate po/git.pot from v2.27.0-rc0 for git v2.27.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
