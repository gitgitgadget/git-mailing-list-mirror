Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67226C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D7B2085B
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzccKDOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgKMMLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgKMMLo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:11:44 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57217C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:44 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so9619787wrp.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=loiULDHUldWa134DuFZ+Pg1IPijkeO8dQ5B1koe9Ios=;
        b=hzccKDOpFCIGjMEZJg4+L4J1M2GPG1rpMdxjM7BoZb4HHj/80XFyJEZ36/XOJFtYa6
         nks7QtbQUgr6wqrBcuhf1NcKFLhWUxhh3i30Z6SUl+7S6vfpDwMP3+E8zaf/NGUTnpB7
         OXDbHEKVrnwUsMCmzdxw2rfhPqUx9IGP3lFpCvi6qbWcZnYmfrKh3eCH4vGWailRCyqn
         kzZVKpbF7yDqcifktWgVbCOik7//QHLsTq3xjQ4LH6T/WSTfbehloVzmuPh+MudDzbPd
         jmNNSwmbr6aIwv2Wecr3ytdfIf66cjAKnRZSblEfOSFylPgPG6qek8yfIhwpmHQ0Qhdk
         CAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=loiULDHUldWa134DuFZ+Pg1IPijkeO8dQ5B1koe9Ios=;
        b=NHJ7vonyN8OEcDK+UfSywTvgV14GgFlRFosZXmjPe/wpd44OP3Xt04JSfkWEIULZIA
         eeXF4zLHImXk9gFn0CEcgNbKEp4ouU6LNNqCKSFLWadgkTizGqHrfcyAU+X7DMmwyyYo
         OAU5GcA5z+sTmD/0PulKav9/qvpp+0THYKMdhSuELq3m7KAUD7jXCU5StUwy+4pqN0u/
         G3ILW05Wcmhun1KYSkOrEqPvcRSFO1UG7vrbEjOhkZ370a8mHwvV+fJTD90N0ZrX6JEv
         VPJLGX5wJHrB6qc9CIwutXzfJ/anWgIqecrVtpcjGH2GjBNsbSlNA27WX1qvNY8xcmXu
         ZhyQ==
X-Gm-Message-State: AOAM532f/VLZ5m8pDGjuz/pjKo7bngx4NRPL1Q7vSNLrvz8bqGItZvZ4
        FyTXl0sO6rwAcsBgmnNjCxFAYcERD5I=
X-Google-Smtp-Source: ABdhPJw7p1jaYcXsiEF9GoyiIVCwRb5Wiu1LtxKNODr+6SUBzSFKSOmypco3mjC+7+ootxQgMKtBeQ==
X-Received: by 2002:adf:84a6:: with SMTP id 35mr3147439wrg.18.1605269503151;
        Fri, 13 Nov 2020 04:11:43 -0800 (PST)
Received: from [192.168.1.201] (194.55.7.51.dyn.plus.net. [51.7.55.194])
        by smtp.googlemail.com with ESMTPSA id z6sm9620466wmi.1.2020.11.13.04.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 04:11:42 -0800 (PST)
Subject: Re: [PATCH v2 09/11] add -i (Perl version): include indentation in
 the colored header
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <304614751ea1b1db80fbbbdc909b3d198c20313e.1605097704.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <70fae5a9-354d-978b-c560-d7fcabb25c76@gmail.com>
Date:   Fri, 13 Nov 2020 12:11:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <304614751ea1b1db80fbbbdc909b3d198c20313e.1605097704.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The header is formatted by padding each column heading with spaces up to
> the length of 12 characters. These padding spaces are naturally included
> when coloring the entire header.
> 
> However, the preceding five spaces indentation for non-flat lists were
> _not_ included in the Perl version, but _were_ included in the built-in
> version. Let's adjust the former to align with the latter's behavior.

I had trouble understanding this. I think my confusion is that the 
padding was printed when the header was colored, but it was not inside 
the colored part whereas the subject lead be to think there was no 
indentation printed when the header was colored. I assume this change is 
so that we can use the same test for both versions?

Best Wishes

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   git-add--interactive.perl | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index e713fe3d02..adbac2bc6d 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -483,10 +483,8 @@ sub list_and_choose {
>   		my $last_lf = 0;
>   
>   		if ($opts->{HEADER}) {
> -			if (!$opts->{LIST_FLAT}) {
> -				print "     ";
> -			}
> -			print colored $header_color, "$opts->{HEADER}\n";
> +			my $indent = $opts->{LIST_FLAT} ? "" : "     ";
> +			print colored $header_color, "$indent$opts->{HEADER}\n";
>   		}
>   		for ($i = 0; $i < @stuff; $i++) {
>   			my $chosen = $chosen[$i] ? '*' : ' ';
> 

