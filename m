Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43338C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 14:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349190AbiCUOPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352042AbiCUOMo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 10:12:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732217584A
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 07:11:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a8so30104567ejc.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vze7ifD0GWHgt1QT7ZUul6xUt+U/sB4pVveZlb9RAiw=;
        b=gsYtPaOU/HmD5+dswq2rLSnsf7frceq9Lksz6WyRV1z57nNnMD6tUmsj7WHs7Vy2Eo
         dZavrjuszpLFn0xqvm1fk7dfcZPC9xUXWydoPBSsDZNVXvp+x7bmketbsIX5Dz7ebroM
         hhxl8C+60m4Hn7CEdW+N9IWJ+d+2zsWRNnBzlXfZ1wi5JudT+l9SeTgwwnq3x2X7kk8N
         dICqUDKebIlttVcNVuXSqGxRBf43UTYEiWWyrCmyc4hZTpk1qtDo1Xb+fgAkcPTOXYv5
         +R1r3DHPerCAiLMRlT1Nes3ZIdM//H3+ZHG8H81kyiidcl9FAUkvg3S8RpREqdEioe5t
         149w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vze7ifD0GWHgt1QT7ZUul6xUt+U/sB4pVveZlb9RAiw=;
        b=FcNCW68Vu7qb9KhuwgXAb7grrPTYDPLMspZ8sOp7S1boFlwX92S1EvRgeGyPIb5D8w
         q6wgdH31nIoEzOwpAB+I34OyxbCxnVb9dmw8DpBIXAusgMsNhOn/5g/Kr78Rw3wG+Bc/
         TlOQTVDu7NS25onoacceHs5TK1QL7xPocQtRMhUuVnjlpB5Z7/sAAVUoG4+iQ/uRA5qk
         xG0alqorfOxTY+B4IrTy5YzVlBO4P+ZIvH5PH07aUW370vqbBx5VBNdTQLW6t25U5DEH
         6YtmBJhC4fE76qNVLdXbHBeAl8Yb/Uvy2UJVra8vllsDbUSp2pVUui6MwH0EeCLhdb2d
         ts7Q==
X-Gm-Message-State: AOAM532ol4KhRGiWB6F6EXCqMc3VPtPYNVsgqwDq1rIu2UwPf5AQbvpC
        KvVxjETcvOnyZWxBBpGoudw=
X-Google-Smtp-Source: ABdhPJw2D82YZH14agSiBuQNP7rwgrDq4eOwxm6LArFf7ylGfetSQwvYzdETPiARGV5azUdANUEjTA==
X-Received: by 2002:a17:907:e87:b0:6df:6a26:e17c with SMTP id ho7-20020a1709070e8700b006df6a26e17cmr21078383ejc.666.1647871876605;
        Mon, 21 Mar 2022 07:11:16 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sh31-20020a1709076e9f00b006dff86479d7sm1852474ejc.21.2022.03.21.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:11:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWIkd-000XB9-Bm;
        Mon, 21 Mar 2022 15:11:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/7] More i18n fixes
Date:   Mon, 21 Mar 2022 14:59:24 +0100
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
 <e44b6ccf-21a2-72c6-4d40-dc0004895255@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <e44b6ccf-21a2-72c6-4d40-dc0004895255@kdbg.org>
Message-ID: <220321.86ils79z0c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Johannes Sixt wrote:

> Am 20.03.22 um 22:54 schrieb Jean-No=C3=ABl Avila via GitGitGadget:
>> This is another i18n PR (and hopefully the last for a while).
>>=20
>> As usual, the intent is kept the same: curbing the number of strings to
>> translate, remove constant, error prone parts out of the way, trying in =
some
>> sense to "put a precedent" so that the template strings can be reused la=
ter.
>
> I feel that many of the example conversions look like sentence lego
> because there remains only one English word, e.g., "'%s' failed". The
> converted code does not leave a hint for the translators what the %s
> will be. Is it a command, a function name, somehting else? Even if the
> hint was provided, different translations may be required depending on
> the substituted entity. Did you investigate the existing translations
> whether all of them can be converted to the new scheme?
>
>> This series has also a RFC status: can "bad argument" messages be merged
>> with unrecognized argument?
>
> The cases that patch 7/7 transforms look like they need not keep
> "unrecognized argument", but can be converted to "bad argument".
>
> Disclaimer: neither am I a translator nor a user of a translated Git.

Just to add to this:

 - Careful use of sentence lego is OK, but e.g. in my native language a
   command-line option would use a male noun article, whereas commands
   would be feminine.

   (I still haven't submitted an Icelandic translation, but this applies
   in general).

   As a result string like "'%s' failed" can be *workable*, i.e. you can
   translate it assuming you'll get any arbitrary string, but the
   translation will often be rather tortured.

   So it's much preferred (and this also goes to Johannes's comment) to
   instead do e.g.:

       "failed to run the '%s' command"
       "failed to use the '%s' argument"

   Or whatever, and e.g. for:
=09
	-		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take argumen=
ts"));
	+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(obj=
ecttype)");

   Instead say "the '%s' format does not...", i.e. disambiguate with
   "format".

 - While perfect shouldn't be the enemy of the good, it would be most
   welcome to improve some of the warts revealed by these messages,
   notably that e.g. the "failed to run X command" don't report
   errno. E.g. this in git.c is a good template (except for the "\n" we
   should ideally get rid of):

       _("failed to run command '%s': %s\n")

 - On that topic, it would be really useful to see if we can unify some
   of these with *existing* po/git.pot messaging, I don't know if that's
   part of your workflow, but in some cases I've seen we can either
   tweak wording slightly to match an existing message, or could further
   unify some existing similar messages.

 - Even if we say "failed to run git-apply" or whatever now we should
   really be adding quotes to these as we convert them. In some cases
   the changes that (good):
=09
	-		die(_("git-http-push failed"));
	+		die(_("'%s' failed"), "git-http-push");

   But not in others (bad):
=09
	-		res =3D error(_("Bad bisect_write argument: %s"), state);
	+		res =3D error(_("bad %s argument: %s"), "bisect_write", state);

   I.e. that should be 'bad '%s' argument. And also on the "unify" point
   above, e.g. grep.c has this:

       grep.c: die("bad %s argument: %s", opt, arg);

   So we could covert that one to "bad '%s' argument: '%s"" while we're
   at it...

- In some cases there's ucase to lcase conversions, like Bad->bad above
  (good), but others are missed, e.g. (also missing quotes as noted
  above):

	-		die(_("Server does not support --shallow-since"));
	+		die(_("Server does not support %s"), "--shallow-since");

 - On quotes, let's consistently use '' quotes, and not e.g.g:
=09
	-		die(_("`scalar list` does not take arguments"));
	+		die(_("%s does not take arguments"), "`scalar list`");

