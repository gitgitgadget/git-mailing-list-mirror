Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AABC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 11:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbiESLsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 07:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiESLsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 07:48:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72FFB41FB
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:48:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ck4so5158938ejb.8
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nKp6mjj/EPcIwGZYSE0yosYFV7kQN0rZpCTuvFIzhik=;
        b=dZnqD1GeQnzAR2t816B5cP+4x53oROekJaklf9oAw6a/TT0VCTOAfLwY05s6jsYWC4
         flfSzvZiL8El7uA3x+2PqmkJPlsriB9CiUPpkBMvAqvhZ3SV2+BikROv+iIODzg/c/uT
         xJ/Bzpweb8E0vav6zaZXAsGIBDCZDO8KRQr994SPGn4ZD+RrnFy5n8HPh2eHkiAOUy0V
         bZwRpTYZ2ChED6Tr9Byc/6yd3VR+Z0dcfC6UDSceQ1C1gLo1IVVaLFwCWty2AV+XT1uh
         xm68W6Xg7qLEPeEC0Ue87lwnUZmVHA222k82YN+wd24OXo/mx0YxviVyWW9Y0BIFAj+b
         J5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nKp6mjj/EPcIwGZYSE0yosYFV7kQN0rZpCTuvFIzhik=;
        b=namuDQbLSoYFlJwcgYqf3A7sqScVbslsWXX/XsnK46Py8oWhQdztJ6o7T7g4+yLX6P
         7xpZtNuA6Dh+pSf4VsCwy06Wbq3DXdF8lqrPNe/F7XVcuoWND+zjPPIUtCuvHSX3EORL
         Z7CRtndXJEkJkn6+g4FxpMHORh7F4/dLYkynCtGmfavGBUXH6xZEbq80+DYFXF0rGyx1
         ICc1ByhOvSMfAuNUuqBF5hMxmPp/oOx1T3CUz5pcunWFsbHGIn36T2UwgTreZSzfll6f
         blkvRunzIk65dcUTqNMrt0sMpOIiDfEDcVFmEjlrSFIAA5OiLfOaWFOiCeV7U6gfaD+7
         D+VQ==
X-Gm-Message-State: AOAM531EOeA9iiC8Xf12aUD8VuS1KjkJY+J8OzTRtxCDNpWPViIfSWPm
        qLU2H52UG4kyCtInnh/hJOM=
X-Google-Smtp-Source: ABdhPJyhbhDtl8PBlH16kvtOKW/FZzAoKjAoY705JUxcfHiO4YiEjXGPVlUqgbobXTs8pgezySHhyQ==
X-Received: by 2002:a17:906:7311:b0:6f4:da1c:2866 with SMTP id di17-20020a170906731100b006f4da1c2866mr3999760ejc.195.1652960881242;
        Thu, 19 May 2022 04:48:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gv29-20020a1709072bdd00b006f3ef214e13sm1996229ejc.121.2022.05.19.04.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 04:48:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nredL-0026HP-UQ;
        Thu, 19 May 2022 13:47:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 04/17] chunk-format.h: extract oid_version()
Date:   Thu, 19 May 2022 13:44:14 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <1d775f9850f00b0c3d1e9133669a6365c8d7bbba.1652915424.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1d775f9850f00b0c3d1e9133669a6365c8d7bbba.1652915424.git.me@ttaylorr.com>
Message-ID: <220519.86mtfd4uc0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 18 2022, Taylor Blau wrote:

> There are three definitions of an identical function which converts
> `the_hash_algo` into either 1 (for SHA-1) or 2 (for SHA-256). There is a
> copy of this function for writing both the commit-graph and
> multi-pack-index file, and another inline definition used to write the
> .rev header.
>
> Consolidate these into a single definition in chunk-format.h. It's not
> clear that this is the best header to define this function in, but it
> should do for now.

Maybe hash.h? :)
https://lore.kernel.org/git/RFC-patch-2.2-051f0612ab9-20220519T113538Z-avarab@gmail.com/

> (Worth noting, the .rev caller expects a 4-byte unsigned, but the other
> two callers work with a single unsigned byte. The consolidated version
> uses the latter type, and lets the compiler widen it when required).

I just went for "int" and had the compiler similarly cast that, which
seems simpler & more obvious, no?

I.e. it seems to me that we really only need these more narrow types at
the time that we write this data, which we alredy have casts for.

> +uint8_t oid_version(const struct git_hash_algo *algop)
> +{
> +	switch (hash_algo_by_ptr(algop)) {
> +	case GIT_HASH_SHA1:
> +		return 1;
> +	case GIT_HASH_SHA256:
> +		return 2;
> +	default:
> +		die(_("invalid hash version"));
> +	}

As noted in the 2/2 I posted above we have some cases where we really
should have BUG here, and others (reading) which are arguably die(). I
think just going for BUG() makes sense in this case.

But if you're just unifying existing code we can also just keep it
as-is.

FWIW I struggled to come up with a name for this, and ended up with
hash_short_id_by_algo(). Somewhat bikesheddy, but I'd prefer if we fixed
that "oid_version" name while at it, since this really has nothing do do
with an "OID version" (whatever that is).

We only refer to hash versions elsewhere, which collectively describe
the versions of all OIDs we need to handle.
