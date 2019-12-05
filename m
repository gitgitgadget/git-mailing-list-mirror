Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523A8C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 11:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226042464E
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 11:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+HjOy1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfLELC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:02:26 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33905 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLELCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 06:02:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id j11so46379pjs.1
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qRu4t/1vGUVbMBppg87fl7QU9zrT9cIDDMPSsAVQT8s=;
        b=Z+HjOy1XVYLBAWCi8c9FAoBVXw3EyoTpUi2tDEKeEXgoTcD0DK+3dx2lt+IkktLmTy
         OEKF2PfjQABhr5UuA1PiVuGHTEANYdCDGj/3sjyDbXiAgYAbOBrzRzyut7WqPRpN8/b1
         9rdkNtiw9oIPOe+LfHnkCM5nZ9ACDltCXroQAdWkAZWrj+jRZVF1PBnHnvyZ9WQzMLrB
         KI6un/VJN/xyBGGwXrOIOvvih4OMzFluo9DTlbsGRrtz8eH2DjyUiBjcTvkoBE5o0el8
         g02+iLpWFUpmOtK2/ywqzVJrLJtmiEfz4zSDbFR4UuHYpflYrVKWGemtWB13W+48T8Q6
         3g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qRu4t/1vGUVbMBppg87fl7QU9zrT9cIDDMPSsAVQT8s=;
        b=uimQAVovAHraoE3KGnUELRUG2rj+VdmMkLQ9MwiPgHJVa6DanjCXie1rakcxKTI7Ig
         nkBfNB4W+BLq463nfnX78ZToYYqVI/sR+MvAl1mMNOKVVPn2bSFoaAS8sFEP84ricO9y
         m/AXbAgXMTZnFaKLF3lvtFBr5BKETMiPdc5kSAPCTIOuJjnB3jRvAIN1yVTBSYZAnElL
         iSgHvNq9lZIkW5dqmnmxJNkMyd5dGyzCNjWsr80ZHJFOjlgOXuZ7Zi8wL7tw/8tiNRnh
         jm27YgN1q/oc6UcgUFAgugJ2/g/GeZjoCDGM1ZbWiRCZW4O23S3qhlYsh3xF4bVd1WFY
         XgiQ==
X-Gm-Message-State: APjAAAVFrQKx1dQTUGTR61khBioHYSI0TkcTd6N5NdM2XVZZuConde1I
        3M09hHNNQ8nRD2CAbPKYQcI=
X-Google-Smtp-Source: APXvYqzYArDCIMcfbFjpwHJtO3UVXU5dk6hFnJP7N5pC9BOrgIpejGuPd9sXUucFHgGjw2DlCb7WZA==
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr8557004pjb.21.1575543745122;
        Thu, 05 Dec 2019 03:02:25 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id ce22sm9443338pjb.17.2019.12.05.03.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 03:02:24 -0800 (PST)
Date:   Thu, 5 Dec 2019 03:02:23 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 04/11] git-p4: python3 syntax changes
Message-ID: <20191205110223.GC1192079@generichostname>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <3c41db3e9157e20aeed41d3eff373183c9834bff.1575498577.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c41db3e9157e20aeed41d3eff373183c9834bff.1575498577.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 04, 2019 at 10:29:30PM +0000, Ben Keene via GitGitGadget wrote:
> From: Ben Keene <seraphire@gmail.com>
> 
> Python 3+ handles strings differently than Python 2.7.  Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.
> 
> There are a number of translations suggested by modernize/futureize that should be taken to fix numerous non-string specific issues.
> 
> Change references to the X.next() iterator to the function next(X) which is compatible with both Python2 and Python3.
> 
> Change references to X.keys() to list(X.keys()) to return a list that can be iterated in both Python2 and Python3.

I don't think this is necessary. From what I can tell, using the
key-view of the dict objects is fine since we're always doing so in a
read-only manner.

> 
> Add the literal text (object) to the end of class definitions to be consistent with Python3 class definition.

Since we're going to be dropping Python 2 soon, do we need this? I get
that we'd be mixing old-style with new-style classes in Python 2 vs
Python 3 but it's not like we do anything with the classess related to
type() or isinstance().

Anyway, I'm going to stop here since it's way past my bedtime. I hope
that my suggestions so far have been helpful.

> 
> Change integer divison to use "//" instead of "/"  Under Both python2 and python3 // will return a floor()ed result which matches existing functionality.
> 
> Change the format string for displaying decimal values from %d to %4.1f% when displaying a progress.  This avoids displaying long repeating decimals in user displayed text.
> 
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> (cherry picked from commit bde6b83296aa9b3e7a584c5ce2b571c7287d8f9f)
