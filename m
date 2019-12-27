Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03595C2D0DA
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 07:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C456D218AC
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 07:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHM2pbx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfL0Hvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 02:51:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33308 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfL0Hvg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 02:51:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so13589811otp.0
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 23:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7sWuOIcD2n/3WmZLNsJtYBoxiuG8i24oZLR+cR9ULq4=;
        b=UHM2pbx3dMerJlr99vWuqN8z2KRBl7uPIk95xsrLID7+qvaTSQhxWbWXXi7V6ViMSX
         a+U55SQw/lLSEBxS8iqAubUcQlQejzB9JpUkHyy6kOF3nZyp1wcA+qMahBy7w1F8r6w3
         J+6XKqmD+39wbrStqCOgtpMJCcRAxM9gO+39lfpFOwU2pHUeC7fmW6pwu+sA9OSUdGBs
         Xl0CTmI0YqJFDV8n00PhNAbLkKYLL5m+itYHxyJQAlT0/g0sLC/JQVy+5KzCI9MGIrC+
         IGIHBicFrFEB6Pq9ZWm8YSO+EpQ2eLhnnweM4hRjwtqBPXOo6d/QmHsDx4Gatb30oI5v
         D4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7sWuOIcD2n/3WmZLNsJtYBoxiuG8i24oZLR+cR9ULq4=;
        b=d+d1mnyVsXrdwEufSZhUaPI7+lCAzAaUZaccrLd9JutrNYrU3nmOSpYd/OjKl8DjoP
         aFApw2vLIrzYFzlXPgMGPBhnr97vjnvVBjDkDTG0ImThegJxneGYyHlC65F4SW1bAakh
         fL8SxNmZRqdXD7ndEtV9CZRWQu3Cra3dMi/2B0cwRdHKni6GkoTC5DkePF6bWb1ULOoc
         e0Scw91y8qHb6bnXCp3v7rZgVUcKFt8xh+nmFYo3jBi2mKdkBmx9a0QqCIsJwf+3xaZc
         jJes5I6ThNecEaqoQ/1TTC09AKmsZFZgWEQd2gP/cCYoT9MuhtGfY8av94DEW4b/Vq3i
         PlZw==
X-Gm-Message-State: APjAAAWSpCZLwd1wVYpejbPwog+lpN7waPjtJOfwUMUEVdba4Sq4FFV2
        wyrZjRvy1yFNhhpd1S7X3l4WnieGEvdGvsEgv7nsvfBfKMg=
X-Google-Smtp-Source: APXvYqzuLtK9Q5hOSRvOUOwsOHNCSh+4XeZYAn5GWV9CTa2FvU6Z7dLUNMtqHQNutYkOeQldpfvQiLteka6xqCbcOig=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr51916064otr.262.1577433095367;
 Thu, 26 Dec 2019 23:51:35 -0800 (PST)
MIME-Version: 1.0
From:   Adrien LEMAIRE <lemaire.adrien@gmail.com>
Date:   Fri, 27 Dec 2019 16:51:04 +0900
Message-ID: <CALqn52MbeiCrEzphMkcjeU6bPbLLaQOa-vzht2156uqVw1wL_g@mail.gmail.com>
Subject: git filters don't get applied to dotfiles
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to report a bug regarding git filters not being applied to
files beginning with a dot character "."
Using git version 2.24.1
Please let me know if there is a better way to report bugs. The github
page only mentions this email.

To give a bit of context, I've followed this arch linux suggestion to
track my dotfiles using the "bare repository and alias method".

.gitattributes
> mailrc filter=remove-smtp-pass
> .mailrc filter=remove-smtp-pass


.dotfiles/config
> [core]
> repositoryformatversion = 0
> filemode = true
> bare = true
>
> [status]
> showUntrackedFiles = no
>
> [filter "remove-smtp-pass"]
> clean = "sed -e 's/gmail.com:.*@smtp/gmail.com:PASSWORD@smtp/'"


The file I'm trying to commit is called .mailrc, but to confirm the
bug, I copied it as mailrc (without leading dot). When adding both
files, the filter only gets applied to the file without leading dot.

> $ config diff --cached
> diff --git a/.mailrc b/.mailrc
> new file mode 100644
> index 0000000..7ac2abb
> --- /dev/null
> +++ b/.mailrc
> @@ -0,0 +1,4 @@
> +account gmail {
> +  set v15-compat
> +  set mta=smtp://lemaire.adrien%40gmail.com:IamApassword@smtp.gmail.com:587 smtp-use-starttls
> +}
> diff --git a/mailrc b/mailrc
> new file mode 100644
> index 0000000..2698128
> --- /dev/null
> +++ b/mailrc
> @@ -0,0 +1,4 @@
> +account gmail {
> +  set v15-compat
> +  set mta=smtp://lemaire.adrien%40gmail.com:PASSWORD@smtp.gmail.com:587 smtp-use-starttls
> +}
> $ config check-attr -a -- mailrc
> mailrc: filter: remove-smtp-pass
> $ config check-attr -a -- .mailrc
> .mailrc: filter: remove-smtp-pass


As reported by check-attr, the .mailrc file is correctly assigned to
the filter, but the diff output shows the password.

Cordially
Adrien
