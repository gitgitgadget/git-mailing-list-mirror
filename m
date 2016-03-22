From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC_PATCHv4 5/7] submodule update: respect submodule.actionOnLabel
Date: Tue, 22 Mar 2016 15:40:03 -0700
Message-ID: <xmqq37rif870.fsf@gitster.mtv.corp.google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens.Lehmann@web.de, sschuberth@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:40:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUyD-000710-K5
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbcCVWkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:40:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752178AbcCVWkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:40:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65D8E4EBE3;
	Tue, 22 Mar 2016 18:40:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w663Ljh1M9L3ZvgzbNuUdYJDcWw=; b=nofJvq
	01mct9e5xn6y0KUCTTiTFAVHahGT5L+nt/jZwtv+f2VXrOsQfMlqO/mXtR3qHo9W
	JPvpGq3uxeU9pfh9lkoZBzXiWmxVDjigeecjjt6lOJTQJQsa+OAVKtlwiIe3ibKG
	imMXE4M7OuG6Is1cqiZUlCO67hy+GOKC5ndGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NobuA9PZKfVf2yUJB1GYeNWWpYaSIItc
	+fomlr2eoltvmtPpxTJBIVuvGW2PSxgy84Y7vhQcX/iHNED+Tst+gIRT4CzE2qpz
	veKTi/G6auBAeAbM6JsttM3/T0QQCPAKmCYftRE0usYs1nUWcKef49FEPqt2ALfC
	x4lEPR0vpuc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58AE54EBE1;
	Tue, 22 Mar 2016 18:40:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 186834EBDF;
	Tue, 22 Mar 2016 18:40:05 -0400 (EDT)
In-Reply-To: <1458612372-10966-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Mar 2016 19:06:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05A8D1BA-F07F-11E5-8AC5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289583>

Stefan Beller <sbeller@google.com> writes:

> This change introduces the 'submodule.actionOnLabel' variable
> in a repository configuration. Generally speaking 'submodule.actionOnLabel'
> restricts the action of a command when no submodules are selected via the
> command line explicitely to those submodules, which are selected by
> 'submodule.actionOnLabel'. It can occur multiple times and can specify
> the path, the name or one of the labels of a submodule to select that
> submodule.
>
> The introduction of 'submodule.actionOnLabel' starts with
> 'git submodule update' in this patch and other commands will follow
> in later patches.
>
> 'submodule.actionOnLabel' implies '--init' in 'git submodule update'.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> TODO: generic documentation for submodule.actionOnLabel
> TODO: documentation for submodule update

TODO: a name that matches the concept better.

So in general

	$ git submodule $subcmd .

may be the way to say "do $subcmd to all submodules", and

	$ git submodule $subcmd

may have been "operate on nothing" (or may have been "operate on
everything"), but with this feature, 

	$ git submodule $subcmd

will by default operate on submodules that match the criteria the
new configuration variable specifies?

I suspect that copying this from .gitmodules to .git/config will
have security implications and will not be done?  What is the
expected way for projects to suggest which set of submodules are the
good ones to work on by default using this mechanism?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c |  22 ++++++++-
>  t/t7400-submodule-basic.sh  | 115 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 136 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a69b1f4..93760ec 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -573,6 +573,8 @@ struct submodule_update_clone {
>  	int current;
>  	struct module_list list;
>  	unsigned warn_if_uninitialized : 1;
> +	/* patterns to initialize */
> +	struct string_list *initialize;
>  
>  	/* update parameter passed via commandline */
>  	struct submodule_update_strategy update;
> @@ -590,7 +592,7 @@ struct submodule_update_clone {
>  	/* If we want to stop as fast as possible and return an error */
>  	unsigned quickstop : 1;
>  };
> -#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
> +#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, NULL, \
>  	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
>  	STRING_LIST_INIT_DUP, 0}
>  
> @@ -644,6 +646,15 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "submodule.%s.url", sub->name);
>  	git_config_get_string(sb.buf, &url);
> +	if (suc->initialize) {
> +		if (!url) {
> +			init_submodule(sub->path, suc->prefix, suc->quiet);
> +			url = xstrdup(sub->url);
> +		}
> +		if (!submodule_applicable_by_labels(suc->initialize, sub)
> +		    && !suc->warn_if_uninitialized)
> +			goto cleanup;
> +	}
>  	if (!url) {
>  		/*
>  		 * Only mention uninitialized submodules when their
> @@ -745,6 +756,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  	const char *update = NULL;
>  	int max_jobs = -1;
>  	struct string_list_item *item;
> +	const struct string_list *list;
>  	struct pathspec pathspec;
>  	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
>  
> @@ -793,6 +805,14 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  	gitmodules_config();
>  	git_config(submodule_config, NULL);
>  
> +	list = git_config_get_value_multi("submodule.actionOnLabel");
> +	if (list) {
> +		suc.initialize = xmalloc(sizeof(*suc.initialize));
> +		string_list_init(suc.initialize, 1);
> +		for_each_string_list_item(item, list)
> +			string_list_insert(suc.initialize, item->string);
> +	}
> +
>  	if (max_jobs < 0)
>  		max_jobs = parallel_submodules();
>  
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index fc948fd..dc45551 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1032,4 +1032,119 @@ test_expect_success 'submodule add records multiple labels' '
>  	test_cmp expected actual
>  '
>  
> +cat <<EOF > expected
> +submodule
> +-submodule2
> +EOF
> +
> +test_expect_success 'update initializes all modules when action-on-label configured' '
> +	test_when_finished "rm -rf super super_clone" &&
> +	mkdir super &&
> +	pwd=$(pwd) &&
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --label labelA file://"$pwd"/example2 submodule &&
> +		git submodule add file://"$pwd"/example2 submodule2 &&
> +		git commit -a -m "add two modules, one is labled"
> +	) &&
> +	git clone super super_clone &&
> +	(
> +		cd super_clone &&
> +		git config submodule.actionOnLabel \*labelA &&
> +		git submodule update &&
> +		git submodule status |cut -c1,42-52 | tr -d " " >../actual
> +	) &&
> +	test_cmp actual expected
> +'
> +
> +test_expect_success 'submodule update applies to action-on-label selection' '
> +	test_when_finished "rm -rf super super_clone" &&
> +	mkdir super &&
> +	oldSubmoduleHead=$(cd example2 && git rev-parse HEAD) &&
> +	pwd=$(pwd) &&
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --label labelA file://"$pwd"/example2 submodule1 &&
> +		git submodule add --label labelA file://"$pwd"/example2 submodule2 &&
> +		git submodule add --label labelA file://"$pwd"/example2 submodule3 &&
> +		git commit -a -m "add two modules, both are labled"
> +	) &&
> +	git clone super super_clone &&
> +	(
> +		cd super_clone &&
> +		git config submodule.actionOnLabel \*labelA &&
> +		git submodule update
> +	) &&
> +	(
> +		cd example2 &&
> +		touch anotherfile &&
> +		git add anotherfile &&
> +		git commit -m "advance example2" &&
> +		git checkout -b branchName
> +	) &&
> +	newSubmoduleHead=$(cd example2 && git rev-parse HEAD) &&
> +	(
> +		cd super &&
> +		git submodule add --label labelA file://"$pwd"/example2 submodule4 &&
> +		git commit -a -m "add another labeled module" &&
> +		git config -f .gitmodules submodule.submodule2.label labelB &&
> +		git config -f .gitmodules --unset submodule.submodule3.label &&
> +		git commit -a -m "unlabel 2 and 3 upstream" &&
> +		git submodule foreach git pull origin branchName &&
> +		git commit -a -m "update all submodules" &&
> +		git submodule status |cut -c1-52 >../actual
> +	) &&
> +	cat <<EOF >expected &&
> + $newSubmoduleHead submodule1
> + $newSubmoduleHead submodule2
> + $newSubmoduleHead submodule3
> + $newSubmoduleHead submodule4
> +EOF
> +	test_cmp actual expected &&
> +	(
> +		cd super_clone &&
> +		git pull &&
> +		git submodule update &&
> +		git submodule status |cut -c1-52 >../actual
> +	) &&
> +	cat <<EOF >expected &&
> + $newSubmoduleHead submodule1
> ++$oldSubmoduleHead submodule2
> ++$oldSubmoduleHead submodule3
> + $newSubmoduleHead submodule4
> +EOF
> +	test_cmp actual expected
> +'
> +
> +cat <<EOF > expected
> +submodule1
> +submodule2
> +-submodule3
> +EOF
> +
> +test_expect_success 'Change labels in .git/config' '
> +	test_when_finished "rm -rf super super_clone" &&
> +	mkdir super &&
> +	pwd=$(pwd) &&
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --label labelA file://"$pwd"/example2 submodule1 &&
> +		git submodule add file://"$pwd"/example2 submodule2 &&
> +		git submodule add file://"$pwd"/example2 submodule3 &&
> +		git commit -a -m "add two modules, one is labled"
> +	) &&
> +	git clone super super_clone &&
> +	(
> +		cd super_clone &&
> +		git config submodule.actionOnLabel \*labelA &&
> +		git config submodule.submodule2.label labelA
> +		git submodule update &&
> +		git submodule status |cut -c1,42-52 | tr -d " " >../actual
> +	) &&
> +	test_cmp actual expected
> +'
> +
>  test_done
