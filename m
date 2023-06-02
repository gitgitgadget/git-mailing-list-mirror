Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FB3C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 18:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjFBS7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFBS7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 14:59:36 -0400
Received: from qproxy2-pub.mail.unifiedlayer.com (qproxy2-pub.mail.unifiedlayer.com [69.89.16.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E9B4
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 11:59:35 -0700 (PDT)
Received: from outbound-ss-820.bluehost.com (outbound-ss-820.bluehost.com [69.89.24.241])
        by qproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 5C4CD8029384
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:59:35 +0000 (UTC)
Received: from cmgw10.mail.unifiedlayer.com (unknown [10.0.90.125])
        by progateway2.mail.pro1.eigbox.com (Postfix) with ESMTP id 0CFD9100492CD
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:59:35 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id 59zqqqE45mjMl59zrq5LwV; Fri, 02 Jun 2023 18:59:35 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=KfEXDSUD c=1 sm=1 tr=0 ts=647a3c17
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=of4jigFt-DYA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=0sg_UfPvMsS_uAhgTWgA:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Date:To:Reply-To:From:Subject:Message-ID:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S7QmcLhsN+Ux3yIISDM44gPxbi3SkDvVf0ldNwGIFj8=; b=kZYAhsmjsRcr41Hc5QyB9V0BHm
        Iag1216lobp98x1j1JBz8i7jiHnusmBSUNQaDRUF4cSoE6xAbqfXXh9RKSv1f5XeyKaV3g0q50TpP
        RNk2ahT/rkf9kPEPBZerNc+Kj;
Received: from [160.231.0.90] (port=14043 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1q59zq-000Eew-Mi
        for git@vger.kernel.org;
        Fri, 02 Jun 2023 12:59:34 -0600
Message-ID: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
Subject: Anyone know why git ls-remote output might be corrupted?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Fri, 02 Jun 2023 14:59:32 -0400
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (by Flathub.org) 
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.0.90
X-Source-L: No
X-Exim-ID: 1q59zq-000Eew-Mi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:14043
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some scripting on my CI/CD servers that invokes git ls-remote
and parses the output.  The scripting is in Python.  Sometimes, but not
always, the output of this command is corrupted.  I've enhanced the
error handling and I see this:

>> git ls-remote --heads origin
*** INTERNAL: remote branch lookup failed:
Output:
-----
8431d80571dea5cc8e6d0848f27124f66346dcc4        refs/heads/foo1
aaec1feb1167cf3fbd39a36cdd7736679a9f4fae        refs/heads/foo2
6167c73fbaded389ff54d52a01878975f4a6d5e5        refs/heads/foo3
   ...
3a2e8036a6f6605d4dd14c72bd395298bff9d80e        refs/heads/xxx1
3a2e8036a6f6605d4dd14c72bd395298bff9d80e        refs/heads/xxx2
795d2ff669041fc91341cf5bf820aibab79dc92bd741e77a7dcf71d94285a6ae494dc0     =
   refs/heads/yyy1
1496ea0ddab29ae3935754fced4bd5858cff7940        refs/heads/yyy2
1496ea0ddab29ae3935754fced4bd5858cff7940        refs/heads/yyy3
-----

Also a bunch of the heads are missing.  It's pretty clear that right in
the middle of printing one of the SHAs we suddenly lost a bunch of
output, and started printing stuff from later (in the last instance 66
out of 131 heads were missing).  Breaking down the output above you can
see:

  3a2e8036a6f6605d4dd14c72bd395298bff9d80e        refs/heads/xxx2
  795d2ff669041fc91341cf5bf820aibab79dc92bd741e77a7dcf71d94285a6ae494dc0   =
     refs/heads/yyy1
                               ^

where the "795d2ff669041fc91341cf5bf820a" before the "i" char is a
valid start of a SHA for a head (not shown), then the "i", then a fully
valid SHA for heads/yyy1 which is 66 heads later.

I've seen this happen with different versions of Git on the client side
and on different OS's (Windows and Linux).  The only real constant here
is the Git server.

Is it feasible that this is an error on the server side?  Does the
server return formatted output for ls-remote?  I would naively have
expected it to return a binary representation of the heads, and the
formatting be done by the client.  But maybe not.

I should point out that subsequent runs in the same client work fine,
and when I log into the CI/CD client and run the command by hand I
can't reproduce it.  It's random.  I also can't find any errors printed
anywhere on either the server (we are using ssh access only for client
connections, managed via gitolite) or the client, except for the above.

Help, this is causing a few spurious failures in my CI/CD system per
day!
