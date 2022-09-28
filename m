Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DC0C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 15:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiI1PHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiI1PHd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 11:07:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD59AFAF7
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:06:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l14so27762182eja.7
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=iF9tE+as3PkoKDUo36YJQvJHHutcHnGp8L4Fhrud6As=;
        b=qaSn5+HVAN8R4NJm/Z5oRkRgliLsE/M2FJ1MinJmc/6UD+CP0J8wclYwT2GIXSUxt3
         OH3dY/prryMbmp2XPGasrX01uc1PerXzAqszUni+AaPveuYmj6+IqGLHUzPcD/BhKwxT
         DluZuHUP/6fasq1yHZ53KMbWlpttouPyoGfeuIh3eNKivnh3RgosQm8r8kXWE/xFTwnX
         F4jh8fmFdLhmnM6kJSEz4avX1bXCBJqipBzUOESgM6KuJdZmjwAkgBF+nIe0xjM/3caZ
         kf9kMlLX7bV5+XURLa6kqJXTb15WCDyXOP0+nyKX93Qd5cSBPRFco+LPkRHNLkinnPeW
         9Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=iF9tE+as3PkoKDUo36YJQvJHHutcHnGp8L4Fhrud6As=;
        b=lgjkMgFvRrRqna1b/KeB1IWr2coYdJjO9q0n80awM372pHcJWg1Oxava7GKkir5Aab
         p2GUWK6FlqulfSm/Ua7NPRMENH4srO9CGL13E+dIrcuTlEMYp0tr8Ri3AcsJWOKh9DXt
         hyrnzTQ9ciVt1FB7CP/dpmOKKbtk+sv/VGtoeAgngGbTaaImjvcQpJX3ZdEajBcGh2yk
         0hvyEersxDQTSzsusp++Ycj/rH74xzavEOcIVPDDuFuGu61BkIZxbjNGs+8we2FmW4B3
         sal6jdWsSke0KLXuWiN/77ASBzgQ5kcz0V5TbglA0m3hxQDDEmGLUP29rpgSSKeqZzis
         kujw==
X-Gm-Message-State: ACrzQf3Hp46B7EEg0onihFw+t35nFsaQntPjHk4CZY0P4jKdlwm++EcA
        tyffaBNGmnmevW+On3RF6P6ns9OJEFEWTg==
X-Google-Smtp-Source: AMsMyM6alAFIr/a539svJvVvuLhvX0+QsU29UZfi27tvOYHf9B5f6hMhm6ehiTP0FlwcFWRbciaiUg==
X-Received: by 2002:a17:906:8441:b0:779:33be:68c9 with SMTP id e1-20020a170906844100b0077933be68c9mr28810645ejy.720.1664377606519;
        Wed, 28 Sep 2022 08:06:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906540900b0073d7b876621sm2503733ejo.205.2022.09.28.08.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:06:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odYe4-0010fx-2q;
        Wed, 28 Sep 2022 17:06:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] config: return an empty list, not NULL
Date:   Wed, 28 Sep 2022 16:37:55 +0200
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
        <396343ce7dd17f86bbbc66197c6f0b4012caf445.1664287711.git.gitgitgadget@gmail.com>
        <220927.86sfkcyebf.gmgdl@evledraar.gmail.com>
        <b85d8a43-6640-aa9c-3103-0c3d43c2a479@github.com>
        <220927.86k05oy5oi.gmgdl@evledraar.gmail.com>
        <26b3c9ef-5dd7-18f2-89c4-8d210a409ce4@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <26b3c9ef-5dd7-18f2-89c4-8d210a409ce4@github.com>
Message-ID: <220928.86y1u3wnaz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 28 2022, Derrick Stolee wrote:

> On 9/27/22 3:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Sep 27 2022, Derrick Stolee wrote:
>>=20
>>> On 9/27/2022 12:21 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>> On Tue, Sep 27 2022, Derrick Stolee via GitGitGadget wrote:
>>>
>>>>>  /**
>>>>>   * Finds and returns the value list, sorted in order of increasing p=
riority
>>>>>   * for the configuration variable `key`. When the configuration vari=
able
>>>>> - * `key` is not found, returns NULL. The caller should not free or m=
odify
>>>>> - * the returned pointer, as it is owned by the cache.
>>>>> + * `key` is not found, returns an empty list. The caller should not =
free or
>>>>> + * modify the returned pointer, as it is owned by the cache.
>>>>>   */
>>>>>  const struct string_list *git_config_get_value_multi(const char *key=
);
>>>>
>>>> Aside from the "DWIM API" aspect of this (which I don't mind) I think
>>>> this is really taking the low-level function in the wrong direction, a=
nd
>>>> that we should just add a new simple wrapper instead.
>>>>
>>>> I.e. both the pre-image API docs & this series gloss over the fact that
>>>> we'd not just return NULL here if the config wasn't there, but also if
>>>> git_config_parse_key() failed.
>>>>
>>>> So it seems to me that a better direction would be starting with
>>>> something like the WIP below (which doesn't compile the whole code, I
>>>> stopped at config.[ch] and pack-bitmap.c). I.e. the same "int" return
>>>> and "dest" pattern that most other things in the config API have.
>>>
>>> Do you have an example where a caller would benefit from this
>>> distinction? Without such an example, I don't think it is worth
>>> creating such a huge change for purity's sake alone.
>>=20
>> Not initially, I started poking at this because the CL/series/commits
>> says that we don't care about the case of non-existing keys, without
>> being clear as to why we want to conflate that with other errors we
>> might get from this API.
>>=20
>> But after some digging I found:
>>=20
>> 	$ for k in a a.b. "'x.y"; do ./git for-each-repo --config=3D$k;  echo $=
?; done
>> 	error: key does not contain a section: a
>> 	0
>> 	error: key does not contain variable name: a.b.
>> 	0
>> 	error: invalid key: 'x.y
>> 	0
>>=20=09
>> I.e. the repo_config_get_value_multi() you added in for-each-repo
>> doesn't distinguish between bad keys and non-existing keys, and returns
>> 0 even though it printed an "error".
>
> I can understand wanting to inform the user that they provided an
> invalid key using a nonzero exit code. I can also understand that
> the command does what is asked: it did nothing because the given
> key has no values (because it can't). I think the use of an "error"
> message balances things towards wanting a nonzero exit code.

Right, to be clear I think 6c62f015520 (for-each-repo: do nothing on
empty config, 2021-01-08) is sensible, i.e. we want to return 0 on a
non-existing key.

We just shouldn't conflate that with e.g. these parse errors, which the
API squashing the underlying negative return values and the "NULL list"
imposes on the user.

>>> I'm pretty happy that the diff for this series is an overall
>>> reduction in code, while also not being too large in the interim:
>>>
>>>  12 files changed, 39 insertions(+), 57 deletions(-)
>>>
>>> If all callers that use the *_multi() methods would only use the
>>> wrapper, then what is the point of doing the low-level manipulations?
>>=20
>> I hacked up something that's at least RFC-quality based on this
>> approach, but CI is running etc., so not submitting it
>> now:
>>=20
>> 	https://github.com/git/git/compare/master...avar:git:avar/have-git_conf=
igset_get_value-use-dest-and-int-pattern
>>=20
>> I think the resulting diff is more idiomatic API use, i.e. you ended up
>> with:
>>=20
>> 	        /* submodule.active is set */
>> 	        sl =3D repo_config_get_value_multi(repo, "submodule.active");
>> 	-       if (sl) {
>> 	+       if (sl && sl->nr) {
>
> You're right that I forgot to change this one to "if (sl->nr)"
> in patch 5.

If I am I didn't mean to point that out, I ws just pointing out the
end-API use. I.e. int return value v.s. the "populate dest" pattern, but
yes, in your end-state you'd drop the "sl &&" part.

>> But I ended up doing:
>>=20
>> 	        /* submodule.active is set */
>> 	-       sl =3D repo_config_get_value_multi(repo, "submodule.active");
>> 	-       if (sl) {
>> 	+       if (!repo_config_get_const_value_multi(repo, "submodule.active"=
, &sl)) {
>>=20
>> Note the "const" in the function name, i.e. there's wrappers that handle
>> the case where we have a hardcoded key name, in which case we can BUG()
>> out if we'd return < 0, so all we have left is just "does key exist".
>
> The problem here is that the block actually cares that the list is non-em=
pty
> and should not run if the list is empty. In that case, you would need to =
add
> "&& sl->nr" to the condition.
>
> I'm of course assuming that an empty list is different from an error. In
> your for-each-repo example, we would not want to return a non-zero exit
> code on an empty list, only on a bad key (or other I/O problem).
>
> If we return a negative value on an error and the number of matches on
> success, then this change could instead be "if (repo_config....() > 0)".

Hrm, I think you're confusing the worldview your series here is
advocating for, and what I'm suggesting as an alternative.

There isn't any way on "master" to have "an empty list", that's a
worldview you're proposing. In particular your 1/5 here removes:

	assert(values->nr > 0);

More generally the config format has no notion of "an empty list", if
you have a valid key-value pair at all you have a list of ".nr >=3D 1".

The "empty list" is a construct you're introducing in this series,
because you wanted the idiom of passing things to
for_each_string_list_item.

I'm advocating for not going that route, and instead make the *_multi()
method like the rest of the config API. I.e. to use the "return int,
populate dest" pattern.

It's fine if we disagree, but I get the sense that it's not clear what
we're disagreeing *on* :)

>> In any case, I'm all for having some simple wrapper for the common cases
> A simple wrapper would be nice, and be exactly the method as it is
> updated in this series. The error-result version could be adopted when
> there is reason to do so.

Well, no :) We ended up with two different "simple wrapper[s]", mine
doesn't have this notion of a "struct string_list *list" with .nr =3D=3D 0.

>> But I didn't find a single case where we actually needed this "never
>> give me a non-NULL list" behavior, it could just be generalized to
>> "let's have the API tell us if the key exist".
>
> Most cases want to feed the result into the for_each_string_list_item()
> macro. Based on the changes in patch 5, I think the empty list is a
> better pattern and leads to prettier code in almost all cases.

I updated the WIP RFC series I linked to upthread a bit since my initial
reply (the link is still good, I force-pushed), I then rebased your
series here on "master", below is a diff of some select files.

The overall diff is much bigger obviously (API changes and all), but the
below demonstrates some of the API changes (yours is "-", mine is
"+"). I've commented inline on some of it:

	diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
	index 635ea5e15fd..16e9a76d04a 100644
	--- a/builtin/for-each-repo.c
	+++ b/builtin/for-each-repo.c
	@@ -29,6 +29,7 @@ int cmd_for_each_repo(int argc, const char **argv, const=
 char *prefix)
	 	static const char *config_key =3D NULL;
	 	int i, result =3D 0;
	 	const struct string_list *values;
	+	int err;
=09=20
	 	const struct option options[] =3D {
	 		OPT_STRING(0, "config", &config_key, N_("config"),
	@@ -42,8 +43,13 @@ int cmd_for_each_repo(int argc, const char **argv, cons=
t char *prefix)
	 	if (!config_key)
	 		die(_("missing --config=3D<config>"));
=09=20
	-	values =3D repo_config_get_value_multi(the_repository,
	-					     config_key);
	+	err =3D repo_config_get_value_multi(the_repository, config_key, &values);
	+	if (err < 0)
	+		usage_msg_optf(_("got bad config --config=3D%s"),
	+			       for_each_repo_usage, options, config_key);
	+	else if (err)
	+		return 0;
	+
	 	for (i =3D 0; !result && i < values->nr; i++)
	 		result =3D run_command_on_repo(values->items[i].string, argc, argv);

Here we're relying an error to the user that we couldn't before, because
repo_config_get_value_multi() would return "NULL" for both "key is bad"
and "key doesn't exist". There's a corresponding test modification
below.

	diff --git a/builtin/gc.c b/builtin/gc.c
	index 1e9ac2ac7e3..94b77a88a99 100644
	--- a/builtin/gc.c
	+++ b/builtin/gc.c
	@@ -1472,9 +1472,7 @@ static int maintenance_register(int argc, const char=
 **argv, const char *prefix)
	 	};
	 	int found =3D 0;
	 	const char *key =3D "maintenance.repo";
	-	char *config_value;
	 	char *maintpath =3D get_maintpath();
	-	struct string_list_item *item;
	 	const struct string_list *list;
=09=20
	 	argc =3D parse_options(argc, argv, prefix, options,
	@@ -1487,18 +1485,11 @@ static int maintenance_register(int argc, const ch=
ar **argv, const char *prefix)
	 	git_config_set("maintenance.auto", "false");
=09=20
	 	/* Set maintenance strategy, if unset */
	-	if (!git_config_get_string("maintenance.strategy", &config_value))
	-		free(config_value);
	-	else
	+	if (git_config_lookup_value("maintenance.strategy"))
	 		git_config_set("maintenance.strategy", "incremental");

In looking at this I thought we were way overdue for a "does this key
exist?" helper, this and a few other API users use it.
=09=20
	-	list =3D git_config_get_value_multi(key);
	-	for_each_string_list_item(item, list) {
	-		if (!strcmp(maintpath, item->string)) {
	-			found =3D 1;
	-			break;
	-		}
	-	}
	+	if (!git_config_get_const_value_multi(key, &list))
	+		found =3D unsorted_string_list_has_string(list, maintpath);

So, it turns out that the initial reason you wanted the "pass NULL to
for_each_string_list_item" is actually something we can do with
unsorted_string_list_has_string(), which implements the same loop.

The difference here is *the* API difference we're discussing. I.e. we'll
never get a NULL "list", we'll instead always get a non-NULL list with
>=3D 1 item if we can get this key at all.

The "const value" helper is a wrapper that handles the "err < 0" case. I
cases where we hardcode the key it's a BUG() if we get "err < 0". The
wrapper is just:

	int err =3D git_configset_get_value_multi(cs, key, dest);
        if (err < 0)
		BUG("failed to parse constant key '%s'!", key);
	return err;

	[...]
	@@ -1547,13 +1537,8 @@ static int maintenance_unregister(int argc, const c=
har **argv, const char *prefi
	 		usage_with_options(builtin_maintenance_unregister_usage,
	 				   options);
=09=20
	-	list =3D git_config_get_value_multi(key);
	-	for_each_string_list_item(item, list) {
	-		if (!strcmp(maintpath, item->string)) {
	-			found =3D 1;
	-			break;
	-		}
	-	}
	+	if (!git_config_get_const_value_multi(key, &list))
	+		found =3D unsorted_string_list_has_string(list, maintpath);

Ditto the same git_config_get_const_value_multi() &
unsorted_string_list_has_string() pattern.
=09=20
	 	if (found) {
	 		int rc;
	diff --git a/builtin/log.c b/builtin/log.c
	index 719ef966045..bdb87f6c42b 100644
	--- a/builtin/log.c
	+++ b/builtin/log.c
	@@ -182,13 +182,15 @@ static void set_default_decoration_filter(struct dec=
oration_filter *decoration_f
	 	int i;
	 	char *value =3D NULL;
	 	struct string_list *include =3D decoration_filter->include_ref_pattern;
	-	struct string_list_item *item;
	-	const struct string_list *config_exclude =3D
	-			git_config_get_value_multi("log.excludeDecoration");
	+	const struct string_list *config_exclude;
=09=20
	-	for_each_string_list_item(item, config_exclude)
	-		string_list_append(decoration_filter->exclude_ref_config_pattern,
	-				   item->string);
	+	if (!git_config_get_const_value_multi("log.excludeDecoration",
	+					      &config_exclude)) {
	+		struct string_list_item *item;
	+		for_each_string_list_item(item, config_exclude)
	+			string_list_append(decoration_filter->exclude_ref_config_pattern,
	+					   item->string);
	+	}

Here's a case where we need to use for_each_string_list_item(), I think
it's nice how we can now scope the "item" variable.

	 	/*
	 	 * By default, decorate_all is disabled. Enable it if
	diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
	index 5a8b6120157..b758255f816 100644
	--- a/builtin/submodule--helper.c
	+++ b/builtin/submodule--helper.c
	@@ -552,7 +552,7 @@ static int module_init(int argc, const char **argv, co=
nst char *prefix)
	 	 * If there are no path args and submodule.active is set then,
	 	 * by default, only initialize 'active' modules.
	 	 */
	-	if (!argc && git_config_get_value_multi("submodule.active")->nr)
	+	if (!argc && !git_config_lookup_value("submodule.active"))
	 		module_list_active(&list);

You changed these in your 2/5, but they really just wanted the new "does
this key exist?" API. No need to construct the string_list just to throw
it away...
=09=20
	 	info.prefix =3D prefix;
	@@ -2720,7 +2720,7 @@ static int module_update(int argc, const char **argv=
, const char *prefix)
	 		 * If there are no path args and submodule.active is set then,
	 		 * by default, only initialize 'active' modules.
	 		 */
	-		if (!argc && git_config_get_value_multi("submodule.active")->nr)
	+		if (!argc && !git_config_lookup_value("submodule.active"))
	 			module_list_active(&list);

Ditto.
=09=20
	 		info.prefix =3D opt.prefix;
	@@ -3164,7 +3164,6 @@ static int config_submodule_in_gitmodules(const char=
 *name, const char *var, con
	 static void configure_added_submodule(struct add_data *add_data)
	 {
	 	char *key;
	-	const char *val;
	 	struct child_process add_submod =3D CHILD_PROCESS_INIT;
	 	struct child_process add_gitmodules =3D CHILD_PROCESS_INIT;
=09=20
	@@ -3209,7 +3208,7 @@ static void configure_added_submodule(struct add_dat=
a *add_data)
	 	 * is_submodule_active(), since that function needs to find
	 	 * out the value of "submodule.active" again anyway.
	 	 */
	-	if (!git_config_get_string_tmp("submodule.active", &val)) {
	+	if (!git_config_lookup_value("submodule.active")) {
	 		/*
	 		 * If the submodule being added isn't already covered by the
	 		 * current configured pathspec, set the submodule's active flag

Ditto.

	diff --git a/submodule.c b/submodule.c
	index 06230961c80..4474cf9ed2d 100644
	--- a/submodule.c
	+++ b/submodule.c
	@@ -274,8 +274,7 @@ int is_tree_submodule_active(struct repository *repo,
	 	free(key);
=09=20
	 	/* submodule.active is set */
	-	sl =3D repo_config_get_value_multi(repo, "submodule.active");
	-	if (sl && sl->nr) {
	+	if (!repo_config_get_const_value_multi(repo, "submodule.active", &sl)) {
	 		struct pathspec ps;
	 		struct strvec args =3D STRVEC_INIT;
	 		const struct string_list_item *item;

Another "*the* API difference we're discussing". I.e. sure, your end
state would be "if (sl->nr)", but if we make it return "int"...

	diff --git a/t/helper/test-config.c b/t/helper/test-config.c
	index 90810946783..432ad047537 100644
	--- a/t/helper/test-config.c
	+++ b/t/helper/test-config.c
	@@ -95,8 +95,7 @@ int cmd__config(int argc, const char **argv)
	 			goto exit1;
	 		}
	 	} else if (argc =3D=3D 3 && !strcmp(argv[1], "get_value_multi")) {
	-		strptr =3D git_config_get_value_multi(argv[2]);
	-		if (strptr->nr) {
	+		if (!git_config_get_const_value_multi(argv[2], &strptr)) {
	 			for (i =3D 0; i < strptr->nr; i++) {
	 				v =3D strptr->items[i].string;
	 				if (!v)

Ditto, (this one converts away from your preferred API use).

	@@ -159,8 +158,7 @@ int cmd__config(int argc, const char **argv)
	 				goto exit2;
	 			}
	 		}
	-		strptr =3D git_configset_get_value_multi(&cs, argv[2]);
	-		if (strptr && strptr->nr) {
	+		if (!git_configset_get_const_value_multi(&cs, argv[2], &strptr)) {
	 			for (i =3D 0; i < strptr->nr; i++) {
	 				v =3D strptr->items[i].string;
	 				if (!v)

Ditto, sans that you'd presumably want s/strptr && // here.

	diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
	index 4675e852517..115221c9ca5 100755
	--- a/t/t0068-for-each-repo.sh
	+++ b/t/t0068-for-each-repo.sh
	@@ -33,4 +33,10 @@ test_expect_success 'do nothing on empty config' '
	 	git for-each-repo --config=3Dbogus.config -- help --no-such-option
	 '
=09=20
	+test_expect_success 'error on bad config keys' '
	+	test_expect_code 129 git for-each-repo --config=3Da &&
	+	test_expect_code 129 git for-each-repo --config=3Da.b. &&
	+	test_expect_code 129 git for-each-repo --config=3D"'\''.b"
	+'
	+
	 test_done

A test showing behavior change we can implement now that we don't sweep
the "err < 0" under the rug.

That branch also grew to have some other changes we may or may not want,
one thing was to convert the various *_get_*() functionts that now
normalize the non-zero return value with e.g.:

	 int git_configset_get_int(struct config_set *cs, const char *key, int *de=
st)
	 {
	        const char *value;
	-       if (!git_configset_get_value(cs, key, &value)) {
	-               *dest =3D git_config_int(key, value);
	-               return 0;
	-       } else
	-               return 1;
	+       int err;
	+
	+       if ((err =3D git_configset_get_value(cs, key, &value)))
	+               return err;
	+       *dest =3D git_config_int(key, value);
	+       return 0;
	 }

No caller currently cares about it, but I think it makes sense generally
not to throw away errors if we can (whether that part is worth the churn
is another topic).

Anyway, the reason I started looking at this RFC to begin with was
because this *_multi() part of the config API has often seemed odd to
me, i.e. I wondered why we couldn't just have it use the "return int,
populate dest" pattern. I'd just never tried to see if I could get that
to work.

It's a bit of one-off churn to get to this point, but I think the end
result of having all the API functions act the same way to signal key
existence v.s. validity is worth it.
