Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3615CC35E01
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058962467D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zrr1Tzxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgBYRkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:40:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56196 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbgBYRke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 12:40:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8633E59359;
        Tue, 25 Feb 2020 12:40:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UsLVUY8bueyTY/npMn7PCWLqUHE=; b=Zrr1Tz
        xbG6SHBtiJsMf0ezabIU0l+R2hvpSbLmDWV0KlPJobkDxiXBvart87m4xAkpWTUT
        q9EGYlXZYO36rl4mLqmPdB4BTTE7RJF77L9yhbTznJ2ihHnEdpCzD/80GekS5AL2
        00QgP5Nh0DcShQzV76tZgjzlbY64Jmqbe+FhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ClAyzyWawFI+EUNC6sF6i5qDdRtv2tAM
        aE+NM58oOrMcUK9xdSFIiVP+CCtUxct+uzur6RQ7+LhJctsUVRO9wTW0/JuyXZPU
        7j3bwOFJKqojBklTmQtCaLSmjsktuZZoLsdarIRK+ySHB/+Gc1CKV9Icbk3QJBF5
        yezezRKG308=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CADA59358;
        Tue, 25 Feb 2020 12:40:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7DAE59357;
        Tue, 25 Feb 2020 12:40:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Feb 2020 09:40:28 -0800
In-Reply-To: <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Tue, 25 Feb 2020 10:55:39
        +0000")
Message-ID: <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA60D096-57F5-11EA-87E5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Heba Waly <heba.waly@gmail.com>
>
> Currently it's very easy for the advice library's callers to miss
> checking the visibility step before printing an advice. Also, it makes
> more sense for this step to be handled by the advice library.
>
> Add a new advise_if_enabled function that checks the visibility of
> advice messages before printing.
>
> Add a new helper advise_enabled to check the visibility of the advice
> if the caller needs to carry out complicated processing based on that
> value.
>
> A list of config variables 'advice_config_keys' is added to be used by
> list_config_advices() instead of 'advice_config[]' because we'll get
> rid of 'advice_config[]' and the global variables once we migrate all
> the callers to use the new APIs.
>


> Also change the advise call in tag library from advise() to
> advise_if_enabled() to construct an example of the usage of the new
> API.

This is for step [3/3], isn't it?  I'll discard this paragraph.

>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  Makefile               |  1 +
>  advice.c               | 86 ++++++++++++++++++++++++++++++++++++++++--
>  advice.h               | 52 +++++++++++++++++++++++++
>  t/helper/test-advise.c | 19 ++++++++++
>  t/helper/test-tool.c   |  1 +
>  t/helper/test-tool.h   |  1 +
>  t/t0018-advice.sh      | 32 ++++++++++++++++
>  7 files changed, 188 insertions(+), 4 deletions(-)
>  create mode 100644 t/helper/test-advise.c
>  create mode 100755 t/t0018-advice.sh
>
> diff --git a/Makefile b/Makefile
> index 09f98b777ca..ed923a3e818 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -695,6 +695,7 @@ X =
>  
>  PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
>  
> +TEST_BUILTINS_OBJS += test-advise.o
>  TEST_BUILTINS_OBJS += test-chmtime.o
>  TEST_BUILTINS_OBJS += test-config.o
>  TEST_BUILTINS_OBJS += test-ctype.o
> diff --git a/advice.c b/advice.c
> index fd836332dad..5c2068b8f8a 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -96,13 +96,56 @@ static struct {
>  	{ "pushNonFastForward", &advice_push_update_rejected }
>  };
>  
> -static void vadvise(const char *advice, va_list params)
> +static const char *advice_config_keys[] = {
> +	[ADD_EMBEDDED_REPO]			 = "addEmbeddedRepo",
> +	[AMWORKDIR]				 = "amWorkDir",
> +	[CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]	 = "checkoutAmbiguousRemoteBranchName",
> +	[COMMIT_BEFORE_MERGE]			 = "commitBeforeMerge",
> +	[DETACHED_HEAD]				 = "detachedHead",
> +	[FETCH_SHOW_FORCED_UPDATES]		 = "fetchShowForcedUpdates",
> +	[GRAFT_FILE_DEPRECATED]			 = "graftFileDeprecated",
> +	[IGNORED_HOOK]				 = "ignoredHook",
> +	[IMPLICIT_IDENTITY]			 = "implicitIdentity",
> +	[NESTED_TAG]				 = "nestedTag",
> +	[OBJECT_NAME_WARNING]			 = "objectNameWarning",
> +	[PUSH_ALREADY_EXISTS]			 = "pushAlreadyExists",
> +	[PUSH_FETCH_FIRST]			 = "pushFetchFirst",
> +	[PUSH_NEEDS_FORCE]			 = "pushNeedsForce",
> +
> +	/* make this an alias for backward compatibility */
> +	[PUSH_UPDATE_REJECTED_ALIAS]		 = "pushNonFastForward",
> +
> +	[PUSH_NON_FF_CURRENT]			 = "pushNonFFCurrent",
> +	[PUSH_NON_FF_MATCHING]			 = "pushNonFFMatching",
> +	[PUSH_UNQUALIFIED_REF_NAME]		 = "pushUnqualifiedRefName",
> +	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
> +	[RESET_QUIET_WARNING]			 = "resetQuiet",
> +	[RESOLVE_CONFLICT]			 = "resolveConflict",
> +	[RM_HINTS]				 = "rmHints",
> +	[SEQUENCER_IN_USE]			 = "sequencerInUse",
> +	[SET_UPSTREAM_FAILURE]			 = "setupStreamFailure",
> +	[STATUS_AHEAD_BEHIND_WARNING]		 = "statusAheadBehindWarning",
> +	[STATUS_HINTS]				 = "statusHints",
> +	[STATUS_U_OPTION]			 = "statusUoption",
> +	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie",
> +	[WAITING_FOR_EDITOR] 			 = "waitingForEditor",
> +};
> +
> +static const char turn_off_instructions[] =
> +N_("\n"
> +   "Disable this message with \"git config %s false\"");
> +
> +static void vadvise(const char *advice, int display_instructions,
> +		    char *key, va_list params)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	const char *cp, *np;
>  
>  	strbuf_vaddf(&buf, advice, params);
>  
> +	if (display_instructions)
> +		strbuf_addf(&buf, turn_off_instructions, key);
> +
>  	for (cp = buf.buf; *cp; cp = np) {
>  		np = strchrnul(cp, '\n');
>  		fprintf(stderr,	_("%shint: %.*s%s\n"),
> @@ -119,8 +162,43 @@ void advise(const char *advice, ...)
>  {
>  	va_list params;
>  	va_start(params, advice);
> -	vadvise(advice, params);
> +	vadvise(advice, 0, "", params);
> +	va_end(params);
> +}
> +
> +static int get_config_value(enum advice_type type)
> +{
> +	int value = 1;
> +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> +
> +	git_config_get_bool(key, &value);
> +	free(key);
> +	return value;
> +}

So, in this hypothetical but quite realistic example:

	if (advice_enabled(ADVICE_FOO)) {
		char *foo = expensive_preparation();
		advice_if_enabled(ADVICE_FOO, "use of %s is discouraged", foo);
	}

we end up formulating the "advice.*" key twice and ask git_config_get_bool()
about the same key twice?

> +int advice_enabled(enum advice_type type)
> +{
> +	switch (type) {
> +	case PUSH_UPDATE_REJECTED:
> +		return get_config_value(PUSH_UPDATE_REJECTED) &&
> +		       get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
> +	default:
> +		return get_config_value(type);
> +	}
> +}

Also, as "enum advice_type" will be part of the public API, and
there is little type checking for enums, we shouldn't be naming them
randomly like these---we'd at least want to use a common prefix,
like "ADVICE_", in front of them.  Those who are focused only on
advice subsystem may feel that names like PUSH_UPDATE_REJECTED are
sufficiently clear, but within the context of the whole system,
there is no cue that these UPCASED_WORDS identifiers belong to the
advice subsystem or somewhere else.

> +void advise_if_enabled(enum advice_type type, const char *advice, ...)
> +{
> +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> +	va_list params;
> +
> +	if (!advice_enabled(type))
> +		return;

Oh, no, make the number of calls to xstrfmr() three times, not
twice, as I said in the previous example.

I wonder if it would make the implementation better to do these:

 - Rename advice_config_keys[] to advice_setting[] that does not
   imply it is only about the keys;

 - This table will know, for each enum advice_type, which
   configuration variable enables it, *and* if it is enabled.

i.e.

        static struct {
                const char *config_key;
                int disabled;
        } advice_setting[] = {
                [ADVICE_ADD_EMBEDED_REPO] = { "addEmbeddedRepo" },
                [ADVICE_AM_WORK_DIR]      = { "amWorkDir" },
                ...
                [ADVICE_WAITING_FOR_EDITOR] = { "waitingForEditor" },
        };


Side Note: you have AMWORKDIR that is unreadable.  If the config
           name uses camelCase by convention, the UPCASED_WORDS
           should be separated with underscore at the same word
           boundary.

Then, upon the first call to advice_enabled(), call git_config()
with a callback like

	static int populate_advice_settings(const char *var, const char *value, void *cb)
	{
		int advice_type;
		const char *name;

		if (!skip_prefix(var, "advice.", &name))
			return 0;
		advice_type = find_advice_type_by_name(advice_setting, name);
		if (advice_type < 0)
			return 0; /* unknown advice.* variable */
		/* advice.foo=false means advice.foo is disabled */
		advice_setting[advice_type].disabled = !git_config_bool(var, value);
	}

only once.  Your get_config_value() would then become a mere lookup
in advice_setting[] array, e.g.

	int advice_enabled(unsigned advice_type)
	{
		static int initialized;

		if (!initialized) {
			initialized = 1;
			git_config(populate_advice_settings, NULL);
		}
		if (ARRAY_SIZE(advice_setting) <= advice_type)
			BUG("OOB advice type requested???");
		return !advice_setting[advice_type].disabled;
	}

with your "push-update-rejected has two names" twist added.

Hmm?
