Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48942C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 16:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349945AbiA1QJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:09:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:53643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349944AbiA1QJc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 11:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643386167;
        bh=6biWlXg/g9ttERQq2d6KT9u7MUIpT2kGCNypgDFawBY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TKo74AA+dgR7APzFdRRDaQhYKDadTaqkzbsnw+DjuadpVoT4vOCQ7C0hnp0XAZMMF
         5NGNWg4TxD69b0m92lkEk+usNfB6cjdKAnMNq59arnd2ivJKraUX5i8B7izxBS+ytr
         x3GzFOrOWM7pIanA2fODneoYlyh3TlWMYjCfQfCQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1mTij02Jth-00p17K; Fri, 28
 Jan 2022 17:09:27 +0100
Date:   Fri, 28 Jan 2022 17:09:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/12] merge-ort: split out a separate display_update_messages()
 function
In-Reply-To: <095aa266c2bfdda47ed722fbc5a0d9c94132fbf1.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281707250.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <095aa266c2bfdda47ed722fbc5a0d9c94132fbf1.1642888562.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Pyqm8hew/rr40GCMF3HMmlABmzUhiJsAOJvIgYMlonH8mi7v6uU
 GkeDaeolDGs5hZBacqfFQfqNiooQ03BcrrTGjqI4IxdgnNRAf/OYAKO4B/8tqc8Z6hhLtoh
 d17eKOx6CFrD1ziU4hBO6s+JMPPD9AQJcA8ctGwV7ZxtKcq8yfykZ6Pb4BUF9emiUtwS6V5
 7uyMn+xyLwVLesF6bggdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7Pf6KvngCk=:twH7DRDGKimM1nsJK1WVcm
 qyIpudh2oDNwvpph1mb0YljxnQiquS5hRwEQxozkkE4XqQp4dZHj15+hSDBH133oPaIspfB+r
 5uU9/LZ5vmJO5AeED6u2u/2qvGQLWJ3Nd+6x/1YD+VZ/TjqroYztZh2Moy/oyUegM6pDRcsbu
 Oq09WH5sh6tGCep11TeOUhqHxVuQVTAcERYSJOrRVoAnCJMCbnvSDbAe+a2nnoVzXX2UwzC73
 HrERj9miHmC+d9LYuSSLGesi0aEtzmFgHXFuoZ7lfvydBLnk4dIdI1OSc1oBPhoo61MKWO4OD
 PkB8GplxQpExoVqc1cdVpNEPpyQ5AxeBkMtWzyGuQVAQDjhKa03+cpuUu/hcwGGT38fJuD/me
 MV7D4jszwSPDxANUdwoUYUcoEfCZuMAzlF66PEQfMgT+wzFcvlT8Zwc3xqJo+FOuTDJFyzAtT
 uMXZ8Y53UBLEdVdrVpVeaBU0QvhA/tc7OWPck8qjAv0x0cB3+ILAVxvIYKmvmbEs042bkkWQb
 ITIYi5paoWBFpbW3gTCom7JoyCTG4nXW3lAuwfgQNHQnBKDIuQdpsoA3gQTaEysAnbvVQVNy6
 teexisOvcp7loEUeCIzm9GZkuSGgpAr2Xwt3JTBtrN/IxuTL4fkpv7vbZj59Dugfml17XMjBQ
 A+4YK4gdVtFgOPDcXkKfKV9cOfeRPtVkeQD3h/Pd5omwn/j/JPrwjF72QqQVKnCTVmRS4bYrQ
 aMEvkR+WQXXAi8l6s/QzRiWI3yc83GUXMSuS7ku/1154zeQvuxUY+KuDgZQrYgi+CmiR/BQmY
 z8BEv2kFgzYRgu+IKanos7SlJLXzTjHpl0PXZDbXX+O1GeErnCrG2U43M9BH0vWvKOEKzR4Hr
 qb4zJjrl3PdIb5Y+PM1cSxxk/uZ67OdE0a2iD2BCJrnQJiR8DENLGH7teINhb/IpFKzX+/UGG
 ZMFYemncZk22LEY+ZoV82qEwE1ZeVyy1NXiaeVgCyJQF4sZSdYfsZOp3RyWX3864BC/Y4yEDM
 IgxNtlxvyBZ01oMFUcQtpvvjR1rinFqBZXlFf2aqORxSmirIMCrMkMTPJajqYiRjdtGnG6iFl
 kbvp8IB/CWHzYQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> No functional changes included in this patch; it's just a preparatory
> step to allow the printed messages to be handled differently by other
> callers, such as in `git merge-tree --write-tree`.

Looks good. FWIW I cheated and looked at the output of

	git show pr-1122/newren/in-core-merge-tree-v1~7 \
		--color-moved \
		--color-moved-ws=3Dallow-indentation-change

(after fetching the tag from https://github.com/gitgitgadget/git) instead
of this patch (which is a lot easier to digest for me, because of the
color-coding, and since GitGitGadget sent the patch, I know that it is
identical to the commit).

Ciao,
Dscho
