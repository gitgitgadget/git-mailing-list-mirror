Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC42C433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 11:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348274AbiA1Ly7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 06:54:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:51229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348266AbiA1Ly6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 06:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643370894;
        bh=hRlMn3s5Gh+V7mmoefdYwCucu8Zq8B1R4v5ajtuqKdM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=G5o/S3HohBydFElLIA7ecQxZiviz+mIy7tVnDQ9r6Io7j+Tsvp1uvUTdnycq9RHzt
         VSJTXD4o9sTGa3xSlOae7tJ72wBDUnF/DVnVHSgjVFGs7WcEoeaJKNDuKhfIouVVFN
         AmP78jQdKM2xH4n744v6y6p9N1YzWrbEtzNI7Ol0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1me51S069w-00ZNe9; Fri, 28
 Jan 2022 12:54:54 +0100
Date:   Fri, 28 Jan 2022 12:54:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-filter: be more careful when looking for negative
 bits
In-Reply-To: <xmqqtudqnk7y.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201281253020.347@tvgsbejvaqbjf.bet>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com> <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com> <xmqq1r0vt0y7.fsf@gitster.g> <YfHRTrdwZVwxcPBK@nand.local> <xmqqtudqnk7y.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m+O2LyxQEHay59oFH7hmljB0pa4A7AK9G0xvwRfna+r/LiGNg+7
 xIShSS3i3qXFQsHS2GHfY931OY+WgZzNNe+GFjEMwdUN2BtcbzvYaL6XMz99yHnzGpL/0Ro
 sKxg/ILr2kpnDRWwSCMQwJJkz7fYVwBKuFWCUit1uN/KfCkE2Sz7tRdWCIvskYI34zv5c1U
 YFBamRvsZFVQDah8mRt2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZsTZw3lzyW8=:4Sad99gArv8eM9fKyAXUL+
 z5ySRBK75x4LpKMA0So12cnV+XzoP9cR+Tbr8U7wYK0UZPoIIIlMX1VKO6BuKS7etYIAeh5sb
 1P7ObfJglJMURffkYxIV5SE6Vv/645YnL/XiNy96CI/F1gpD5RgWBvfQxh2iXssZp0BvhBqo5
 pyAwhqsC8bapXnztSnuqSV/sdgCne+r+v/oSxrT2zulFM47HmUlyLV0AyxSjOorhik5mP/eLf
 p1G3PIvIgFYoCHXl6cZTSkuE5vQj9gzw8nAsebjK5E7tDGCs8/h+JLgzMAB3hu+4wBwXqI2d7
 Q5tDB1gJ4smcmkhQu85+CQ1EiswRcvPCGZvAE+/zxGZ8bM8Vn46Zr6WHexa+k7f8mvokpxkTj
 Ch9VRcjY+89c/Hj2+9deqmzawmA4O5ZIe742+prlZCRIpRRJKtemSSfT24N7tyGtLE2c+pmCh
 ZL19uCi3/W39npaUG4oxuAsbNDhhnZV0A5rhoz8ohHBgj8C41xFjXUgtO+9bTXVzy1XTZpInR
 COSs4jgfFCfp5wlk3MT2eOgbS5DOvEPfQXvMIZti6saTCAjesJ/X76dYNV7e6F1kkNRjwtm4W
 qMJFA88KWqZB6vUjazbAz4D1zoxkXe7KqBPvoTPbOKqiiHZsKFejC4Otck0of4n9S2ts7i4If
 5KVIakwD6gWbOe06Xt7en5yHPnK+Y7cJwPci+TZAiuYTxpv2ITcB7XB16SzMe23+iqL3CG6Ui
 ah7lmJXmRS4XKMPePP/FWTXSbuYw7c041qFZyN//i4yLqQZ7ZSbWTvVOnu4CjeMdPcg3mE18B
 59INr+++8JiG7pqyNGTC+fEnfcuN/ume2BnPDZaGRkuQhNje8DoPWtIJ5yQYQb6sRjAqg+7Ky
 8lQ14h/WfxqO86zFU8Fs3RCIPMhM3vYtbAqVRQMyOEOieSE/RETxQp1tqchk3BZkXp/QtgIFT
 t/ssQJzxou5mCu6HHhMSfDIcFTqiTXIH/MKRJXvX9t1cRjd10iGbFia5BixIl97px9qb6pARD
 scDsJmYZHHCR7EJgw74tW8dn+N2v+o+z3lhGI6pj9PIl4lmKJqLmUbEBGVgESIkH2d7kOWG7Y
 pGHe+CKElZdHXM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Jan 2022, Junio C Hamano wrote:

> [...] this loop should disappear when the code is properly rewritten to
> correct the interaction between two or more "--diff-filter=" options, so
> it would not matter too much.

And so it did. Thank you for the suggestion. At first I thought that it
would require too extensive a code change, but was pleasantly surprised
when I figured out that the final step can be done as part of
`diff_setup_done()`, with a quite pleasant-to-read patch, if I may say so.

Ciao,
Dscho
