Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C27C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 04:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiKREJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiKREJF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 23:09:05 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D952684324
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 20:09:01 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n21so10102152ejb.9
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 20:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7XMEwa51bDnzar+iD0CSTNI+YEibVeffsckGlXbn5qs=;
        b=N8LSCvIv2EGtdLh2wYYNFIQkRQ0kOFPCiPow1gL1NbPn0FxoEqfUyYVQWmsxEeR6ID
         jIlo/myVGjBDeJ0gVDPWpGWsknhIFN3NyZZ76NgwXP/3OtwfxD6DPmyQiNZWbhIihaPO
         GOIObNRrXOSOuWvsDXlaK20aNM7Xs6Y2RpChK4wnHp0NHo9dMVZ4qxr1Uh1gwfL5pYWS
         sQWIo/wN+EO+Ag3tEliuIsOXUYV32BOTEpMPYcGiOd3nyU97pWijzSm1yDRfPYFjbRyN
         Z3wWRPj6UXG8gFygtxtOI8RtZoWxPWb/N2DwUrkR6V+FS/1Ogw4lhFBzHeiTAWNWrHR2
         EU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XMEwa51bDnzar+iD0CSTNI+YEibVeffsckGlXbn5qs=;
        b=4mye2wSa/6JzaUNf+CvionuQHfIfdUzMFXUhgiBX2152wXWikU05RqD6zr1gf7LLDF
         X1n+zqmorVex3qMnvV0dkF5snPO0WDl5gbtEu/0S7ohuhe+IpB05XSwzwXcQfApmeFQt
         IZHJgma5R9M2ut5g5pVUrcHpugHE+1EynFtjfoyAGbSILVHyaNTJEFP56+VRg2AeA43t
         3ulzBmonUwB24MtgjFJ0JtFWp4MbnFu+onSKwgVK3AOnXwX6eD+Z7J/sqZCnI6LapYEJ
         qXbrZKeZTGqRG6mSfSXmk9T16B5HgtamoB5e3oV/kruBsr3vj1jU2xAagOi/NtzILHru
         bAyg==
X-Gm-Message-State: ANoB5pmPI3bXMvAFNskXUiUuSXEsdXqpgrT0qEeJ3X0+u6iNihs+kZdJ
        3MXX5ej0fmp++56JfwmwYKxqzcWtH/pGNg==
X-Google-Smtp-Source: AA0mqf6HvfmkC5monLAtN9YKrChj31kkw/ePCA5DuthfdfcIiH6ALVkNDKbSIhJ+t3o46fByWFAqOQ==
X-Received: by 2002:a17:907:378:b0:7ad:db82:d071 with SMTP id rs24-20020a170907037800b007addb82d071mr4710781ejb.200.1668744540226;
        Thu, 17 Nov 2022 20:09:00 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b007b2a3cad2cfsm1148252ejh.132.2022.11.17.20.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:08:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovsgV-005D8T-0e;
        Fri, 18 Nov 2022 05:08:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] branch: force-copy a branch to itself via @{-1} is
 a no-op
Date:   Fri, 18 Nov 2022 04:58:54 +0100
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <db182322-1383-4311-8baa-c4a9aeed3b4d@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <db182322-1383-4311-8baa-c4a9aeed3b4d@gmail.com>
Message-ID: <221118.868rk8hpk4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Rub=C3=A9n Justo wrote:

> Since 52d59cc645 (branch: add a --copy (-c) option to go with --move
> (-m), 2017-06-18) we can copy a branch to make a new branch with the
> '-c' (copy) option or to overwrite an existing branch using the '-C'
> (force copy) option.  A no-op possibility is considered when we are
> asked to copy a branch to itself, to follow the same no-op introduced
> for the rename (-M) operation in 3f59481e33 (branch: allow a no-op
> "branch -M <current-branch> HEAD", 2011-11-25).  To check for this, in
> 52d59cc645 we compared the branch names provided by the user, source
> (HEAD if omitted) and destination, and a match is considered as this
> no-op.
>
> Since ae5a6c3684 (checkout: implement "@{-N}" shortcut name for N-th
> last branch, 2009-01-17) a branch can be specified using shortcuts like
> @{-1}.  This allows this usage:
>
> 	$ git checkout -b test
> 	$ git checkout -
> 	$ git branch -C test test  # no-op
> 	$ git branch -C test @{-1} # oops
> 	$ git branch -C @{-1} test # oops
>
> As we are using the branch name provided by the user to do the
> comparison, if one of the branches is provided using a shortcut we are
> not going to have a match and a call to git_config_copy_section() will
> happen.  This will make a duplicate of the configuration for that
> branch, and with this progression the second call will produce four
> copies of the configuration, and so on.
>
> Let's use the interpreted branch name instead for this comparison.
>
> The rename operation is not affected.

Good catch! Yes this definitely wasn't intended, and is just a failure
of the config name v.s. ref names drifting from what the previous logic
was assuming.

> @@ -584,13 +584,13 @@ static void copy_or_rename_branch(const char *oldna=
me, const char *newname, int
>  	strbuf_release(&logmsg);
>=20=20
>  	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> -	strbuf_release(&oldref);
>  	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> -	strbuf_release(&newref);
>  	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) =
< 0)
>  		die(_("Branch is renamed, but update of config-file failed"));
> -	if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsect=
ion.buf, newsection.buf) < 0)
> +	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_con=
fig_copy_section(oldsection.buf, newsection.buf) < 0)

We try to stay under 79 chars, see CodingGuidelines. The pre-image was
already violating this, but the new one is really long. I think it would
be good to just wrap this after the last && while at it.

>  		die(_("Branch is copied, but update of config-file failed"));
> +	strbuf_release(&oldref);
> +	strbuf_release(&newref);
>  	strbuf_release(&oldsection);
>  	strbuf_release(&newsection);

This moving around of destructors isn't needed, and is just some
unrelated cleanup. Your change here only needs to be:

	-       if (copy && strcmp(oldname, newname) && git_config_copy_section(ol=
dsection.buf, newsection.buf) < 0)
	+       if (copy && strcmp(interpreted_oldname, interpreted_newname) &&
	+           git_config_copy_section(oldsection.buf, newsection.buf) < 0)

If you'd like to re-arrange some of this and e.g. free stuff at the end
instead of after it's last used (which is what the current code is
aiming for) that's arguably good, but let's do that in another commit
then.
