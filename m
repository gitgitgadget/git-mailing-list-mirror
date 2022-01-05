Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1CFC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbiAEQlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241974AbiAEQlB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:41:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D405C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 08:41:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso3639616wmf.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 08:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OvOlo0G6nzyt1FB+oPmZEwGd/0YuvJlwBrqtQkwyDTg=;
        b=OfEFf3q+o4OfyQVEg8leyruzmLijyuQdl7RJtBFRgERPYaJnfDJjDdFSYxRaeol1px
         sA4/SXF6oszaabiPTSBM5a9dMLRPCTlpFSrxiA4PfMMUe8oBegsf9pKG9zs/AlWGfCMM
         7fZlg/ZfJBgkOJjcF/giM2mr8odBPKlO3TCz9IXM0KTlRsQ7zdFfNo+NgWGFDemYbUFc
         B1UF8DQ5rBit/fxbe0BDqGEUuX5+76GzepMwBhkAJw/SSoKHPv2ujuOckn0UNQ8ImXXD
         RL/w5lFzQczU/iCzcl8uWHtqAdiKu8KsJvXa7CUM4sU1BsYW2xbss60PMoFKs+1FJJX+
         ZLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OvOlo0G6nzyt1FB+oPmZEwGd/0YuvJlwBrqtQkwyDTg=;
        b=MpWPW2bqfpw58BHf25g27VetfxkewktGrNXif99L8dsemSMwtVEuU2TeIMl7mPgP9M
         reNBFAOYqUp5906j/bpkPMTULPhaVGB0T4ftX3+7qSyhR1pBLBcq6bXwX1vEpETjkRjh
         JAYuTZb9yEr5yjBP3qZ2B2sDVRPvQYE1htIDPmnem9YqSqCfiuQ0Nx7lLsVIPVI7VXVJ
         uzEnXHig2HU2yubV6+CKLsTczMZ4xsUV1JaltS0e9zJ8XG0n/wEQ5g8q/b0VWAvihV4d
         csRP4Tzh9uhh0ren90qa3RHmLkiULMfGb8Fr0HqhpJPZB0/sQkotEa7+F58zKt8wfizg
         4O+w==
X-Gm-Message-State: AOAM533kd6LYQN+uRMcpO+QLe1S+bOCysdvo8r+0J0EpGbdlPj54kq0I
        +xzLb5EcS5uAvbJQvs1b/J8qPlCHva28qA==
X-Google-Smtp-Source: ABdhPJwyKJNfwOf7z3kqL95/e9vSNrfUV0pLLeewiJmTI9PmMkrGthfbiVmtwArqh2Vc6AO5RrKmaQ==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr3576549wmq.166.1641400859863;
        Wed, 05 Jan 2022 08:40:59 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id q14sm40615006wro.58.2022.01.05.08.40.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 08:40:59 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for CHERI/Arm's
 Morello
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20220105163935.eqfdqbeifcgj2wna@carbon>
Date:   Wed, 5 Jan 2022 16:40:59 +0000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <85A71121-BD74-416B-BDC5-3818C6892F7C@jrtc27.com>
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
 <20220105163935.eqfdqbeifcgj2wna@carbon>
To:     Konstantin Khomoutov <kostix@bswap.ru>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 Jan 2022, at 16:39, Konstantin Khomoutov <kostix@bswap.ru> wrote:
>=20
> On Wed, Jan 05, 2022 at 01:23:10PM +0000, Jessica Clarke wrote:
>=20
> [...]
>> This means that, currently, the code when run on a CHERI architecture
>> will preserve the metadata from the integer, i.e. an invalid =
capability
>> that will trap on deference, and not the pointer.
>=20
> ^ You have probably meant to use "dereference" here.

Indeed I did; spellcheck doesn=E2=80=99t help for wrong words...

Should I send a v2, or can that be fixed on git-am?

Jess

