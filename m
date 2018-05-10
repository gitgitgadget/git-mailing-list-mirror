Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AAFA1F42D
	for <e@80x24.org>; Thu, 10 May 2018 06:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756661AbeEJGhs (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 02:37:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39597 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeEJGhr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 02:37:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id f8-v6so2286483wmc.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 23:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=koGX7PmJeDQuVlEZ1uduQv55n/LaODHFq6WrNGF0+Vk=;
        b=UhKSycbbM5AQGsGH8DgGl8iHyjuZvTH6IW3YFwkzzydE5Y0BUEG3OawWmetK+s+/TU
         lObCatVk27MzIieQsQoWJVSOdeIWUrtEdSMk1Dht8PYo4/k8kSQ72WudlkLFNMtaXOjX
         JDSNF0U0xwBrtXkjb2JHkouFi8z02YHCo+6HVYxYdfK+k1pFVquTNqa43JceQ0HyXTTa
         pUUMWMl9p1vmt9Lwb8pqWAQDNSxhSQfydV/IgNaMXraIXvf7LQFn2bAl2vIK80hJweqx
         xydGsh5USLPvkZTmOyaKNUO9cRjk27dMcoVSWQAIKeE2iJETXqphJo3Bu+LtIz+bG1Xg
         ujbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=koGX7PmJeDQuVlEZ1uduQv55n/LaODHFq6WrNGF0+Vk=;
        b=bR8Vai7CuqRyu4xB5vmyDmAlqGO0Yw2xjvJdl9XqhaNOrsSgDLK3xMCke6NCkYEpjg
         w/k8ySdMgudsIGN9E3yrbOKhZdye8RnSvPAyw3HUc+lZARRC4UEYqlEvYQp5ctRA8wcB
         Hj+Yi8chJU9vYGildD3q62Hj26AL8nsq5jJe8H5xGBYdy4tYQDl9CAU/yiICGrxuV90i
         Is7pNVWELc9s51VnDnPRag79XuWniBceiHR18c3p31nb/3lgUdWS1xOWAkicWX41LMjD
         1pcWBt3JtiN4J7LJPsBCcw6sH5+jD6yYzWpDoHZAxvsbCMw5XqGul8UBc7SU4QOldQKi
         pskg==
X-Gm-Message-State: ALKqPwd4AhZ88lSUfirkf/0vf5qoLOmqgzfnTZh7uwmPzXgkP3YAlp4J
        qKkWUxqewqELQIOG4N8CAUw=
X-Google-Smtp-Source: AB8JxZoD9N+DAIPecmnFWRMuGAAioYY2EQIkD5KyMHAj5pgtiyGsYi9XvAi3VfOGcyHeX0ZJ7XZuaA==
X-Received: by 2002:a1c:b884:: with SMTP id i126-v6mr328547wmf.30.1525934265913;
        Wed, 09 May 2018 23:37:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 44-v6sm416184wrv.47.2018.05.09.23.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 23:37:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        jonathantanmy@google.com, pc44800@gmail.com
Subject: Re: [PATCH 4/4] submodule: port submodule subcommand 'foreach' from shell to C
References: <20180503005358.89082-1-sbeller@google.com>
        <20180509002952.172347-1-sbeller@google.com>
        <20180509002952.172347-5-sbeller@google.com>
Date:   Thu, 10 May 2018 15:37:44 +0900
In-Reply-To: <20180509002952.172347-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 8 May 2018 17:29:52 -0700")
Message-ID: <xmqqo9hoj9s7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
> +				       void *cb_data)
> +{
> +	struct cb_foreach *info = cb_data;
> +	const char *path = list_item->name;
> +	const struct object_id *ce_oid = &list_item->oid;
> +
> +	const struct submodule *sub;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	char *displaypath;
> +
> +	displaypath = get_submodule_displaypath(path, info->prefix);
> +
> +	sub = submodule_from_path(the_repository, &null_oid, path);
> +
> +	if (!sub)
> +		die(_("No url found for submodule path '%s' in .gitmodules"),
> +			displaypath);
> +
> +	if (!is_submodule_populated_gently(path, NULL))
> +		goto cleanup;
> +
> +	prepare_submodule_repo_env(&cp.env_array);
> +
> +	/*
> +	* For the purpose of executing <command> in the submodule,
> +	* separate shell is used for the purpose of running the
> +	* child process.
> +	*/

Micronit: this multi-line comment is indented in a funny way.

> +	cp.use_shell = 1;
> +	cp.dir = path;
> +
> +	/*
> +	* NEEDSWORK: the command currently has access to the variables $name,
> +	* $sm_path, $displaypath, $sha1 and $toplevel only when the command
> +	* contains a single argument. This is done for maintaining a faithful
> +	* translation from shell script.
> +	*/

Same micronit.

The scripted version does 'eval "$1"', so $1 could be something like 

	for-each 'echo "$name:$sm_path:$displaypath:$sha1:$toplevel"'

and it can see any variable, not just these 5 (i.e. we could have
fed e.g. $wt_prefix and $mode to the above 'echo' and with the
scripted version the script would have learned their values; with
this version it no longer does, but only these 5 are part of the
documented API, so we choose not to consider it a regression).

> +	if (info->argc == 1) {
> +		char *toplevel = xgetcwd();
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		argv_array_pushf(&cp.env_array, "name=%s", sub->name);
> +		argv_array_pushf(&cp.env_array, "sm_path=%s", path);
> +		argv_array_pushf(&cp.env_array, "displaypath=%s", displaypath);
> +		argv_array_pushf(&cp.env_array, "sha1=%s",
> +				oid_to_hex(ce_oid));
> +		argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
> +
> +		/*
> +		* Since the path variable was accessible from the script
> +		* before porting, it is also made available after porting.
> +		* The environment variable "PATH" has a very special purpose
> +		* on windows. And since environment variables are
> +		* case-insensitive in windows, it interferes with the
> +		* existing PATH variable. Hence, to avoid that, we expose
> +		* path via the args argv_array and not via env_array.
> +		*/
> +		sq_quote_buf(&sb, path);
> +		argv_array_pushf(&cp.args, "path=%s; %s",
> +				 sb.buf, info->argv[0]);

OK, so we do the equivalent of

	name=... sm_path=... displaypath=... sha1=... toplevel=... \
	sh -c 'path=...; echo "$name:$sm_path:..."'

when doing

	for-each 'echo "$name:$sm_path:..."'

with parts denoted with ... correctly quoted as necessary.  I guess
it would be the best we could do.

I myself do not know if it is true that bash ported to Windows won't
get confused with the above "we use path (all lowercase) only as a
pure shell variable without exporting it ourselves"; I'd trust those
who are more familiar with the platform to raise objections and
suggest a better alternative if it is not the case.  

Thanks for the (malformatted;-) leading comment to highlight why the
'path' variable alone is treated differently from the others.

> +		strbuf_release(&sb);
> +		free(toplevel);
> +	} else {
> +		argv_array_pushv(&cp.args, info->argv);
> +	}
> +
> +	if (!info->quiet)
> +		printf(_("Entering '%s'\n"), displaypath);
> +
> +	if (info->argv[0] && run_command(&cp))
> +		die(_("run_command returned non-zero status for %s\n."),
> +			displaypath);
> +
> +	if (info->recursive) {
> +		struct child_process cpr = CHILD_PROCESS_INIT;
> +
> +		cpr.git_cmd = 1;
> +		cpr.dir = path;
> +		prepare_submodule_repo_env(&cpr.env_array);
> +
> +		argv_array_pushl(&cpr.args, "--super-prefix", NULL);
> +		argv_array_pushf(&cpr.args, "%s/", displaypath);
> +		argv_array_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
> +				NULL);
> +
> +		if (info->quiet)
> +			argv_array_push(&cpr.args, "--quiet");
> +
> +		argv_array_pushv(&cpr.args, info->argv);
> +
> +		if (run_command(&cpr))
> +			die(_("run_command returned non-zero status while"
> +				"recursing in the nested submodules of %s\n."),
> +				displaypath);
> +	}
> +
> +cleanup:
> +	free(displaypath);
> +}

