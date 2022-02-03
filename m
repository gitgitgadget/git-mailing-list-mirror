Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A99BC433FE
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 08:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349459AbiBCIQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 03:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiBCIQU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 03:16:20 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ACDC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 00:16:20 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id d10so6042275eje.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 00:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=I5AQNMjVz1XnOPFlSBQ3ux4D5+Ri1g28QaNyqx3i7KY=;
        b=BJSQ7THYeCE6TjrBzsJZ0wp5Y2ti19HcJeTOq5+OGdwIXmo07esB34G+sjaLKQA73O
         QrwHw0ZCMetKv4cPMwFrhBTV1X3Nf6jMYejPvoCsipg7eA/lZg9sB1YHFKVP9aWKm0v/
         Jo2QMSQYGEFFGG2gwUtWgsYRhnx5yIa8malB3/jBfZIhY4rEv1IlfTgSph+lZCzVc6wH
         JNlEEiFEHtnT8Cqi+TMThpgKPK6DbhUOu4JaPy4+zAt+RaOQuc/GUgNOeYTGqpBJ6YBN
         3xMMEMRIL2MNG9YkCDkMYSuvVCU2wPUDUU9VFSOq4PYGnzNKiacGoZiyEsPIgiA48jQI
         a+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=I5AQNMjVz1XnOPFlSBQ3ux4D5+Ri1g28QaNyqx3i7KY=;
        b=7RaHqsBTJucw+K7F/W6msL4hiRhJu4w/4paFV/311CuiiTDKeyYZ4FWXt7XsG/+nII
         UBEFSdP1PY2QRAFFlt2e/KjgWVSh3oNDZf/GqorJbkhZTxf+O/oQCUQSoyTIhv7VFfKQ
         bz1nggXfGTvrqfbOkSYKzil/InygbRs6Gv+InxYlHyDJCBlOQNyKfiF7hftrcsdah7fq
         /xc2WewmqtmoVyNt3PXbnX0K1aHJYaPlHNeoDdAK7Y52TmQM+dRzxF1s8ToobXLm3Air
         e3bHwNdsEuypNgo3QE6Li07f2D1TY3MbT8rlyazDBpLBXwWkNA8HuEgkt1hDDLg9PBc8
         fbOg==
X-Gm-Message-State: AOAM533g6hWcrDhdR+LNCZY5iWsUwE2SE5H9idHeK3yv6qXuxk7YxVlh
        oJrjwi5q3oGGjWQ/aZhjX/pckA/UKoc9xQ==
X-Google-Smtp-Source: ABdhPJxwPwvF2hQkeCft/4nNODbXPQS+66sL4kTvERQo4CvFqDGVbN8gSYjQXBefh/FIHWM074Vjmg==
X-Received: by 2002:a17:907:96aa:: with SMTP id hd42mr28926663ejc.74.1643876178130;
        Thu, 03 Feb 2022 00:16:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p13sm16467231ejx.191.2022.02.03.00.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 00:16:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFXHs-004sg2-OT;
        Thu, 03 Feb 2022 09:16:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: move core cmd_update() logic to C
Date:   Thu, 03 Feb 2022 09:15:19 +0100
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
 <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
 <patch-v5-9.9-e8e57606ee9-20220128T125206Z-avarab@gmail.com>
 <kl6l4k5g246p.fsf@chooglen-macbookpro.roam.corp.google.com>
 <220203.865ypw7jw6.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <220203.865ypw7jw6.gmgdl@evledraar.gmail.com>
Message-ID: <220203.861r0k74bz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Feb 02 2022, Glen Choo wrote:
>
>> - Junio pointed out that this conflicts with
>>   es/superproject-aware-submodules [2]. I'm not sure which should be
>>   based on which. If this does end up being based on
>>   es/superproject-aware-submodules, it would probably be easier to
>>   rebase as a series of smaller patches. Atharva noted that the
>>   conflicts are mild though, so maybe it's not so bad.
>
> I think it makes sense to get this series through first, i.e. the
> (supposedly) no-behavior-changing one, and then one that introduces new
> submodule behavior.
>
> Particularly because for es/superproject-aware-submodules the main
> selling point is a performance improvement, which as I noted in the
> review for it I've been unable to observe once the C<->sh layer goes
> away.
>
> I'm not saying it's not there, just that I don't think it's been shown
> so far, IIRC there was some reference to some Google-internal network FS
> that might or might not be helped by it...
>
>> - Besides making sure that the sh -> c is faithful, a thorough review
>>   should hopefully catch unintentional mistakes. The size of this patch
>>   makes such mistakes difficult to spot. For instance, here's something
>>   I spotted only after trying to split the patch myself..
>>
>>   > +static int module_update(int argc, const char **argv, const char *p=
refix)
>>   > +{
>>   > +	const char *update =3D NULL;
>>   > +	struct pathspec pathspec;
>>   > +	struct update_data opt =3D UPDATE_DATA_INIT;
>>   > +
>>   > +	struct option module_update_clone_options[] =3D {
>>   [...]
>>   > +	};
>>   > +
>>   > +	const char *const git_submodule_helper_usage[] =3D {
>>   > +		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path=
>...]"),
>>   > +		NULL
>>   > +	};
>>   > +
>>   > +	update_clone_config_from_gitmodules(&opt.max_jobs);
>>   > +	git_config(git_update_clone_config, &opt.max_jobs);
>>
>>   Notice that we copy-pasted the option parsing from update-clone into
>>   module_update() but forgot to update the names.
>>
>> My ideal patch organization would be something like:
>>
>> - wrap some existing command in "git submodule--helper update" (probably
>>   run-update-procedure)
>> - absorb the surrounding sh code into "git submodule--helper
>>   update" one command at-a-time i.e. deprecating and removing the
>>   commands one at a time - instead of deprecating and removing them all
>>   at once (like this patch), or deprecating all at once and removing
>>   them one at a time (like v1).
>
> I do think atomic changes that don't leave dead code for removal later
> are easier to read & reason about, whatever else is reorganized.
>
> I.e. not to have something where we replace all the running code, and
> then remove already-unused code later.
>
> On that topic, I noticed this series could/should have [1] fixed up into
> it.
>
>> - If you think this alternative organization would be helpful for you
>>   too, I will attempt it. This will take a while, but by the end you and
>>   I will have effectively reviewed all of the code, so it should be easy
>>   to finish up the review.
>
> I think it might, but I really don't know. We'll just have to see, so if
> you want to take a stab at it that would be great.
>
> Maybe it's a good way forward. E.g. as af first small step we could turn:
>
>     while read -r quickabort sha1 just_cloned sm_path
>     [...]
>     die_if_unmatched "$quickabort" "$sha1"
>
> into version where we fold that die_if_unmatched() logic into the C
> code, and then ensure-core-worktree etc.

Sorry, that one makes no sense since it's an artifact of the shellscript
implementation.

But I tested the below on top of master, and it passes all tests, which
isn't very promising...

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4a0890954e9..e749008f13a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2783,40 +2783,6 @@ static int push_check(int argc, const char **argv, c=
onst char *prefix)
 	return 0;
 }
=20
-static int ensure_core_worktree(int argc, const char **argv, const char *p=
refix)
-{
-	const char *path;
-	const char *cw;
-	struct repository subrepo;
-
-	if (argc !=3D 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path =3D argv[1];
-
-	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
-		die(_("could not get a repository handle for submodule '%s'"), path);
-
-	if (!repo_config_get_string_tmp(&subrepo, "core.worktree", &cw)) {
-		char *cfg_file, *abs_path;
-		const char *rel_path;
-		struct strbuf sb =3D STRBUF_INIT;
-
-		cfg_file =3D repo_git_path(&subrepo, "config");
-
-		abs_path =3D absolute_pathdup(path);
-		rel_path =3D relative_path(abs_path, subrepo.gitdir, &sb);
-
-		git_config_set_in_file(cfg_file, "core.worktree", rel_path);
-
-		free(cfg_file);
-		free(abs_path);
-		strbuf_release(&sb);
-	}
-
-	return 0;
-}
-
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -3391,7 +3357,6 @@ static struct cmd_struct commands[] =3D {
 	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 652861aa66a..460cbd4e265 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -387,8 +387,6 @@ cmd_update()
 	do
 		die_if_unmatched "$quickabort" "$sha1"
=20
-		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
-
 		displaypath=3D$(git submodule--helper relative-path "$prefix$sm_path" "$=
wt_prefix")
=20
 		if test $just_cloned -eq 1
