Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97095C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 18:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLOSDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 13:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLOSDc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 13:03:32 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F6442D1
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 10:03:31 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|roger@ecstaticsignal.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3B619341206
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 17:55:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 97B883413DD
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 17:55:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1671126903; a=rsa-sha256;
        cv=none;
        b=EXsO9R6fA3rWsNLskXYpxp2ogIX9njdUOOS1JjTSXpK7Y7bdxzrZacu8pbOFgboCv0LvMD
        Eym/dc1dSSA3zDrg+g99J9SiAs1RbR7rg825wYGLB0Ufiagw+keCiI0K/oHDbTNcbbxpSf
        /bsoKE3qAweCd79JrgRuykAuKSRvedaw2+JRwfcLJQcMvcoJEBDGhCgvsHzzNtHuIFdQJP
        oPo1ohnAouWedOSx+n2gN/jekjU2oIzK8qatjktW67z7S4iUwxymxLudIX1kGATrqoGQTD
        rXaXQQm056GocXFliYH5azAZZPW5N1gzXm4+B/6FCxamli+SPqvM/Mz9w7V+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1671126903;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=exgFJREJZFgcgBq+GtWyY5t/4ipHDy0ll7/FWgOdQr8=;
        b=kA9KR+czHeOv0CfBW8+ojeW5ZW7phD6Ki98zRuxXPVPcEg4C3TMZ9KnQyum3o32kRUn9+P
        u/Ytju0pHS+oD35EllKVd8hobv/leu+T92to2o+uW671kN/gOH9RwS587wutJWBFIo+6vX
        2n3e4IxjD9hlZULc+MWWXa+pWX4uW/p2zVjF+DrK45bSfD20XHvXcZcnPmTSeUORYh1Uh3
        EQLWSaVjvEoXQwc7gGJpHcW7xJcpUeaZpzg2chSM2s7nToTf8jimcdC0vUMoiA0+F5PR74
        5vdaSaqbwuDjr+R8DfjKgBoI3s0zdv+jKrrZLVpH+1I2bb/VMr7l2Cx9MmR9lA==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-tqrcc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=roger@ecstaticsignal.com
X-Sender-Id: dreamhost|x-authsender|roger@ecstaticsignal.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|roger@ecstaticsignal.com
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Whimsical: 42d64fb95938040d_1671126903845_2260054943
X-MC-Loop-Signature: 1671126903845:123926605
X-MC-Ingress-Time: 1671126903845
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.57 (trex/6.7.1);
        Thu, 15 Dec 2022 17:55:03 +0000
Received: from smtpclient.apple (23-93-204-144.fiber.dynamic.sonic.net [23.93.204.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: roger@ecstaticsignal.com)
        by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4NY0Hq2W5Xz1s
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 09:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecstaticsignal.com;
        s=dreamhost; t=1671126903;
        bh=exgFJREJZFgcgBq+GtWyY5t/4ipHDy0ll7/FWgOdQr8=;
        h=From:Content-Type:Content-Transfer-Encoding:Reply-To:Subject:Date:
         To;
        b=rAsCiHFsVB2ktQEAXQV+PgXOlLpYf/NxIIFePDgOWcVelcCCqbZEnJOZwMP4Ok0O3
         y/r9OJQoW2kbf90HvlvrxB1C6UBArL/ZTR3nKXrUSNpnEIpJ04mSo0iyaSChCsKjeU
         EoeAM5P+DGVoPwG2s33hE5D5kSzBiM2KX3Ji2UOm01csKDxH7kv3wJfBIdTRAqc0mW
         XrdlQ48PoaZ6luFySwDAEaqW649eUvTOEacTho19RGCaY2CGkbcvfmGfggdpDd/uKu
         AO11yv+7otTX7ytlWZT1Cx+XeiSlPEptUREo7XmblcHSwAVCOl6DYVUsZtBOxaoDbr
         rGqJXTLjiVmUw==
From:   Roger Rohrbach <roger@ecstaticsignal.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Reply-To: Roger Rohrbach <r.rohrbach@elsevier.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Commiting old version of file introduces other files to commit
Message-Id: <2AA962BD-8AB4-4DEE-A56E-5C10DE7FDE3F@ecstaticsignal.com>
Date:   Thu, 15 Dec 2022 09:55:02 -0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My commit changed one file, and deleted another:
=20
    commit 5ad22bab408029fde463eae0354becfee702c89b
    Author: Roger Rohrbach <rrohrbach@bepress.com>
    Date:   Fri Dec 9 20:43:04 2022 -0800
=20
        Automatically disallow robots for ringfenced site
=20
        As a side effect of setting "Ringfence this site" to "Yes," =
install a
        Robots Exclusion Protocol file (overwriting any existing one) =
that
        disallows all robots.
=20
        Also remove unused static robots.txt file with same rules, to =
avoid
        confusion.
=20
    diff --git a/opt/bepress/share/robots.txt =
b/opt/bepress/share/robots.txt
    deleted file mode 100644
    index 6ffbc308f7..0000000000
    --- a/opt/bepress/share/robots.txt
    <diffs redacted>
    diff --git a/perllib/Site.pm b/perllib/Site.pm
    index b531e6dade..671d2f0a97 100644
    --- a/perllib/Site.pm
    +++ b/perllib/Site.pm
    <diffs redacted>
=20
I needed to revert the change to the first file, but wished not to =
restore the deleted file.  So, instead of 'git revert 5ad22ba', I did =
this:
=20
    # Check out the version of the file immediately preceding my commit:
    git checkout 68e2db7 perllib/Site.pm
    # Commit it:
    git commit -m "Back out Site.postsave installation of robots.txt"
=20
Imagine my surprise when this introduced two additional files to the =
commit:
=20
    [DCIR-188-3 1daac3bdf0] Back out Site.postsave installation of =
robots.txt
    3 files changed, 3 insertions(+), 20 deletions(-)
    create mode 100644 opt/bepress/share/robots.txt
    delete mode 100644 perllib/.htaccess
=20
Not only did this restore the file I was taking pains not to restore; it =
arbitrarily deleted another file I'd never touched.
=20
Is this some weird hash collision problem?


