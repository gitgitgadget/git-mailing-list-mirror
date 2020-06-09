Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E0CC433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF2C2072F
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 22:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtX3H1c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgFIWSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgFIWSX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 18:18:23 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE4C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 15:18:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r10so38357pgv.8
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=IQFI5srh9t1t06/mhbG7cM1TJ33B5N3tpbmtONBrMuk=;
        b=GtX3H1c5/9EF2Kyh0+w45co6QwaxlVbbx/xTbxyCEle00LReSH/MwjAvo7qjT4LbZj
         tkCwSSo7+qi+AZPGFE9AbokwFoQuCrl7gCcoRR0VOjQWEThf+ELUfX+35MwOgeu61UOh
         TYmjXcdX0ABM29WtAjY8iwoNbh/thA5StjS330QKJ396wPAl6+Zb6xMH2Fy7d8d0aIGC
         W3sJYSOXg+JbhVzqdybJ9Fop3NDpLkTSWFnpcMeDSSMUYG4H6J704Rn8eRDD1y09Xl6E
         jMQZV5cAA+lTKWjj3jrVPRhmwzwFbCTwKvXCEk2k82HoSKixLwqh3TYsWboGz7zWZLQC
         nL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=IQFI5srh9t1t06/mhbG7cM1TJ33B5N3tpbmtONBrMuk=;
        b=EqOuvPkoXBlxuL/Hn8sSD0zG5enGhhFhuT4nkurTMXPlYJKP3ee5Z0nrP1BQgu7xvz
         To21hIvCt0sGQ+lIG0re5ZUf5GklQy/sFKZGf9KgPhsWeUVQ+sjtkzGKmrnutjX2nj/4
         qSnDvdOAKgY7u6ACFKfHa9wOldZ76RPh5DAkOrKQmG+9E0NS9H2sAWb+vtFGP7nxk7XG
         o33zneKUxFe02tI4n/EOOSTs8zExq2KobsgRf7ZH9eoToq30nVUxEnU2zZfeSPK7JVwq
         sgTTJMudOdqQMLhPT1CFFMOqVMpjirSEY7IkdK9abqdu4KpGE209ffSJq4Bu6ONMcCy9
         LxFg==
X-Gm-Message-State: AOAM532WIS5Mp8bJBRB3eX7b8v3YDuwYNUCDCUQ2m0aV4ejj6HN/f6jq
        //isU2QObFOvN/auDYoEDm6riT5in0o=
X-Google-Smtp-Source: ABdhPJzK/7dbfH0Zt7wuL9eP9Jo8RWgogcQqzFnLkEUIYDhhOzn96BY9bFaWm53Y/STy2RsfUJxqsQ==
X-Received: by 2002:a63:3409:: with SMTP id b9mr155856pga.106.1591741101734;
        Tue, 09 Jun 2020 15:18:21 -0700 (PDT)
Received: from [10.154.173.216] ([37.111.6.195])
        by smtp.gmail.com with ESMTPSA id u4sm8769238pfl.102.2020.06.09.15.18.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 15:18:21 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   S0E THURA <soethura@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Wed, 10 Jun 2020 04:48:19 +0630
Subject: Hello 
Message-Id: <9CF05004-EFE9-4B82-9BA4-500A27176A2F@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (17F75)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi I am interested 

Sent from my iPhone
