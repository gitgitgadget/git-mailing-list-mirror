From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] builtin/push.c: fix description of --recurse-submodules option
Date: Wed, 19 Nov 2014 08:46:32 +0800
Message-ID: <CANYiYbG-r2tHXQureuqoFZ+7t27u78w-QUooHAXHRX5qNU+zOg@mail.gmail.com>
References: <1416333466-27186-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	hvoigt@hvoigt.net, phillip.szelat@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 01:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqtPq-000301-3s
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 01:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615AbaKSAqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 19:46:34 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:61890 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220AbaKSAqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 19:46:33 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so169178wiw.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 16:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CK6iCgD+t/pqDgMyPepEF6TbfICJ/7LI0lE8GLrE8t0=;
        b=SCnVD4oyXw7kxdMzfrItNXPARwAaW+5sPKgaOVxdtoh48lWIty+8mXutvzYgCha51Z
         9lUM7+HHy0P6QMkMDBBhUiUg/nEhPtiFU8mOGCtP4m3QpdTg8OLeCN5gGOTmIzotH9nN
         0I/nmHbSJttpM+q9U/vO3YkicRE2y3qZRzlBQFyreTrYYyYgmILpkXhQLgW4z9Xkvkd8
         lShqJsyuf6sRUsmOZ+Nc2vuIX9n25lZfyXN4npA/oOQMflGN59hQkiHXH2DHasaxiAHI
         0dtBJK22iZpLmxoSGeK4K37sVhRFGHvAOMehzdQxNe0obqxpsgHa/kNmDnz50JltVVMA
         NOAw==
X-Received: by 10.180.72.199 with SMTP id f7mr7627436wiv.53.1416357992603;
 Tue, 18 Nov 2014 16:46:32 -0800 (PST)
Received: by 10.194.56.8 with HTTP; Tue, 18 Nov 2014 16:46:32 -0800 (PST)
In-Reply-To: <1416333466-27186-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2014-11-19 1:57 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
> The description of the option for argument "recurse-submodules"
> is marked for translation even if it expects the untranslated
> string and it's missing the option "on-demand" which was introduced
> in eb21c73 (2014-03-29, push: teach --recurse-submodules the on-demand
> option). Fix this by unmark the string for translation and add the
> missing option.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  builtin/push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index a076b19..cfa20c2 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -503,7 +503,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>                   0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>                   N_("require old value of ref to be at this value"),
>                   PARSE_OPT_OPTARG, parseopt_push_cas_option },
> -               { OPTION_CALLBACK, 0, "recurse-submodules", &flags, N_("check"),
> +               { OPTION_CALLBACK, 0, "recurse-submodules", &flags, "check|on-demand",

Yes, should not mark this for translation, and only two available options
for the "--recurse-submodules" flag.

The following code snippet is from builtin/push.c:

451 static int option_parse_recurse_submodules(const struct option *opt,
452                                    const char *arg, int unset)
453 {
454         int *flags = opt->value;
455
456         if (*flags & (TRANSPORT_RECURSE_SUBMODULES_CHECK |
457                       TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND))
458                 die("%s can only be used once.", opt->long_name);
459
460         if (arg) {
461                 if (!strcmp(arg, "check"))
462                         *flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
463                 else if (!strcmp(arg, "on-demand"))
464                         *flags |= TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND;
465                 else
466                         die("bad %s argument: %s", opt->long_name, arg);
467         } else
468                 die("option %s needs an argument (check|on-demand)",
469                                 opt->long_name);
470
471         return 0;
472 }



>                         N_("control recursive pushing of submodules"),
>                         PARSE_OPT_OPTARG, option_parse_recurse_submodules },
>                 OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),
> --
> 2.2.0.rc2.258.gc851c5b
>



-- 
Jiang Xin
