Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD452CCA47C
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 15:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiF2P1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiF2P1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 11:27:24 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98622E9FB
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 08:27:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BD8B5C06CB
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 11:27:21 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Wed, 29 Jun 2022 11:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theknown.net; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=mesmtp; t=1656516441; x=1656602841; bh=r0nLov9
        O6ZkMPjqrXaGvQ3/hs7F5PR9yE3PdusZku9Y=; b=NPJiLM//KAGqTEzGK4IRqAk
        ssx0awD/kshuygL1wrdKIDA+IRhQohhPcOntIy3/hUUIMcHy/jXVNffyxh1CNVdK
        ZL2vpIPciUUUHx01QXRoZtcMSB+oKX7HN8wvdczwfE0GcnfdTXaqqQq9aDZNg5u6
        elnvURWlCgRqCcXm5Kvk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656516441; x=1656602841; bh=r0nLov9O6ZkMPjqrXaGvQ3/hs7F5
        PR9yE3PdusZku9Y=; b=VqkzDNoPiBXj/Omttym1xa0ol92Qcy7NICSQwnPgrywd
        PtMkL8qLCziNPqmkb0lE/6vok+8V3J/fMFHp2w+whfnSGV2frXI5NYE571xVYnck
        E+EFgJDXrH/Oq14WOZpCAPBulGeBoxVDWJUVKn0ylDUKxcdJgdwpgKB7i9u5LtaZ
        eYo3YC2tGDHhNi+EwqTCXnM3Gd9l+RL7DkxNxAzgopzVsMW3onyNA16IWV0uJ7P+
        +Avf/Uw9rMXLFKg6zPeW9dLaFcQJp6Kc1YN/h1UMOIXz2IlEo7JZ3RcVG74oR3ks
        GxlYPP9oPSBAaqJ2+5VWkcvnWzKs+7YszXtDQoFlDg==
X-ME-Sender: <xms:WG-8YoOiucHtxetWWTp2jBiq8Nxs0hfArrm2foYq9ahvadMPVuu_uQ>
    <xme:WG-8Yu__xfalFXM30k0AnvvraMgtup92sPhOo32uZ0YAl4xTTp18iULXHpsd4eHDb
    9fT4Opseiew7N9Yvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdfkrghnucghhhhithhlohgtkhdfuceoihgrnhesthhhvghk
    nhhofihnrdhnvghtqeenucggtffrrghtthgvrhhnpeeugeeghefhudehvdffgeeigeefue
    dtudffleehhfffffduueelgfdufeefffegveenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehirghnsehthhgvkhhnohifnhdrnhgvth
X-ME-Proxy: <xmx:WW-8YvQK8x_NQ-NFprmrUmfK0nUfASNzfFqiSlXRqZsJq9KpEGdPEQ>
    <xmx:WW-8YgtOJuxeDGSKAlU0Gy3yNm43dWeJ3nHxQB2zW0DWHpHwuKhYgg>
    <xmx:WW-8Ygfh1K5nCy9MODektbZxH8mdaOSyKHAttblhHBvLfwUDdY_cow>
    <xmx:WW-8Yqq6HKu9jmwrOCxtZbTt2r8ucSURzvyeP0PenpqV9dnN2YVQ8g>
Feedback-ID: i84894270:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E5F892D40071; Wed, 29 Jun 2022 11:27:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-713-g1f035dc716-fm-20220617.001-g1f035dc7
Mime-Version: 1.0
Message-Id: <d2a7caa9-e2ba-457d-9fe9-92b29b5ee47a@www.fastmail.com>
Date:   Wed, 29 Jun 2022 10:26:59 -0500
From:   "Ian Whitlock" <ian@theknown.net>
To:     git@vger.kernel.org
Subject: Bug: "git-remote ls -h"
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I found a bug and couldn't find another way to report it. I hope this is=
 okay.
The help output for `git ls-remote` shows that `-h` should display remot=
e HEADs, but instead the help output is displayed!

 =E2=9E=9C git ls-remote -h    =20
usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<exec>]
                     [-q | --quiet] [--exit-code] [--get-url]
                     [--symref] [<repository> [<refs>...]]

    -q, --quiet           do not print remote URL
    --upload-pack <exec>  path of git-upload-pack on the remote host
    -t, --tags            limit to tags
    -h, --heads           limit to heads
    --refs                do not show peeled tags
    --get-url             take url.<base>.insteadOf into account
    --sort <key>          field name to sort on
    --exit-code           exit with exit code 2 if no matching refs are =
found
    --symref              show underlying ref in addition to the object =
pointed by it
    -o, --server-option <server-specific>
                          option to transmit


Small bug, but a bug nonetheless.

Thanks for building such a lovely tool
