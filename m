Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4AEC4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3CA2072E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 11:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeR2zkqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgCWLdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:33:44 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:38459 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgCWLdo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 07:33:44 -0400
Received: by mail-pf1-f178.google.com with SMTP id z25so3026172pfa.5
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=IizbdO7tH4R6Q6kZq1VIzTUPi8iin4wRulvrdq2+9s8=;
        b=OeR2zkqNDBL76lAHxU0X+aavIss3+K3ZYbKtf1rYs7i4keQ87hagPzh22D1FioCEdq
         dwwHQW4oasExjVnvvlT4+AnIOQzU8RsA9IT6hZVKsuDaGM4jukd3XUSy61nI8PBwYuQc
         5Sd/dhP/7eXxhcTESLQd5hIJS54TNsoiMDTgs3UGMBVTbSAKWszkNQNTR60csXrLiRrK
         8qs1O3U5RE8s95CMlA+E/RaCdGpETNl6Vs5el+6w5/n2+Lx35GCU+KFcrFo+f5SnQkiq
         0eevTWjVMNycw2dZPsbU8GX9Qc5kXAViuI2F/e58FChXhMJLcHvc4ohVmadPrIIo4Nvp
         78rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=IizbdO7tH4R6Q6kZq1VIzTUPi8iin4wRulvrdq2+9s8=;
        b=XO4sHpsDWfroXlKGBs26M7ycuwdmcCfK8WVxyBNFAEsCt8Y/XES7ruH+rKLaqW7E6u
         5Nv9IO4UkEmxanwXx081y0jw7mLmx+bZNt2KcxrDbMVaUUte3xp3FXik3FU+2xX3LuyI
         o0hCrp1RtkUXA1puOPtH1xOgWf00UQxhrCZqnPE/8PAehR5vsf2oCDDkW7wd0r+LYcZy
         xOM0Px0Okt2bES8boTpXLs7OZU3U9pfsHSaAWzyakHpgmPQUIulEX3/SReVsCjMCBtdX
         Km2UXZjNSkkPlFOQq/PtgIqHIv5IsV3NipWcUrFQv2/k1RIrbNieJALtimGICabw/fU1
         8mqg==
X-Gm-Message-State: ANhLgQ36rUERcvP/heXt19x0Zk6/MdvpX49Ytftxl2KWqGhRV/ah8JrW
        EA720XH6oA4vyRadFx0l7IQ=
X-Google-Smtp-Source: ADFU+vstirS3YlMZCSACCn4wOig7DYd7d34SPFlwdbiDxBJ/Ysepf/P8Rg4+gUf0MTiY7DmX8HkucQ==
X-Received: by 2002:a63:e511:: with SMTP id r17mr21598385pgh.352.1584963222330;
        Mon, 23 Mar 2020 04:33:42 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:299:434d:74e4:610e:e237:91fc])
        by smtp.gmail.com with ESMTPSA id e184sm13003194pfh.219.2020.03.23.04.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:33:41 -0700 (PDT)
Date:   Mon, 23 Mar 2020 17:02:31 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     jnareb@gmail.com, git@vger.kernel.org
Subject: Re: [RFC][GSoC] Implement Generation Number v2
Message-ID: <20200323113231.GA22065@Abhishek-Arch>
Reply-To: xmqq369z7i1b.fsf@gitster.c.googlers.com
References: <20200322093526.GA4718@Abhishek-Arch>
 <86eetkrw8p.fsf@gmail.com>
 <20200323042517.GA1258@Abhishek-Arch>
 <xmqq369z7i1b.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq369z7i1b.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 10:32:32PM -0700, Junio C Hamano wrote:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> 
> >> Unfortunately for the time being we cannot use commit-graph format
> >> version; the idea that was proposed on the mailing list (when we found
> >> about the bug in handling commit-graph versioning, during incremental
> >> commit-graph implementation), was to create and use metadata chunk or
> >> versioning chunk (the final version of incremental format do not use
> >> this mechanism).  This could be used by gen2 compatibile Git to
> >> distinguish between situation where old commit-graph file to be updated
> >> uses generation number v1, and when it uses v2.
> >> 
> >> If you have a better idea, please say so.
> >
> > We could also use a flag file. Here's how it works:
> >
> > If the file `.git/info/generation-number-v2` exists, use gen2.
> > Otherwise use gen1.
> 
> If the file is lost then we will try to read the other file that has
> the commit-graph data as if it were in old format?  And if such a
> file was created (say, with "touch .git/info/generation-number-v2"),
> a file in the original format will be read as if it is in new
> format?  If that is the case, it is likely that we'd see a segfault;
> sounds too brittle to me.

Agreed. Flag file has too many issues to be pursued further.

> 
> It appears that the format of "CDAT", and the fact that generation
> is represented as higher 30-bit of a be32 integer, is very much
> hardcoded in the design and is hard to change, but your new version
> of graph file can be designed not to use "CDAT" chunk at all, and
> instead have the commit data with new version of generation numbers
> stored in a different chunk (say "CDA2") to force older version of
> Git not to use the new graph file---would that work?

A commit-graph without "CDAT" chunk will hard fail on older versions of
Git. verify_commit_graph_lite() errors out if chunk_commit_data is null.

Metadata chunk seems the way to go.

Regards
Abhishek
