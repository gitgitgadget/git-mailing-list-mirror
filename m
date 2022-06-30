Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B4EC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiF3Xd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiF3Xd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:33:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECE657279
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:33:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n8so919808eda.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FdTGbyg73EE9u5xA8OQusLd7OyHNMZU9TLYCT+MOu+I=;
        b=cSuTclcY9IAsnYmI26CicUVLa3oovUcpMljCA06S2DOQR44FG6DAzSP6WRx7PzLxsh
         kqXZpEj3I1j03QNDCzAUc+w98LfIlCnlPJymv8EDgkCsZ55dNqfuLFFGqu5nXF7AOtNf
         KpvU6nYZXLpmSoJABOGvWLg1uvf8Wnx8hnj7pcUO0PFcBb/IUh+Ia5U/KKeTz1Q2ziJt
         BUEgtybn9Bs7yRp6Z92LYn7pubJ4/QKFQbJbHgkFbOqO/GqZ16CgyAcaR6kt5IhbJQnq
         ZILFIwZOQBegW9+UGsGfr6/skLm4JavnS2GCv94PmYyTgwR54beVbcvNdzdX4lZ25bJk
         k5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FdTGbyg73EE9u5xA8OQusLd7OyHNMZU9TLYCT+MOu+I=;
        b=GZhIbdLSsOvBIdddttQm/xMaFE5D3VKJHoVvmb89EMWisZyy9CN7PNWBrd8M0aXgEz
         Kcj3dJHGjWyowKWMXsVykgDzTvswHOc2EG6x0YQKAxT8tI5qYbiPn4ai1jNpCUuOfeYj
         f/7tVzOqc5i0xPSz+sx1eNsJ7TyPiUlVO6jaeoj6qrqIhHXO1cbXLHapx3RiRSfuxVHh
         tWmKUm8gT4vbcKxeHVY5tqbP2+C8IWhO2j39u3pvsB/dAuhTw0fMUDqMTPRquBm/JwjS
         m0RvGPIi473xfqzI27YbUYjTl/j4wKXEkMDku8LMdBR+TTfiZNxLoio39n3pS7nY4N+H
         QL2g==
X-Gm-Message-State: AJIora+6xBtm36zSj+9HJ7rjdgsepRT/Azj/sv2s/fBLDFJrV6N28m3d
        DvTcsO+5JAuV4Z3L4btCzcY=
X-Google-Smtp-Source: AGRyM1tdUSJkvA8V9cuISKj7UpMkI2V4HbG7KkRggCXbZa9BTpQPOjlCy6+P6FL9VpbWkDYWGpcEpw==
X-Received: by 2002:a05:6402:4252:b0:437:6618:1738 with SMTP id g18-20020a056402425200b0043766181738mr14923375edb.259.1656632029842;
        Thu, 30 Jun 2022 16:33:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7d989000000b004355cb1e77esm13784998eds.91.2022.06.30.16.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:33:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o73fQ-002cOT-2i;
        Fri, 01 Jul 2022 01:33:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v6 0/5] config: introduce discovery.bare and protected
 config
Date:   Fri, 01 Jul 2022 01:07:54 +0200
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
Message-ID: <220701.861qv5d8v7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Glen Choo via GitGitGadget wrote:

> This is a quick re-roll to address =C3=86var's comments on the tests (tha=
nks!).

Thanks!

> =3D Description

Just more generally on this series & approach. I know this is a v6 by
now, but I haven't kept up with this topic, but to be fair I did mention
pretty much this in:
https://lore.kernel.org/git/220407.86lewhc6bz.gmgdl@evledraar.gmail.com/

So...

> There is a known social engineering attack that takes advantage of the fa=
ct
> that a working tree can include an entire bare repository, including a
> config file. A user could run a Git command inside the bare repository
> thinking that the config file of the 'outer' repository would be used, but
> in reality, the bare repository's config file (which is attacker-controll=
ed)
> is used, which may result in arbitrary code execution. See [1] for a full=
er
> description and deeper discussion.
>
> This series implements a simple way of preventing such attacks: create a
> config option, discovery.bare, that tells Git whether or not to die when =
it
> finds a bare repository. discovery.bare has two values:
>
>  * "always": always allow bare repositories (default), identical to curre=
nt
>    behavior
>  * "never": never allow bare repositories
>
> and users/system administrators who never expect to work with bare
> repositories can secure their environments using "never". discovery.bare =
has
> no effect if --git-dir or GIT_DIR is passed because we are confident that
> the user is not confused about which repository is being used.

I'm not insisting that the entire approach here should be changed, but
in the above exchange you seemed to have performance concerns about the
"just walk up in setup.c" approach I mentioned, but it's not clear if
that's still the only thing that necessitates taking this approach.

There may be security subtleties that I've missed, but from the
description here it seems like that would work equally well, and
wouldn't require configuration, except insofar as we'd need to opt-in to
reading config from bare repositores *that also exist in a parent tree*.

And it would be a more narrow & more secure solution, since it would
e.g. allow you to intentionally navigate to /var/repos/git/git.git in a
server setup and read the config there, which it could distinguish from
a case of /var/repos/.git existing, and git/git.git being brought in as
a part of that "parent" repo.

The "more narrow" and "more secure" go hand-in-hand, since if you work
on such servers you'd turn this to "always" because you want to read
such config, but then be left vulnerable to the actual (and muche rarer)
exploit we're trying to prevent.

Which, it seems...

> This series does not change the default behavior, but in the long-run, a
> "no-embedded" option might be a safe and usable default [2]. "never" is t=
oo
> restrictive and unlikely to be the default.

This series has (since v3?) been noting aspirations to have a
"no-embedded" variant of this config, which your 5/5 here notes would be
better, but isn't implemented by this series.

But your 5/5 also notes:

    but detecting if a repository is embedded is potentially
    non-trivial, so this work is not implemented in this series.

Hrm, well, the diff-stat isn't quite that trivial either :) :

> [...]
>  upload-pack.c                       | 27 ++++++----
>  12 files changed, 304 insertions(+), 47 deletions(-)

In threads linked from the above ML link I linked to some POC code
showing how to hack a second .git discovery walk into setup.c. This was
as part of the "submodule parent dir" proposal, which is a different
feature, but also needs such "find the parent" code:
https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.com/

Now, obviously that's a dirty hack, but it's not that hard to just
change the part of setup.c where we're satisfied that we've found the
git dir, then walk up "$THAT_DIR/..", and start our search again.

Then:

	if (first_dir_was_bare() && found_parent_dir())
        	enforce_no_embedded();

Isn't that what your proposed "no embedded" option would need to do?
Well, maybe we'd also check if the "first dir" is in the index of the
parent, as opposed to just being a bare .git somewhere in ~/Downloads,
e.g. if you have a ~/.git and keep your dot-files in git.

But I think for an initial implementation just doing the walk would be
good enough, and would have a more narrow scope than this configuration
setting.

AFAICT the performance concerns aren't supported by any data, in the
case of the "submodule superproject" feature it turned out to not be the
directory walk, but us shelling out in a loop in git-submodule.sh.

Well, *maybe* that's not the case, I think I have managed to read
between the lines of some of these past exchanges that there's some odd
propriterary internal NFS-like setup at Google where *parent dirs* are
auto-mounted and searched on access, so a "walk up" pattern would be
much more expensive.

I do worry a bit about us ending up with design choices in git that we
wouldn't have ended up with, if not to cater to some in-house setup
somwhere that 99.99% of git users will never see.

But I don't have the full picture on the "submodule superproject"
problem, or this one, and maybe I'm missing something. Just food for
thought, and wondering where we're eventually taking this.

Thanks!

