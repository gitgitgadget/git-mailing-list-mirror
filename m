Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D099F1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 20:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965074AbeFYUPm convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 25 Jun 2018 16:15:42 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:46159 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965061AbeFYUPh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 16:15:37 -0400
Received: by mail-yb0-f195.google.com with SMTP id s14-v6so5671881ybp.13
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 13:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ad6L94G1RH5duhOM5HLX1a1x/Iozy8DRND5Jd2dh4L4=;
        b=HZFBw2RtMYZUD6E67vQ20j4UVhkibaPfxseGfWecKK3PCVrkh4WtIrFJ1Tlwjh/Wup
         xS2h3BNXgrXW56g5g38XYFMM9/0rXi3H0qMQGsPVwOF52/9ymuuJIpKDbcepYfCTuvnm
         aP58kANW2zCmaoKe22pgzKwnzygD4BfE3v+CST6RNbZBw/757PX2K59mR/Yz1V1dP63i
         kWaPEaK1/hOIXj0CvvxIGFsUDywgRMLPhP3KT0T30wiOf7/d3stYgWCGFhpBBUexqxcZ
         DcRR/sMsWMBgWgtbk8VubKUh1grAaGMl2r9EU1nnCSh3cNy3hG9urlQxhFAqVrTM5YDu
         Malw==
X-Gm-Message-State: APt69E2wWi4U65X37zIkMwovbY5/R8DIe8sUkJSFzn/u6CekJkM/KVIc
        u76jPKF1nJwh3DKbsi9BFALw9O9q6S0pbAYHx1Y=
X-Google-Smtp-Source: ADUXVKKViCRdoQtfM5WcqYQJ7hZtNgMvbpXHRPj+Ep60XFl6sA4cz6F8pfuz+RzhY2GWFxwmipH7hLEIYG0sA2UbOds=
X-Received: by 2002:a25:c0c1:: with SMTP id c184-v6mr1705754ybf.76.1529957736850;
 Mon, 25 Jun 2018 13:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <1529954005-18189-1-git-send-email-asedeno@mit.edu>
In-Reply-To: <1529954005-18189-1-git-send-email-asedeno@mit.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Jun 2018 16:15:25 -0400
Message-ID: <CAPig+cQxAxFUFE8j2O7iaZoAby9ioNd6Wf1OVAr5qU7kTrQOyQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: tweak sed invocation
To:     =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc:     Git List <git@vger.kernel.org>, Dan Jacques <dnj@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 3:18 PM Alejandro R. Sedeño <asedeno@mit.edu> wrote:
> With GNU sed, the r command doesn't care if a space separates it and
> the filename it reads from.
>
> With SunOS sed, the space is required.

MacOS and the various BSD's ship with BSD 'sed', not GNU 'sed', so it
seemed prudent to check this change against them as well, which I did,
and can report that it does not cause any regression on those
platforms.

Therefore, the patch looks good. Thanks.

> Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
> ---
> diff --git a/Makefile b/Makefile
> @@ -2109,7 +2109,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
>         $(QUIET_GEN)$(RM) $@ $@+ && \
>         sed -e '1{' \
>             -e '        s|#!.*perl|#!$(PERL_PATH_SQ)|' \
> -           -e '        rGIT-PERL-HEADER' \
> +           -e '        r GIT-PERL-HEADER' \
>             -e '        G' \
>             -e '}' \
>             -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
