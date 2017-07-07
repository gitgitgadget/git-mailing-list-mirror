Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10BE202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 12:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbdGGMhd (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 08:37:33 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36764 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdGGMhc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 08:37:32 -0400
Received: by mail-wr0-f172.google.com with SMTP id c11so45264712wrc.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4byJnwCMuVBlOfUDLo6IeDNRWx3DbtfrfKTbqurnvvM=;
        b=RhSyngWwr1SpxhuEjEFoU4/a5ecTzvRc2HzRnnT6v0npI4s7CRCBa+sXGwGJYILcwX
         Giv5f4eJL6L9xrXx8FJdflfXZBvbgJCnrjbTmFaoFakwh/cu4n9/oVJwmczt2XcsMgZI
         uiPZXfX2tmQ3S62b5TCzNq0SMtEi+MpcEeXcf/1HrysqhAZL58gw10ellGzpOF6Wg6ZI
         8XaERoUunRHzQ/LvpBzp3eaQqd5YHye0C7MXTnA/YE/IWbs8Qq/zy4t26hK7H3n7x3F+
         c+eV7vued958dcz3kaXVdAS4nTWyHrBvghwOlZhikf7y+zesTlw3FiRRImxhoIfAxw2A
         LVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4byJnwCMuVBlOfUDLo6IeDNRWx3DbtfrfKTbqurnvvM=;
        b=CfstUtkQvBNMx9vmwBpZVSszxYCfrHAPfalvi1+dusldcoOylJaX379Z18NvLjTMKH
         wuJCAHa+w/6FSphddxMHYNrXOa2rhFJHnBSOXrrmY3xq/I076YdJb4SUDzxnrQnwH9qW
         8HoRYCxb3mBTLI/2KWhKwSCkIg9RlO4xtZCFhLl9Ia7AI++6uLvV/HqDQNR6iEduR83z
         PQ1UAvYEHKrmvseDy1cSPcX3oFwDjpK0or2P5fB0mRmYE4e3LakZL/p8JM1lmLlJGf+e
         WZ/98esa+qx0LHiJrFrTN+F8+DGF5lViOImQBhWwTswIQcbur2LsN/e4u27UO6rSwckh
         QnFg==
X-Gm-Message-State: AIVw110CcqcM7Yw+hwNfUFY1LcYmg2eDCsTdoXiXEeDSDOSNU1+Hrub5
        czAAPTssatHH/DivFb8=
X-Received: by 10.28.105.91 with SMTP id e88mr2246965wmc.52.1499431051243;
        Fri, 07 Jul 2017 05:37:31 -0700 (PDT)
Received: from ltop.local (6.37-64-87.adsl-dyn.isp.belgacom.be. [87.64.37.6])
        by smtp.gmail.com with ESMTPSA id d91sm4185019wma.7.2017.07.07.05.37.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jul 2017 05:37:30 -0700 (PDT)
Date:   Fri, 7 Jul 2017 14:37:28 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     git@vger.kernel.org
Subject: bug during checkout of remote branch and uncommited changes ?
Message-ID: <20170707123727.dgd5rub2ycrg525y@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170428 (1.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Lately I've been caught several time with a problem which,
to me, is a bug. It can easily be reproduced, so I think
It's very possible it has already been reported.

The problem arise when trying to checkout a branch while having
some uncommited changes. The scenario is the following:
	$ git status
	M  afile.c
	$ git remote add <aremote> <anurl> 
	$ git fetch <aremote> <abranch>
	remote: Counting objects: 7, done.
	remote: Compressing objects: 100% (6/6), done.
	remote: Total 7 (delta 5), reused 3 (delta 1)
	Unpacking objects: 100% (7/7), done.
	From <anurl>
	 * branch                <abranch> -> FETCH_HEAD
	 * [new branch]          <abranch> -> <aremote>/<abranch>
	$ git co <abranch>
	error: Your local changes to the following files would be overwritten by checkout:
		afile.c
	Please commit your changes or stash them before you switch branches.
	Aborting
	$ git reset --hard
	patching file afile.c
	$ git co <abranch>
	fatal: Not tracking: ambiguous information for ref refs/remotes/<aremote>/<abranch>

What can be ambiguous here?
Strangely, trying a second time, succeed:
	$ git co <abranch>
	Previous HEAD position was ...
	Switched to branch '<abranch>'

-- Luc Van Oostenryck
