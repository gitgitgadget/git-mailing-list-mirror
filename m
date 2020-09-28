Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE56C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764A72071E
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCauEg5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgI1T3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgI1T3d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:29:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEDFC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:29:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so1976848pfg.13
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EKT+spKBKl1cZOKy9n8YfbZ2WlF1+0j6wLlDsOWRTLk=;
        b=eCauEg5sV/SIJaBHckOf7EYLCsMJgYFS4oN7xnPrlL0h1F42/fMfQu7zFpqiPUNHpF
         mnDsCiI+jpOtRgiMtlTMaMUk5mfhC79wPwfPz7pNMJawr0bk1PXnkZXvU6g+DRmGDMtR
         OahcV+e1VY206eCELxRrYOpep3c9298EesBo8AzjWXl/NNAp4ISQGoNDgshm85y+HiGD
         NP5psRhRqslTbTXCQg+1OQbdXjBfpBiKDsSSU9B5Siuo32/ndHQGVY0zoBOHU99rSfjr
         ZicffNJD91G2yI8hUJEUYcaCBRgJvG6HIONE162yVwBuOiCysWL47ocyK/FU6mUZZg/7
         J+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EKT+spKBKl1cZOKy9n8YfbZ2WlF1+0j6wLlDsOWRTLk=;
        b=cbpRCUzGCyNAyCDQTX23jcZ2b4DWBRKpCB80hDeelWDWNNTL5Px3ttF0uRZa+DJLB5
         DKQAYGEFtu7tpAJ76dplf7zD1/tjKbWno0NKVDBPQzEGik7efOQIRbSyY2iv+XIr0BKU
         aQcRAad/3Sl9oj7QvSImQAEXCy6IY6Lbs2B+ml49vHlog5GAaJyQ2YrflONB51ToBMEU
         at/DObm5STc0x70LOuC8MjecGBkxj+5fPGBWq/hEzKE6nT4MG3mnFIPHE0GiEjeT8kIs
         7MAhOe/U/toFGBvW+wV0hgB8nOESeyOh853OspfJb+0tJFjRMjUcJnfZrp87VGs8maEg
         E/ug==
X-Gm-Message-State: AOAM533BnnVKmycSQWx4E8JwJB7cm4AqIPaFTZP6kq7RA/CpCW93AG5j
        gVOms75IByt7yPV/7XMu0ikkimTFuui5Mg==
X-Google-Smtp-Source: ABdhPJw9ZC9hZvxgkE7yjYDHCyls6Tm30wGQLwS5kH0NDpNfw2SXJW60rL8qwep+tH7KCQRRxML+Bg==
X-Received: by 2002:a17:902:6b0a:b029:d2:62fd:97ba with SMTP id o10-20020a1709026b0ab02900d262fd97bamr902940plk.34.1601321372704;
        Mon, 28 Sep 2020 12:29:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id q65sm2003265pga.88.2020.09.28.12.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:29:31 -0700 (PDT)
Date:   Mon, 28 Sep 2020 12:29:26 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 6/9] hook: add 'run' subcommand
Message-ID: <20200928192926.GB4095761@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-7-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909004939.1942347-7-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.09.08 17:49, Emily Shaffer wrote:
> In order to enable hooks to be run as an external process, by a
> standalone Git command, or by tools which wrap Git, provide an external
> means to run all configured hook commands for a given hook event.
> 
> For now, the hook commands will in config order, in series. As alternate

Looks like a small typo here:
s/will in config order/will run in config order/
