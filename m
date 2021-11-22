Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C2AC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhKVSc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhKVSc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:32:58 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953DCC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:29:51 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v1so47353388edx.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=plaB37r4Lotp535URrKpnqXpeUlICw+QlrUjobD+ixY=;
        b=E94rpTCZmw4xsat46n0WPYHqXpsumvleTKEoQYXRPooVmf18ohObgn+VJvd4ixSqvd
         HAKfr7T0+lE4ykLnpWy93Zw5lSJwmw4Rxq96KPuCwuWzAoaeLE/81WfkMtUpcDZFkUhQ
         Ul2Kn3WoS8zLHP7ZeBP2mbxQw9oJGnP4wV+wk9NT5wX9TPOufA3BhVrhlsQr8PCYUngn
         meCcm9UT+3DJ6jMJrK3yW0oHMK2u7+0069XrC+NTlNuA3CJE53pZ8mA+JrPGFin+eTP3
         Mer8HEsc4UeX8/5kPp+ck6uE6IyibqfDP0+Ye4QiDJ0010sduHl+9gIf4lY62ZTZefRO
         ST2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=plaB37r4Lotp535URrKpnqXpeUlICw+QlrUjobD+ixY=;
        b=0G6vdCL4CdOBwBA4u+NWGf616tEW/694BSKu+MHbFvBC5/7dEIkBUujiYlUwiLSYBb
         fQqKJWvt3N5e5ZrrvQzJjDcvVRWCMSOFORBekoHMKoPBPTUEbjb35WMuHz1IkIXeb9mP
         yYlEe0s+uGgestll02mNA/fcAATveXPkp8XbyGakGbiMV7H7+UivnuJVp6g+YO1jfKyR
         dVaPFVgcjfMBHjV+AqbtYXXhIX7BrvognDxTWqFIUKYfXuekD/ujLMyxnEq5H1Lt8Z0e
         WzXxZyG0h6zCxpLtEgtKzHa+v6PRBWLbuaZAkQcxGIaxpmho5x9UM0Mhll0jmCAk1pgw
         DJAA==
X-Gm-Message-State: AOAM532/Y8oVAZxPzHrwvSkEXhk2h8sheOh5by8qVSZYOaxdIbeFZ2HV
        XA4GKSyNVytx01SxUoGqBYT8KGRuFwbHGw==
X-Google-Smtp-Source: ABdhPJzMZLoLDBVHM6quKPKweon3/Ti8bfkK92ZzlCW6JNuA9DXzVqKUEGjhXAdbsSgOkzHqWvGCFw==
X-Received: by 2002:a17:906:7ccf:: with SMTP id h15mr42967193ejp.386.1637605790011;
        Mon, 22 Nov 2021 10:29:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w18sm4474241edx.55.2021.11.22.10.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 10:29:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpE4b-001AEC-1w;
        Mon, 22 Nov 2021 19:29:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 0/5] run-command API: get rid of "argv"
Date:   Mon, 22 Nov 2021 19:26:26 +0100
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <YZvY+BJhxaFIOdnJ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZvY+BJhxaFIOdnJ@coredump.intra.peff.net>
Message-ID: <211122.86sfvoxcv6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Jeff King wrote:

> On Mon, Nov 22, 2021 at 05:04:02PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This series is an alternate but more thorough way to solve the pager
>> segfault reported by Enzo Matsumiya[1], and more generally avoids
>> similar issues in the future.
>>=20
>> That the run-command API exposed two subtly different ways of doing
>> the same thing wouldn't only lead to the sort of bug reported in [1],
>> but also made memory management around it rather painful. As noted by
>> Jeff King in[2]:
>>=20
>>     I'd like to eventually get rid of the argv interface entirely
>>     because it has memory-ownership semantics that are easy to get
>>     wrong.
>
> Yeah, unsurprisingly I'm in favor of this direction (and in fact started
> looking at myself before seeing your responses). It's big and complex
> enough that I do worry about prepending it in front of the segfault bug
> fix being discussed.
>
>> As noted in 5/5 we've still got a similar issue with "env" and
>> "env_array". I've got a follow-up series that similarly removes "env"
>> which we can do at some point (it's much smaller than this one), but
>> for now let's focus on "argv".
>
> I think we should probably do both, though I am OK with doing it
> separately. There are fewer callers for "env", but I found more
> ancillary cleanup necessary (e.g., "const char **" versus "const char
> *const *" headaches).
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
>>   archive-tar: use our own cmd.buf in error message
>>   upload-archive: use regular "struct child_process" pattern
>>   run-command API users: use strvec_pushv(), not argv assignment
>>   run-command API users: use strvec_pushl(), not argv construction
>>   run-command API: remove "argv" member, always use "args"
>
> I left a few comments on individual patches. I had done a rough cut at
> this, too. One big difference is that I used the opportunity to clean up
> some ugly and error-prone uses of argv that are now unnecessary. For
> instance:
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 2b2bac43f3..85d1abad88 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -134,14 +134,13 @@ static void copy_obj_to_fd(int fd, const struct obj=
ect_id *oid)
>=20=20
>  static void write_commented_object(int fd, const struct object_id *objec=
t)
>  {
> -	const char *show_args[5] =3D
> -		{"show", "--stat", "--no-notes", oid_to_hex(object), NULL};
>  	struct child_process show =3D CHILD_PROCESS_INIT;
>  	struct strbuf buf =3D STRBUF_INIT;
>  	struct strbuf cbuf =3D STRBUF_INIT;
>=20=20
>  	/* Invoke "git show --stat --no-notes $object" */
> -	strvec_pushv(&show.args, show_args);
> +	strvec_pushl(&show.args, "show", "--stat", "--no-notes",
> +		     oid_to_hex(object), NULL);
>  	show.no_stdin =3D 1;
>  	show.out =3D -1;
>  	show.err =3D 0;
>
> The show_args variable is error-prone in two ways:
>
>   - the magic number "5" must be in sync with the rest of the array. In
>     this case it's superfluous and could just be removed, but I'll give
>     a related example below.
>
>   - we have to remember to include the trailing NULL. We have to for
>     pushl(), too, but in that case the compiler will warn us when we
>     omit it.
>
> Here's another one:
>
> @@ -943,23 +941,22 @@ static int run_receive_hook(struct command *command=
s,
>=20=20
>  static int run_update_hook(struct command *cmd)
>  {
> -	const char *argv[5];
> +	const char *hook_cmd;
>  	struct child_process proc =3D CHILD_PROCESS_INIT;
>  	int code;
>=20=20
> -	argv[0] =3D find_hook("update");
> -	if (!argv[0])
> +	hook_cmd =3D find_hook("update");
> +	if (!hook_cmd)
>  		return 0;
>=20=20
> -	argv[1] =3D cmd->ref_name;
> -	argv[2] =3D oid_to_hex(&cmd->old_oid);
> -	argv[3] =3D oid_to_hex(&cmd->new_oid);
> -	argv[4] =3D NULL;
> +	strvec_push(&proc.args, hook_cmd);
> +	strvec_push(&proc.args, cmd->ref_name);
> +	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
> +	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
>=20=20
>  	proc.no_stdin =3D 1;
>  	proc.stdout_to_stderr =3D 1;
>  	proc.err =3D use_sideband ? -1 : 0;
> -	strvec_pushv(&proc.args, argv);
>  	proc.trace2_hook_name =3D "update";
>
> In this case the magic "5" really is important, and we get rid of it
> (and again don't need to worry about the terminating NULL).
>
> I'm on the fence on how important it is to do these cleanups. IMHO they
> are half of what really sells the change in the first place (since the
> other bug can pretty easily be fixed without it).
>
> But maybe it is piling too much onto what is already a pretty big
> change. The cleanups could be done individually later.

Yeah, those are nice. I did do most/all those initially myself, but
ended up ejecting them in anticipation of getting comments about runaway
refactoring, as they're not strictly necessary. But I can include them
again if you/Junio would like...

> diff --git a/daemon.c b/daemon.c
> index cc278077d2..4a000ee4af 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -329,10 +329,15 @@ static int run_access_hook(struct daemon_service *s=
ervice, const char *dir,
>  	char *eol;
>  	int seen_errors =3D 0;
>=20=20
> +	strvec_push(&child.args, access_hook);
> +	strvec_push(&child.args, service->name);
> +	strvec_push(&child.args, path);
> +	strvec_push(&child.args, hi->hostname.buf);
> +	strvec_push(&child.args, get_canon_hostname(hi));
> +	strvec_push(&child.args, get_ip_address(hi));
> +	strvec_push(&child.args, hi->tcp_port.buf);
> +
>  	child.use_shell =3D 1;
> -	strvec_pushl(&child.args, access_hook, service->name, path,
> -		     hi->hostname.buf, get_canon_hostname(hi),
> -		     get_ip_address(hi), hi->tcp_port.buf, NULL);
>  	child.no_stdin =3D 1;
>  	child.no_stderr =3D 1;
>  	child.out =3D -1;
>
> I had other changes from yours like this. This is purely cosmetic, and I
> could see arguments either way. I find the one-per-line version a bit
> easier to read. Even though it repeats child.args over and over, it's
> easy to look past since it's all aligned.
>
> I'm OK calling that bike-shedding, but I offer it mostly in case you
> didn't try it the other way and actually like my color. ;)

I do like it better :) It's another thing I did like that initiall, but
ended up moving to strvec_pushl(). IIRC because I got the opposite
request on a recent bundle.c topic of mine (now landed). I.e. it used
multiple aligned strvec_push() initailly, and it was suggested to use
strvec_pushl() instead...
