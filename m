Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3CEC433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 12:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiC0Mzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 08:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiC0Mzc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 08:55:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460CD4FC4B
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 05:53:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so23563286ejc.7
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NbHnJdVKQDYKnV5EDchwiE+axF6UljqRy6i8OweEikc=;
        b=mNb2ztFR/skF0MXyv+9NEu0NFV3Zk7LFFis3DIiTA70fugS3Fj1zwIXTPsRKCN0u06
         3rkuH3tzxCfZKjxAE4bayQJPlbvrY2odWC3yrlKrs9tWSxP0Ev4zHxRv2DKlbr2u0SAN
         rZf/dQoermhlizlsNptVVOCHamEA8BWgdT4ZmoBgQuZjDoBTJjNWziNUColvsnLo37Jq
         DdDe8vRKph6XxficmWo6yknBTBYQ7wL8cswfXUxMsjXFAQSdVt59ebzQ4POT5l8Fef0H
         ygUj66wjj7AzEVl7XiwLVO7WuQQSaaqT/uq2D5KpZ7XE9Bsy5SaYjYTvLOyU1oAk3WrJ
         YVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NbHnJdVKQDYKnV5EDchwiE+axF6UljqRy6i8OweEikc=;
        b=PqVHEUPLlSsIeLS7El4xUFy1KzowpqelVRIc4ACVXyarsNVetcXxp8hbh18/xnkYlt
         r6tVwdDZAl+gXPxZ8wyZzUIUMqK5ZTtrMDGyoGApKs9XCJfDh01wHdjnkL8CLcBpQeS6
         ubYpBfzeIlzu0YiUVIou2OAOGNndT4mkHheyJO0/ffiQBK8fLUEVZKCNXi66B8fAl+VJ
         mfPilEbxlKCf0RqbtWeb39T0HB8RZ/EnGKhY1/Hx5r88QI7Zi6XBIJm57GWOjUPCu9+c
         obPhsD/V32qeo19rHlm9d+rA6IdnCCVzdUrzaZP0kVVHRp5Dc5iznHtJlNhJ5RDFxufw
         Pqug==
X-Gm-Message-State: AOAM530IJlIyZ2/XhLvup0M2cMiLZ501wIAaUVAGeFPkjpBj9XBRl54i
        OYG+3bwhK50biLnrvP43BRI=
X-Google-Smtp-Source: ABdhPJzJc+xw0F7ozVyI1luj0PXZhdUKHS3ssE06CVsFzpmSvMRV6GoRGuqg7KKcG4CSQs+2fy5vtw==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id k11-20020a17090666cb00b006cfe4f79504mr22319513ejp.142.1648385630313;
        Sun, 27 Mar 2022 05:53:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe4d1edc6sm4625336ejc.61.2022.03.27.05.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 05:53:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nYSOz-002nn1-2t;
        Sun, 27 Mar 2022 14:53:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: do we have too much fsync() configuration in 'next'? (was:
 [PATCH v7] core.fsync: documentation and user-friendly aggregate options)
Date:   Sun, 27 Mar 2022 14:43:48 +0200
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
 <20220315191245.17990-1-neerajsi@microsoft.com>
 <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
 <CANQDOdeeP8opTQj-j_j3=KnU99nYTnNYhyQmAojj=FZtZEkCZQ@mail.gmail.com>
 <220326.86ils1lfho.gmgdl@evledraar.gmail.com>
 <CANQDOdeduc8bFA_=R-kXmkM+nb__oTxVhjBfFYj70vCFew1EyA@mail.gmail.com>
 <220326.86sfr4k9rm.gmgdl@evledraar.gmail.com>
 <CANQDOdfWh5aO9cuJVuUccKyD9Cj+NndisokiewBH9Sq4oSUp5A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <CANQDOdfWh5aO9cuJVuUccKyD9Cj+NndisokiewBH9Sq4oSUp5A@mail.gmail.com>
Message-ID: <220327.86y20veeua.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 26 2022, Neeraj Singh wrote:

> On Sat, Mar 26, 2022 at 8:34 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Fri, Mar 25 2022, Neeraj Singh wrote:
>>
>> > On Fri, Mar 25, 2022 at 5:33 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
[...]
>> > I want to make a comment about the Index here.  Syncing the index is
>> > strictly required for the "added" level of consistency, so that we
>> > don't lose stuff that leaves the work tree but is staged.  But my
>> > Windows enlistment has an index that's 266MB, which would be painful
>> > to sync even with all the optimizations.  Maybe with split-index, this
>> > wouldn't be so bad, but I just wanted to call out that some advanced
>> > users may really care about the configurability.
>>
>> So for that use-case you'd like to fsync the loose objects (if any), but
>> not the index? So the FS will "flush" up to the index, and then queue
>> the index for later syncing to platter?
>>
>>
>> But even in that case don't the settings need to be tied to one another,
>> because in the method=3Dbulk sync=3Dindex && sync=3D!loose case wouldn't=
 we be
>> syncing "loose" in any case?
>>
>> > As Git's various database implementations improve, the fsync stuff
>> > will hopefully be more optimal and self-tuning.  But as that happens,
>> > Git could just start ignoring settings that lose meaning without tying
>> > anyones hands.
>>
>> Yeah that would alleviate most of my concerns here, but the docs aren't
>> saying anything like that. Since you added them & they just landed, do
>> you mind doing a small follow-up where we e.g. say that these new
>> settings are "EXPERIMENTAL" or whatever, and subject to drastic change?
>
> The doc is already pretty prescriptive.  It has this line at the end
> of the first  paragraph:
> "Unless you
> have special requirements, it is recommended that you leave
> this option empty or pick one of `committed`, `added`,
> or `all`."
>
> Those values are already designed to change as Git changes.

I'm referring to the documentation as it stands not being marked as
experimental in the sense that we might decide to re-do this to a large
extent, i.e. something like the diff I suggested upthread in
https://lore.kernel.org/git/220323.86fsn8ohg8.gmgdl@evledraar.gmail.com/

So yes, I agree that it e.g. clearly states that you can add a new
core.git=3Dfoobar or whatever down the line, but it clearly doesn't
suggest that e.g. core.fsync might have boolean semantics in some later
version, or that the rest might simply be ignored, even if that
e.g. means that we wouldn't sync loose objects on
core.fsync=3Dloose-object, as we'd just warn with a "we don't provide this
anymore".

Or do you disagree with that? IOW I mean that we'd do something like
this, either in docs or code:

diff --git a/config.c b/config.c
index 3c9b6b589ab..94548566073 100644
--- a/config.c
+++ b/config.c
@@ -1675,6 +1675,9 @@ static int git_default_core_config(const char *var, c=
onst char *value, void *cb)
 	}
=20
 	if (!strcmp(var, "core.fsync")) {
+		if (!the_repository->settings.feature_experimental)
+			warning(_("the '%s' configuration option is EXPERIMENTAL. opt-in to use=
 it with feature.experimental=3Dtrue"),
+				var);
 		if (!value)
 			return config_error_nonbool(var);
 		fsync_components =3D parse_fsync_components(var, value);
@@ -1682,6 +1685,9 @@ static int git_default_core_config(const char *var, c=
onst char *value, void *cb)
 	}
=20
 	if (!strcmp(var, "core.fsyncmethod")) {
+		if (!the_repository->settings.feature_experimental)
+			warning(_("the '%s' configuration option is EXPERIMENTAL. opt-in to use=
 it with feature.experimental=3Dtrue"),
+				var);
 		if (!value)
 			return config_error_nonbool(var);
 		if (!strcmp(value, "fsync"))
diff --git a/repo-settings.c b/repo-settings.c
index b4fbd16cdcc..f949b65b91e 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -31,6 +31,7 @@ void prepare_repo_settings(struct repository *r)
 	/* Booleans config or default, cascades to other settings */
 	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
 	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
+	r->settings.feature_experimental =3D experimental;
=20
 	/* Defaults modified by feature.* */
 	if (experimental) {
diff --git a/repository.h b/repository.h
index e29f361703d..db8f99a8989 100644
--- a/repository.h
+++ b/repository.h
@@ -28,6 +28,7 @@ enum fetch_negotiation_setting {
 struct repo_settings {
 	int initialized;
=20
+	int feature_experimental;
 	int core_commit_graph;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
