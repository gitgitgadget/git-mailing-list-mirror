From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/4] submodule: implement `module_name` as a builtin
 helper
Date: Wed, 5 Aug 2015 21:06:35 +0200
Message-ID: <55C25EBB.2000304@web.de>
References: <1438733070-15805-1-git-send-email-sbeller@google.com>
 <1438733070-15805-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 21:06:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN41X-0000uq-Qv
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 21:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbbHETGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 15:06:43 -0400
Received: from mout.web.de ([212.227.17.11]:60590 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbbHETGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 15:06:42 -0400
Received: from [192.168.178.41] ([79.211.101.152]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LfRvZ-1Z3gcm07dh-00p7Zm; Wed, 05 Aug 2015 21:06:37
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <1438733070-15805-2-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:o6gTK6CazzKXdkI6MLVazzDZEP0zCNqthJjp68CLBIVQXy4yNsX
 +q7NOjwOC60pR6mKZJbHOfZO2d41yYgfOjYvnfG1gvy5xnhu7VnM+pS1Ju+FZIfXxp0d+UO
 pQ+keNUh0Xwn8EnpXCQ2RWa4OzVyOyDs5ZyT0fTxLH9Qk5rA4ya0Lr1S/yMjz9dYGaLV0HZ
 PNIObQ4un1d4BrrSdrQfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uNki/74GXVE=:MKBy4Dz6PZO74gPw8Fuo0e
 FuiVtKLifzD9Wg+FASqFjPqeTDz5QWe2seuOd6aDb7HSZvigdy/drZDUVO21H41EBO6dzUg4p
 4jW0DI5D9AQ2GkHCn0H9FoYNkzy5tacBf2V/b311VMRt+0BIGTdd7nG7MRMSx6uFg8sigfx8R
 Eye6N1gBUwZMhYwgs+a/pKJUJCHrKsokgin0i2X4xR7IXu/7UR6OF+oohOom6Rr57CO1Q4GQ3
 DuAScZadJHacVtyYjr/88gW1LevJsUm/aGYn4TFmPAmTSvtQVlPZg4FJnLwlSEzm8ZyOF9xba
 oeCK8N/vv8SHLf7r9CEfZvQtbtnk4ncGVop6vl3euxOMkpv8nGhmySarJpnyawh+s6wvVx4MH
 R82Bl/FJAAk+8B1+TW4ssOEkipkFFY5wXKyAS4V1SnmaxJz9rF9MQlqb6KbyXZMuotjo0OHwC
 c6NOiYjZfp3kJXOMWDsfHyfAuTNSay8J5PoychfPQfGbEG7Lq5Gcchf7J/BlnYpY2Tk0zcYa0
 QTmHwN1PWJ79qdRGrCd2iBOv8mVlLix8v+PYrpLyGlFFVNEsX/XfbMxNOQoT4Pb+VZQtCYmtj
 Jd1EBUa5o94T7bEU0K1Ggpvd1NjqgNNea4+4wX6iyHJUU2/r3K/Q+kr9Ir9IJURSqwuDPJZcI
 KBos/qbmf2IyKSiFN5isjMZn5XmLxjSEkn1ThohEes3qAo0MFamM+XrBHRFkU+Two3Ks=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275387>

Am 05.08.2015 um 02:04 schrieb Stefan Beller:
> The goal of this series being rewriting `git submodule update`,
> we don't want to call out to the shell script for config lookups.
>
> So reimplement the lookup of the submodule name in C.

Cool. This brings down the duration of the test suite from 3:13
to 3:12 for me (best of three).

You might wanna have a look into submodule.c: after initially
calling gitmodules_config() one can lookup the submodule name
in the static "config_name_for_path" string_list. If you'd add
a public method to submodule.c which accesses that string_list
and returns the name for the given path, you won't need your
two new functions ... or am I missing something?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>   When I started to implement git submodule add in the helper, I realized
>   the very first thing to be done would be module_name translated to C,
>   so I did that separately. Maybe we need to split this up as well into two
>   separate steps for processing and I/O, such that it can be reused better
>   from a future "git submodule--helper update" function
>
>   builtin/submodule--helper.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   git-submodule.sh            | 32 +++++++-----------------------
>   2 files changed, 54 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index cb18ddf..dd5635f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -5,6 +5,8 @@
>   #include "pathspec.h"
>   #include "dir.h"
>   #include "utf8.h"
> +#include "run-command.h"
> +#include "string-list.h"
>
>   static char *ps_matched;
>   static const struct cache_entry **ce_entries;
> @@ -98,6 +100,48 @@ static int module_list(int argc, const char **argv, const char *prefix)
>   	return 0;
>   }
>
> +
> +static int collect_module_names(const char *key, const char *value, void *cb)
> +{
> +	size_t len;
> +	struct string_list *sl = cb;
> +
> +	if (starts_with(key, "submodule.")
> +	    && strip_suffix(key, ".path", &len)) {
> +		struct strbuf sb = STRBUF_INIT;
> +		strbuf_add(&sb, key + strlen("submodule."),
> +				len - strlen("submodule."));
> +		string_list_insert(sl, value)->util = strbuf_detach(&sb, NULL);
> +		strbuf_release(&sb);
> +	}
> +
> +	return 0;
> +}
> +
> +static int module_name(int argc, const char **argv, const char *prefix)
> +{
> +	struct string_list_item *item;
> +	struct git_config_source config_source;
> +	struct string_list values = STRING_LIST_INIT_DUP;
> +
> +	if (!argc)
> +		usage("git submodule--helper module_name <path>\n");
> +
> +	memset(&config_source, 0, sizeof(config_source));
> +	config_source.file = ".gitmodules";
> +
> +	if (git_config_with_options(collect_module_names, &values,
> +				    &config_source, 1) < 0)
> +		die(_("unknown error occured while reading the git modules file"));
> +
> +	item = string_list_lookup(&values, argv[0]);
> +	if (item)
> +		printf("%s\n", (char*)item->util);
> +	else
> +		die("No submodule mapping found in .gitmodules for path '%s'", argv[0]);
> +	return 0;
> +}
> +
>   int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>   {
>   	if (argc < 2)
> @@ -106,6 +150,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
>   	if (!strcmp(argv[1], "module_list"))
>   		return module_list(argc - 1, argv + 1, prefix);
>
> +	if (!strcmp(argv[1], "module_name"))
> +		return module_name(argc - 2, argv + 2, prefix);
> +
>   usage:
>   	usage("git submodule--helper module_list\n");
>   }
> diff --git a/git-submodule.sh b/git-submodule.sh
> index af9ecef..e6ff38d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -178,24 +178,6 @@ get_submodule_config () {
>   	printf '%s' "${value:-$default}"
>   }
>
> -
> -#
> -# Map submodule path to submodule name
> -#
> -# $1 = path
> -#
> -module_name()
> -{
> -	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
> -	sm_path="$1"
> -	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
> -	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
> -		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
> -	test -z "$name" &&
> -	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$sm_path'")"
> -	printf '%s\n' "$name"
> -}
> -
>   #
>   # Clone a submodule
>   #
> @@ -498,7 +480,7 @@ cmd_foreach()
>   		then
>   			displaypath=$(relative_path "$sm_path")
>   			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
> -			name=$(module_name "$sm_path")
> +			name=$(git submodule--helper module_name "$sm_path")
>   			(
>   				prefix="$prefix$sm_path/"
>   				clear_local_git_env
> @@ -554,7 +536,7 @@ cmd_init()
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> -		name=$(module_name "$sm_path") || exit
> +		name=$(git submodule--helper module_name "$sm_path") || exit
>
>   		displaypath=$(relative_path "$sm_path")
>
> @@ -636,7 +618,7 @@ cmd_deinit()
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> -		name=$(module_name "$sm_path") || exit
> +		name=$(git submodule--helper module_name "$sm_path") || exit
>
>   		displaypath=$(relative_path "$sm_path")
>
> @@ -758,7 +740,7 @@ cmd_update()
>   			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
>   			continue
>   		fi
> -		name=$(module_name "$sm_path") || exit
> +		name=$(git submodule--helper module_name "$sm_path") || exit
>   		url=$(git config submodule."$name".url)
>   		branch=$(get_submodule_config "$name" branch master)
>   		if ! test -z "$update"
> @@ -1022,7 +1004,7 @@ cmd_summary() {
>   			# Respect the ignore setting for --for-status.
>   			if test -n "$for_status"
>   			then
> -				name=$(module_name "$sm_path")
> +				name=$(git submodule--helper module_name "$sm_path")
>   				ignore_config=$(get_submodule_config "$name" ignore none)
>   				test $status != A && test $ignore_config = all && continue
>   			fi
> @@ -1184,7 +1166,7 @@ cmd_status()
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> -		name=$(module_name "$sm_path") || exit
> +		name=$(git submodule--helper module_name "$sm_path") || exit
>   		url=$(git config submodule."$name".url)
>   		displaypath=$(relative_path "$prefix$sm_path")
>   		if test "$stage" = U
> @@ -1261,7 +1243,7 @@ cmd_sync()
>   	while read mode sha1 stage sm_path
>   	do
>   		die_if_unmatched "$mode"
> -		name=$(module_name "$sm_path")
> +		name=$(git submodule--helper module_name "$sm_path")
>   		url=$(git config -f .gitmodules --get submodule."$name".url)
>
>   		# Possibly a url relative to parent
>
