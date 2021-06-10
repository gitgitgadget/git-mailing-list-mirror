Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D1C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 06:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2208C613DE
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 06:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhFJGnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:43:21 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:33494 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFJGnU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 02:43:20 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4G0vWj5yfyz5tlF;
        Thu, 10 Jun 2021 08:41:21 +0200 (CEST)
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        git@vger.kernel.org
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
Date:   Thu, 10 Jun 2021 08:41:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210609192842.696646-8-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.06.21 um 21:28 schrieb Felipe Contreras:
> Virtually everyone is using it, and it's one of the first things we
> teach newcomers in order to resolve conflicts efficiently.
> 
> Let's make it the default.

I tested diff3 style the VERY FIRST TIME the other day and was greated
with the below. Needless to say that this change is a no-go from my POV.

Without diff3:

<<<<<<< HEAD
    CClustering ComputeSSLClusters(double threshPercent, const CDataInfo* scale) const override;
    void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
        double& minDist, double& maxDist) const;
    double EstimateNodeDist2() const override;
    std::vector<double> EstimateNeighborMinDist() const override;
=======
    CClustering ComputeSSLClusters(double threshPercent,
        const CDoubleArray& compWeights, const CDataInfo* scale) const override;
    static void ComputeDist(const CNetNodeHolder& vecs, CDoubleArray& dist,
        double& minDist, double& maxDist);
>>>>>>> no-compweights-in-cnet 

With diff3:

<<<<<<< HEAD
    CClustering ComputeSSLClusters(double threshPercent, const CDataInfo* scale) const override;
    void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
        double& minDist, double& maxDist) const;
    double EstimateNodeDist2() const override;
    std::vector<double> EstimateNeighborMinDist() const override;
||||||| merged common ancestors
<<<<<<<<< Temporary merge branch 1
    CClustering ComputeSSLClusters(double threshPercent, const CDataInfo* scale) const override;
    void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
        double& minDist, double& maxDist) const;
    virtual void ComputeKNearest(int K, const double*,
        Neighborhood& result) const;
||||||||| d261d9944
    CClustering ComputeClusters(const double* dist, double threshold,
        const CDataInfo* scale) const override;
    virtual void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
        double& minDist, double& maxDist);
    virtual void ComputeUMatrix();
    virtual void ComputeKNearest(int K, const double*,
        Neighborhood& result) const;
=========
    CClustering ComputeClusters(const double* dist, double threshold,
        const CDataInfo* scale) const override;
    virtual void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
        double& minDist, double& maxDist);
    virtual void ComputeUMatrix();
=======
    CClustering ComputeSSLClusters(double threshPercent,
        const CDoubleArray& compWeights, const CDataInfo* scale) const override;
    static void ComputeDist(const CNetNodeHolder& vecs, CDoubleArray& dist,
        double& minDist, double& maxDist);
>>>>>>> no-compweights-in-cnet 

-- Hannes
