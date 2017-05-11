Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7CAD201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756646AbdEKWFC (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:05:02 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34822 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756641AbdEKWE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:04:59 -0400
Received: by mail-qk0-f174.google.com with SMTP id a72so34407260qkj.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accedian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WkeRkWrXNyYP2s7lnK2z4yuaKqtStVKI8masSFYW02k=;
        b=pBo05MkDxu0HwcuOGGxCJtmn/UDtf+b/sA0FXHRT5644bn5wL8enqC69K0fZfE1GHy
         F4Lk8vjnd7qC15UCtrSIYZBZBdeCloZsloC1tIM0MaAk69wp8MqX226wPk5ZPUic1dVU
         XCmJKKunTBED2YinYOOamwRkXcO4ARvQUSmFYuurxrbjqiPYBRkCUVOfr6z2RJcJd5Lx
         xM+Q8+VMMSBv5HMB+Y+v1iwQOZXkfSPhF/rRPjFPa7K4y8h7hiW4S2yNjQccm/SwBO2e
         nEr846Wr9p3agWTV36srOsab56lNaS9DfSjXtpghAN/WSA7Yo3PPJxk6JJUM3GvcuwyT
         6Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WkeRkWrXNyYP2s7lnK2z4yuaKqtStVKI8masSFYW02k=;
        b=gRV5jlpfW/l1/AO6bsUALSZuFYrthL6tzYCRTMkNddcJyscbNL/VU/AX2QK60Yuq3F
         m0wkbX6N7VV53+wMRVsd6T36IXMEqYitTVo1ivGSmHvMm8Em+kcZuX4LgvsoggRpIZfS
         sMLkPKRXhl7KgFvQoAFJAVWbFi5Yzomc4fQdZoY/rHIvICYZnHslrWyS3C+cae+J8ndU
         Poe5xnhpLX7RuHS2a5cR9hBSj0xUgq7VHVqH/7Fph5nYOQZ0/NCATdMT11JQXO2V3PFF
         +WHw1QimTcTzfQyIZWa2y8oQ5p2hprUCzuzGRv6moW/3Bx/MTDHiSqX4D5PE7BLzwPdm
         tAdw==
X-Gm-Message-State: AODbwcBGnd2EE348/GGRh55wPoiDhPHrkg1bmxgAhkZXQtgg1xrKkgGB
        3annwD8EWEzNT3RerZMyWB2XoXiqSOrl5/zp8kB+2fvSLTPoC6eB6Xd+kYXShQtk6aRLcgFB47D
        9IEz0dhpXnOz9QQ==
X-Received: by 10.55.93.133 with SMTP id r127mr799473qkb.98.1494540298818;
 Thu, 11 May 2017 15:04:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.38.107 with HTTP; Thu, 11 May 2017 15:04:58 -0700 (PDT)
From:   Jean-Francois Bouchard <jfbouchard@accedian.com>
Date:   Thu, 11 May 2017 18:04:58 -0400
Message-ID: <CAPYmS36e40gb6_2updPKvzo8EJj7+f5npZy9nPDkz1ou8a80_g@mail.gmail.com>
Subject: clone vs submodule operation with HTTP cURL
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

In our usage of GSSAPI via HTTPS, all our operation with git are very
well handle, however, when trying to update a submodule, git seems to
be managing cURL differently. cURL drop the ball quickly.

Example (No other setup needed on the client) :
git clone HTTPrepo -> GET -> 401 -> GET -> 401 -> GET (this time with
Authorization: Negotiate)  -> 200 OK

git submodule update -> GET -> 401 -> git prompt for username

Is the codepath for clone regarding cURL is different than with submodule ?

Using : 2.13.0, I have also tried the emptyAuth stuff with no avail.

Thanks,
JF

--=20


Avis de confidentialit=C3=A9

Les informations contenues dans le pr=C3=A9sent message et dans toute pi=C3=
=A8ce qui=20
lui est jointe sont confidentielles et peuvent =C3=AAtre prot=C3=A9g=C3=A9e=
s par le secret=20
professionnel. Ces informations sont =C3=A0 l=E2=80=99usage exclusif de son=
 ou de ses=20
destinataires. Si vous recevez ce message par erreur, veuillez s=E2=80=99il=
 vous=20
plait communiquer imm=C3=A9diatement avec l=E2=80=99exp=C3=A9diteur et en d=
=C3=A9truire tout=20
exemplaire. De plus, il vous est strictement interdit de le divulguer, de=
=20
le distribuer ou de le reproduire sans l=E2=80=99autorisation de l=E2=80=99=
exp=C3=A9diteur.=20
Merci.

Confidentiality notice

This e-mail message and any attachment hereto contain confidential=20
information which may be privileged and which is intended for the exclusive=
=20
use of its addressee(s). If you receive this message in error, please=20
inform sender immediately and destroy any copy thereof. Furthermore, any=20
disclosure, distribution or copying of this message and/or any attachment=
=20
hereto without the consent of the sender is strictly prohibited. Thank you.
