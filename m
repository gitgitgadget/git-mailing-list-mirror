Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04CDC32771
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 02:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B82D2173E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 02:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajMm8+QH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA1CJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:09:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37211 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgA1CJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 21:09:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so6144627pga.4
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 18:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TijNlN80iB1WW2ANh0blPD3Dwgda2gyNjuWs1AWw1fY=;
        b=ajMm8+QHEf4+vKaK8lHGb9zsk1zl5T2taVm+XATb1okzgbsvzF87vaCleUSnobUYYs
         kyXOPbGIgjctlUPJlWAlca1O5UnfT/TDUQem7qXyausDynoSad21N49w/eZ0QB4NO9M/
         rHxXtXEdYeEQsilNfwDr/9PkkKRQ+oMJKTgtIA1Qdrep8jByOxoloLOETEBRk0raefg5
         UL/TpZYGKi46ZRXN14Tdxjp7rpkRpbD4AHmturTY6iqY0LZ1PLAx4jOv6g5VsjaAmfEF
         bYpHokxlZV79IlIqSSQpgsW+jZc1pwIXDWz4RbTBpZGRvurrrom7Tb2vDJQ1xnDVZ5nY
         +QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TijNlN80iB1WW2ANh0blPD3Dwgda2gyNjuWs1AWw1fY=;
        b=D0eWs0j+oYblF6+kc25VZz512iXNnDLIgEOwkoyZdVvLMYk1Wo9yeh3TgCs4AB9kkN
         h+m4nR3ymVON3uk7cGQQY+h8N49Zq3c/pT3IY91NR9AvMFSYhr9l4H/fRjB+kwG7CFjk
         o6JyGs8UchbGLAecIPRX0hshGPcqyux1T35WXM07LLMMomuHdGMSJTujyn/SHon2f7uw
         ND3Rs4UDDKaT1ssMxrrWU5QxBzm+pO7xDZo2Mb84jOkqJMaaFc7XAhxAll0HdfnJ95iv
         CuKRMPuH4Cz8Pf4H64GYc0Qq6AdJKuNcRSvRlBPZXhHktUZHoTzCp+05Mm1C4WSB5KIQ
         NS3A==
X-Gm-Message-State: APjAAAUYNmoGBCT3wTWeuY9ruRu+ZqrDRUGkobOKMTijvt4PQjFu7ioC
        DV9HXwWJzZK6pXjpZdBjwnc=
X-Google-Smtp-Source: APXvYqxAlPKKksTkQy31wQ5ex04XvQgYoOYpQE02lWGUZGGCYIC0KxaxwiHXuBSqHVoZIWNja2tjvg==
X-Received: by 2002:a63:7b4f:: with SMTP id k15mr22119570pgn.58.1580177353689;
        Mon, 27 Jan 2020 18:09:13 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id b4sm17474775pfd.18.2020.01.27.18.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 18:09:12 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC] Doubts in an issue
Date:   Tue, 28 Jan 2020 07:38:20 +0530
Message-Id: <20200128020820.6895-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings Johannes!

I was trying to solve isse #406[1]. I have understood what we are trying to achieve for
the most part, but I still need some confirmation. As far as my understanding goes, here
is what I have inferred(forgive me if I am wrong anywhere):

We had "dashed" versions of present day commands such as <<git add>> in the old times.
Now, whenever we call scripts whose "dashed" version exists, it will sort of link the "dashed"
version as well for I guess historical reasons? ;)

And hence this takes up quite some time to link those built-ins especially in Windows. Therefore,
our aim is to remove that option of linking the "dashed" forms by default.

One thing I don't understand is, where is the <<libexec/git-core/>> directory? And what exactly
do we mean by "built-ins" here(does it refer to the "dashed" commands)?

Thanks, 
Shourya Shukla

[1]: https://github.com/gitgitgadget/git/issues/406

