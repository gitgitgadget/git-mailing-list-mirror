Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FDBC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFB120674
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 15:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574264633;
	bh=OIQb+6psRlWelwffCVGSxL2dkte9vBvO24+jfhv0F8I=;
	h=Date:From:To:Subject:List-ID:From;
	b=o5FQfDDxL4+IzXC/sRO7xZRGMoedDG6klLO1ZqhZkgimMc5S7uz/JmevW7gTIQYzZ
	 MdsJpHIvCm47bxX2C6s/tk09ipaVan37Ee0QheaPjAFkteqUMflc0rwbOpF2hl/Dmg
	 V92JrYhgdXeoBo2dTlpk98TA2SEfPV7aAjw1BEPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfKTPnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:43:52 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:42908 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfKTPnv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 10:43:51 -0500
Received: by mail-qk1-f171.google.com with SMTP id i3so140711qkk.9
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=xnZ8P+kn6+BVNCv7qPXipc9Ft7Phfcc1ZvcH5GybTPc=;
        b=fGdxnp4Gk0BdbcjOSAsBw3p9UK0ze5EQS4GrlI099azQluQ19DwQSj0X9U6f1CTYtT
         yOJ2HJeXDhIc61F7LHsNpLfMdhN1CUW+/iKHRK/FPDgLHmbr+KbK+KvCN/RxoKG692lg
         MaXFcdUHwGDYf2lDnMAhUOnjRaF3DnAyg7E4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=xnZ8P+kn6+BVNCv7qPXipc9Ft7Phfcc1ZvcH5GybTPc=;
        b=UO906Cjmno7m5bCI/Ly4mEPPSL6azDEMoDBCqNUxG0CMIR1vqEJxWjc+uNGJk8BWki
         ACUzDMCI6zfXuPo+9aA2rIZlq3wYFkpFpioOwYiU8hLAy/CevU3zOdlCVJv1/iPCW9e+
         VLe995f2hcyYK38UcHBM9I+BzdmIyb8AR5XQyDT7TOycYufPRKnRlHuC/yTdFZ35gz8F
         +DQYZuyBZ5IkdpHK/5lC8ni6imXkK+AHHZmcra/XWZBabYtIOYlD9btMNFCn9KIUGFD4
         yLHg4SkH3/ZDEVd8xN8xCxue38oFgwcXneAIlSlFgBUcEdwuezSjSAFbQeiKAc1eR2uB
         C+0Q==
X-Gm-Message-State: APjAAAVKK1VbH5iFHrHBNDfol92XkUqNver+4oWq6oqFypkhNJkZnBM4
        cyNRvRohnW2EzjAnm/42rONMv0QgRXdE3A==
X-Google-Smtp-Source: APXvYqzEss+Hjj+AErCtUfWIE8amROaY+8/v9g/+p/Qs/f81i5X0JjLwyle0r0djfVqXVZENx6GsiA==
X-Received: by 2002:ae9:d60f:: with SMTP id r15mr3006771qkk.207.1574264629852;
        Wed, 20 Nov 2019 07:43:49 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id t24sm14943109qtc.97.2019.11.20.07.43.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 07:43:49 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:43:47 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: This list is now also archived on lore.kernel.org/git
Message-ID: <20191120154347.x6w4v7cdzy4yrx6q@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

I used Eric's public-inbox.org archives to set up our own copy on 
lore.kernel.org and identical list archives are now available on that 
server.

I spoke with Eric and he recommends that official project documentation 
starts using lore.kernel.org/git URLs in daily use and git's official 
documentation in order to allow him more freedom of decision when it 
comes to hosting his equipment. The URLs at both domains remain the 
same, e.g.:

- https://public-inbox.org/git/7vll0wvb2a.fsf@assigned-by-dhcp.cox.net/
- https://lore.kernel.org/git/7vll0wvb2a.fsf@assigned-by-dhcp.cox.net/

Best regards,
-K
