Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD0DC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 15:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDRPQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRPQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 11:16:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6269EAF17
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 08:16:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dx24so30109556ejb.11
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681830985; x=1684422985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js3MdinnyhdXwUnfoHQCkiepk4ckhdAIRVwKuXMh01M=;
        b=Z/QnJlOgFH9Fb8Xz2cI3M6PGFwvi7bfQszphFNyJL82iMZvtenSwKBx3oO5tI6SmlB
         6JbMVFxoDsiiKB9gpxTLdm34I6RVHU4eNWVQZeuRmcYScUD98DspIpGi+EkDm9bGdC2d
         TDPgVcQ1E/mqe5gsVFqbbC7v4tGMCZ0Yz0NOCZ6tvkDejYeV6pw+pCSdBNsIBkcLyhJn
         9SeAayyKQ6TGR1dXeMZwI+dLSfdyCeCq7z7gcDXXb3VYt1fOJrEAsbx4IlXNZ1CDav+9
         6DLdfLNvXAo1I+d/7q6LCmBiD6JASkAxZpFCbKznWNmQ9tE4pYOZW2Al74RKDxLiYlYY
         oxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681830985; x=1684422985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js3MdinnyhdXwUnfoHQCkiepk4ckhdAIRVwKuXMh01M=;
        b=jXcHPIIb3fZpRYGKKXCrj8y9GibMgfsArdGMOtKn0UVWoD/1ejaV5B1Z3H2MzHvMV8
         tieXnDFyfWWG88sX7sAaTj5ATlbIa3l0DYIltIl79x1m3CaRCUHiZLeuAI9fthDrYYOX
         S35Phs/MFur3O2dOySwCXp6rio8MAuY3Q6fJw07aIuboBMrG3LhHVcHkzdfiM0TnuYpn
         AgFKnmXtUXSLEFrxdg5Q86Z/s4JxK0FiZRmK+WAqySb7+eh6nGKdsndZU4GJZXOjH6ZN
         q0wnX8WS/Txofz9u/4Jr9DWKTQ1Tbz0YiiKtB4Kx1usKp0n5o4pLLYIh3TPLNc1bUY9s
         JeFg==
X-Gm-Message-State: AAQBX9eXzMknzXpZgaB96CtJW+pATm7nWMyQoARk1nAP3uU5DE2tZgC2
        Ph6LHSrtXJCe4MeipQJxnAWYuAv+I6zT/PE3h6M=
X-Google-Smtp-Source: AKy350abl7Tt+3NtUcqK2zpCtqT19Our//maen0oxuAIK0Th04YnB1+tw95r8pA9TxUN1ggSy/upaw6fL82+FVL7eBQ=
X-Received: by 2002:a17:906:11d2:b0:94e:6a70:edd0 with SMTP id
 o18-20020a17090611d200b0094e6a70edd0mr11879035eja.24.1681830984698; Tue, 18
 Apr 2023 08:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <5926995.lOV4Wx5bFT@devpool47.emlix.com> <20230418064846.GA1414@coredump.intra.peff.net>
In-Reply-To: <20230418064846.GA1414@coredump.intra.peff.net>
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
Date:   Tue, 18 Apr 2023 20:46:16 +0530
Message-ID: <CACaPSotwDfDXk=kR7LntF46NN-cM-zx22T83m1sjYEDLbnSxNQ@mail.gmail.com>
Subject: Re: gpg-related crash with custom formatter (BUG: gpg-interface.c:915:
 invalid trust level requested -1)
To:     Jeff King <peff@peff.net>
Cc:     Rolf Eike Beer <eb@emlix.com>, git@vger.kernel.org,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the report.

The patch did not preserve the exact behaviour of
the previous code. Rather than calling BUG() whenever a trust level is out
of the sigcheck_gpg_trust_level[] array, we can simply return an empty stri=
ng

if (level < 0 || level >=3D ARRAY_SIZE(sigcheck_gpg_trust_level))
        return "";

It will replicate the exact behaviour as the previous code. But as
Jeff pointed out,
Should this really be the defined behavior?

Let me know what you think. I will make the necessary changes.

Thanks,
Jaydeep.


On Tue, Apr 18, 2023 at 12:18=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Tue, Apr 18, 2023 at 08:12:03AM +0200, Rolf Eike Beer wrote:
>
> > When I now run "git log" in a repository that contains commits signed b=
y
> > people not in my keyring (e.g. the Gentoo git) I get this backtrace:
> >
> > BUG: gpg-interface.c:915: invalid trust level requested -1
>
> Thanks for giving an example repo. After cloning:
>
>   https://anongit.gentoo.org/git/repo/gentoo.git
>
> I can reproduce just by running "git log -1 --format=3D%GT". Bisecting
> turns up 803978da49 (gpg-interface: add function for converting trust
> level to string, 2022-07-11), which is not too surprising.
>
> Before that we returned an empty string. I don't know if the fix is a
> simple as:
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index aceeb08336..edb0da1bda 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -934,7 +934,10 @@ const char *gpg_trust_level_to_str(enum signature_tr=
ust_level level)
>  {
>         struct sigcheck_gpg_trust_level *trust;
>
> -       if (level < 0 || level >=3D ARRAY_SIZE(sigcheck_gpg_trust_level))
> +       if (level < 0)
> +               return "";
> +
> +       if (level >=3D ARRAY_SIZE(sigcheck_gpg_trust_level))
>                 BUG("invalid trust level requested %d", level);
>
>         trust =3D &sigcheck_gpg_trust_level[level];
>
> which restores the original behavior, or if the original was papering
> over another bug (e.g., should this be "undefined"?). Certainly the
> empty string matches other placeholders like %GS for this case (since we
> obviously don't know anything about the signer).
>
> +cc folks who worked on 803978da49.
>
> -Peff
