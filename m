Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55D51F404
	for <e@80x24.org>; Thu, 25 Jan 2018 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbeAYViW (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 16:38:22 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:44435 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeAYViV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 16:38:21 -0500
Received: by mail-qt0-f172.google.com with SMTP id l20so22978050qtj.11
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 13:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AfljZ6XBReCmkxYB1UIKdkw1n3jfpfv931Z28GFHzc4=;
        b=BwgpOZbMPZQt1OWuzJxCYQCJ178XBTpyayr/ZuxFi26llh7cZTE9eXO8abRuseeDH8
         iOm34tBYrvUyGUydLd4ew2RFSzHlWRxYJ/lRr6P2ZpKZxmq/NC+WtwTrY3wUmrnV+lMg
         niv2nvJuylHgm8p53K+VtMUWnxeiX3Tl5b9FEH88lK6cNeVq0wZk+RJLUtcRN46TpjqB
         0IM+gpInWckf6Zvo78NSo4mhb677JsruLWyZEgJ0MhMsRaJte7vlI9/y+sGL56Tw4j0w
         yIKY6U53mChRMkeTAjKYi324XqIUtMlwbBP9rCWcFN7OmOXyMNztV2zkYqEAYF9a33+w
         b+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AfljZ6XBReCmkxYB1UIKdkw1n3jfpfv931Z28GFHzc4=;
        b=eEDkz5PZReKirkS+ojcOPqiZgVMYg3wbrNyj2+KBaWP9WpnQojSr+/SqsfHSd+9wcC
         wIMeRGrSIoetBgH0Pryek5BLwHyWhkFJKQnElRYz32/GWpX1pAtNKUhDcbaF4fcm23lb
         9RVOzVy9ugEFUSMueuua3rGFF8ysUx8EMGAqcl/5u797doaunkfq+0sDQHVY+l/LEsK3
         ++iVmjfWJpnOJWHgsoE6AlQ7iNaVRFj21J99ZK9UDr9CKpu02whWF9tFpDJloWs8FaF8
         2o07CBRgL6IdKSmU4zCzmpZ8x0foMI8oNipFfk5CQ+NSYn3daJINpFB2XBIespHJH7Bb
         pfJA==
X-Gm-Message-State: AKwxytcfffIvsBRNTfJmJpK6bEJMMsyUvhnTWD27Samgzlc4CDTMHnOz
        7PVezbiYuhVpHe3uVhZKyCh2TKKNd88wINLlz1c=
X-Google-Smtp-Source: AH8x225KHsoe7Eretz1C+Ew5sMX9jWZPCDa0osHwPeA7uyjG5CfCUkzbAI6vpRDehPi1MCh584lkI8+pwsqx8riXBU4=
X-Received: by 10.55.177.135 with SMTP id a129mr17073603qkf.112.1516916300745;
 Thu, 25 Jan 2018 13:38:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Thu, 25 Jan 2018 13:38:20 -0800 (PST)
In-Reply-To: <20180125005854.GF26850@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net> <20180125005854.GF26850@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 25 Jan 2018 16:38:20 -0500
X-Google-Sender-Auth: LTZw9-DJ3LHNzJBY2or3jcfo0mg
Message-ID: <CAPig+cTR39UAbMmKnoi4fhU6EjQp=VGcd0J6=_rS3iD+aixJOg@mail.gmail.com>
Subject: Re: [PATCH 6/6] daemon: fix length computation in newline stripping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 7:58 PM, Jeff King <peff@peff.net> wrote:
> When git-daemon gets a pktline request, we strip off any
> trailing newline, replacing it with a NUL. Clients prior to
> 5ad312bede (in git v1.4.0) would send: [...]
>
> Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> @@ -196,5 +196,20 @@ test_expect_success 'daemon log records all attributes' '
> +test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
> +       {
> +               printf "git-upload-pack /interp.git\n\0host=localhost" | packetize

Do we care about the &&-chain here? (We'd notice if something went
wrong in 'packetize' even without &&-chain since 'input' would likely
end up with incorrect content, but still...)

> +               printf "0000"
> +       } >input &&
> +       fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
> +       depacketize <output >output.raw &&
> +
> +       # just pick out the value of master, which avoids any protocol
> +       # particulars
> +       perl -lne "print \$1 if m{^(\\S+) refs/heads/master}" <output.raw >actual &&
> +       git -C "$repo" rev-parse master >expect &&
> +       test_cmp expect actual
> +'
