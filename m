Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0253D1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 01:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeKDKRl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 4 Nov 2018 05:17:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37907 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKDKRk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 05:17:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so9232319qkg.5
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 18:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X36QkLRqY8jiY+pesYpbr2mmy1+ANB91q/DTzOkywQY=;
        b=UB74RJTlBYF06wzbPzsZdrx9+/4j9zh0gnpPwZyPcjJVmqk3hTSRuDXGVAVbzamwtn
         sfG+jaweY6XzGM35N/vrwx0lKSDw4Tc0Q6qnUGofHD4aPtoyAFMtYUVtOnUQc6pHKjRr
         rrZZQJ/GFwYt+vXSXICBKr+U6LnWfGFjx/6umiw5WpzN1bIFCurzn93Sw4dyA8AkM+Hm
         0IAQCWk/xXII5JzdSfEvadgQGgt89875YjgfD/6Dant0FEd78ozkAH+78RQF0wCyomL4
         FG7bxCO6lQEYyIGCWmgM1N0TIfQV2HstWy1xq/PsoTaDXlJKK0Sr+Mfa5ay3MglKH/8G
         IeSQ==
X-Gm-Message-State: AGRZ1gInSYLdMurS8GoXWf0vNq0Hs4cVFajDwlMsDRLN4XjT6ke2cjtz
        jfiLm2xGed8DDdm8rqYOVRbwgU9GjPwcwmFSmf0=
X-Google-Smtp-Source: AJdET5ftXkBQeiCf5/SbiHzj6kX47GSARb2a9XgG5fTgz2nwpjAjWIvMYy7/VoHe6h9q7i+xVytxFWOz09NTYspQW5c=
X-Received: by 2002:ac8:592:: with SMTP id a18-v6mr16469068qth.184.1541293479631;
 Sat, 03 Nov 2018 18:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-6-avarab@gmail.com>
In-Reply-To: <20181102223743.4331-6-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Nov 2018 21:04:28 -0400
Message-ID: <CAPig+cSyyEsoP532DnUy=XO2OXNiGmKJqkqQsau4n13J1fQZ7w@mail.gmail.com>
Subject: Re: [RFC/PATCH 5/5] Makefile: Add a NO_INSTALL_BUILTIN_EXECDIR_ALIASES
 flag
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, stanhu@gmail.com,
        richardc@unixbeard.net, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 6:38 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Let's add an option to break this backwards compatibility. Now with
> NO_INSTALL_BUILTIN_EXECDIR_ALIASES=YesPlease there's only 3 programs
> in the bindir that are hardlinked to "git" (receive-pack,
> upload-archive & upload-pack), and 3 in the
> gitexecdir (git-remote-{ftp,ftps,https} linked to git-remote-http).
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> @@ -346,6 +346,13 @@ all::
> +# Define NO_INSTALL_BUILTIN_EXECDIR_ALIASES if you'd like to skip
> +# installing legacy such as "git-init" and "git-add" in the
> +# gitexecdir. Unless you're on a system where "which git-init" is
> +# expected to returns something set this. Users have been expected to

s/returns/return/
s/something/&,/

Although, it's not clear what "return something" means. Perhaps rephrase it as:

   ...git-init is expected to exist, set this.

> +# use the likes of "git init" for ages now, these programs were only
> +# provided for legacy compatibility.
> +#
