Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F24EC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A92613C5
	for <git@archiver.kernel.org>; Thu, 27 May 2021 14:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhE0OBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhE0OBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 10:01:39 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAD5C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:00:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v22so846912oic.2
        for <git@vger.kernel.org>; Thu, 27 May 2021 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ye0Ddd7BvEOIH0C3ZxOh6Nc20aChdTwzlV1UxA/k7sQ=;
        b=GfRHTHbfMUZWI1foMmQGq1V2Dov3/WrkPlRkh3CW+gpBO8G5sOZlP0a7Pbct67abRA
         6n/VEU3486YZBlKnQPA11IBGaSRvF1b46nj+PiiX4lGJInjVRxZQ8Jj6ugeYl13GGO3x
         +L9r1Fdvx8s+WRKqrEIBfvy/Mj5CNmFGU4g9ul4WCt+6C2n4s8DCWAxsMiXE10xDCKRZ
         r14Vqm/GzfKIlbllCK2jOd7hB9yLdDhE4pOZSnh8AxULQnvtrg7yNfflPP1Ghfc0XsVL
         vV9JuUcPZVwP+61M3WYRIa+ob4ghmXcDKEK5AzMt0LJcN0hrSpUiX0B0DaxT/LgD621w
         fyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ye0Ddd7BvEOIH0C3ZxOh6Nc20aChdTwzlV1UxA/k7sQ=;
        b=AxedugKXwCAGp7p/3eXs9u9ofIx1oPWFa4sK1zcgO8eqcPJ6Py4HIt7Tv+u+qpUV14
         lqoa5oBuyB/YaeXWwaguXc/U5BHZdJ0Bho+Sr9e2DbY7Gf9g5G+zL4gIZLOuxK1QW08C
         3gS7a0HlLLf5vSQ7rttwsoHP418uK8FiO3Bae6ybjg8Awwsa1qPVsT9E6NdWCTw/PhrQ
         exvZ0W9vxUF/katuQizL/DTNWxZGIhjhMZYk+B8qp/i4ew1NhkdfAvduuvKUBnBOMKNK
         g+ArA/cS7aZbfbRVvu/MOFn35ju6EX8ex3w4z0f8eFOcHG5RbIw2ZrF1BwcAS+tsQVID
         S8qw==
X-Gm-Message-State: AOAM530yv+4YDyeP67cg0N4/IPAwOcV7kd0tmDqFoxZVVoPcpV0sTxm6
        dow7sJ8NnW6lDadiI4Nhl+4=
X-Google-Smtp-Source: ABdhPJzRFI/LCLyHZyWBlEA5hqXUOp5uIiBzKvqQCumfk0gQDBZ1DWMweAhDjkenOTqaMM3x49K4Yg==
X-Received: by 2002:a05:6808:1414:: with SMTP id w20mr5396271oiv.136.1622124003140;
        Thu, 27 May 2021 07:00:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t23sm473118oij.21.2021.05.27.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:00:02 -0700 (PDT)
Date:   Thu, 27 May 2021 09:00:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60afa5e07bcd9_2056d2084d@natae.notmuch>
In-Reply-To: <02bbe080-cd8a-cc7d-5dbc-9231b51c4baf@iee.email>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
 <60adb824bac10_2c7f620844@natae.notmuch>
 <da77d0a0-7fdb-e4c8-6510-87ea0294dac4@iee.email>
 <60ae947797deb_25ba2089c@natae.notmuch>
 <6dcc8557-9df4-9ea2-c348-f4ebf76ff446@iee.email>
 <60aedb22c075e_4bd420896@natae.notmuch>
 <02bbe080-cd8a-cc7d-5dbc-9231b51c4baf@iee.email>
Subject: Re: fast forward merge overwriting my code
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 27/05/2021 00:34, Felipe Contreras wrote:
> > Yes, but that is a separate issue.
> >
> > Right now they are able to resolve conflicts with a jupyter mergetool.
> 
> I don't believe that ("resolve") is true in the sense they would like. I
> don't think they are really 'merging' in an all-in-one `git merge`
> sense, rather they are [trying to] splitting and patching and commenting
> the changes.

He explicitly mentioned a merge, but ultimately it doesn't matter, the
mergetool can be used in other scenarios, like `git am`.

I did try to setup those tools, nbdime does setup a merge tool [1].

Cheers.

[1] https://nbdime.readthedocs.io/en/latest/

-- 
Felipe Contreras
