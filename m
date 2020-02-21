Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF35C35657
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 17:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1814B20722
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582305251;
	bh=eJ/lPaKV0Aob52FS7P/zuUI9dCs6uUi/DgksUG6PHso=;
	h=Date:From:To:Subject:List-ID:From;
	b=2DiKBW8nFjQT3IYDrFpVMmn5GGWYuSc6MMEYIJrp3VCXFgj0bz5yd0BJkD/nycTJD
	 Q6Btq7h58Lb8ef3KXrBSCR0OJQHExaWCCh11VDENRPMxvXkddmCSbeVltQeCbrARk+
	 V12BT5erGmFBWzo2iy8Xkupvi0mU5MyjO3O9DMPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBUROI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:14:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34457 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgBUROI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 12:14:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so2056163lfc.1
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 09:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=C5vciRI9pbuH1Viq1LtBuA9xvYdR42wAiuk231ilRlM=;
        b=Me0F4gSvQ0di3ewxmFulRR3dTdjvO9wgNlQ5tlHI7Q6/4VQXnG7at3b80YDN8Gh54t
         WfSC6vFO9Nbr10vPtqxXywQc8ldXwrV7GvO8qmkUljL3MPG9MqknUtNCpUkIEcAyjUZt
         KZeL6wAshFBz5hqTCxVUsq/WaOBVmaQlok4k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=C5vciRI9pbuH1Viq1LtBuA9xvYdR42wAiuk231ilRlM=;
        b=JKrwnLgi8CkJfCgIGy8KuQMKpLFIUgzdvGxwUFaN0SNxXOYmqwXkFqpdamkVY01Mv3
         9JVJS4iqQR4hXLhZ3z/kO97VXLuauL3kvAnULqYdWZBgnEs60wtZlZ2cMGefak3ykyny
         4euFs0/e52uK3plH/JUwUv01q8fIIGi10hWfzQKmTU3RAy1Ga4RZGUzBdPH6U4u+yoEK
         NySD/NcEJWOqem+rA4Weo6WRfcEReleJq0VAQLVG9oUoj0pqG7OHM067XYcOKd9i++0H
         WwFIqjBo341/3aX/1Bzbj9BcF+pGRWxSJXET9syeaV/i5xNzqtY2/YqwaUqdHJJZw7sI
         q+0Q==
X-Gm-Message-State: APjAAAUp7R87BOK/ANXMfx2f9SF4o2c/I+9/3E2iDuyKIZUxSpOvPHUO
        amALFdrttHhYQVS6gxq8Tu388p4dqtnKYA==
X-Google-Smtp-Source: APXvYqyHe212o9AWHXe8HfOi6aqtpr9jwlUCOTiM0IkpNvsJTjwWlEWqle4YFVc/LcSXHdPzMesqfg==
X-Received: by 2002:a19:7515:: with SMTP id y21mr20148290lfe.45.1582305246080;
        Fri, 21 Feb 2020 09:14:06 -0800 (PST)
Received: from chatter.i7.local (tor-exit-16.zbau.f3netze.de. [185.220.100.243])
        by smtp.gmail.com with ESMTPSA id n15sm2244349lfe.54.2020.02.21.09.14.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 09:14:05 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:14:01 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Getting clean diff data from git-mailinfo
Message-ID: <20200221171312.xyzsrvebuwiw6pgj@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello:

Git-mailinfo is a handy utility to quickly parse the contents of a 
message containing a patch. However, I'm curious why there isn't a way 
to get just the diff data, without all the surrounding junk. E.g.:

curl https://lore.kernel.org/driverdev-devel/20200221123817.16643-1-ajay.kathat@microchip.com/raw  \
  | git mailinfo msg patch > info

The contents of "msg" are already munged to reduce it to exactly what 
would be in the commit message (properly processing the extra From: 
header), but the contents of "patch" contain all the junk from around 
the diff, like the diffstat, git version info, and the list trailer.

Is there a git-native command to further clean up the "patch" file to 
get just diff contents (i.e. as returned by "git diff" after this patch 
is applied)?

-K
