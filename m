Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DA2C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 17:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8012E21775
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588267312;
	bh=CiHVUPPTlEV+2d2jQllyXspW3skT6Mkuj9XomSWyJhY=;
	h=Date:From:To:Subject:List-ID:From;
	b=AxsfF7LTvxusrMmDhUOfT68yCIe6DbQ9x4rZfGOgshiBMhTGIhwsVsHg3kfzvCBhS
	 dfTYGvDst9l2z6kUtMItVEdM5neLHgbx42R4IDIlpLV+4WFlrzrPxzmavZxP+hzYQF
	 /xYP4NcIoEFVYVRhFLZemuaFv7GXRzjSzV45z1z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgD3RVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD3RVv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 13:21:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C3DC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 10:21:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id z90so5633820qtd.10
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=h786awmUkNYc4MtqhGBXdaYj1YKyFOSQcj74D8+2raE=;
        b=finju/DCXji5QMzcgCOofr0NjtHno9An2Ij3YVbe+bGt8iEsIBaMvFk2f3RT5VbCVU
         GKrASl3U5apUkgXJMCrxO3jAlKgS9cBND38ZpdttDv0jIUUMHyrmI+lwZIgRfnJNLVA9
         uiCKw2S3ermTl+ju14Ba0JOYWPAB+khX+vwvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=h786awmUkNYc4MtqhGBXdaYj1YKyFOSQcj74D8+2raE=;
        b=nhg2XN8kodgFh6qM1P2H7GAfEEspqkdxQ0iE36+eKE+Up2/26rYmDizYo2XLtyxgqJ
         Eao+G00kn5kMNLg6WxinlPfSpt3+O5tsyTg5YJDuPW+9DmaR7tujRqrSKnY1HqQKpnFI
         WyvXJbHkBzd8F9Nn/CMBv9qAD99OnatVIMlEA+AZD9ZT6dq0ZUkAUaMrtElz69BUlbw+
         7XlaxWcgrq2gDW61Ous/PUxrq378WlE2mck8pGA6PrUDnxL6Hh4S/JBfwj2nI+9YAp09
         ZeZMZcJuXuc3t2KJ6DzuKXNqug1iGor5RtJ3/xDslsSnVFcNxPb1o6nVKxW+WTikuPnI
         tLJA==
X-Gm-Message-State: AGi0PuYSHA82KH3267vrXjwbKEaFA4N0wxf4CbiV8KamlkTxFOQiiWbN
        NvV80mWBM+KFprvk8YR52+IbezLzG4I=
X-Google-Smtp-Source: APiQypLlJg5JMCyA6NRjwrVRx6hVTo4zJFUN122cEf87dctiOS3M39JdrThoNIGDP/O0tqqC4avt6Q==
X-Received: by 2002:ac8:6902:: with SMTP id e2mr4580346qtr.214.1588267309792;
        Thu, 30 Apr 2020 10:21:49 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id 190sm514369qkj.87.2020.04.30.10.21.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 10:21:49 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Thu, 30 Apr 2020 13:21:47 -0400
Date:   Thu, 30 Apr 2020 13:21:47 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Guess the base-commit of a series
Message-ID: <20200430172147.3fblnrvi73asnkp5@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello:

Given a/ b/ filenames and blob index information, is there a relatively 
easy way to find the latest branch commit where a patch series would 
apply cleanly (i.e. guess the base-commit)?

-K
