Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF81C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282FF20716
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584036415;
	bh=PBrCXYfbckkavdpk6gStlsMfPSJTRjpGxM/KEAGVSlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FzGNQLIMPc0/Iug7K9RI64UADaeHZnMIp2IvrRoHOesTRELFUTZ5rZMrA0DnZIJRL
	 dkFKVbMXMlGiAUZMARy6kniKyrugqLyXYRp/PywbPd2i5T/QoP+v1ZNkHAtn6QMAY7
	 EO5HDwcS3pfEyC6PDPGpmFwybTkNte5tLjLOAZkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgCLSGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:06:54 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:47042 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCLSGy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 14:06:54 -0400
Received: by mail-qk1-f177.google.com with SMTP id f28so7760640qkk.13
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZIbx8hwle18njBnIWJtc9Oh4S0jQVmUo5sJdNJJr5E=;
        b=a4TkbcH2d54s7Imv/dAYar1Y+3aNqpCOU1S9iQrjzYIYx83xCQUryHK42yVA+MKSZ+
         ibBuCuY9KTc+eY8SQ7mb4nsJAoYzCTh1EjPxztJtLoOtltm9PkMsRiIRrc+deLYL+hts
         3VIO5FmVVbWE8ZGvhqeGsuV6Tt0pZF2VAca/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=eZIbx8hwle18njBnIWJtc9Oh4S0jQVmUo5sJdNJJr5E=;
        b=YCgR39KtzdBzOXsRNNM8fvKbI1o67veJBC/K42KfttWdTNLbbQw5ZTrcehTmCkogm/
         uG9Oiay1w+nLg8lI+lWmqMaHSMHDQumnUlUYJjfzT1g2gD3JbkXhJq6HrFYTyFYRbLJd
         qhsBx3VKN5GbzS5uNTHK1v3A2HspxzCRNGUHfOQRQxBYNkraM4/VZU/mnFb98YksIfd9
         2p7A3MZQNsbsvGC7TYwyRD653rlmObZn71wsyEVEU0+sVcDS9gzbDv71eyuCnyziPE94
         Ir7jvX3yD00tKRxxqEuteqY0IZ7Q2u8ctnAi+C8SPOmRQB46nqE28TLUc18baQ7Fm82C
         RCCw==
X-Gm-Message-State: ANhLgQ2xLlFBURLpdMILJOlnfwrXH0rkyLmiPAoEpfq7g9LtU3UpBCEm
        dtnpfL18W/Sy6p8fuKCzUZBBynloqZwi6Q==
X-Google-Smtp-Source: ADFU+vur2Aq02LYR8+LYa9XAUIAf2adJLjxaVGa5jDvP+2omXrfn665hv5XcjqDbroj056BQtRw3aQ==
X-Received: by 2002:a37:2fc3:: with SMTP id v186mr9059944qkh.311.1584036413310;
        Thu, 12 Mar 2020 11:06:53 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id z11sm10073054qti.23.2020.03.12.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:06:52 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:06:51 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     James Ramsay <james@jramsay.com.au>
Cc:     git@vger.kernel.org
Subject: Re: [TOPIC 3/17] Obliterate
Message-ID: <20200312180651.yonj6wzuatur25w6@chatter.i7.local>
Mail-Followup-To: James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 02:57:24PM +1100, James Ramsay wrote:
> 8. Jeff H: can we introduce a new type of object -- a "revoked blob" if you
> will that burns the original one but also holds the original SHA in the ODB
> ??
> 
> 9. Peff: what would this mean for signatures? New opportunity to forge
> signatures.

Easy, you just quickly find a collision for that blob's sha1 and put 
that in place of the offending original. ;)

(Fully tongue-in-cheek.)

-K
