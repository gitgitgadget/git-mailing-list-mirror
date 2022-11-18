Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A3DC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 06:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241021AbiKRGBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiKRGBn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 01:01:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C63F6D4AB
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 22:01:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v17so5702918edc.8
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 22:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DUhAeDFV/AuorM1DGXkIVEZSi2pXFlcs8x1YWbYvTbo=;
        b=OLfYkDQSmVJdm7ppnclfRiph8r+bzig+nIn7KLMhIVOep7lNkFu9i1eMhcTS2CqsQD
         SlBKewpg0n6GbBv0fN1RNVhH/1Ove076othr5UE9nzkVWFpo92TgF4gfGRNpB+PTGfyC
         hnuR5HHQqcMnA0A5p9dsBQELl62UqtqKxoJureD8JmaDgO8rvSPYqvWbJDHVa8H1AeIQ
         5rbS24G+qXQh172iPa7DI45yxCRVsDIt4UakpwPmZlRWKT81qpyugUrvEC4TNLgCDlOY
         FK7uoxwG3yYISNvRUDkGW+wlaNX3JL/wpIleCMA17/MGNhNDBygooDrFz4ON/ptmUNcz
         j+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUhAeDFV/AuorM1DGXkIVEZSi2pXFlcs8x1YWbYvTbo=;
        b=N0OSMvq1LyrbgYeUHB+EamTwg829/kzRmXa4qr7ul08vRy25X90NMQ8f9VbysWnyid
         gQrn7pKab+zJxjonJqHK5mRdtQpIPX6IK6mhwWeB1AUIh4F2SghZUhHe3jG0VG3XzApE
         Wna3NUqWB7JwL0DTDLIwSGJ70tget8wyB0wUuzS8lQGqMwjv+WAaVyXfaFzpRczPH3MV
         MZ5XT3iCcrFHMwgEtuwpjXGGv4Zz54LrIUsOoFHSO3YeQ644L5CAqgJMbsGPSlaKRSrZ
         u7vUcM7W6y7L4+Sk7d/Jn93wNDG4o/bQFu3ERSsTuw9wpmLqpOJP1JcNhVzbB1viUU+k
         gDWQ==
X-Gm-Message-State: ANoB5pnPyrg00UWCPsROiGVy0ZDjxzOqMLK8dX/AetVFFVw8Deyt4OiG
        F21aLxgUvf/mUcgbiCXhvcSj8SvURbAcNQ==
X-Google-Smtp-Source: AA0mqf5l8JA5qnVSa1bcS+K3TyPM6PbQd91fRIk2rz6pjdKfYYsQCPWKkwsrHCElJetun+H8E9xp+Q==
X-Received: by 2002:aa7:d88c:0:b0:468:ffca:6982 with SMTP id u12-20020aa7d88c000000b00468ffca6982mr2406564edq.282.1668751301007;
        Thu, 17 Nov 2022 22:01:41 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id lb9-20020a170907784900b0073d796a1043sm1235017ejc.123.2022.11.17.22.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:01:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovuRX-005GMU-2u;
        Fri, 18 Nov 2022 07:01:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] branch: clear target branch configuration before
 copying or renaming
Date:   Fri, 18 Nov 2022 05:51:54 +0100
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
Message-ID: <221118.864juwhkcc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Rub=C3=A9n Justo wrote:

> There are two problems with -m (rename) and -c (copy) branch operations.
>
>  1. If we force-rename or force-copy a branch to overwrite another
>  branch that already has configuration, the resultant branch ends up
>  with the source configuration (if any) mixed with the configuration for
>  the overwritten branch.
>
> 	$ git branch upstream
> 	$ git branch -t foo upstream  # foo has tracking configuration
> 	$ git branch bar              # bar has not
> 	$ git branch -M bar foo       # force-rename bar to foo
> 	$ git config branch.foo.merge # must return clear
> 	refs/heads/upstream

I'm fuzzy on whether Sahil and I discussed these edge cases at the time,
but my first reaction was surprise that you thought this was purely a
bug, I'd have thought it was a feature.

I.e. yes there's bugs & edge cases here, but fundimentally doesn't it
make sense to think about "branch -c" as being mostly equivalent to a
hypothetical:

	git branch --just-the-ref-operations -c <old> <new>
	git config --rename-section branch.<old> branch.<new>

And not:

	git config --remove-section branch.<new>
	git branch --just-the-ref-operations -c <old> <new>
	git config --rename-section branch.<old> branch.<new>

From reading the initial thread I see the "delete first" seems to have
been a TODO item of Sahil's[1], but the "copy branch" initally (I
mentored Sahil on it) from a shell one-liner I still have in my
.gitconfig history, which was a mostly-rename-section.
=09
>  2. If we repeatedly force-copy a branch to the same name, the branch
>  configuration is repeatedly copied each time.
>
> 	$ git branch upstream
> 	$ git branch -t foo upstream  # foo has tracking configuration
> 	$ git branch -c foo bar       # bar is a copy of foo
> 	$ git branch -C foo bar       # again
> 	$ git branch -C foo bar       # ..
> 	$ git config --get-all branch.bar.merge # must return one value
> 	refs/heads/upstream
> 	refs/heads/upstream
> 	refs/heads/upstream

Yeah, you came about this conclusion because you're looking at the
tracking config, of which there should be only one.

Our config space is multi-value in general, although most (all?) of our
branch.* space is one-value.

But users can also stick things in there, so....

> Whenever we copy or move (forced or not) we must make sure that there is
> no residual configuration that will be, probably erroneously, inherited
> by the new branch.  To avoid confusions, clear any branch configuration
> before setting the configuration from the copied or moved branch.

So, whatever tea leaves we read into the history, or whether this was a
good or bad design in the first place, I think we should probably lean
towards not having this be a bug fix, but a new feature. Both modes are
clearly easy to support.

And then document it in terms of some new switch being the equivalent to
--remove-section followed by a rename, the existing thing a rename etc.

> @@ -583,12 +583,17 @@ static void copy_or_rename_branch(const char *oldna=
me, const char *newname, int
>=20=20
>  	strbuf_release(&logmsg);
>=20=20
> -	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> -	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> -	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) =
< 0)
> -		die(_("Branch is renamed, but update of config-file failed"));
> -	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_con=
fig_copy_section(oldsection.buf, newsection.buf) < 0)
> -		die(_("Branch is copied, but update of config-file failed"));
> +	if (strcmp(interpreted_oldname, interpreted_newname)) {
> +		strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> +		strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> +
> +		delete_branch_config(interpreted_newname);
> +
> +		if (!copy && git_config_rename_section(oldsection.buf, newsection.buf)=
 < 0)
> +			die(_("Branch is renamed, but update of config-file failed"));
> +		if (copy && git_config_copy_section(oldsection.buf, newsection.buf) < =
0)
> +			die(_("Branch is copied, but update of config-file failed"));

Aside from any question of a hypothetical "should", your implementation
is running head-first into a major caveat in our config API.

Which is that we don't have transactions or rollbacks, and we don't even
carry a lock forward for all of these.

So, there's crappy edge cases in the old implementation as you've found,
but at least it mostly failed-safe.

But here we'll delete_branch_config(), then release the lock, and then
try to rename the new branch to that location, which might fail.

So, we'll be left with no config for the thing we tried to clobber, nor
the new config.

