From: Ryne Everett <ryneeverett@gmail.com>
Subject: Re: Fsck configurations and cloning.
Date: Sun, 6 Mar 2016 10:38:15 -0500
Message-ID: <CAGbFckYi1-b1NTaiQ8q1Ny_2+2rZFGMz+R-xgfRo1u5P-LKDwg@mail.gmail.com>
References: <CAGbFckZNpy=2P8kpSsEpCeTFmgzE5MEK7fnS8xJzDSPJs3iJdQ@mail.gmail.com>
	<20160306115850.GA985@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 06 16:38:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acalF-0002nr-UG
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 16:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbcCFPiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 10:38:18 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34833 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbcCFPiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 10:38:17 -0500
Received: by mail-wm0-f51.google.com with SMTP id l68so53749249wml.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Sx+gv6zDQjI2vJkI7hcop6VUDC9sR8dHix52UCdhdRY=;
        b=WxHw1vn37d94IGw4LLEG5vdwrLOmw2/LCuQ4vHPElfaXyD6BqI+uMwnjnissFa5uv7
         /2h3lGMMiXTy58x342zJnoNDbLe2SnTCUj6YqoO+AweFNnNjeWLxNokzFG5zJyOT7tPZ
         0iW6cr3YEG0vaT0Kip+t6aDfDYChy/xJzMAEIrWb6yUCExxudj+MdDzTJ8oe2aQeEI/q
         nQwBxBS31/1WWue9dxehLXBLwHx9zp60E28HZaqspEdFhTfT75F0eZArZHI9hrNv/n6Q
         vvgF3y3vpGHaQQ+y2FfIhMFJd65O/oN5YEZjFF3ZNGDNoEnyacJufTY7ksF9ZuDBkoHe
         J5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Sx+gv6zDQjI2vJkI7hcop6VUDC9sR8dHix52UCdhdRY=;
        b=IIpeIQedIMPrb6gWfWlBVgNHxj6LosPchyfX8Qmsucx6s/duMCM/m8fUTlkg2eLSvE
         lykdTDAKwZU884PkogQdSG08LyxBbqVl24Npp8Aj+OXUMXs/11LCeOTsLHyEspzL/qns
         Tsl9QZkb68K7Pab3KMELFbXv8jn//k8h7e5cEZBUJ1+uXQ0s3iNmj1ERDTUJv59y61Bs
         HZO/0NUElgcQP773Z4o2l8KrrrAj2dJKyp6uJCgcYlR2lS1BO5GIss/efu+3d1sWuVBB
         FgYZu5g7fS2X5mwbZNNxsqGvkQ7tae/SqauGun7Wchf7VZXhrSCU+CYy4YPNrEXY+2T4
         WIVQ==
X-Gm-Message-State: AD7BkJLgCq6usueY0aHZX31oEy61+f1ejVuAsm7/h8MiEUhDpygPT8QUYeUBrSYEaeEHiIn5+59/xv4DSWCh0Q==
X-Received: by 10.194.123.131 with SMTP id ma3mr18038926wjb.107.1457278695249;
 Sun, 06 Mar 2016 07:38:15 -0800 (PST)
Received: by 10.28.16.15 with HTTP; Sun, 6 Mar 2016 07:38:15 -0800 (PST)
In-Reply-To: <20160306115850.GA985@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288362>

> I think there are two problems here.
>
> The first is that fsck.skiplist takes a filename that contains a list of
> sha1s, not the sha1s themselves. So it would be more like:
>
>   echo 5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8 >skiplist
>   git -c fsck.skiplist="$(pwd)/skiplist" clone ...

I think I got this one right. Note the use of `cat` in my original post:

  $ cat $(git config --get fsck.skiplist)
    5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8

> The second is is that only "fsck" and "receive-pack" seem to have
> learned about skiplist and other per-error config. There is no matching
> fetch.fsck.* config to cover fetches.

Ah, well that sounds like the answer -- my original assumption was wrong.

> With the patch below (which I don't think is suitable for inclusion;
> it's a copy-paste from receive-pack, and should be re-factored to share
> code; doing so might be a nice low-hanging-fruit project for somebody),
> I can do:
>
>    echo 5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8 >skiplist
>    git -c transfer.fsckobjects=true \
>        -c fetch.fsck.skiplist="$(pwd)/skiplist" \
>        clone https://github.com/kennethreitz/requests.git
>
> ---
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f96f6df..19c83fa 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -16,6 +16,7 @@
>  #include "prio-queue.h"
>  #include "sha1-array.h"
>  #include "sigchain.h"
> +#include "fsck.h"
>
>  static int transfer_unpack_limit = -1;
>  static int fetch_unpack_limit = -1;
> @@ -24,6 +25,7 @@ static int prefer_ofs_delta = 1;
>  static int no_done;
>  static int fetch_fsck_objects = -1;
>  static int transfer_fsck_objects = -1;
> +static struct strbuf fsck_msg_types = STRBUF_INIT;
>  static int agent_supported;
>  static struct lock_file shallow_lock;
>  static const char *alternate_shallow_file;
> @@ -762,7 +764,7 @@ static int get_pack(struct fetch_pack_args *args,
>             : transfer_fsck_objects >= 0
>             ? transfer_fsck_objects
>             : 0)
> -               argv_array_push(&cmd.args, "--strict");
> +               argv_array_pushf(&cmd.args, "--strict%s", fsck_msg_types.buf);
>
>         cmd.in = demux.out;
>         cmd.git_cmd = 1;
> @@ -895,6 +897,32 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>         return ref;
>  }
>
> +static int fetch_config_cb(const char *var, const char *value, void *data)
> +{
> +
> +       if (strcmp(var, "fetch.fsck.skiplist") == 0) {
> +               const char *path;
> +
> +               if (git_config_pathname(&path, var, value))
> +                       return 1;
> +               strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
> +                           fsck_msg_types.len ? ',' : '=', path);
> +               free((char *)path);
> +               return 0;
> +       }
> +
> +       if (skip_prefix(var, "fetch.fsck.", &var)) {
> +               if (is_valid_msg_type(var, value))
> +                       strbuf_addf(&fsck_msg_types, "%c%s=%s",
> +                                   fsck_msg_types.len ? ',' : '=', var, value);
> +               else
> +                       warning("Skipping unknown msg id '%s'", var);
> +               return 0;
> +       }
> +
> +       return 0;
> +}
> +
>  static void fetch_pack_config(void)
>  {
>         git_config_get_int("fetch.unpacklimit", &fetch_unpack_limit);
> @@ -903,7 +931,7 @@ static void fetch_pack_config(void)
>         git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
>         git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
>
> -       git_config(git_default_config, NULL);
> +       git_config(fetch_config_cb, NULL);
>  }
>
>  static void fetch_pack_setup(void)
