Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A9020954
	for <e@80x24.org>; Thu, 30 Nov 2017 09:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbdK3JzK (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 04:55:10 -0500
Received: from giant.haxx.se ([80.67.6.50]:57263 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbdK3JzI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 04:55:08 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Nov 2017 04:55:08 EST
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id vAU9kluF031610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2017 10:46:47 +0100
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id vAU9klBS031606;
        Thu, 30 Nov 2017 10:46:47 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Thu, 30 Nov 2017 10:46:47 +0100 (CET)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Doron Behar <doron.behar@gmail.com>, git@vger.kernel.org,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: Re: imap-send with gmail: curl_easy_perform() failed: URL using
 bad/illegal format or missing URL
In-Reply-To: <50fb321e-bbfc-adae-992d-eea1b818171e@suse.de>
Message-ID: <alpine.DEB.2.20.1711301041250.30591@tvnag.unkk.fr>
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain> <20171130020445.GF15098@aiede.mtv.corp.google.com> <50fb321e-bbfc-adae-992d-eea1b818171e@suse.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1129329158-959768077-1512035207=:30591"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1129329158-959768077-1512035207=:30591
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 30 Nov 2017, Nicolas Morey-Chaisemartin wrote:

> This is due to the weird "[Gmail]" prefix in the folder.
> I tried manually replacing it with:
>         folder = %5BGmail%5D/Drafts
> in .git/config and it works.
>
> curl is doing some fancy handling with brackets and braces. It make sense 
> for multiple FTP downloads like ftp://ftp.numericals.com/file[1-100].txt, 
> not in our case. The curl command line has a --globoff argument to disable 
> this "regexp" support and it seems to fix the gmail case. However I couldn't 
> find a way to change this value through the API...

That's just a feature of the command line tool, "globbing" isn't a function 
provided by the library. libcurl actually "just" expects a plain old URL.

But with the risk of falling through the cracks into the rathole that is "what 
is a URL" (I've blogged about the topic several times in the past and I will 
surely do it again in the future):

A "legal" URL (as per RFC 3986) does not contain brackets, such symbols should 
be used URL encoded: %5B and %5D.

This said: I don't know exactly why brackets cause a problem in this case. It 
could still be worth digging into and see if libcurl could deal with them 
better here...

-- 

  / daniel.haxx.se
--1129329158-959768077-1512035207=:30591--
