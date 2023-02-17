Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E78EC636D4
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 06:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBQGqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 01:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQGqa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 01:46:30 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6824BE94
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 22:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676616374; i=tboegi@web.de;
        bh=wnkVbvOnuZNgro2cZO5ZxmMGbVji8h0otTpml7Z2me4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=U34EwnLr6R2Di+EuleHZPERfpjH31FtlgfWwnL54FAMqEAaEyIRdu/tV/vCU6vedS
         joKXAJVwll9eUVJsGa4LzEufc8ZJhR2RO17U/YTQsg1OpebsJW25HtziVYyguwDNy7
         KFaOxwu9SiFbCm88OyBjbPrhDq4GIAWr2Cz1Pq1/ptFdsVJxJhlxisvHFK4kL6md7Y
         2Z6Dv2AfR/RSKDWMqjZwAbQvzZ0ZsHqr6WaYRE7qN3siWiJCbej1uPZ+hSzYOlMGsD
         amSDlYKraiImMepNIltQG97rcFhozyiC5mUG3qzNBRehLp2L6G4foCZ+g+fR5t/fO8
         QwENtOPeRULew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtwh-1pHbxv2HOb-00BWv8; Fri, 17
 Feb 2023 07:46:14 +0100
Date:   Fri, 17 Feb 2023 07:46:13 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] shorten_unambiguous_ref(): avoid sscanf()
Message-ID: <20230217064612.q56bqbrdfbqjzurs@tb-raspi4>
References: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
 <Y+z3RfhAxW/2iNYP@coredump.intra.peff.net>
 <20230216055641.brlx3os2ucj3ywer@tb-raspi4>
 <Y+5ohGA6NKNi6Di6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y+5ohGA6NKNi6Di6@coredump.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:31g+gzoPvwpgSSziusu4YJnx6/ICxXoPmJsq/zFjPTAtNcfGFRx
 C7fGYPPzy+myQS5vlc9D6LZ/HsfG3TuvzzIPTAjR3BUI53BQLoFrg7Cw+FXhcxDSB/NRqFq
 CvxN8ydfqtcrQx9uHM3MG6svk8kKE/Uc347m0hEBX2tPFEfBKUOGEHW8oS6Mw45zY9WUv1T
 XtDlHCpqgty6CUa8lcxtw==
UI-OutboundReport: notjunk:1;M01:P0:De8WWkIzBFc=;VYrF73OdCi7jMG2eyWau0LphtiT
 jsYhEEZe5TsL1+8S3PAGg8H3+tyzF7y3nEPEiwNSti7LIXe3FYq+RaPcXmcu+BJaAKXdPKS1i
 djkMh9iFz4+cLtTEJ9ibuV/DWrFZ7bV6KstL4zytawEKhnFI/TGyi21fYjlcdpOZsw+sJlDsr
 wH63HhvCGfef7lbA33CkQgjIpBOCXAlckRVnia4xo6QR7EOyXBzl/7ekl4Ib2PlLeHgT7qrSI
 h+KQ1GleJDnaGjgPT0jYmbLd5frJIv1SY0R34cIOadTVPSfD6mAZdSKNbz7JOqvKkVzeaLciY
 f586vTy3byDgTUnmbWXFZISWsZkM3SAiOznIEgS4lJX7/XLzoS26ABIYy6mk1rLNrTS7VDSEt
 k3p20/oqdGB9Vn7ABUA4pLseK4e/it4n18+cs+1UDak/ka0l5UILVwlMt8+GHjHoSpX+caomu
 HMNPJBMsUbYyFKyrsAsQQuOuY/SZ5a5jMPX5PTEJrO7b9BPhZzn7grXrDHO7sq2wGrrQg87Js
 LsFwSl7qVIgoQDi6Ujp9wVWH6/SEBkwsqd3UZVyKIzEcytBPxHt0Wny7Yl+ledfkmmhgmGY3l
 lXTeYu0axjRKDquXa0cZiKD0AYoywQuEVDTpOySoV+n7aXMv7i2PVkaSaXVo92pF6Kg7IQsLp
 dbHpUC67mJ4rzwjR7iFo0fvCP4NjZBrowHCuPKBR4SUjdFJZO5QsJUvRzYHLKM3Iy784bA+mx
 TUkNBGeWcxAeQM27RSZL25SduQKcgneWDMLogDwdhifHw9JcuO8D4Zl1hjNSUvIlc/YobTPYd
 aR54fuz66E7xcbqUKreOsEQyZRdF+sJ33cXuIX4Mz+lA1oUsp6VgpzlaPbB9g3Wln0XR/cTLs
 iwwVq98IKAvY8y9PHVu7jDFAvblZmj1yLtb7Qh77tI7QocqMK9dd8GZOx8MBXeuFCU4GRkK9I
 90DF4UALuqOB4bmZAQ+fvvzkFo4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 12:31:48PM -0500, Jeff King wrote:
> On Thu, Feb 16, 2023 at 06:56:41AM +0100, Torsten B=F6gershausen wrote:

[]
Thanks for the patience with my somewhat confusing emails-
I was to much confused by the fact that I couldn't reproduce the problem h=
ere.
In short: The bug is in good hands.
