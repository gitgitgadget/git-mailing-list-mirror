Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E973C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DD62076A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX+T0YgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgDUNLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728391AbgDUNLY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:11:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46AC061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:11:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kb16so1326006pjb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsnCnjLS8eQURncea4tgKI6ED2XRjRS6coNC79gbTZ4=;
        b=eX+T0YgBwD3Ro9b5HPKwmjgWByAgjGv7DYhgDDEtu15z5E19xvNmcl7xEhbbd3CaTz
         Z8lMFrGWMjjWV1EPsD7Mz1KHQ7Z+wYEjKP87NHlaMCVP3TioYcI8kufnfXAM7VGaFAXG
         U8Pnz4Vtg/Y8gxIKZSIdI3pL6F87Wl0s5OmfmY6Ucx1xMz3x2maw/LiiFk8C5K2WuYkA
         TSqjvd2jMbhjbndxFOhH/taKWbQ9aWsQ9N2QY36lXr7JTOkRImextgaK9Sy96y86sKl/
         E9HGurHXwC1X3UFYodxzuVEURv0Ha+Ke4eBWLgSOFmHBAspA7D69oEfLviOTeTrOX0Lm
         21hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsnCnjLS8eQURncea4tgKI6ED2XRjRS6coNC79gbTZ4=;
        b=C+nrZV/B98avf6KKtSx+zYZ/kFo8vCkuz29t3UMPr4Atdw0yePZZ1Qktcu4gcwZvLG
         qqxGCPTunOrppsYHosWntqve48jItodA1kLfMG7HLbVRFQ/WAd1guv2WZ5DTCJ6tH4aa
         u4BrlTdCumPrWboTPrUdzI/NtBtS8YFfzRC7rnggpklvol4/zCImh0F7rOtuGaG2nqgz
         SaKu+28GnadM+nQSSBz4+tZPmxN7SZfaSazGtXtSQpwXsGCYwGf+NeEgS41gFk+Oz/NB
         OSpixYfX+swtij4EVVP408Uk6k8ZmXBXkPqfOW31/7Jjs+9U+BLnBZV/Iu1yq4swXj7K
         T5GQ==
X-Gm-Message-State: AGi0PuZQEa5AkWWNHWzMXhGeMcB5B6vymxXpK/hrekn5fwifJa9aTtpb
        TEFWdWDxH+hG/1wq8XnlTJa8D6vS4uw=
X-Google-Smtp-Source: APiQypKvLsHZISGJq3nJQHVS48ITV8OD9qGPA99aWWNxtTml13QFvZwiw+2biKpQaoR1fnDXiLhwdA==
X-Received: by 2002:a17:90a:414b:: with SMTP id m11mr5435517pjg.160.1587474683809;
        Tue, 21 Apr 2020 06:11:23 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id i8sm2529422pfq.126.2020.04.21.06.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:11:23 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3 0/4] gitfaq: add issues in the 'Common Issues' section
Date:   Tue, 21 Apr 2020 18:41:08 +0530
Message-Id: <20200421131111.29201-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third version of addition of issues in the 'Common Issues' section.
In this version I have:
	1. Changed column wrapping from 90 col. to ~70 col.
	2. Removed the issues: 'rebasing-and-merging' & 'checking-out'
	3. Added issue: 'shallow-cloning'
	4. Separated the issues in individual commits.
	5. Corrected spelling and grammatical mistakes.

I decided to drop the issues mentioned in (2) because of the lack of clarity
in them. As Junio advised, it would be better to improve their respective
documentations rather than adding them in the FAQ.

I really appreciate Junio and Brian for reviewing my patch in such great detail :)

Regards,
Shourya Shukla

Shourya Shukla (4):
  gitfaq: files in .gitignore are tracked
  gitfaq: changing the remote of a repository
  gitfaq: shallow cloning a repository
  gitfaq: fetching and pulling a repository

 Documentation/gitfaq.txt | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

-- 
2.20.1

