Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B271F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 21:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbfAOVJe convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 15 Jan 2019 16:09:34 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:42080 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfAOVJe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 16:09:34 -0500
Received: by mail-qt1-f182.google.com with SMTP id d19so4666883qtq.9
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 13:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u0MsuP0bPxWjL3GLDmArOBzlS+gr8XZOxTK2RFHaAx8=;
        b=Trs+vvlTfqoYu8dTgNbUQ4ZQyBbtaP80m6U27BxGhJFBqs/eorfXIKlxC3V6p69MFr
         nHM5bRN1z+cn9q9rbstputhfEkRre+u8bKnpBKmbMRAJRgTm+JSXyfjulY4F8bHEBwBr
         zztlpINCn6x9hY91Md187124rXRRoCpSfQvrxBftxxqxuINDCY/foMaeBeFaI/p6+r91
         8F27EE6QX8iWbGPSa10bp8h5d94BJ75n8LuwzWgLW4ahxQPAuecV9mkh3D7s7lK1o/lm
         HNtTKnCm6D2ul8yr36ZkCMaAX+eG3DAnC23wZYFY03cz50oU25LBuHE7b5gigPyZtz9W
         G+bg==
X-Gm-Message-State: AJcUukedVZNFcO172kTCZCOrWrK/Yo7QHOJscJ0+Jw6wN2skni0ceTVR
        E8DqNmGT2eGjEpJ4D862pitt0TH1N8XRtwEWU8w=
X-Google-Smtp-Source: ALg8bN7jcPqa+TLwowWrTBQnH+pYm/x5ROL6wx45Te6rX4DE0It3hM5fnAFf7+7FUbP6MLzwgO7ZOzrm0Di2/qfer2k=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr4584946qti.184.1547586573311;
 Tue, 15 Jan 2019 13:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20190110115704.GL4673@szeder.dev> <20190115203038.10574-1-tboegi@web.de>
In-Reply-To: <20190115203038.10574-1-tboegi@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Jan 2019 16:09:22 -0500
Message-ID: <CAPig+cSeDNYFGYC2WznjW3zYMJCWZbZFY1KM5H5ir2L=Jxwy7w@mail.gmail.com>
Subject: Re: [PATCH/RFC v1 1/1] test-lint: sed -E (or -a, -l) are not portable
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        zhiyou.jx@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 3:31 PM <tboegi@web.de> wrote:
> From `man sed` (on a Mac OS X box):
> The -E, -a and -i options are non-standard FreeBSD extensions and may not be available
> on other operating systems.
> [...]
> To be on the safe side, don't allow it.
>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> @@ -35,7 +35,7 @@ sub err {
> -       /\bsed\s+-i/ and err 'sed -i is not portable';
> +       /\bsed\s+-[Eail]/ and err 'Not portable option with sed. Only -e -f -n are portable';
>         /\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
>         /^\s*declare\s+/ and err 'arrays/declare not portable';
>         /^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';

Please update the new message to be more consistent with existing
surrounding error messages. For instance:

    err 'sed -i/-a/-l/-E not portable (use only -e/-f/-n)'

or something. Thanks.
