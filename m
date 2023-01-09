Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12728C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbjAIROH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbjAIRNV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:13:21 -0500
Received: from mx-out1.deshaw.net (mx-out1.deshaw.net [149.77.95.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE81A22F
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:12:57 -0800 (PST)
Received: from mx-relay1.deshaw.net (localhost [127.0.0.1])
        by mx-out1.deshaw.net (Postfix) with ESMTPS id C0D73C1B1A8
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 12:12:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deshaw.com; s=k001;
        t=1673284376; bh=9P95LHGmQKPhVM9ihtEoK9Pm0aHxp/yT3DcIe3r+sbw=;
        h=From:To:Subject:Date:From;
        b=LbPxzcU7AgyRnqHmRqnlJW2y+8enWyzZBameHh/xgUyq2+RkZ8AgPN1WUZtX1DnSa
         BHijNHbH3S13T9vi0DiqfTJ/IeZcCHLkfDu6XESuIV3ny08RupJw/tibEaR8QvUsA1
         8SctpLlWqW8pCXVPq7T9PRpl9Dzj/jHzBAO3ptnA=
Received: from deshaw.com (mail-multi.dr.deshaw.com [10.218.243.33])
        by mx-relay1.deshaw.net (Postfix) with ESMTPS id BE7D7120732F
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 12:12:56 -0500 (EST)
Received: from exchmbxtoa1c.deshaw.com (exchmbxtoa1c.deshaw.com [10.219.74.10])
        by mail-multi.dr.deshaw.com (Postfix) with ESMTPS id B8C95600027E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 12:12:56 -0500 (EST)
Received: from exchmbxnyc1a.deshaw.com (10.228.68.80) by
 exchmbxtoa1c.deshaw.com (10.219.74.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 12:12:56 -0500
Received: from exchmbxtoa1b.deshaw.com (10.219.74.15) by
 exchmbxnyc1a.deshaw.com (10.228.68.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 12:12:56 -0500
Received: from exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c]) by
 exchmbxtoa1b.deshaw.com ([fe80::b55e:2430:4455:ec8c%8]) with mapi id
 15.01.2507.016; Mon, 9 Jan 2023 12:12:56 -0500
From:   "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: BUG: git prompt breaks with zsh < 5.0.6
Thread-Topic: BUG: git prompt breaks with zsh < 5.0.6
Thread-Index: AdkkTWwUKBHMF2rJR52T9tUx9MJG2A==
Date:   Mon, 9 Jan 2023 17:12:56 +0000
Message-ID: <5807cdbe6d66427c9ff45ea78c2c1ffb@deshaw.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.219.66.97]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Content-Scanned: Fidelis Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A change to git-prompt.sh in v2.38 to show presence of unresolved conflicts=
 contains syntax which is not valid under zsh < 5.0.6. This version of zsh =
is old, but is still the default on RedHat 7 machines, for example.

The offending block is:

       local conflict=3D"" # state indicator for unresolved conflicts
       if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" =3D=3D "yes" ]] &&
          [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
               conflict=3D"|CONFLICT"
       fi

[[ $(command) ]] syntax doesn't work in older version of zsh and should use=
 [[ -n "$(command)" ]] instead.

Thanks,
Vitaly

