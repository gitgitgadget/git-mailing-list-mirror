Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721221F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 13:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbeKTXcI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:32:08 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:46560 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeKTXcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:32:08 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id P5gGgf5BKdJAeP5gHgagcf; Tue, 20 Nov 2018 13:03:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542718986;
        bh=Lm9JxeUK+0LtLkhrIClQnszdqx4PC5L74rUyv7Z5qMM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UurVDx8y+zxZN+EnxtXCISUPedegAgDNAdbpat357irW+GG8WqSv9NpqDRdvY0RS8
         wBKSVMTyRvy9BCcnIDzuJLKkxue0L+tryXf5yOE68Pk4B4r5WGaoaCfy5wLIgWBUtv
         0pLX3zj64FbeO4WLR+JwpTzTG5kLmTIKhp3twqW4=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=s2Dxv2vniOzAcYISLdkA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     sxenos@google.com, git@vger.kernel.org
Cc:     sbeller@google.com, jrn@google.com, jch@google.com,
        jonathantanmy@google.com, stolee@gmail.com, carl@ecbaldwin.net,
        dborowitz@google.com
References: <20181115005546.212538-1-sxenos@google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d77c4aa6-be5e-a6fe-1d43-6cfa28161ae1@talktalk.net>
Date:   Tue, 20 Nov 2018 13:03:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181115005546.212538-1-sxenos@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIsMmI1MJfMddjEveGLIiCvbqxnFBMHiTz6zzeWbc+uWaAe4fGyPxCrCNspN0CJtWI3u3ZbfAcKVWyngkhCC43dMETMLnKETLTXRl7hxL0ln+JBQTaQ1
 ARK039NS5Jki4M4roazvaiQexZteUtRgfQS6UgdN2pvXsYvR8n6G6b0Q2+KY2kxnMpaSEryWpbKZrDoHcgr0+fKGbrlQcla9Rkxoxtv1piGlKisCOXT3Fn/c
 Z+B8iSb1hCVqET5TTzTUKGiIQ86drmMfG+F9RpjQrt5sVI4/TzaoYBTnmfgboEJ+xfkRnlohP7HdA9/vnMCjcy1yZDD2VAlW2Ja0Bf321AGI9PNmZrjFcWcA
 EFJbg8NejrNME1NEprC9XwyFPFCGP9wgUelRSFTQfmPQ9VMJBKE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/11/2018 00:55, sxenos@google.com wrote:
> From: Stefan Xenos <sxenos@google.com>
>
> +Obsolescence across cherry-picks
> +--------------------------------
> +By default the evolve command will treat cherry-picks and squash merges as being
> +completely separate from the original. Further amendments to the original commit
> +will have no effect on the cherry-picked copy. However, this behavior may not be
> +desirable in all circumstances.
> +
> +The evolve command may at some point support an option to look for cases where
> +the source of a cherry-pick or squash merge has itself been amended, and
> +automatically apply that same change to the cherry-picked copy. In such cases,
> +it would traverse origin edges rather than ignoring them, and would treat a
> +commit with origin edges as being obsolete if any of its origins were obsolete.

If a merge has been cherry-picked we cannot update it as we don't record 
which parent was used for the pick, however it is probably not a problem 
in practice - I think it is unusual to amend merges.

Best Wishes

Phillip
