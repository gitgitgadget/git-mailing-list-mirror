Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B041F45F
	for <e@80x24.org>; Tue,  7 May 2019 21:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEGV5u (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 17:57:50 -0400
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:46356 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbfEGV5u (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 May 2019 17:57:50 -0400
Received: from resomta-po-13v.sys.comcast.net ([96.114.154.237])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id NxMThiArm3hFEO85thpA3V; Tue, 07 May 2019 21:57:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1557266269;
        bh=ULVjAXQvhfUuvaxEBO9xJH4Mw83xr2l070sUEOJ6/vw=;
        h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
         Message-Id:To;
        b=02g83iL/Bh/aaOcpFK6RxoU1+V2OR0jUnxNi4wX0hIR03/g2dtusDF1dEnnnnbqGh
         uRU4pP0FVNpNzjzePk4Z8kEE4mHNjB5ri1BGRwcyN9W39xZrjRSuCLrnIVyeQfJZMz
         NlPDF120Go3/F3Ymyg5XAMsi/A2pPAH2PU6cbwTIrywC45TG+OSU9D/GtUjCnvG4El
         26QEHUp+DszlAyDwIy94OxIduOH/z5McypQ+imqZHcmz198A9TsJfa4W/d88HvUUvr
         9wZYLa/AFo7gjF3QMoRmel2JEnLZSWeTz9A8f+fzie6jdM7zaAhZmynKzA3TCxzBQE
         LsPKtkUq+QR0w==
Received: from [IPv6:2620::100e:913:7070:2ecd:151f:60ea] ([IPv6:2620:0:100e:913:7070:2ecd:151f:60ea])
        by resomta-po-13v.sys.comcast.net with ESMTPA
        id O85ch4P6nM7ICO85hhxbOF; Tue, 07 May 2019 21:57:47 +0000
X-Xfinity-VMeta: sc=0;st=legit
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Proposal: object negotiation for partial clones
From:   Matthew DeVore <matvore@comcast.net>
In-Reply-To: <20190507183450.50568-1-jonathantanmy@google.com>
Date:   Tue, 7 May 2019 14:57:32 -0700
Cc:     matvore@google.com, git@vger.kernel.org, jrn@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0ADEE11-E3E1-4DE0-81BA-40771C783E4E@comcast.net>
References: <CAMfpvh+jbPcU2waU5n6nToxGEsC29WGOFPLR+ibXbhXL6WBb6w@mail.gmail.com>
 <20190507183450.50568-1-jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 2019/05/07, at 11:34, Jonathan Tan <jonathantanmy@google.com> =
wrote:
>=20
> To get an enumeration of available objects, don't you need to use only
> "blob:none"? Combining filters (once that's implemented) will get all
> objects only up to a certain depth.
>=20
> Combining "tree:<n>" and "blob:none" would allow us to reduce the =
number
> of trees transmitted, but I would imagine that the savings would be
> significant only for very large repositories. Do you have a specific =
use
> case in mind that isn't solved by "blob:none"?

I am interested in supporting large repositories. The savings seem to be =
larger than one may expect. I tried the following command on two huge =
repos to find out how much it costs to fetch =E2=80=9Cblob:none=E2=80=9D =
for a single commit:

$ git rev-list --objects --filter=3Dblob:none HEAD: | xargs -n 2 bash -c =
'git cat-file -s $1' | awk '{ total +=3D $1; print total }'

Note the =E2=80=9C:=E2=80=9D after HEAD - this limits it to the current =
commit.

And the results were:
 - Linux: 2 684 054 bytes
 - Chromium: > 16 139 570 bytes (then I got tired of waiting for it to =
finish)

