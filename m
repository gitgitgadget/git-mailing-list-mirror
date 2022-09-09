Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E542ECAAD5
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 01:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIIBIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 21:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIIBIf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 21:08:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444CB0B01
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 18:08:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q21so236851lfo.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 18:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IVZUikOK8kB7wRrPG2CEx0klt6JwEfBaO0E3ncJS6U8=;
        b=rOf7gEzb9Fk9T3vGR1Tr19ZGkcUvd8W5pOUzzcE8CIZYLSNJajmulw7sOyZM12ZP+u
         I9fQKDwJ826ShYnxekl8RS8iU7OWniWB8nr28mhdFbOOzOWOZkjYnC/x/alUKyMl4CAj
         Dz4qM8ozb2zvj673URQtzhGJ5eDxFnCl4GDEXK8DxTSLnmFb4eMli/Rt23pCktHFncTZ
         q5oGty7GSlbaADSbCD5AQNg4cNFcjjKLMGT8HBv+iFub4TeQVjOjLn+C7gspp9rLa0eq
         z5dvBDFq2+295UvNq/MkpKx+nVx7k9q8V2pbVuwgcD075BLEnfev5B6zAcDbRor5cSbW
         i2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IVZUikOK8kB7wRrPG2CEx0klt6JwEfBaO0E3ncJS6U8=;
        b=fYt7jDOyCiGaYMGVlhcNiVw0Kgd28dcYZirgnO3omavwdNOfoK9bEq6IW61oo9LmbQ
         lcnTLQfGdodxF6yG6sEgFnahaINomJxn+DYM0QD2Fy+G+a03LVFs/+Mc5I0D5Qb1B0Gz
         YrSBmNztOhTMVR3b3tAUIOBl0mVHKSIOT6PHQuvEPXQ9TXX4ftnfApOjb4WgcVDA4SbK
         VT1vulIuul/gUQ0fRRKgQ8UsNPgr21brxibE9EhjaWyeYBm8gkmDYBuFO8sq4YhA/Kch
         c19o7avo88vqCi95KAOvixDFLKpLo5ziDwV7cl7k1OomfkVF3KO2R3dGgMyRdsga2ZDe
         6xgQ==
X-Gm-Message-State: ACgBeo3G16A5CTxupu/0AEqV8jdTC1u9eCChuFCzqU6xm1aCFYaId3SC
        dG5Bc6r0TvP6QjxoUrEx374UiTCIsGX/UUZndkcbHx9gmigUhQ==
X-Google-Smtp-Source: AA6agR4gtYTd86pcxIJ3Jl9I3vsG9BudCDcvIZZNW3kDlWz6ccihIrj5ERDL7gro3dpZ/QDg5EDaV3kiNapsJrHqbWo=
X-Received: by 2002:a05:6512:3409:b0:48a:ef20:ddb with SMTP id
 i9-20020a056512340900b0048aef200ddbmr3914043lfr.597.1662685710265; Thu, 08
 Sep 2022 18:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662559356.git.matheus.bernardino@usp.br>
 <a2c4514aa03657f3b1d822efe3dd630713287ee6.1662559356.git.matheus.bernardino@usp.br>
 <4d750ff2-9df5-504f-9972-59b082000db0@gmail.com> <xmqqa67buj4m.fsf@gitster.g>
In-Reply-To: <xmqqa67buj4m.fsf@gitster.g>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Thu, 8 Sep 2022 22:08:19 -0300
Message-ID: <CAHd-oW4Z-UbFWy=fj=L-CqiG9QP0x3ZLRg0icgK5Xgu=THd4Lw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] format-patch: warn if commit msg contains a patch delimiter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2022 at 3:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Hi Matheus
> >
> > Thanks for working on this, having a warning for this is a useful
> > addition. If the user embeds a diff in their commit message then they
> > will receive three warnings
> >
> > warning: commit message has a patch delimiter: 'diff --git a/file b/file'
> > warning: commit message has a patch delimiter: '--- file'
> > warning: git am might fail to apply this patch. Consider indenting the
> > offending lines.
> >
> > I guess it's helpful to show all the lines that are considered
> > delimiters but it gets quite noisy.

Hmm, right :/ Perhaps we could avoid repeating the warning message:

warning: commit message has a patch delimiter(s):
diff --git a/file b/file
--- file
....
warning: git am might fail to apply this patch.

> True.  I wonder if automatically indenting these lines is an option ;-)

Makes sense. Perhaps under a config option? The difficult part would
be for the scissors; just indenting it with whitespaces wouldn't
suffice, right?
