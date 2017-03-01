Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6502023D
	for <e@80x24.org>; Wed,  1 Mar 2017 17:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbdCARQi (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 12:16:38 -0500
Received: from avasout01.plus.net ([84.93.230.227]:46117 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdCARQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 12:16:37 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id qhGU1u00222aPyA01hGVle; Wed, 01 Mar 2017 17:16:30 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=IItyMknG c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=5Xv2Mqva_RWtUuOsMVUA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v7 3/3] config: add conditional include
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170224131425.32409-1-pclouds@gmail.com>
 <20170301112631.16497-1-pclouds@gmail.com>
 <20170301112631.16497-4-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <32efbc7b-182e-2169-78a7-c959661f8207@ramsayjones.plus.com>
Date:   Wed, 1 Mar 2017 17:16:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170301112631.16497-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/03/17 11:26, Nguyễn Thái Ngọc Duy wrote:
> Sometimes a set of repositories want to share configuration settings
> among themselves that are distinct from other such sets of repositories.
> A user may work on two projects, each of which have multiple
> repositories, and use one user.email for one project while using another
> for the other.
> 
> Setting $GIT_DIR/.config works, but if the penalty of forgetting to
> update $GIT_DIR/.config is high (especially when you end up cloning
> often), it may not be the best way to go. Having the settings in
> ~/.gitconfig, which would work for just one set of repositories, would
> not well in such a situation. Having separate ${HOME}s may add more
> problems than it solves.
> 
> Extend the include.path mechanism that lets a config file include
> another config file, so that the inclusion can be done only when some
> conditions hold. Then ~/.gitconfig can say "include config-project-A
> only when working on project-A" for each project A the user works on.
> 
> In this patch, the only supported grouping is based on $GIT_DIR (in
> absolute path), so you would need to group repositories by directory, or
> something like that to take advantage of it.
> 
> We already have include.path for unconditional includes. This patch goes
> with includeIf.<condition>.path to make it clearer that a condition is
> required. The new config has the same backward compatibility approach as
> include.path: older git versions that don't understand includeIf will
> simply ignore them.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/config.txt  | 64 +++++++++++++++++++++++++++++++++
>  config.c                  | 92 +++++++++++++++++++++++++++++++++++++++++++++++
>  t/t1305-config-include.sh | 56 +++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1fad746efd..2a41e84bab 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -90,6 +90,59 @@ found at the location of the include directive. If the value of the
>  be relative to the configuration file in which the include directive
>  was found.  See below for examples.
>  
> +Conditional includes
> +~~~~~~~~~~~~~~~~~~~~
> +
> +You can include a config file from another conditionally by setting a
> +`includeIf.<condition>.path` variable to the name of the file to be
> +included. The variable's value is treated the same way as
> +`include.path`. `includeIf.<condition>path` supports multiple key
----------------------------------------^^
s/<condition>path/<condition>.path/

ATB,
Ramsay Jones
