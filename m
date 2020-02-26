Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4684EC4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152F421556
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582747779;
	bh=dvz/MBDS73ebkEHV56VFB6qeIb98AynIatfNf2BxDe4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=O4SoMAIQ4b8mFyOJ7lq71L2zrXnXNookNBF5J2vMBebEvCNXE6WmM8fsYAFK93klP
	 rozDebaEaMC7hUlEURrobiK6elF+2A6xLxQCmUow5u7lx+hRrf9C5BlSHmzV+IspCf
	 QJSBjI05/+VbG0klczgDGXD0fkr8kdPPP94k48oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBZUJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:09:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36226 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgBZUJi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:09:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so696033wma.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=fQSXnY41z3oz04f2s0XHJQWYI5MX6prz0kwRQ/zX+g8=;
        b=Lg9QM9S2KVoH+ii7nw/KAlmE169QRWTDUhOMG5WHhrh6y2f/FWNe+WG63ruquh3LKr
         /9v+lkrXjLlTrikyiXMesJGv7LPHqBYMiIUoBR0jK2mYZAL0Hw2CgkSJO6/2/YfgsvjO
         ihveT8OK2O7qaS2uu+g/9BE3e/1Szy8VvyTRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=fQSXnY41z3oz04f2s0XHJQWYI5MX6prz0kwRQ/zX+g8=;
        b=pl0viE8nvMbnuHZ52pQu7egML/EkVDfpST142mqCyv9cTCf9FlEbY8ikkm7BLBJy1d
         iMBOWRptxB4BfLSf0PW6oqwUoaZmaPdT/4UZd4/hLm7O0LAMdMZIuWn+sa4Z2Sp0P0v1
         8epQsjqQckXOFlsMHbEpm0GOaDE6cFkbDciFiCcxEXhbofs9jDH/LXyFWc9dJYsFIUBc
         nwfEn+sNdNs23iug9uXpbHfOUYI0o+lutU2+9If47fxQXtxqUDbN2TuCDyijSa8eA4fG
         O1sP2cI8jqgIkjPDjRCEVy5nH24X9ZWZ+FGY39JeCK+jjzikkxpw8Kxmn8SQBkrqopi6
         cv1A==
X-Gm-Message-State: APjAAAV+i99ebkogPCygz+GMhiapgUvB7k+NPD9+IVNEn8xnhtmfGSvP
        0o6sQzwVVASaCA4uGsFYCE5L+/U4WVkSmQ==
X-Google-Smtp-Source: APXvYqwmY6GlItllMb6lb2VN1AUcocqX4zVZF8fWQ4RKjUaXlVTNOeGYOYeg+iyRNJvqVrLY1Dqw2A==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr577241wmb.33.1582747775596;
        Wed, 26 Feb 2020 12:09:35 -0800 (PST)
Received: from chatter.i7.local ([185.220.102.7])
        by smtp.gmail.com with ESMTPSA id 133sm4768352wmd.5.2020.02.26.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:09:34 -0800 (PST)
Date:   Wed, 26 Feb 2020 15:09:29 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Cc:     vegard.nossum@oracle.com
Subject: Making GitGitGadget conversion lossless
Message-ID: <20200226200929.z4aej74ohbkgcdza@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org, vegard.nossum@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

GitGitGadget is great, and I'm looking forward to adapting it to Linux 
Kernel's needs. There is one area where I think the situation can be 
further improved, and that's if the process of converting a pull request 
into a patch series were completely 100% reversible. As of right now, 
the following data is permanently lost from commits as they are 
converted into patches:

- parent/tree hashes
- author/committer information
- cryptographic attestation (gpgsig)

There is an existing body of work done by Vegard Nossum [1] that makes 
it possible to fully reconstruct a git commit from an email message, and 
I hope that it can make its way into official upstream. If that were to 
happen, it would mean that converting from a pull request into a patch 
series would become a lossless operation and tools like GitGitGadget 
would be able to preserve full cryptographic attestation of commits.

Vegard, if there is interest in getting this work into upstream, are you 
in a position to continue your work on it?

Best regards,
-K

[1]: https://lore.kernel.org/git/20191022114518.32055-1-vegard.nossum@oracle.com/#t

