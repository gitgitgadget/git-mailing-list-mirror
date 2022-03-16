Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F3DC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 14:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352135AbiCPOvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347295AbiCPOu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 10:50:59 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0A5F257
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:49:45 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22GEnaLw029490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Mar 2022 10:49:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>, <git@vger.kernel.org>
References: <036701d83942$e6963ca0$b3c2b5e0$@nexbridge.com>
In-Reply-To: <036701d83942$e6963ca0$b3c2b5e0$@nexbridge.com>
Subject: RE: [RFE] Signing using SSL
Date:   Wed, 16 Mar 2022 10:49:31 -0400
Organization: Nexbridge Inc.
Message-ID: <036901d83945$0e9c98a0$2bd5c9e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEPHGOlDpxeio8Suw6+ThURSydcNK5UTfrQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 16, 2022 10:34 AM, I forgot to mention:
>Following up on our IRC discussion on Monday, I have had a request to
support
>signing git commits and tags with SSL certificates instead of SSH/GPG. The
>organization is heavily invested in SSL infrastructure, so they want to go
down that
>path.
>
>The basic technique for doing this is, for example:
>
>openssl dgst -sha256 -sign key -out content.sha256 signature.txt -passin
>passphrase
>
>There is a pre-step to compute the sha256, in this example, into a file
provided to
>openssl. We could use openssl to compute the hash also.
>
>Verification is a bit different than what SSH or GPG does:
>
>openssl dgst -sha256 -verify  <(openssl x509 -in certificate -pubkey
-noout) -
>signature sign.txt.sha256 signature.txt
>
>and reports either
>
>Verified OK
>Or
>Verification Failure
>
>It does not look like completion codes are consistently involved.
>
>This also does look structurally different than both GPG and SSH and more
work to
>set up. It may be possible to provide wrappers and pretend we are in SSH,
but I'm
>not sure that is the right path to take.
>
>Any pointers on how this might be done in existing git infrastructure, or
should I
>look into making this work in code? Sorry to say that the documentation is
not that
>clear on this.

It looks like there probably needs to be come configuration support
including things like httpVerify=false for self-signed certs, certificate
store paths, etc., to support SSL infrastructure.

