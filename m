Return-Path: <SRS0=levB=AJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B5C433DF
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 06:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3BDD2076C
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 06:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="STwoBkha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgF1GXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Jun 2020 02:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgF1GXv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jun 2020 02:23:51 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE27C061794
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 23:23:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id e13so12617770qkg.5
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 23:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Zu9jGMruzB+vbm6TAG42hMSEiNUsp6dpmNr1V2UXC90=;
        b=STwoBkhapqq4xUR3Qv7AWX7e+02PYxG0G9Hx/8sYmlrKRDKUC+fAg/WFDYnw2eev1r
         FTajci+pCWpBwcPTOhKbDna1IFHo4XGspEIMU3VZzPHTNMQmFy2D7cEf8jYzDCHpFBun
         c5vNlulc8PkYU+9WBqsNCn6lvVTbvjZbrChJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=Zu9jGMruzB+vbm6TAG42hMSEiNUsp6dpmNr1V2UXC90=;
        b=X1SfIZx0lB+8Pl58HsfRbKr6S1KavjvwO8s1MLZ0m1QpENRXAay4v2woQuFevap//H
         cXjLHO3jOhYOIUXJg705O+xcuvTgsBSnnMiwghvPVUnaH8UkUtU6v0WDY5g2XzJSdfWc
         9uH0K6PM75Irwmcc8gnzowSvPWt6soUPj+m4ywe0N9Fp7Ro7VmyWLCsBVz9TvT91VZYM
         oQMmH/PDAVpsWyp9cvbnWyJWBy1knSX7rdRJ+bTp9G6ElXHG7wdhnQj0JaepN9lL08GM
         c6G9y9jq0mTN9TIg3Ai1iH7ezkxfg3c0GYvVVhyHcj258pueu/Kxlc1f6+irJMf+e22M
         lknw==
X-Gm-Message-State: AOAM530/pNyA3f/eaJVc5ee4jxj8pzXqXwXfbdMDRQnikXurnln0r6Ta
        PWGJfkITfyuyNDY6q3A/YUvhHD17V7odUFzg6b0mvZEhvFAPJ0mM37d3c/ifp9mTAjcWRNphpBc
        O9dJ8JzOSGmaKZkms1oIXK+u0882CFveY1fGmMRkYQEr2dHPbDwMEdrbAhw==
X-Google-Smtp-Source: ABdhPJw9ca7vG9z6sGoXu9idWQGOjNnLH+PLWEgc3vqM0XfeiXkZL4rbLVoSIZk33TprZAmFCoJfSQ==
X-Received: by 2002:a37:44d5:: with SMTP id r204mr10487035qka.113.1593325429645;
        Sat, 27 Jun 2020 23:23:49 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id g145sm12803201qke.17.2020.06.27.23.23.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 23:23:48 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Pratyush Yadav'" <me@yadavpratyush.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <311401d63e0e$b1ffe490$15ffadb0$@zoom.us>
In-Reply-To: <311401d63e0e$b1ffe490$15ffadb0$@zoom.us>
Subject: RE: [PATCH v2] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Sun, 28 Jun 2020 14:23:43 +0800
Message-ID: <0c2401d64d14$aeafa680$0c0ef380$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHphUzghMrol5AeU7CziB+seEvqZKjHHcLw
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

Could you help to review and merge this patch? Or do you know who can =
review and merge this patch please?

Regards
Lin
-----Original Message-----
From: lin.sun@zoom.us <lin.sun@zoom.us>=20
Sent: Tuesday, June 9, 2020 11:33
To: 'Pratyush Yadav' <me@yadavpratyush.com>; 'sunlin via GitGitGadget' =
<gitgitgadget@gmail.com>
Cc: git@vger.kernel.org; 'sunlin' <sunlin7@yahoo.com>
Subject: RE: [PATCH v2] Enable auto-merge for meld to follow the =
vim-diff beharior

Hi Pratyush,

Yes, you're totally right, it's my typo, and it's fixed by my last =
commit [PATCH v2].=20
I tried git merge-tool with meld and found there is "auto-merge" option =
for better experience.
The "auto-merge" was added since meld 1.7 (Year 2012).
Here're some documents for it.
https://meldmerge.org/features.html
https://lukas.zapletalovi.com/2012/09/three-way-git-merging-with-meld.htm=
l

Regards
Lin
-----Original Message-----
From: Pratyush Yadav <me@yadavpratyush.com>
Sent: Monday, June 8, 2020 17:50
To: sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org; sunlin <sunlin7@yahoo.com>; lin.sun =
<lin.sun@zoom.us>
Subject: Re: [PATCH] Enable auto-merge for meld to follow the vim-diff =
beharior

Hi Lin,

I'm not familiar with the code so I'll let someone else comment on that. =

But...

On 08/05/20 01:25AM, sunlin via GitGitGadget wrote:
> From: "lin.sun" <lin.sun@zoom.us>
>=20
> The mergetool "meld" does NOT merge the no-conflict changes, while the =

> mergetool "vimdiff" will merge the no-conflict parts and highlight the =

> conflict parts.
> This patch will make the mergetool "meld" similar to "vimdiff",=20
> auto-merge the no-conflict parts, highlight conflict parts.
>=20
> Signed-off-by: Lin Sun <sunlin7@yahoo.com>

... your name and email in "From:" and "Signed-off-by:" should be the =
same. So either use "lin.sun" <lin.sun@zoom.us> in both places or use =
Lin Sun <sunlin7@yahoo.com> in both.

--
Regards,
Pratyush Yadav


