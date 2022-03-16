Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F3C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 09:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbiCPJao (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 05:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbiCPJal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 05:30:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BD065415
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647422965;
        bh=TRByo4JCJQtjkIZIsSVEJSdudB1m66DDHudUIHl5fiA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FE8G4qMqfu7bwGwCTnvPDWiFJTFmeYmzo8fgsoYbd/B+OnlmncL+R1+Nn/LXp6N5n
         fZLxQ3perIua6GK2e20uNrnegf7c0vadVjkF0/TpnmwOXQho76TQsGsBO2t/Zc6FdW
         VDWPMJLtX/KCXage1vpyNX7bL0XY12diqoUZHy6M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1nRgPL1TRW-006B5l; Wed, 16
 Mar 2022 10:29:25 +0100
Date:   Wed, 16 Mar 2022 10:29:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jayati Shrivastava <gaurijove@gmail.com>
cc:     Git List <git@vger.kernel.org>,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/1] Use reverse_commit_list helper function for in-place
 list reversal
In-Reply-To: <CANsrJQd0v2V9H8HPkiH2179C1c-NOSTRRB8YXt8v6R0YAbFPDQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203161028560.357@tvgsbejvaqbjf.bet>
References: <20220314080601.10504-1-gaurijove@gmail.com> <CANsrJQd0v2V9H8HPkiH2179C1c-NOSTRRB8YXt8v6R0YAbFPDQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xLOuhdCX8Kxv8592RvcTtB8iVjZ6b1ZPURoswftPogdHGH2wwNs
 g/+WFi0a+qvlw5WuvxihoL6I+dFst9n1p1tHGXBlNXbjVM7CWVvaRUOBWwwuDJZgryXZP6B
 DCn5sT3gy5z7fgQOnUyb7jhgVmwd8XJV7Bwe4/brzDctzyegmhve3zSZuj4zvF2lhMf30xC
 R0poq9nouMoSM/pZEQAjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fJ/FdNNA0e8=:13AeaFQ3zVpIcqjV3q1p9Q
 1RceY179oKK+3xaRR6Z9qBmcx/orkVIgXspSRxjhrwJVeZucnG/SoivENH8nBbiPoczdkruOr
 OBzBpHUSNeXTl+wTOUxLvglWbLVcaOxP6gGEAjUs5b88A2mcf57ggUwZ7LEb6QJPE/NQuy1Uk
 4pu5xlbGV8pyE2QN43oxLuSS+87zhMHC8/m+25SMtRCm6Q0pRoiS3SBb+BsB/3h3q6i9Np/ys
 Dv68znSaOI8Ca6AIrHBKJZHbwngHDmdEMDwMZYnwVRm1pMQNJkJNerlej72mV4bk7yUPnzQI3
 ZkwVrvZvPj2bDNX8EDgpd8/jSPsuD0hCcX+0YSSDAJ80HFBJ4wcCwHSACjQJKYE/69jCjjO2E
 aPgSbvx1Rhz1YFESgsUSuwGKysbAqouw/1XxP6JAPIV/mtIuTzd+qyHBoB6Tgj3C+Ru7Vyzz+
 8BAumLsmOVYT5cRYbUm1DykBGaN6dYrUmENUZ189veKx6aHpFp/6+GQ3EI2qo2R0atvWN7hzU
 ANGoj8vBNUUDpkreJ9C0gRI+gqmeAtWMtoQ1wnXhqPYREdjqzzMLHErAZbnalbzU1GH4YD1e1
 OOYhgntrTpiqZxoIjtndd+Gsag0m4LEMQxwykO9ZfOtRN0ckJ1/vrS3klN+yGf+BhZQXxaELF
 OemiX8res8Rtw5REBhwXBhEwiiJ1JCwnqHVyq9fjWrMnETDqQUw/pM+UXd9uSP7tM1ifSoj3M
 4nBels1Cf+JyEz48WllZHS/8Ev65mEmK0maB+KkingOPYJzmGnDT6IIGQRun7zG7SMt1nPTu6
 /uOpzbTfkoRW8ArgwZBYfNATA1J6X2yQj72Sh+T4UW6rtIZ62zHx4AP5oPmM72xotQj+swKKE
 mUiPajoW+hyqE77UDAw1sQc9/wWmT1FBl4fNYnLlGaZgOrxOQtssCKaeO2RP/62bZGDTVd+is
 wh9eUiDzZE/IFk/arNF9ywYL+I4efyLQfrxlDb5fzjMCsnYQ099Hs5oLk3xXVNT3vMcDQSUnk
 elOJSaTW88hs0M/idMZ80pkCj/bYUzgKV2WBnNbnNc3N+qWNszx4zObOeTqbVTZOv5qRKoaV7
 +MioHq/KG1DjtU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jayati,

On Mon, 14 Mar 2022, Jayati Shrivastava wrote:

> This patch addresses https://github.com/gitgitgadget/git/issues/1156 . I have
> left builtin/merge.c unmodified since in its case, the original list
> is needed separately
> from its reverse copy.

This information is quite useful. Can you please integrate it into the
commit message before sending the next iteration?

Thank you,
Dscho
