Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2C82018F
	for <e@80x24.org>; Wed, 13 Jul 2016 19:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbcGMTGq (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 15:06:46 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35726 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbcGMTGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 15:06:44 -0400
Received: by mail-lf0-f41.google.com with SMTP id f93so46330242lfi.2
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 12:06:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q8LKx+v2vZJi2juNliD33VzsnXlBymo+GQJV6iboRWg=;
        b=oO0NCwwxvofPH6ja5MQariqVL+M3waWgXxQG/9OTH1ul+9TQrToiz+18fLgdsaydnp
         ZDjQuFew9tMchf3kTjgEURi+PlKZj0SmwStO8VCyjtLHQQ2etwcT9UIyipHtZFu3gzfe
         rl4VeQecuLW2ta+k+UsnpkaqGAj0LdRRK52P5R3ODS8fxIYb8cwOEYwq3gorSLw+L5HC
         NH4RqkyiF4+sc2frXcxPRIbRaQ4v45lloNjnuI1k9jxBLYol0elcyHeqtWdU3yaSMjsV
         WQnhyZ2YyXkqxWkZWdZ5f/FKXeEUef42uXiyzUMk+K+WND0isKDdKDFRrrke/0wVOy4i
         wvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q8LKx+v2vZJi2juNliD33VzsnXlBymo+GQJV6iboRWg=;
        b=Kv9NXweL18TngP0thKTRor/ZxW03CPVQdkd0YAHt/zg6x5kp9pGYB9K/2ucEgnxFco
         cJAnlCAooclqAur6KWp27Z70yvInekEFXuQs1/f8Zt+Krp8ClyorGOrNjxrQz7hUSaW9
         Vpcr29Vv2GzIPtTLsWMvHNXHmOprCWHtiE2i8TPXNJ5kJ0/x75RAzerS2Wb4DdOjbjxs
         L6vGHTEGbARH4ofcfMg+Uu6b9ZqYoVsgohO0n+igcOMX59r5NNimlpLVuL3n2BIXNqGU
         NcfY82kXdT2usCBoyao0eS69qHuiD2AfOhhTYa6Fh/bhRtJUjcr8sET4rzA+WlNUb/q5
         yFhg==
X-Gm-Message-State: ALyK8tKBaLoIuq3187pEGggvkhAkE5ca7dZztw8cvahZiQ0YKDfaxsiCTVrfXDIJLho7XYPKekZY6WHgDBeQVg==
X-Received: by 10.25.41.142 with SMTP id p136mr746480lfp.32.1468436797409;
 Wed, 13 Jul 2016 12:06:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.88.205 with HTTP; Wed, 13 Jul 2016 12:06:36 -0700 (PDT)
From:	Nikos Andrikos <nick.andrik@gmail.com>
Date:	Wed, 13 Jul 2016 21:06:36 +0200
Message-ID: <CANn5kOsr9K35oVErEeZetwphQpNLZbKRDraMoDzVq2rdVZ-XPg@mail.gmail.com>
Subject: Issue with git p4 clone when using multiple depots and multiple branches
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

We have a perforce structure at work that looks like this:

//depot/basic/{main,branch1,branch2}/component{1,2}
//depot/extra/{main,branch1,branch2}/extra{1,2}

I'm trying to create 3 branches, i.e. main/branch1/branch2, with all
sub-components together, i.e. component1/component2/extra1/extra2.

For this reason I have created a p4 client, with all 12 paths used like this:
//depot/basic/main/component1/... //client.name/main/component1/...
//depot/basic/main/component2/... //client.name/main/component2/...
//depot/basic/extra/extra1/... //client.name/main/extra1/...
//depot/basic/extra/extra2/... //client.name/main/extra2/...
... similar also for branch1 and branch2.

I have setup my git using these:
git config git-p4.clientclient.name
git config git-p4.branchList main/extra1
git config --add main/extra2make

The problem is that all //depot/extra paths are ignored when I'm
running the following command
> git p4 clone --use-client-spec --detect-branches //depot/basic@all //depot/extra@all --destination project

I think the issue is in git-p4 and especially in importNewBranch.
Instead of using:
"""
branchPrefix = self.depotPaths[0] + branch + "/"
self.branchPrefixes = [ branchPrefix ]
"""
We should be using
"""
self.branchPrefixes = [x + branch + "/" for x in  self.depotPaths]
"""
Same also for "p4ChangesForPaths([branchPrefix], ..."

What do you think?

Thanks,
Nikos

--
=Do-
N.AND
