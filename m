Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69223C433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 19:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiAATJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 14:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiAATJq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 14:09:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF7C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 11:09:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z3so22183654plg.8
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 11:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GIjbnY9fGgjeyihM9rXXNkVaaW0jkyOw9q7j+DIX2IQ=;
        b=AXuX8MdFDzSO/KzK9FUARAgFGsSEpRGPkpdxhWMPDUtPGkRxzwvUW5NVBtgeGRlYBA
         +hLKU7qkErnkcEidJ9JvdY+oxxLAJMeVeCsyTCma4j5/62ctYOcoeyXtROBM5vaWbQEK
         deEPc620C3DwoScZ9ciHlHgeQQqKsab8tY3WX3XD6i1cmJXIKNz8phflHIexiH+R+6jv
         wUiBL5x+Zv4qBmwday5geZ8k6uvrdLvx4diSCGKfFBY96nZgo8Thj2MoyD/RwxnVaAOM
         GKybgmEBMeotK+U3jGvzatEY/5o46AwV27te24nKToVgzW1XUbAIBZv7uKYYoO9UdUKk
         HOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GIjbnY9fGgjeyihM9rXXNkVaaW0jkyOw9q7j+DIX2IQ=;
        b=dHE32oRgpc2mg9qap9b8Nq0HfbwIsJDdvLLHrUQSrijWNG8o+IOHp3WVYxUqMCkIkW
         oX95kXAQSgvrVngVXFyHGohNu9yYBQ1rJI3Qntk4Z1C76WwwAjkd7qDiEpyN7SrJmSZN
         vkHUG09OfAxzhfYWkHhKzP5Mo4+pCuf43r49DtoaQELDWHm+16yBrylgATLcCaDdBzGv
         OYBx2fdAFqKuq3XrT3jqoHkB3hjn+xvdUjBl5z/4iY/7vFAAVj4lXyVokgniQE898E2C
         JBEOX2NBl5R+2i9A3VXZ6OverI68rv0w3Ot/aY6W/Si/QmzjhmSkj/hqw6QrSmqBdehi
         6lvQ==
X-Gm-Message-State: AOAM531zz0hibXDUMMu5fhvI+hoKRGiUnPh/VuattkRogV+1Bidhg6u3
        a3lZpvCcFw720VYoTQ9SKo1QSgvMs4s=
X-Google-Smtp-Source: ABdhPJw1rsEBbXJyJzVPC+EKGUI33J7+6SKm1wxqrT6khJSwK6JZxOQ/YeP3322omZ6Z5r1RHfBEHw==
X-Received: by 2002:a17:90a:e7cc:: with SMTP id kb12mr48246571pjb.189.1641064186013;
        Sat, 01 Jan 2022 11:09:46 -0800 (PST)
Received: from smtpclient.apple ([2600:1012:b144:c416:68d6:5692:a3d4:e3b])
        by smtp.gmail.com with ESMTPSA id b11sm35919485pfv.39.2022.01.01.11.09.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jan 2022 11:09:45 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 1/2] builtin/reflog.c: use parse-options for expire
 subcommand
From:   John Cai <johncai86@gmail.com>
In-Reply-To: <a3db4c74-1c60-5ef5-4865-e0fa9639bc5b@web.de>
Date:   Sat, 1 Jan 2022 11:09:43 -0800
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D4E4253-6EBE-4AA7-86A5-413A732C6E38@gmail.com>
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
 <9bd3c6672c4232e0a5c0905b834146ca02af8a4b.1640932151.git.gitgitgadget@gmail.com>
 <6C9B7D67-D21C-44EA-B3FB-9605968AD0FF@gmail.com>
 <a3db4c74-1c60-5ef5-4865-e0fa9639bc5b@web.de>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 1, 2022, at 3:16 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>=20
> Am 01.01.22 um 03:06 schrieb John Cai:
>>=20
>>=20
>>> On Dec 30, 2021, at 10:29 PM, John Cai via GitGitGadget =
<gitgitgadget@gmail.com> wrote:
>>>=20
>>> From: John Cai <johncai86@gmail.com>
>>>=20
>>> Switch out manual argv parsing for the reflog expire subcommand to =
use
>>> the parse-options API.
>>>=20
>>> Signed-off-by: "John Cai" <johncai86@gmail.com>
>>> ---
>>> builtin/reflog.c | 72 =
++++++++++++++++++++++++------------------------
>>> 1 file changed, 36 insertions(+), 36 deletions(-)
>>>=20
>>> diff --git a/builtin/reflog.c b/builtin/reflog.c
>>> index 175c83e7cc2..afaf5ba67e2 100644
>>> --- a/builtin/reflog.c
>>> +++ b/builtin/reflog.c
>>> @@ -11,13 +11,8 @@
>>> #include "revision.h"
>>> #include "reachable.h"
>>> #include "worktree.h"
>>> +#include "parse-options.h"
>>>=20
>>> -/* NEEDSWORK: switch to using parse_options */
>>> -static const char reflog_expire_usage[] =3D
>>> -N_("git reflog expire [--expire=3D<time>] "
>>> -   "[--expire-unreachable=3D<time>] "
>>> -   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
>>> -   "[--verbose] [--all] <refs>...");
>>> static const char reflog_delete_usage[] =3D
>>> N_("git reflog delete [--rewrite] [--updateref] "
>>>   "[--dry-run | -n] [--verbose] <refs>...");
>>> @@ -539,6 +534,14 @@ static void set_reflog_expiry_param(struct =
cmd_reflog_expire_cb *cb, int slot, c
>>> 		cb->expire_unreachable =3D =
default_reflog_expire_unreachable;
>>> }
>>>=20
>>> +static const char * reflog_expire_usage[] =3D {
>>> +	N_("git reflog expire [--expire=3D<time>] "
>>> +   "[--expire-unreachable=3D<time>] "
>>> +   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
>>> +   "[--verbose] [--all] <refs>..."),
>>> +	NULL
>>> +};
>>> +
>>> static int cmd_reflog_expire(int argc, const char **argv, const char =
*prefix)
>>> {
>>> 	struct expire_reflog_policy_cb cb;
>>> @@ -547,6 +550,29 @@ static int cmd_reflog_expire(int argc, const =
char **argv, const char *prefix)
>>> 	int explicit_expiry =3D 0;
>>> 	unsigned int flags =3D 0;
>>>=20
>>> +	const struct option options[] =3D {
>>> +		OPT_BIT(0, "dry-run", &flags, N_("do not actually prune =
any entries"),
>>> +				EXPIRE_REFLOGS_DRY_RUN),
>>> +		OPT_BIT(0, "rewrite", &flags,
>>> +				N_("rewrite the old SHA1 with the new =
SHA1 of the entry that now precedes it"),
>>> +				EXPIRE_REFLOGS_REWRITE),
>>> +		OPT_BIT(0, "updateref", &flags,
>>> +				N_("update the reference to the value of =
the top reflog entry"),
>>> +				EXPIRE_REFLOGS_UPDATE_REF),
>>> +		OPT_BIT(0, "verbose", &flags, N_("print extra =
information on screen."),
>>> +				EXPIRE_REFLOGS_VERBOSE),
>>> +		OPT_EXPIRY_DATE(0, "expire", &cb.cmd.expire_total,
>>> +				N_("prune entries older than the =
specified time")),
>>> +		OPT_EXPIRY_DATE(0, "expire-unreachable", =
&cb.cmd.expire_unreachable,
>>> +			N_("prune entries older than <time> that are not =
reachable from the current tip of the branch")),
>>> +		OPT_BOOL(0, "stale-fix", &cb.cmd.stalefix,
>>> +				N_("prune any reflog entries that point =
to broken commits")),
>>> +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of =
all references")),
>>> +		OPT_BOOL(1, "single-worktree", &all_worktrees,
>>> +				N_("limits processing to reflogs from =
the current worktree only.")),
>>> +		OPT_END()
>>> +	};
>>> +
>>> 	default_reflog_expire_unreachable =3D now - 30 * 24 * 3600;
>>> 	default_reflog_expire =3D now - 90 * 24 * 3600;
>>> 	git_config(reflog_expire_config, NULL);
>>> @@ -560,41 +586,15 @@ static int cmd_reflog_expire(int argc, const =
char **argv, const char *prefix)
>>>=20
>>> 	for (i =3D 1; i < argc; i++) {
>>=20
>> I was hoping we could get rid of this for loop altogether, but I
>> couldn=E2=80=99t figure out a clean way since --expire and
>> expire-unreachable take a value __and__ set a flag bit. So I kept
>> this for loop for the sole purpose of setting the explicit_expiry bit
>> flag. Any suggestions?
>=20
> The problem is that the default value can vary between reflogs and we
> only know which ones are to be expired after option parsing, right?

That=E2=80=99s a good point. Does it matter that the default value =
varies between reflogs?

Would something like this suffice?

-       for (i =3D 1; i < argc; i++) {
-               const char *arg =3D argv[i];
-               if (starts_with(arg, "--expire=3D")) {
-                       explicit_expiry |=3D EXPIRE_TOTAL;
-               } else if (starts_with(arg, "--expire-unreachable=3D")) =
{
-                       explicit_expiry |=3D EXPIRE_UNREACH;
-               }
-       }
-
        argc =3D parse_options(argc, argv, prefix, options, =
reflog_expire_usage, 0);

+       if (cb.cmd.expire_total !=3D default_reflog_expire)
+               explicit_expiry |=3D EXPIRE_TOTAL;
+       if (cb.cmd.expire_unreachable !=3D =
default_reflog_expire_unreachable)
+               explicit_expiry |=3D EXPIRE_UNREACH;


>=20
> The easiest way is probably to initialize the date variables to a
> magic value that is unlikely to be specified explicitly.
> parse_expiry_date() already uses two such magic values: 0 for "never"
> and TIME_MAX for "now".  Perhaps 1 for "default"?
>=20
> 	cb.cmd.expire_total =3D cb.cmd.expire_unreachable =3D 1;
>=20
> 	argc =3D parse_options(...);
>=20
> 	if (cb.cmd.expire_total =3D=3D 1)
> 		cb.cmd.expire_total =3D default_reflog_expire;
> 	else
> 		explicit_expiry |=3D EXPIRE_TOTAL;
> 	if (cb.cmd.expire_unreachable =3D=3D 1)
> 		cb.cmd.expire_unreachable =3D =
default_reflog_expire_unreachable;
> 	else
> 		explicit_expiry |=3D EXPIRE_UNREACH;
>=20
> A somewhat cleaner approach would be to store that bit separately:
>=20
> 	struct expire_date {
> 		unsigned is_explicitly_set:1;
> 		timestamp_t at;
> 	};
>=20
> ... and add a callback function that wraps parse_opt_expiry_date_cb(),
> expects the new struct (instead of timestamp_t directlly) and sets
> that bit.
>=20
>>=20
>>> 		const char *arg =3D argv[i];
>>> -
>>> -		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
>>> -			flags |=3D EXPIRE_REFLOGS_DRY_RUN;
>>> -		else if (skip_prefix(arg, "--expire=3D", &arg)) {
>>> -			if (parse_expiry_date(arg, =
&cb.cmd.expire_total))
>>> -				die(_("'%s' is not a valid timestamp"), =
arg);
>>> +		if (starts_with(arg, "--expire=3D")) {
>>> 			explicit_expiry |=3D EXPIRE_TOTAL;
>>> -		}
>>> -		else if (skip_prefix(arg, "--expire-unreachable=3D", =
&arg)) {
>>> -			if (parse_expiry_date(arg, =
&cb.cmd.expire_unreachable))
>>> -				die(_("'%s' is not a valid timestamp"), =
arg);
>>> +		} else if (starts_with(arg, "--expire-unreachable=3D")) =
{
>>> 			explicit_expiry |=3D EXPIRE_UNREACH;
>>> 		}
>>> -		else if (!strcmp(arg, "--stale-fix"))
>>> -			cb.cmd.stalefix =3D 1;
>>> -		else if (!strcmp(arg, "--rewrite"))
>>> -			flags |=3D EXPIRE_REFLOGS_REWRITE;
>>> -		else if (!strcmp(arg, "--updateref"))
>>> -			flags |=3D EXPIRE_REFLOGS_UPDATE_REF;
>>> -		else if (!strcmp(arg, "--all"))
>>> -			do_all =3D 1;
>>> -		else if (!strcmp(arg, "--single-worktree"))
>>> -			all_worktrees =3D 0;
>>> -		else if (!strcmp(arg, "--verbose"))
>>> -			flags |=3D EXPIRE_REFLOGS_VERBOSE;
>>> -		else if (!strcmp(arg, "--")) {
>>> -			i++;
>>> -			break;
>>> -		}
>>> -		else if (arg[0] =3D=3D '-')
>>> -			usage(_(reflog_expire_usage));
>>> -		else
>>> -			break;
>>> 	}
>>>=20
>>> +	argc =3D parse_options(argc, argv, prefix, options, =
reflog_expire_usage, 0);
>>> +
>>> 	/*
>>> 	 * We can trust the commits and objects reachable from refs
>>> 	 * even in older repository.  We cannot trust what's reachable
>>> --
>>> gitgitgadget

