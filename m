Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001C1C77B6C
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 15:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDHPnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDHPnm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 11:43:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CAFC140
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 08:43:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y4so1265969ljq.9
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680968619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uMIzDCmrNmvWFuJbWCabvqKSLuhbbfDD5QlmGKTkq5Y=;
        b=m9GiW5MI4zGkLaFXiCYkPbUyqC8pm7kqjNy/7+xoJRBtkby39cH5W0pNr7oMZqMp/R
         uS7alRABjy+v0hzQpkYUNZcTLnV8cEm6dgPavyHXl+W2jat5Mmpqe9JSGaLZMeUN04RJ
         ahF0743ZaqEjkw38Kw+18tTeugEi3EKXj4YL6tqiqewWPTsH0Ct/GyKNc58+yKvY1Dlr
         n6zOxgWUvBZGDzmwP0LUHUWvVGanVI0FrdsZfWACrF02IPRrhnzBwqumkY98DMNL0Hp0
         etLGMfy4abeVhCpiK2JW/HRTN5CXwbsHUrnqDlOmE3kBDZOD7uBoAUXiI2Zws0inG2vm
         l71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680968619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMIzDCmrNmvWFuJbWCabvqKSLuhbbfDD5QlmGKTkq5Y=;
        b=QrgyXPCbysxzBzI4sfHsletTElQSjDP7k8ulJi5kYMTGlUUx0mLBCS5fmIxoY1VNox
         OcyI3b5OIGufpiAABJ7VIqprW37kQ/oojbA85Eee0jlldc1s7GSrXhGh2ehjRNBD2YfK
         OjMPnyKs05iIIMS9wmXYqnPdPNv51v0jtscNFxLQlB7w04gBw6LUwh/3JkXNXDb77qpD
         go7HrKBUki8CP8LvDJ5uJc3aBdlbwovhMaiLcqmf2iEtisoDgb37swsJXsReujp/bLPN
         QSyTTQbdrQd3iu9yMDprTBiH+VgeO9bEKQXqE4NOcR6XCiYTsvb4dncGQkjvT8Of7xqP
         gKpA==
X-Gm-Message-State: AAQBX9dnFv/JTN4Gi/WpyQ5Vy88bc+ZnQHZ2BGXFIcC3itxalGONXjQr
        e8ruBcIdmL5BZEI/ERMLSVhHOueL3WorN8tq6pi+oDEa
X-Google-Smtp-Source: AKy350b44A7leRizBF5f7Ns7kaiO11jOMSMlfVQD1qAF7hRXRp8IihiQUcnm3jySeavg1kILh9qhHyB9I/nGRotKYak=
X-Received: by 2002:a05:651c:1035:b0:2a5:f6f2:1ff4 with SMTP id
 w21-20020a05651c103500b002a5f6f21ff4mr1440058ljm.10.1680968619291; Sat, 08
 Apr 2023 08:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <GVXPR10MB8199D186532A7A285CCF1538B9939@GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GVXPR10MB8199D186532A7A285CCF1538B9939@GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Sat, 8 Apr 2023 10:43:27 -0500
Message-ID: <CANaDLWJ4XSFUULc4PGen_trsyJ1_K1qoufisoxgpjCfMhoDjKQ@mail.gmail.com>
Subject: Re: Negative patterns in cone mode
To:     "Brown, Chris" <chris.c.brown@siemens.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> I'm facing an issue with negative patterns in cone mode.
> I can't tell from the docs or git code if I misunderstand the
> usage, am trying something not supported, or if there is a
> bug.

My understanding so far, and I would appreciate if someone can
correct me if I'm wrong, is that the point of cone mode is that there
can't be negative patterns, and everything is a positive rule, so
the match search can stop as soon as a positive rule is found.

My understanding has been that it was designed with the use
case in mind of large mono-repos made of several independent
applications, of which a given developer only needs a few. For
instance, if I am an iOS developer, I will configure my sparse
checkout to have the back-end code and the iOS code, but not
the front-end code and the Android code.

I don't know if that's accurate because I'm not as well-versed
about it as I should be, so I would appreciate if someone could
correct my understanding. It is the chief reason we are
sticking with non-cone mode with our massive monolith at
Salesforce: it is not a mono-repo of independent applications,
but one massive monolith of which only a few (very large) files
are not needed for all devs.

Thanks in advance for anyone who may have insights.
