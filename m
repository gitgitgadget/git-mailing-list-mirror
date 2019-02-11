Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3861F453
	for <e@80x24.org>; Mon, 11 Feb 2019 08:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBKIyH (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 03:54:07 -0500
Received: from adoakley.name ([88.198.105.104]:55742 "EHLO adoakley.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfBKIyH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 03:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F1UsjnHpI6keNo9fDeuJlM1VDYuK2r1g2nH3lQCY1lE=; b=cCaxcmvqm9Inlfia6t0Yto4sPV
        hT3OcvBHTffq8yRTZ9FeojRQJA3cdkpbrlJsQFNMwxM3IzthBcm04JYUR2ySOurrs5uyZ+TkjVQmy
        QGx9P6MAUp3xuOpIfOmvBV2sWqszDZbnEYS447JsnxOXGSG5ySseU2pSFEGhox+Xv1UQ=;
Received: from ado-amd-gentoo.home.adoakley.name ([2001:8b0:14bb:e93b:b0a2:3603:6426:932f])
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <andrew@adoakley.name>)
        id 1gt7Lo-0006FB-Ox; Mon, 11 Feb 2019 08:54:04 +0000
Date:   Mon, 11 Feb 2019 08:54:05 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: recover from inconsistent perforce history
Message-ID: <20190211085405.51d752b7@ado-amd-gentoo.home.adoakley.name>
In-Reply-To: <20190208091033.12617-1-andrew@adoakley.name>
References: <20190208090704.68154885@ado-amd-gentoo.home.adoakley.name>
        <20190208091033.12617-1-andrew@adoakley.name>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri,  8 Feb 2019 09:10:33 +0000
andrew@adoakley.name wrote:

> From: Andrew Oakley <andrew@adoakley.name>
> 
> Perforce allows you commit files and directories with the same name,
> so you could have files //depot/foo and //depot/foo/bar both checked
> in.  A p4 sync of a repository in this state fails.  Deleting one of
> the files recovers the repository.
> 
> When this happens we want git-p4 to recover in the same way as
> perforce.

Unfortunately this still has a few issues:
- newer p4d versions don't allow this by default so the tests fail
- deleted files get recreated in some cases
- command line too long when there are lots of deletions

These are all easily fixable, but I'll test more on a real repository
with before sharing another patch.

-- 
Andrew Oakley
