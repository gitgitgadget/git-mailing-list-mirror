Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C33C4332F
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 09:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiAMJwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 04:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiAMJwo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 04:52:44 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BFEC06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 01:52:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c71so20974384edf.6
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 01:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RHRQWq/rez9RYb+DoTHRnDAwejY31cS6W3N771Q1RKM=;
        b=bkUMEu0/RrZL7ayQfPUplUc+EgKenzLsKRpsch5gjPbSnOgKeh/060HhM3Xi0GQGXu
         6D87qoZKSlsDH8l5oq73PiwXfewHZ7qa4MaP6yvLsALJhTB9P5pLL0zM71Sh3929z1FX
         arsLc2nMR5Kq7WREOFDRixTIRjp6P27GHJTMLnuYCJLIeOMSNbUWGJFurPX01HjehKwL
         u5otoU0R9QJ7AMifYNGniSV+1qaYs+oF0uDEoP97ajKnbUw2P8qVb0e4FdJi1DyMYTJN
         OHZ0JwYnPtWlfB0NGniK7BH95c5G7HhVwwuHxGUFdtGGEpEQS0ah8SY+ibnuMXr5dQlN
         NLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RHRQWq/rez9RYb+DoTHRnDAwejY31cS6W3N771Q1RKM=;
        b=DO+oOUE4ZUsmaFdcvsvsIwAMpCluINvtPLkJMVnSxWrdAriE06LTcg6Tm7vtr6EvqB
         ZbYSAHI9ikYJqkNYwnzPHzqIm4UtAXxRcAIHgrkUW12vesmzKhxKnGn1vD6+GT6qSjyw
         zkGqHVoLqqUjmsYHzzpdD9V9YmVLSVD4ocbkCiwXhFyfzhF+ieBLDV1jXRHeYkA0q+yK
         K6vC1bDS3kHTT95JBWqMvyiQZpD85gYl/1irX8/oOtBNLIemQn9xd9hGPmeQxLwuc0d+
         6X5HIfwhs6mzIDMFnvDQN0Z7Jqk4wANu9grgwaeEc4Sf455xbzf7rdBPdSScnheLaE/0
         HLQQ==
X-Gm-Message-State: AOAM532xY31MRMtTFI9EGacXgGN+zW17r6VvqMDJ9YspoPjR5C94AwKk
        npfGQIMYHVWaZGtXW+ywv+5473MrSDoMDw==
X-Google-Smtp-Source: ABdhPJwF3uQHY81R4iRSlj31Ic/2ZVuYWoOJUbBOpBUpxbHu9gwnULad5erZDRPD3XBIcAgwrE23ww==
X-Received: by 2002:a17:906:c2c7:: with SMTP id ch7mr2312571ejb.595.1642067562090;
        Thu, 13 Jan 2022 01:52:42 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f11sm413486edv.67.2022.01.13.01.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:52:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7wmf-000qba-0P;
        Thu, 13 Jan 2022 10:52:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
Date:   Thu, 13 Jan 2022 10:22:05 +0100
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
 <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet>
 <xmqq8rvn1nkw.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet>
 <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com> <xmqqy23kx2k5.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqy23kx2k5.fsf@gitster.g>
Message-ID: <220113.86fspsvu6v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 12 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Maybe that was the right thing to do, maybe not, but it went out with
>> v2.30.0 and the lack of complaints since then would seem to suggest that
>> I was right that removing it wouldn't be a big deal.
>>
>> Of course it may have broken someone's script somewhere.
>>
>> But an important distinction is that they can get it working again by
>> just copy/pasting that ~100 line shell library into their own script, or
>> calling the underlying commands it was invoking themselves.
>
> Was parse-remote a part of what promised our end-users? [...]

It was listed under "LOW-LEVEL COMMANDS (PLUMBING)" =3D> "Syncing
repositories", which has git-daemon, git-{upload,receive}-pack,
git-shell etc. now.

So, pedantically we removed a removed a plumbing utility without much if
any warning.

But as I argued when it was removed I think that realistically some of
our plumbing tools were made for internal-only use, and as the *.sh->C
rewriting of built-ins progressed they became orphaned.

They only had public-facing manpages due to plans that never came to
fruition, or just in copy/pasting an existing template at the time.

I don't think that would matter for git-parse-remote if it had
subsequently gotted widespread use in the wild (even if it were
undocumented), but when I investigated that it really seemed to be used
by approximately nobody.

But a while after it was removed you pushed back on some further similar
changes to git-sh-setup. I asked some follow-up questions in
https://lore.kernel.org/git/87tuiwjfvi.fsf@evledraar.gmail.com/ about
how we should consider these that you didn't reply to.

The greater context being that I was removing git-parse-remote.sh so
that I could eventually get rid of the bridge of extending
libintl/gettext to *.sh-land. The current state of that on "master" in
that regard being:
=20=20=20=20=20=20=20=20
    $ git grep '\b(eval_)?gettext(ln)?\b' -- ':!t/' ':!ci/' ':!git-gui' ':!=
git-sh-i18n.sh' '*.sh'
    git-merge-octopus.sh:    gettextln "Error: Your local changes to the fo=
llowing files would be overwritten by merge"
    git-merge-octopus.sh:           gettextln "Automated merge did not work=
."
    git-merge-octopus.sh:           gettextln "Should not be doing an octop=
us."
    git-merge-octopus.sh:           die "$(eval_gettext "Unable to find com=
mon commit with \$pretty_name")"
    git-merge-octopus.sh:           eval_gettextln "Already up to date with=
 \$pretty_name"
    git-merge-octopus.sh:           eval_gettextln "Fast-forwarding to: \$p=
retty_name"
    git-merge-octopus.sh:   eval_gettextln "Trying simple merge with \$pret=
ty_name"
    git-merge-octopus.sh:           gettextln "Simple merge did not work, t=
rying automatic merge."
    git-sh-setup.sh:# Source git-sh-i18n for gettext support.
    git-sh-setup.sh:                die "$(eval_gettext "usage: \$dashless =
\$USAGE")"
    git-sh-setup.sh:                LONG_USAGE=3D"$(eval_gettext "usage: \$=
dashless \$USAGE")"
    git-sh-setup.sh:                LONG_USAGE=3D"$(eval_gettext "usage: \$=
dashless \$USAGE
    git-sh-setup.sh:                gettextln "Cannot chdir to \$cdup, the =
toplevel of the working tree" >&2
    git-sh-setup.sh:                die "$(eval_gettext "fatal: \$program_n=
ame cannot be used without a working tree.")"
    git-sh-setup.sh:                die "$(eval_gettext "fatal: \$program_n=
ame cannot be used without a working tree.")"
    git-sh-setup.sh:                        gettextln "Cannot rewrite branc=
hes: You have unstaged changes." >&2
    git-sh-setup.sh:                        eval_gettextln "Cannot \$action=
: You have unstaged changes." >&2
    git-sh-setup.sh:                        eval_gettextln "Cannot \$action=
: Your index contains uncommitted changes." >&2
    git-sh-setup.sh:                    gettextln "Additionally, your index=
 contains uncommitted changes." >&2
    git-sh-setup.sh:                        gettextln "You need to run this=
 command from the toplevel of the working tree." >&2
    git-sh-setup.sh:                gettextln "Unable to determine absolute=
 path of git directory" >&2
    git-submodule.sh:                       die "fatal: $(eval_gettext "Una=
ble to find current revision in submodule path '\$displaypath'")"
    git-submodule.sh:                               die "fatal: $(eval_gett=
ext "Unable to fetch in submodule path '\$sm_path'")"
    git-submodule.sh:                       die "fatal: $(eval_gettext "Una=
ble to find current \${remote_name}/\${branch} revision in submodule path '=
\$sm_path'")"
    git-submodule.sh:                               die_msg=3D"fatal: $(eva=
l_gettext "Failed to recurse into submodule path '\$displaypath'")"

I.e. if we were able to get rid of that we could remove
sh-i18n--envsubst.c and git-sh-i18n.sh itself.

Some of that is dead code, others have pending *.sh->C rewrites. For the
rest we could expose a trivial git-i18n.c helper to emit the <10
messages that remained pending further rewrites, which would be much
simpler than extending the generic libintl functionality to *.sh.

But since git-sh-i18n.sh latter is publicly documented as plumbing
(which I'm responsible for, merely by copy/pasting an existing template)
I stalled on that. Since you seemed to suggest in the linked-to thread
that removing any such publicly documented shellscripting functions was
a no-go, even if we'd previously removed git-parse-remote.sh.
