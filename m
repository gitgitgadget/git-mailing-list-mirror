From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv9 4/6] git submodule update: have a dedicated helper for
 cloning
Date: Tue, 9 Feb 2016 16:37:41 -0800
Message-ID: <20160210003741.GJ28749@google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
 <1455051274-15256-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 01:37:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTIn3-0004j5-OO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 01:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbcBJAht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 19:37:49 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33202 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135AbcBJAhp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 19:37:45 -0500
Received: by mail-pf0-f173.google.com with SMTP id q63so2491000pfb.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 16:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=M6N/ZmO5enzqUwBud4CF3wjKsm6Z+v8MMo+CNwlORss=;
        b=tW5+5KFiDHMd08QDsZKtgAaB/XybBRVbjIeocCAgtqkbTW8f80SYaU0AznLddiIg8o
         FhWsh0iRMTG3Np2KhZpZnH3s5PHWoYpqZk3/lpGMVxlSavePpIJDuXNkoosJLzfMoZ7d
         dwcdShQHQOuJB38WeNnkXP++w6Gxxfbq6GAcJZmlbf18tz0UKBdZviArSMBuOAb3aPnE
         F9YAfHPhglBIktOkAYdM8QoIf7nxhsvdu+0uRI6HpJH96NiaH9LaH2LG1BYaH7Iqixnd
         S9sP+0/6lLxSnDaSwY1WTYPlM7pJk3gvtQTeKwqxckms4UzGlzZnyP34pLkWRxHqoT5n
         ncAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=M6N/ZmO5enzqUwBud4CF3wjKsm6Z+v8MMo+CNwlORss=;
        b=cNRsdsaHyqNmX8/C8MgGB6BTpl6+kmeV6Gq+JowhiMhBdzKtRar08o1Aug4p0FwHd+
         gXlU/g7JsOvCp5qqKLEnWWnKjQwZx9coTxL2mm2VFRQozgysnGnJkBhnxvPbk7N4cI6r
         Spid4RGa7Oq94IofVzfhNIy5xIHz2UyE+G/+Z3K0mticeWW1F2OskOZm8GrCHTk+FISp
         LGuV/3GjL8j3IoSSyVTr8eKzqB/QL1cOvdRuNt9qgKMRlRmr/zyTjofdDhVx/QR4TCGE
         iiOCX5cI3co2tueMfj3iCxeyDueGgKR62G65M+3gZDCFdkZweMCNdQ6VZAXRN1sW/Ews
         UBaA==
X-Gm-Message-State: AG10YOT/2Eu6xk7VMfOTXt+H2Q0U8Aek/bCUzM19jXJRgUMjqGv8BPloFFcNlRm5UUMYNg==
X-Received: by 10.98.34.25 with SMTP id i25mr54682720pfi.26.1455064664147;
        Tue, 09 Feb 2016 16:37:44 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:609c:fa:6497:fd10])
        by smtp.gmail.com with ESMTPSA id 89sm477692pfi.2.2016.02.09.16.37.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Feb 2016 16:37:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455051274-15256-5-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285887>

Stefan Beller wrote:

> This introduces a new helper function in git submodule--helper
> which takes care of cloning all submodules, which we want to
> parallelize eventually.

Neat.

[...]
> As we can only access the stderr channel from within the parallel
> processing engine, we need to reroute the error message for
> specified but initialized submodules to stderr. As it is an error
> message, this should have gone to stderr in the first place, so it
> is a bug fix along the way.

In principle this could have happened in a separate preparatory patch
(so that the move to C would have no functional effect) but I don't
think that benefit alone is worth the churn of going back and doing
that.

[...]
> +++ b/builtin/submodule--helper.c
> @@ -255,6 +255,235 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +static int git_submodule_config(const char *var, const char *value, void *cb)
> +{
> +	return submodule_config(var, value, cb);
> +}

Can callers use submodule_config directly?


> +struct submodule_update_clone {
> +	/* states */
> +	int count;
> +	int print_unmatched;

I'd add a blank line here.

> +	/* configuration */
> +	int quiet;
> +	const char *reference;
> +	const char *depth;
> +	const char *update;
> +	const char *recursive_prefix;
> +	const char *prefix;
> +	struct module_list list;
> +	struct string_list projectlines;
> +	struct pathspec pathspec;
> +};
> +#define SUBMODULE_UPDATE_CLONE_INIT {0, 0, 0, NULL, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP}

What is this struct used for?  Maybe this would be clearer if it
appeared immediately before the function that used it.

This is the shared cb object passed to run_processes_parallel, right?
Some name like parallel_clone_opts or parallel_clone_cb might work.

What do the fields represent?  E.g., what is count a count of, what
does it mean when print_unmatched is true, etc?

Would it make sense to put the options in a separate struct from the
state fields (so e.g. it could be const)?  The options are easier to
understand because they correspond to command-line options, while the
state fields are something different and internal.

[...]
> +static int update_clone_get_next_task(struct child_process *cp,
> +				      struct strbuf *err,
> +				      void *pp_cb,
> +				      void **pp_task_cb)
> +{
> +	struct submodule_update_clone *pp = pp_cb;
> +
> +	for (; pp->count < pp->list.nr; pp->count++) {

Could some of this loop body be factored out into separate functions?
(e.g. whether to skip a submodule, getting the display path, ...).

[...]
> +		/*
> +		 * Looking up the url in .git/config.
> +		 * We must not fall back to .gitmodules as we only want
> +		 * to process configured submodules.
> +		 */
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "submodule.%s.url", sub->name);
> +		git_config_get_string(sb.buf, &url);
> +		if (!url) {

I can see how the submodule API would be overkill for this.  But it's
still tempting to use it.  'struct submodule' could gain a field
representing whether the submodule is initialized (i.e., whether it
appears in .git/config).

I wonder whether the strbuf_reset + addf idiom would be a good thing
to factor out into a mkpath()-like function --- i.e., something like

		git_config_get_string(fmt(&sb, "submodule.%s.url", sub->name), &url);

That's a little less risky than mkpath was because it explicitly
mentions &sb but maybe it's too magical.

[...]
> +static int update_clone_start_failure(struct child_process *cp,

Will review the rest when I get home.

Thanks,
Jonathan
