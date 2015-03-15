From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: Re: [PATCH] [GSoC] Add configuration options for some commonly used
 command-line options
Date: Sun, 15 Mar 2015 20:35:16 +0100
Message-ID: <5505DEF4.3060208@posteo.de>
References: <5505DD9D.8010102@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 15 20:36:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXEKZ-000366-61
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 20:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbbCOTgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 15:36:07 -0400
Received: from mx02.posteo.de ([89.146.194.165]:43277 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084AbbCOTgG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 15:36:06 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id D62D322B47F5
	for <git@vger.kernel.org>; Sun, 15 Mar 2015 20:36:04 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l4rbS549zz5vNG
	for <git@vger.kernel.org>; Sun, 15 Mar 2015 20:36:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <5505DD9D.8010102@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265516>



On 03/15/2015 08:29 PM, Koosha Khajehmoogahi wrote:
> This patch adds a 'showmerges' config. option for git-log.
> This option determines whether the log should contain merge
> commits or not. In essence, if this option is set to true,

Sorry, this should be 'false'.

> git-log will be run as 'git-log --no-merges'.
> 
> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
>  Documentation/config.txt | 3 +++
>  builtin/log.c            | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1530255..7775b8c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1735,6 +1735,9 @@ log.showroot::
>  	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
>  	normally hide the root commit will now show it. True by default.
>  
> +log.showmerges::
> +	If true, merges will be shown in the log list. True by default.
> +
>  log.mailmap::
>  	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
>  	linkgit:git-whatchanged[1] assume `--use-mailmap`.
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..bb36f61 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -31,6 +31,7 @@ static const char *default_date_mode = NULL;
>  
>  static int default_abbrev_commit;
>  static int default_show_root = 1;
> +static int default_max_parents = -1;
>  static int decoration_style;
>  static int decoration_given;
>  static int use_mailmap_config;
> @@ -108,6 +109,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
>  	rev->diffopt.stat_graph_width = -1; /* respect statGraphWidth config */
>  	rev->abbrev_commit = default_abbrev_commit;
>  	rev->show_root_diff = default_show_root;
> +	rev->max_parents = default_max_parents;
>  	rev->subject_prefix = fmt_patch_subject_prefix;
>  	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
>  
> @@ -390,6 +392,12 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  		default_show_root = git_config_bool(var, value);
>  		return 0;
>  	}
> +
> +	if (!strcmp(var, "log.showmerges")) {
> +		default_max_parents = git_config_bool(var, value) ? -1 : 1;
> +		return 0;
> +	}
> +
>  	if (skip_prefix(var, "color.decorate.", &slot_name))
>  		return parse_decorate_color_config(var, slot_name, value);
>  	if (!strcmp(var, "log.mailmap")) {
> 

-- 
Koosha
