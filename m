Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909991F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeH3CgQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:36:16 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:32828 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbeH3CgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:36:16 -0400
Received: by mail-wr1-f50.google.com with SMTP id v90-v6so6259089wrc.0
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=OQX8tplTbUVmhxZycSp/PJ8zfYBHLcm+MQSgk2VV190=;
        b=pUfTbmws23jmlyuoffLFXvJLIX3d5g9fh11xQRiTXoOPVu2GNGkBDY6N7sv/9RG8c4
         Lukya5ojHCAs5Zc0XOSt4sgQ1oPFB0GDCQ7z6W0sxL27AKclCW/Up00kfDt8dI8NZHPO
         gpQhYCU9eBYiGrEM683/wBhz/lztPClS+HkBi3wqZee6fhdRSfpunNismm8joo4dunL/
         3d6bma2lUATE0t6jKd1UDBeTgmwZMHzaM/YuEZX+qsOas3Um0g6MO5KcjG5X4lqhScLV
         uIGcklgZK19rTBp+wJ5ETzZLy+eic1x9tI524G31KThOnbRWp4P9aC/SU6CUgGrctWhu
         I0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=OQX8tplTbUVmhxZycSp/PJ8zfYBHLcm+MQSgk2VV190=;
        b=cd8BbwrYvJlC/RX+yTO9cov0OTGPrp8Dqn7EOLNU5l3t2Afxm8Ilvdvy7CkKHCRInJ
         aZP7vGX28bAISFhFHItBN5bfnto9R2xlmvcD0JuKbXIgf6s5giOXksJ2GPg4ETD/hdph
         iN5L3lkK03wPbFAMcFU7d8aRnO4JN3HN5ILEbvpk+ziGdzo2tE7oBiZr1JpP5jK+YPPu
         2DORpkhGOSVsnu/P7EZBoondPkw4m1Eh2wqZOy8KonARfOarBW/7i+0q6IKlcpH5TONO
         4jT+DjhQQSkkS4D00o3mQO8JBjYdsp3nqM6NuFdLNK5ErwMWoYBokMFsn1CUDW+sSJum
         fO+Q==
X-Gm-Message-State: APzg51BUkAcpd36dxInujlvfloSmbAxP7l4Xyn2BlVRvz/rdShK7OXEI
        7xIL2bKXqsxLX+grkli+dYY=
X-Google-Smtp-Source: ANB0Vdaw/pidh1M0Ke19FchC6/B2QleDRbL2qPjpnPGOiSXTFJruV5NJZMdpzzFAlSf4mDHQzFx5DQ==
X-Received: by 2002:a5d:5450:: with SMTP id w16-v6mr5994494wrv.4.1535582231970;
        Wed, 29 Aug 2018 15:37:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q16-v6sm3917515wrn.41.2018.08.29.15.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 15:37:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/3] read-cache: load cache extensions on worker thread
Date:   Wed, 29 Aug 2018 15:19:18 -0700
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180829152500.46640-1-benpeart@microsoft.com>
        <20180829152500.46640-3-benpeart@microsoft.com>
        <xmqqk1o9cd18.fsf@gitster-ct.c.googlers.com>
        <606bb7e9-0d58-ec86-6a3c-8a123679f9f4@gmail.com>
Message-ID: <xmqqd0u094ve.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> There isn't any change in behavior with unknown extensions and this
> patch.  If an unknown extension exists it will just get ignored and
> reported as an "unknown extension" or "die" if it is marked as
> "required."

OK.
