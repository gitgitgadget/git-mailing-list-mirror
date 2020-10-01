Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA9DC4363D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65252087D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrSYIHho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgJACo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 22:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJACo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 22:44:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA01AC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 19:44:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md22so836216pjb.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y/ww9WIbt+GADTOlr1MUi6Vb9N5l/WFPR+l0Xju/VAI=;
        b=jrSYIHho3zd46rN3yoJB1GsrtWN7tnNYmExnV1nApE+Ve+1ywx+O6MBI6VWwNOetsw
         t/hYi3/OewTugAt0TuNcariPNYqNUSbQmpSKHb09uQgSUgMPyv1BRBzoTO/wVh73MLzv
         W8nJGXOSZtj+y+fRtq6JbV9rvcHKzGzrbfR/3sZ1+IziRQx5uc04Buyiwhk/P8wNrmhw
         Jjo9ksIrTIluYdtJ0F9UWdknFca7eFj/WnCtueXROhfbNN5jlxR7p+tHUVi/87oBP0rv
         NNfwaxEVUJaPHtWhOtz0sKM9XuyCn3L/Ubnm7r4qf6Sg7Rb61YjlVMKNPQYUKiM/xyzv
         8vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y/ww9WIbt+GADTOlr1MUi6Vb9N5l/WFPR+l0Xju/VAI=;
        b=I+uweZJmGeQd1EH1QlMbcr2kUDX5QoQqCfzFYL4fXzhfhm8lWMjkiueQIKciVZCbH3
         k5hULd7aFFACWjmCeDzeEP7I1trKcmHH2qzA+MGHgnO0crcqfvSRmQg0ZJ0Vtelz/39c
         dQCtkzirY/GrUesxo0f4W04zmcgmxeHs53aFSYDOAX0nsxGkmSSfDafkcVUzq3J+7lxp
         PnzVsQ/DcmWAyxMbY3UEsuDwT/zDPaSxmWPxZtjXg/FZEN6Z7Nx2OZbt1N7Qv2F3ImxX
         JX+DZurWy38nJZsZ5JAxPXqoXgKnwB+gWPc4DYWrlE+/FtWPR8z94iQNL3PXWX+ZBzq/
         zPdQ==
X-Gm-Message-State: AOAM530iHFnEDfRoWDI7UKYu4ULt7CyAt1duFpCxHaVHaXX69JF/8QgN
        1UiihDP6Rdvjah8rwmCJzyU=
X-Google-Smtp-Source: ABdhPJxP0TeRLgiaIXZepaqjSuW3H6wnY0Trng1F66ikjU5+79Z9iDq2msS8WPQmupJbrY00qxo36g==
X-Received: by 2002:a17:90a:a40d:: with SMTP id y13mr4881327pjp.183.1601520295118;
        Wed, 30 Sep 2020 19:44:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id s8sm3510788pjn.10.2020.09.30.19.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 19:44:54 -0700 (PDT)
Date:   Wed, 30 Sep 2020 19:44:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, gitster@pobox.com
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
Message-ID: <20201001024452.GA2930867@google.com>
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
 <20200930232138.3656304-1-shengfa@google.com>
 <20200930232138.3656304-2-shengfa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930232138.3656304-2-shengfa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Shengfa Lin wrote:

>  Documentation/config/user.txt   |  4 ++++
>  builtin/commit.c                |  5 +++++
>  t/t7527-commit-hide-timezone.sh | 37 +++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100755 t/t7527-commit-hide-timezone.sh

Thanks for this discussion starter.  I'm interested to see what we end
up with.

To summarize the thread so far:

Nathaniel Manista, who we can credit with a `Reported-by` line,
reports that (mildly paraphrased):

	Authoring and sharing a commit by default exposes the user's
	time zone.

	"gt commit --date=YYYY-MM-DDThh:mm:ss+0000" suffices to put
	the author time in UTC (though not the commit time in UTC).
	But the user shouldn't have to pass a flag at all.

	Where the user is in the world is private information that git
	ought not to record and make available as part of the user's
	software engineering (make available to colleagues, in the
	case of proprietary development, and make available to the
	world, in the case of open source). Git should entirely stop
	accessing, recording, and sharing the user's time zone.

On the other hand, various others have mentioned some beneficial
aspects of recording the timezone --- for example, it makes it easier
to make sense of the chronology in a program's development.  What
seems uncontroversial is that users should have control over the time
zone used (as they already do, via the TZ environment variable).

In response to the suggestion of a "[user] timeZone" setting,
Nathaniel suggests

	That sounds like a great first step and like something that
	wouldn't ruffle anyone's feathers while proving the value of
	ignoring time zone information. 🙂

There is more to discuss in this design space --- let's see where the
patch leads us.

> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -36,3 +36,7 @@ user.signingKey::
>  	commit, you can override the default selection with this variable.
>  	This option is passed unchanged to gpg's --local-user parameter,
>  	so you may specify a key using any method that gpg supports.
> +
> +user.hideTimezone::
> +  Override TZ to UTC for Git commits to hide user's timezone in commit
> +  date

To me, this seems less appealing than being able to set the time zone.
By setting the time zone to match others in the same project, I would
be able to blend in without sharing information about my travels.  If
I use the hideTimezone setting instead, then I may stick out as the
only contributor using UTC.

UTC is the default timezone in various development environments so
this is not a big deal, but it seems enough reason to prefer the
fuller-control approach.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 42b964e0ca..fb1cbb8a39 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1569,6 +1569,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>  	s.colopts = 0;
>  
> +  git_config(git_default_config, NULL);
> +  int hide_timezone = 0;
> +  if (!git_config_get_bool("user.hideTimezone", &hide_timezone)  && hide_timezone)
> +    setenv("TZ", "UTC", 1);

Like Junio mentioned, this affects "git commit" but not other commands
that record the current date with the local timezone.

The fundamental tool to exercise that machinery is

	$ git var GIT_AUTHOR_IDENT
	Jonathan Nieder <jrnieder@gmail.com> 1601517809 -0700

so I suppose I'd be interested in seeing that exercised in tests.

Looking at the implementation, I find fmt_ident in ident.c, which
calls ident_default_date(), which calls date.c's datestamp, which uses
localtime_r to get the timezone.  localtime_r on all platforms I know
of calls tzset, though apparently[*] it is not required to.

The unfortunate thing about these APIs is that there's no way to pass
in a timezone from a string instead of from the environment.  This
means that passing through the environment as above is the only
reasonable way to do it, but that would have the unfortunate result
of changing the output of commands like "git log --date=local" that
are about writing dates to the terminal instead of storing them.

So I'd be tempted to do something targetted like this:

-- 8< --
diff --git i/date.c w/date.c
index f9ea807b3a9..658ba1a9a45 100644
--- i/date.c
+++ w/date.c
@@ -5,6 +5,7 @@
  */
 
 #include "cache.h"
+#include "config.h"
 
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
@@ -998,6 +999,20 @@ void datestamp(struct strbuf *out)
 	time_t now;
 	int offset;
 	struct tm tm = { 0 };
+	const char *env_tz;
+	char *config_tz = NULL;
+	int restore_tz = 0;
+
+	if (!git_config_get_string("user.timezone", &config_tz)) {
+		env_tz = getenv("TZ");
+		if (env_tz)
+			env_tz = xstrdup(env_tz);
+		if (!env_tz || strcmp(env_tz, config_tz)) {
+			restore_tz = 1;
+			setenv("TZ", config_tz, 1);
+			tzset();
+		}
+	}
 
 	time(&now);
 
@@ -1005,6 +1020,14 @@ void datestamp(struct strbuf *out)
 	offset /= 60;
 
 	date_string(now, offset, out);
+
+	if (restore_tz) {
+		if (env_tz)
+			setenv("TZ", env_tz, 1);
+		else
+			unsetenv("TZ");
+	}
+	free(config_tz);
 }
 
 /*
-- >8 --

Looking over callers, who would this affect?  There are three callers:

 fast-import.c::parse_ident:
	Used to handle ident string "now".  That seems in keeping with
	the intent here, and fast-import does respect some other
	configuration though only affecting storage.  Seems fine.sensible.

 ident.c::ident_default_date:
	Used to produce author and committer timestamps and timestamps for
	reflog entries.  That's the goal; good.

 send-pack.c::generate_push_cert:
	Used for the timestamp sent to the server in a signed push
	certificate.  Also good.

So I think this does the right thing, plus it retains the
user-friendly feature of being able to *display* timestamps in their
local timezone.

Now let's talk through the downsides:

It's complex.  The performance isn't likely to be bad when
user.timezone is not set, which is nice, but it still is messier than
I'd like to see.

It's specific to Git, but a user might want to disable recording their
timezone in *all* collaboration tools (mail clients, newsreaders,
etc), not just Git.  So I would find it more compelling if there were
a common convention shared across tools for setting your exposed
timezone, just like the EMAIL envvar for setting your exposed email
address.

Thoughts?

Thanks,
Jonathan

[*] https://pubs.opengroup.org/onlinepubs/9699919799/functions/localtime.html
