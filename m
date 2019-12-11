Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F091C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC322173E
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMT0Ek4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLKUsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:48:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43459 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLKUsS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 15:48:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id q16so44213plr.10
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HemmO+zGL/564bHX6OEW9+FHG3swTcNWyYL5r7qR3Ek=;
        b=EMT0Ek4klTwmz1ZRabeBmHdzLk4ZGyVFxmyvAorz3ZGQ/RYa1+OeoH8CIhozeeY4FZ
         SBgWwrp9D4SLVPog0X7Nw409W08JgS03gkzEkJRInkOYZIRKwHRatLlKOTLQZHW1RzB+
         Wf9Dkgcz+UbmrTHoOPZkdO6psg6K3b80SGgmUuuOsH9aa03YZ3cjzDqW9ftmBK8Pgs/M
         TbXwzxXJ1PbNlCS+Ilith/rEf9DPI41waOgRcgdyqrjbDkDeaBs3L9kuuENTxbgqXPxX
         ei9Al1bCIgaGcETidtUJsiOexsEODWo4TXFwnFv1YxOiOZ8S2zzb3wtftJ8veVAQTO8g
         3Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HemmO+zGL/564bHX6OEW9+FHG3swTcNWyYL5r7qR3Ek=;
        b=lf2cnnmyaEWdJaItOu/Ncxb+Vfbo1zdEe50J4Fnl3I72l2uWEnD5n7YAWRDHPAGiXw
         iFHWwgewEYvCyB+M1FLT7xLqc30e3wK0Wh5h4SOQiSh0f/wds9N4vjakVX8hFc06WCRC
         ImahC3u++fRUBT9SEMCc6wyak+yBrRfq2yyFfFBrY5iRxr1abNtz1thsuHEJdqXE5im6
         tij8kDRAyAQ+j/K3rAWcAOEql7Jaxd63gSbz/rDAk/vee4DZK1QfjeZ81P84BuCJnItY
         Na3uClU5i9zf6oMp1uN6TKndXw/YnXLCt5/PL2A5VSrdGcVyQWEdVOJDY4piydM04/+c
         dqOw==
X-Gm-Message-State: APjAAAWzp0g5gPdULXC+v1Dbchs9Y8CQxlUp8Lwtg0v+R+G+jkxo8gDL
        MhnMW4SeqYhVeQFgS8xPD/F1QT7XlkM=
X-Google-Smtp-Source: APXvYqxf8waHh9aYyoLWl1uovTOFKZp/uNGgf+xmxJa7YZDnZOeW5sGEO8cECVHB5enF/IuYI9x4jw==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr5512998pld.248.1576097297158;
        Wed, 11 Dec 2019 12:48:17 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id e7sm4088454pfe.168.2019.12.11.12.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:48:16 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:48:11 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/9] bugreport: add config values from whitelist
Message-ID: <20191211204811.GC107889@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-5-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1910281506040.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910281506040.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 03:14:35PM +0100, Johannes Schindelin wrote:
> Hi Emily,

Sorry for the delay in replying. This work has been backburnered and
this mail slipped through the cracks.

> 
> On Thu, 24 Oct 2019, Emily Shaffer wrote:
> 
> > Teach bugreport to gather the values of config options which are present
> > in 'git-bugreport-config-whitelist'.
> >
> > Many config options are sensitive, and many Git add-ons use config
> > options which git-core does not know about; it is better only to gather
> > config options which we know to be safe, rather than excluding options
> > which we know to be unsafe.
> 
> Should we still have the `// bugreport-exclude` comments, then?

They were optional (useless) before too. I can remove them if you want;
I suppose I like the idea of having precedent if someone wants to build
their own internal version with opt-out configs rather than opt-in. I
can remove them if we want; it doesn't matter very much to me either
way.

> 
> >
> > Reading the whitelist into memory and sorting it saves us time -
> > since git_config_bugreport() is called for every option the user has
> > configured, limiting the file IO to one open/read/close and performing
> > option lookup in sublinear time is a useful optimization.
> 
> Maybe we even want a hashmap? That would reduce the time complexity even
> further.

Sure, we can do it. I'll make that change.

> 
> > diff --git a/bugreport.c b/bugreport.c
> > index ada54fe583..afa4836ab1 100644
> > --- a/bugreport.c
> > +++ b/bugreport.c
> > @@ -1,10 +1,24 @@
> >  #include "cache.h"
> >
> >  #include "bugreport.h"
> > +#include "config.h"
> > +#include "exec-cmd.h"
> >  #include "help.h"
> >  #include "run-command.h"
> >  #include "version.h"
> >
> > +/**
> > + * A sorted list of config options which we will add to the bugreport. Managed
> > + * by 'gather_whitelist(...)'.
> > + */
> > +struct string_list whitelist = STRING_LIST_INIT_DUP;
> > +struct strbuf configs_and_values = STRBUF_INIT;
> > +
> > +// git version --build-options
> > +// uname -a
> > +// curl-config --version
> > +// ldd --version
> > +// echo $SHELL
> 
> These comments probably want to move to a single, C style comment, and
> they probably want to be introduced together with `get_system_info()`.

Yeah, it's stale and has been removed now. It was less commentary and
more todo list for author ;)

> 
> I also have to admit that I might have missed where `$SHELL` was added
> to the output...

I skipped it entirely since bugreport doesn't run in shell anymore. If
you have advice for gathering the user's shell I can try to add it; is
there such a difference between, say, a Debian user using bash and a
Debian user using zsh? I suppose it could be useful if someone has an
issue with GIT_PS1, or with autocompletion. I'll look into gathering it.

> 
> >  void get_system_info(struct strbuf *sys_info)
> >  {
> >  	struct child_process cp = CHILD_PROCESS_INIT;
> > @@ -53,3 +67,39 @@ void get_system_info(struct strbuf *sys_info)
> >  	argv_array_clear(&cp.args);
> >  	strbuf_reset(&std_out);
> >  }
> > +
> > +void gather_whitelist(struct strbuf *path)
> > +{
> > +	struct strbuf tmp = STRBUF_INIT;
> > +	strbuf_read_file(&tmp, path->buf, 0);
> > +	string_list_init(&whitelist, 1);
> > +	string_list_split(&whitelist, tmp.buf, '\n', -1);
> > +	string_list_sort(&whitelist);
> > +}
> > +
> > +int git_config_bugreport(const char *var, const char *value, void *cb)
> > +{
> > +	if (string_list_has_string(&whitelist, var)) {
> > +		strbuf_addf(&configs_and_values,
> > +			    "%s : %s\n",
> > +			    var, value);
> 
> A quite useful piece of information would be the config source. Not sure
> whether we can do that outside of `config.c` yet...

It's possible. I can add it.

> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void get_whitelisted_config(struct strbuf *config_info)
> > +{
> > +	struct strbuf path = STRBUF_INIT;
> > +
> > +	strbuf_addstr(&path, git_exec_path());
> > +	strbuf_addstr(&path, "/git-bugreport-config-whitelist");
> 
> Hmm. I would have expected this patch to come directly after the patch
> 2/9 that generates that white-list, and I would also have expected that
> to be pre-sorted, and compiled in.
> 
> Do you want users to _edit_ the file in the exec path? In general, that
> path will be write-protected, though. A better alternative would
> probably be to compile in a hard-coded list, and to allow including more
> values e.g. by offering command-line options to specify config setting
> patterns. But if we allow patterns, we might actually want to have those
> exclusions to prevent sensitive data from being included.

Hm, interesting. Do we have precedent for compiling in a header
generated during the build process? I think I saw one when I was adding
this script - I'll take a look.

> 
> > +
> > +	gather_whitelist(&path);
> > +	strbuf_init(&configs_and_values, whitelist.nr);
> > +
> > +	git_config(git_config_bugreport, NULL);
> > +
> > +	strbuf_reset(config_info);
> > +	strbuf_addbuf(config_info, &configs_and_values);
> > +}
> > diff --git a/bugreport.h b/bugreport.h
> > index ba216acf3f..7413e7e1be 100644
> > --- a/bugreport.h
> > +++ b/bugreport.h
> > @@ -5,3 +5,10 @@
> >   * The previous contents of sys_info will be discarded.
> >   */
> >  void get_system_info(struct strbuf *sys_info);
> > +
> > +/**
> 
> I also frequently use JavaDoc-style `/**`, but I am not sure that this
> is actually desired in Git's source code ;-)
> 
> > + * Adds the values of the config items listed in
> > + * 'git-bugreport-config-whitelist' to config_info. The previous contents of
> > + * config_info will be discarded.
> > + */
> > +void get_whitelisted_config(struct strbuf *sys_info);
> > diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> > index 7232d31be7..70fe0d2b85 100644
> > --- a/builtin/bugreport.c
> > +++ b/builtin/bugreport.c
> > @@ -56,6 +56,10 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
> >  	get_system_info(&buffer);
> >  	strbuf_write(&buffer, report);
> >
> > +	add_header(report, "Whitelisted Config");
> 
> Quite honestly, I would like to avoid the term "whitelist" for good. How
> about "Selected config settings" instead?

Will do - thanks for the callout.

> 
> Thanks,
> Dscho
> 
> > +	get_whitelisted_config(&buffer);
> > +	strbuf_write(&buffer, report);
> > +
> >  	fclose(report);
> >
> >  	launch_editor(report_path.buf, NULL, NULL);
> > --
> > 2.24.0.rc0.303.g954a862665-goog
> >
> >
