Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D08C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3A420836
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRo2vmB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgCSQi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:38:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45629 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCSQi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:38:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id b9so1273203pls.12
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqXkZcK0Sjzb3xZRUJQ0Sr0Wu+/J1LWF4VR6/QMe3B8=;
        b=cRo2vmB48/SFlPD8HDx3ducYfwWmd9uHPLsHukKg2l8B2xFAPaRKcDNtsDx1t8XCLt
         AABoM1qUY3jJ9LZL/X0JtnpHAWaJ8f3V5uROZ7nm/4LLqVAQqOC7e6Rtx631XMcVrDdh
         mE7H7FPTapYTt8ZRHoH7LTaYSous8x0yoMM0xlULkVB5fR2XwgVtrRsq6xVd3I4+G+yB
         HOmmwCgQ5PJpoMKGBIdojhVQXMVB9rGU6tK4cnocdau093k8F69NJ8xIQhHBeoG/9B6l
         DJObnZ+ReSMwdJvAQ4levgLvXzDbXsnF/vbtyRtt+UL7tp1KKgvWz87w9kraGXYKfbfB
         UE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqXkZcK0Sjzb3xZRUJQ0Sr0Wu+/J1LWF4VR6/QMe3B8=;
        b=kUiNgXMc3gzXivsis/OmyB0QDxESAo9b2SXdZHDtpUAqgzgJ7uFKeyO8nKwpRsSBuC
         T/nlkFvVg4P9AN36LJoDZ+6+BnKFp6OPVOOwjj2qaiL2baNl7i0+86f9YkgT2mMyt8RQ
         uzy3dCVnSuZGwmObi6Oy2JZ4HOPXVGGJIZD3ASH87rUUMx9ie1T+KQjf5+FZct9dAraJ
         NPknXwyO8KYGvgl+bLgqvohEEGeDO9LzvNzmOBvRwBCdXeAPHY7DjFBiatfgsls0L1z1
         Rs+eQYVZIVmfV2CDirXJIcUCkSiTSbaLSuxWeeJUuo8YFFftCaJSGnCANLT9w1eYfW7j
         HD2Q==
X-Gm-Message-State: ANhLgQ0m9MD73/GyeDIzNxc6vPOYQ10mD/DFXaJndmxv++9uAxJIsZ0n
        T1dQ8LoatRyII+DCCrI1hdY=
X-Google-Smtp-Source: ADFU+vtm4cL1DuauRXj1uBeXXwsBfT2IWZ+GOj6umv6R3L6qiYHAdaU6ssOeQaG5dNhYtjEfhDK9dw==
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr4173432plo.233.1584635906669;
        Thu, 19 Mar 2020 09:38:26 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id t1sm2858737pgh.88.2020.03.19.09.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 09:38:25 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     harshitjain1371999@gmail.com
Cc:     git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [GSoC][PATCH 1/2] t4131: modernize style
Date:   Thu, 19 Mar 2020 22:08:17 +0530
Message-Id: <20200319163817.4239-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319132957.17813-2-harshitjain1371999@gmail.com>
References: <20200319132957.17813-2-harshitjain1371999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Harshit,

> The tests in 't4131-apply-fake-ancestor.sh' were written a long time ago, and have a few style violations. Update it to adhere to the CodingGuidelines.

Maybe add a commit title and then have a body? To do so, do a 'git commit' instead of 'git commit -m "message"'. This will open a text editor
in which you can edit your commit message. You may refer to this answer I gave on StackOverflow on commit messages:

https://stackoverflow.com/a/60755299/10751129

Also, commit messages are generally around 72 characters per line. What are the
style violations you are talking about BTW?

The commit title can be of the form:

t4131: modernise style

<<commit description>>


Regards,
Shourya Shukla
