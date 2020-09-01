Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C697C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163062078B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvsnunYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgIAUHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgIAUHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 16:07:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7513C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 13:07:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m6so2903714wrn.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=uek73eyIFxWid8QmXHJBLByrWaNOW33sEDmXcp8Zkbo=;
        b=WvsnunYBPA6wvHBjAmx/83v/Q/mG3VVwr+qMT4g9tcUFMzMkuyPVfmOnfYXVwGiYp2
         rrbxKOf0vbDC0639uxrSVq+Q+r5OdwZbeQr+RjhZs5i1PDskYp2+ylVMIxXDpbqPXLZz
         QFyKq4sbdOjA8fphYdmsE7XVVlp+Qc3+VEL/YA0ibQenJMis+qSmmdcXYjXD2yldzFa4
         YiUX0dwZT+2oAvhAx9qYf2so7HGcgQTFlxaN6DRYjlnBwEqG39DIg088P2YJtRVkva75
         kN0OySQMYL2B0zG7hnbcHzz0tvMK2hjLwaAVsF0YZGSEirPVvCNuBhMNIjE0ghpN5JFs
         keUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=uek73eyIFxWid8QmXHJBLByrWaNOW33sEDmXcp8Zkbo=;
        b=XQqYmN4ovQi7wVE+7kqDUVfOg7webuWsgV8uXRG4PlsEqRpgnxrOXxbyZ1OVGr1F9q
         sIvCwaiItMrlaIfsEdkXF665i+Pf3i577vhP3xPdamLo4L9HQNAg3PSmBvVyi17Z4q2b
         SKH4qzviDuVjxPeExA15w5e/gDQRC1o+xDM6/eCtKc9VDhJEat2SYD+4C+1ClKf311PO
         jvrypZJCn5YquAdZYiJv0Kuj5ZC3VNrZvEY/YkTPI6js6hBE/rmPH79o8VccKHc+ipyO
         eKpoODStKCGi+A8EiItBhPiu06LsQELm9C9c4criZiB5XLI8QG6uowzAR/hev5HLeBoB
         TyTQ==
X-Gm-Message-State: AOAM5309H4SQjKWAMhVxi/rUmLM/MfvEyqtUpnFG/AK8MQJLL7GJ75tf
        yas6ygEiufENW+T9+65+uE2QchFp8Uk=
X-Google-Smtp-Source: ABdhPJwEUSUq36KBz5tjlQOAVYD66iqJuaDO+1tjxXmot6XqF0NsVeOExDoTfBpC1N62lmbgU03jMw==
X-Received: by 2002:a05:6000:1248:: with SMTP id j8mr3894810wrx.292.1598990851407;
        Tue, 01 Sep 2020 13:07:31 -0700 (PDT)
Received: from debian1 (79-64-23-13.host.pobb.as13285.net. [79.64.23.13])
        by smtp.gmail.com with ESMTPSA id q186sm3338744wma.45.2020.09.01.13.07.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:07:30 -0700 (PDT)
Message-ID: <f3253a90491a76e755f0cd7d2b80032e6ea6ac88.camel@gmail.com>
Subject: [gitk] bad quoting of user input for command line injection, with
 possible unintended side effects
From:   Lyndon Brown <jnqnfe@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Tue, 01 Sep 2020 21:07:29 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

So I pasted the following line (without quotes) into the 'find' textbox
of gitk, whilst in 'touching paths' mode, intending to switch to
add/remove afterwards.

"*pp_es = (i_es > 0) ? calloc( i_es, sizeof(**pp_es) ) : NULL;"

This results in an error dialog stating the following:

----
can't read output from command: standard output was redirected
can't read output from command: standard output was redirected
    while executing
"open $cmd r+"
    (procedure "do_file_hl" line 28)
    invoked from within
"do_file_hl 46"
    ("after" script)
----

What prompted me to report this at this time (I've encountered and
ignored this previously) is that subsequently I switched back to git-
gui and refreshed, and was surprised to find that a new empty file had
been created called "0)".

Clearly the text has made it into some commandline execution without
proper quoting, thus the "> 0)" portion of the text has resulted in
creation of the file.

I'm using version 1:2.28.0-1 on Debian.

