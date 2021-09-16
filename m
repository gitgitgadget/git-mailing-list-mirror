Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C70FC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4C26120D
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhIPVay (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhIPVay (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:30:54 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDFCC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 14:29:33 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id m4so8061777ilj.9
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=I85Z9Q0tTCC3a5uqDOsVOdviZPmVDf2+B+6TFjyhxJE=;
        b=2gioejJfx48unGmY8oSotBOQ1TAUpxTclX5Ol9DmD8bO6VL26jlVngzQVqTwL+Oolx
         N2iQAfJSAyMyZOyoG9bcObIeVx3TOnBv5/3ORVvIOlXLMfX+7d87x1ABlj0n/7XXPL62
         rnaGpiVKULDlc3yj5tUK9ndWSeZszjwt4XBEgGrL4QDXZYHnlq7T1OtqDeXVySkwDSq4
         YNq+Pl7a7326CXa0Gb7ox/njQ/5d8nO993/mn3BwvKJTnZwYZG3u7TF/EvjYxpid4zRz
         laOPYMmSE3tvHToFc6dUECDt6YWNtoANrlCjK05xDK7lWMpabY1ixbiRNQASaeVHtAns
         wf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I85Z9Q0tTCC3a5uqDOsVOdviZPmVDf2+B+6TFjyhxJE=;
        b=rOrD9k8LW2Jc338y7j7wTKmqlIljCKSEA+rPy1y8Uw926ZkTDvjAqkMOtacO3Mx05r
         kagyrsG332sTKFNaONvfc6l3Mt3B38vbiYl0elzGNr7imQGaOPs9gFy8BZ6xxc9rVUza
         EfV9QZ9tLNgQ4kJuk1oi86oW+6BQMXd0WraPpR9bATaRqJ4p+jmc5gJhJQE9wHkx2m+I
         QXD6CUiQsfN2JTBLa2WGVYtGIvGe1PK58VZFbAJs5OEe1gEQIhhLIGBDzwdaNTMBJjvF
         FRq8Df78X46BQ26hIcuv3aqxV7cXlMqiPiTal1duHslMywaablftoNxTrODFUNAGN25a
         Ngkw==
X-Gm-Message-State: AOAM533ZA65IaL3iLDPwd6uxx4oUElxF0BvbLKgSJyP/qx/x427HkFUa
        1rcQBxJDwIBfEMN1FadPNTCLTQ==
X-Google-Smtp-Source: ABdhPJyE9SJ0bYFmK/jr4V+dneGb2xrrRVa2T91mLgwHprlx2zz1Cy+AhIQpW7Xxi87FLw9qM30YEQ==
X-Received: by 2002:a92:c9c9:: with SMTP id k9mr5411308ilq.82.1631827772633;
        Thu, 16 Sep 2021 14:29:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e22sm2211354iob.52.2021.09.16.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:29:32 -0700 (PDT)
Date:   Thu, 16 Sep 2021 17:29:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 08/22] object-file.c: don't set "typep" when returning
 non-zero
Message-ID: <YUO3OjbnpqwEWeDv@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-08.22-38e4266772d-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-08.22-38e4266772d-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:03PM +0200, Ævar Arnfjörð Bjarmason wrote:
> When the loose_object_info() function returns an error stop faking up
> the "oi->typep" to OBJ_BAD. Let the return value of the function
> itself suffice. This code cleanup simplifies subsequent changes.

The obvious danger (which you mention) is that somebody is relying on
what typep points to, and is reading it even if we returned non-zero
from whatever called this function.

Hopefully nobody is, but this change makes me a little uncomfortable
nonetheless, since there are so many potential callers (even though this
function has only one caller, it doesn't take long before the number of
indirect callers explodes).

So it would be nice if we could do without it, but you claim that it
simplifies changes that happen later on. So let's continue to see if we
really do need it...

Thanks,
Taylor
