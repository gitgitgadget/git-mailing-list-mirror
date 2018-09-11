Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55CB1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 07:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeIKM1Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 08:27:16 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:40107 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeIKM1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 08:27:16 -0400
Received: by mail-io0-f175.google.com with SMTP id l14-v6so2765237iob.7
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jrXVTvUh4doVqs8wWkvYvIkF/3RGtcz2u5/8+EubU1Y=;
        b=NyUcUtdImGd1cYQJ9BYXinYryvbZ5wb/NLaTiRsfEyJg9HkElhHz+75dA5LrGSl3zJ
         WnyoX5T4lnrDBciRxu9RxiDjibRAS2+uPTLzDTymiEY5qZKxDdTQ6cAiFWPmtpl0hFog
         uM+2HCOJI4JPoBLmLNqkqmLj2idRBmYJ8G8kc/ILc8WVLSl9yvoY0n2PQLaMiwwkErCR
         8DOcEg4FEPHtr8QU94vSUDXf6EKfI+xVorExZ7JNfQ9wgtFp1FPV9MWaexyFVWIzx6px
         QZoSEx3/S1lG3dDZegZEETpiF/j4sIIAk+5y7y8vRj0DiDF5185V1JTntOR6std8JJD+
         T6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jrXVTvUh4doVqs8wWkvYvIkF/3RGtcz2u5/8+EubU1Y=;
        b=jk2D+NRyvQNbLEAyER256mQoSLhhnPjjG0stlWwNRmQ+dUuWzy/6OvSGQYvo3IBWA/
         iaK5XCDgApS9eKvZya19GXcvut+Ove0h3MvTNr5vTyVAjh7fjU7oOt6xpLW2vf32K+1L
         LBMc98A7FuwBD1SLTrzm1iWktGHvsmLjexQroJ0SgDaw/vlwkUQNB0IVlteCHr4qg6tc
         pn9BDWcQvk/+yR2pRIw/DP2VWyZ2hVXpogN7qYjX/uHKYefcaQBRSIMGQbMPbmjmLrZ6
         iOntaRIvdXHo6n1E9s5lpS22dyvr1rKFzv17m3ik6dXi6AHB5kVGql7jIqMSNjCoTFpa
         OZXA==
X-Gm-Message-State: APzg51DOhoDR3UiYR52QVr6ilBjwN0sNRRz2dBzoNdK2EiCtD07Ynn6s
        fbXYnZMTvLClWeuT3NG3tlEPj59Kep0yadgcdv/Tt8jr
X-Google-Smtp-Source: ANB0VdaoMy48x403eRy8n/Rm1kyLbouzF661vRFf8COrcyQ/Jj7Spih5u22sUsjbmdlOXNF2oc4IHwdcBr47Rz8Sdms=
X-Received: by 2002:a6b:26ca:: with SMTP id m193-v6mr20997804iom.91.1536650957818;
 Tue, 11 Sep 2018 00:29:17 -0700 (PDT)
MIME-Version: 1.0
From:   Ciro Santilli <ciro.santilli@gmail.com>
Date:   Tue, 11 Sep 2018 08:29:06 +0100
Message-ID: <CAFXrp_fLwL5=K3B5rWjY+imoqtskT8LG-UH8ec3CPwM0iiSzFg@mail.gmail.com>
Subject: Is it possible to git clone --filter= without any objects?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At v2.19.0 I was trying to clone a fetch just a single directory:
https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository/52269934#52269934

I got really close with:

git clone --depth 1 --no-checkout --filter=blob:none \
  "file://$(pwd)/server_repo" local_repo
cd local_repo
git checkout master -- mydir/

The only missing thing is that uneeded tree objects are still being fetched.

If I had a:

git clone --filter=none

for example then that would be done.

Nothing major since those are small, but just looking for the perfect
command :-)
