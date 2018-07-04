Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63CB21F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 06:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeGDGnu (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 02:43:50 -0400
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:44774 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932615AbeGDGnt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Jul 2018 02:43:49 -0400
X-Greylist: delayed 2100 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 02:43:49 EDT
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 08D4F175DCD
        for <git@vger.kernel.org>; Wed,  4 Jul 2018 00:08:48 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id aay6fcCA29wBZaay6fC1mV; Wed, 04 Jul 2018 00:08:46 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:To:Reply-To:From:Subject:Message-ID:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rr4EZckH9gRgOfUpk7XCgzQY/x0gq2qXzoxtDhttZN8=; b=aqcsMG3YPGxpSGEbqkjQNqE5wn
        rvJPkJ1CQbaEeA9qslTsnUUPOR2Ng5DsY7nhC3pDHW5jWMQVKENfUsS8qxI4+bzxKBkM2zvUFaJjz
        +sm9K7Gr/M9gZdLbrkI2UprCY;
Received: from pool-72-70-58-227.bstnma.fios.verizon.net ([72.70.58.227]:34234 helo=homebase.home)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1faay7-003SZa-Dw
        for git@vger.kernel.org; Wed, 04 Jul 2018 00:08:47 -0600
Message-ID: <e9d5bbec6242e47b1f4141ffd99b276eb6a41347.camel@mad-scientist.net>
Subject: RUNTIME_PREFIX references in gitconfig variable paths
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Git mailing list <git@vger.kernel.org>
Date:   Wed, 04 Jul 2018 02:08:46 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 72.70.58.227
X-Source-L: No
X-Exim-ID: 1faay7-003SZa-Dw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-72-70-58-227.bstnma.fios.verizon.net (homebase.home) [72.70.58.227]:34234
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One thing I wanted to do was provide a default ca-bundle.crt file along
with my local build of Git.  I need my installation to be relocatable
and I'm using RUNTIME_PREFIX with Git 2.18.0 (on GNU/Linux).

I can provide a system gitconfig file with a setting for http.sslCAInfo
but the problem is I can't create a relocatable path here so I don't
know how to set it:

  $ cat $prefix/etc/gitconfig
  [http]
      sslCAInfo = <prefix>/etc/ca-bundle.crt

What do I use for <prefix> above since I want it to be relocatable? 
Basically I want this to be in the same directory as the relocatable
sysconfdir (I don't actually care much but that seems like a good
place).

Is there some way to create a reference to a path relative to the
installation directory?

For example "~" is accepted as the users $HOME path; is there some
syntax which refers to the Git installation directory?

If not this seems like something that would be very useful.


I can use a wrapper script and set GIT_SSL_CAINFO, but that will also
override any user's setting of http.sslCAInfo in their local gitconfig
which I don't really want.
