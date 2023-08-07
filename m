Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31AAC001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 21:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjHGVbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjHGVbX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 17:31:23 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CE11705
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 14:31:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583fe10bb3cso57088757b3.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691443871; x=1692048671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LuoMNrIZdLB7SxejZNS9KoIlyCy0fV1USU+rGrrb3I=;
        b=toys0u5eMh8kaHKbOcXCvjB/zWq9Pq49mdbwUjunkfxt0FQJCr4Ob9GXsK107IDVkd
         vzoRSxQZNXhPs5lcDgpJ7b2sUignMoxL5Hvc0K8uTtyetee/2h5Qv0STDiF7omf/eg7X
         3EdGN3P6EavolUzSdfv54fVn0+nTWuDOvfMdHjX814dzkt6o1uhW7m/ZJo//0cOQmSOQ
         CkswxjKzK388o6nU3wyVvq/dLXhw0u4DYDry6TO/a3WKfZc8g+I2EbYYtQ1FhMp89N+x
         vZzNQy5JWmGUzBx5/ylWwNM/S0hKtfMuO0liAUX2gmp0qyFdFUZIwc8xHA0+3me39iCV
         KwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443871; x=1692048671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LuoMNrIZdLB7SxejZNS9KoIlyCy0fV1USU+rGrrb3I=;
        b=hcggWO3AoD+CT99bAXjWDi/QZ38EyAREz959aCl8D8PN1HX2UAINYEPR71QOHsqHpC
         BolcHvSDM1FnTwKMaS6XDWBc+wvR1wHHri7Bi0sDtQJ7aoZbI/LmZnEHRyfsFMu9/l9/
         3zL776+DLm36ohBtjRhyJjjMp3NlFtEUDK2BF0G6Ldz+t8TXBKbbxngMoTt15V/eJ7kv
         nZie8knk9/1hvj2Fy9ptrsEzL519KGqXavo0OBwwwHRWtWILZopEM1Q2L2JzJI0bZtm0
         o4khMW8se7tRzoZpVrBycmgJRvG3sSzY1HcKmD+PqXm9qQtgH28ewIQWZjUBOR2mHhZB
         QKHg==
X-Gm-Message-State: AOJu0Yw8FsLTNt5veWEN8I1PaGmVaiR+K0+UkmanVHXHQ5JWC52KwTNB
        GVmMNWcrCCYuwkRDBFoRVkf2RQ==
X-Google-Smtp-Source: AGHT+IGECFFLnCyvF6tkA1l5vcUkVKsu8nJTVhrbIFnDXQfoafYUcFZTQ2YimjiVYYN0sHCMdu+yng==
X-Received: by 2002:a81:4806:0:b0:579:e8de:3580 with SMTP id v6-20020a814806000000b00579e8de3580mr12514193ywa.9.1691443871612;
        Mon, 07 Aug 2023 14:31:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y74-20020a81a14d000000b0056d51c39c1fsm2912127ywg.23.2023.08.07.14.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:31:11 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:31:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Message-ID: <ZNFinmsgDI7Upw60@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 06:51:40PM +0000, Derrick Stolee via GitGitGadget wrote:
> In order to set these schedules to a given minute, we can no longer use
> the 'hourly', 'daily', or 'weekly' strings for '<schedule>' and instead
> need to abandon the template model.

Makes sense.

> Modify the template with a custom schedule in the 'OnCalendar' setting.
> This schedule has some interesting differences from cron-like patterns,
> but is relatively easy to figure out from context. The one that might be
> confusing is that '*-*-*' is a date-based pattern, but this must be
> omitted when using 'Mon' to signal that we care about the day of the
> week. Monday is used since that matches the day used for the 'weekly'
> schedule used previously.

I think the launchd version (which uses "0" for the day of the week)
runs on Sunday, if I remember correctly. I don't think that these two
necessarily need to run on the same day of the week when configured to
run weekly.

But I figured I'd raise the question in case you did mean for them to
both run on either Sunday or Monday.

> The rest of the change involves making sure we are writing these .timer
> and .service files before initializing the schedule with 'systemctl' and
> deleting the files when we are done. Some changes are also made to share
> the random minute along with a single computation of the execution path
> of the current Git executable.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/gc.c           | 82 ++++++++++++++++++++++++++++++++----------
>  t/t7900-maintenance.sh |  4 ++-
>  2 files changed, 66 insertions(+), 20 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index b3ef95b10aa..5f5bb95641f 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2299,13 +2299,20 @@ static char *xdg_config_home_systemd(const char *filename)
>  	return xdg_config_home_for("systemd/user", filename);
>  }
>
> -static int systemd_timer_write_unit_templates(const char *exec_path)
> +static int systemd_timer_write_unit_template(enum schedule_priority schedule,
> +					     const char *exec_path,
> +					     int minute)
>  {
>  	char *filename;
>  	FILE *file;
>  	const char *unit;
> +	char *schedule_pattern = NULL;

You should be able to drop the NULL initialization, since you assign
this value unconditionally in the switch statement below (or BUG() on an
unknown schedule type).

> +	const char *frequency = get_frequency(schedule);
> +	char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);
> +	char *local_service_name = xstrfmt("git-maintenance@%s.service", frequency);
> +
> +	filename = xdg_config_home_systemd(local_timer_name);
>
> -	filename = xdg_config_home_systemd("git-maintenance@.timer");
>  	if (safe_create_leading_directories(filename)) {
>  		error(_("failed to create directories for '%s'"), filename);
>  		goto error;
> @@ -2314,6 +2321,23 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
>  	if (!file)
>  		goto error;
>
> +	switch (schedule) {
> +	case SCHEDULE_HOURLY:
> +		schedule_pattern = xstrfmt("*-*-* *:%02d:00", minute);
> +		break;
> +
> +	case SCHEDULE_DAILY:
> +		schedule_pattern = xstrfmt("*-*-* 0:%02d:00", minute);
> +		break;
> +
> +	case SCHEDULE_WEEKLY:
> +		schedule_pattern = xstrfmt("Mon 0:%02d:00", minute);
> +		break;
> +
> +	default:
> +		BUG("Unhandled schedule_priority");
> +	}
> +
>  	unit = "# This file was created and is maintained by Git.\n"
>  	       "# Any edits made in this file might be replaced in the future\n"
>  	       "# by a Git command.\n"
> @@ -2322,12 +2346,12 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
>  	       "Description=Optimize Git repositories data\n"
>  	       "\n"
>  	       "[Timer]\n"
> -	       "OnCalendar=%i\n"
> +	       "OnCalendar=%s\n"
>  	       "Persistent=true\n"
>  	       "\n"
>  	       "[Install]\n"
>  	       "WantedBy=timers.target\n";
> -	if (fputs(unit, file) == EOF) {
> +	if (fprintf(file, unit, schedule_pattern) < 0) {

OK, this is the templating part that you were mentioning earlier. I was
wondering what we were doing fputs()-ing a string with "%i" in it
without a formatting value to fill it in with. But that "%i" pertains to
systemd's instance value, IIUC.

The rest all looks good, thanks.

Thanks,
Taylor
