Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A328EC3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC6020873
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9sPhTfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgCCRJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:09:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40877 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgCCRJK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:09:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id e26so3635084wme.5
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BXP3F9v4iSfcBvMWeZefLpNqGiZZEwYVOaNv5UaSQ5k=;
        b=e9sPhTfWp5XX6ur9JytMXU+gUaZq6rZ6LuS5rM7Cer6m5a17/qD9yNN7zfEYNaa/R+
         eAHcd8Hnk7CkYnDPsb9Z4rwdnIY5nslS7kKT6+NfDWdmPytvH138rsEFjYNr+TEIeQ32
         A04Kad0I7zecJaSa1/R1WKyglLrokN+b5BAM5Bz42qiPMnZ/mjpPcplvzzP9yWn+G/xO
         tgA4idKs5MNx3IOrmNwNpb3s/497VvqXJG0eRoTfXpV6ZFy/gnUo6XYeECKZ+FtCGGoh
         CmymlmqyoUvuWadTlp/5AsSO3OTznwJbCUcYP8OFVe/Dpu1lQJB6XMet64O22mcHZ9zE
         SPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BXP3F9v4iSfcBvMWeZefLpNqGiZZEwYVOaNv5UaSQ5k=;
        b=t4rdDJwSlrlxNOJ2zShOwPv2+WR+jJXONkkjJX/C4xblUQcaYhdPSKa4IiRPrb1EWv
         1v3CR26sfsCMjw/dz+ERx/MZbguHdMtwapnGPmXNx0PNMiP+1AtAAYfwDz85U+OWotoN
         2M1Gn2EkkROoGvZKUIQKDd5nKJJ8QX0zeLeohfTkutm03sknYJMbOwizgSL3eDzlDxdL
         nIoKTNw9ZTuQPLSr2u+CVww5jVlbZJvK8uysyVXq62Cva2u+A51+4IfgWu36PThKk8X+
         P9xgHlTXLcEfaSYn19ip9pYanm63v5kkRCvW+DKp+q49L1XwIZsTSWSqPRsgZE2tDrsG
         0TsQ==
X-Gm-Message-State: ANhLgQ07SuYUBo1GLtLRZQ86hSVDmtRTvHy35eIJZ7fLoJqmzwyQPzNG
        f8T0xXadlzZ9eswAnviDmBQ=
X-Google-Smtp-Source: ADFU+vv3VMneJ5owO8RoUGK4kCMi5Qzz8RQYQUQb1hQojYivp7nCbNnCKJ+EWe6b36DJKEwoSr7Isw==
X-Received: by 2002:a05:600c:552:: with SMTP id k18mr5367461wmc.171.1583255347835;
        Tue, 03 Mar 2020 09:09:07 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id a70sm5122110wme.28.2020.03.03.09.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:09:07 -0800 (PST)
Date:   Tue, 3 Mar 2020 18:09:05 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] doc: list all commands affected by recurse.submodule
Message-ID: <20200303170905.hnsf4o37mmlcf3hz@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 18:07:54 +0100
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
 <20200228103558.1684937-2-damien.olivier.robert+git@gmail.com>
 <6C13DF7D-2999-4C91-882F-B899CEBD7C29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C13DF7D-2999-4C91-882F-B899CEBD7C29@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Philippe Blain, Sun 01 Mar 2020 at 23:43:35 (-0500) :
> I’d also add the same list to the "Implementation details" section of the gitsubmodules guide [1], which just mentions `checkout`
> at the moment.

The implementation details section really is about the behaviour of
cloning and checkout. So I just added a link to git-config.
