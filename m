Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE75FA3742
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 15:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJ1PbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJ1PbR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 11:31:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1EE1CC746
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:31:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f27so13799262eje.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nFjK6BLpzT7lVhN8pP3TzuZPE19vdJc+5KwpewTGYyk=;
        b=eR7S/HHAPVZEzJv9L57JkFlR5hiXtYLv2lB6I4LGcw25zp6AdmR16/cX7nsNi2m7YA
         vHYUusTe2g4FE3eTIllkmWf1X/1Dg8K5ZxNKl9PDpLgCsm0Rrn2DL8KSXMmOdcRSze1y
         3jgqUYj4suUyueXoncs0ihuObBLltU95LeVba11clcPwnd7ruVrAfCiN1njlRAGFvRTA
         mSTUj/LXrx66ymskka1p7uxewy4sxekjjSutGHn0PGWQodGll8I7hShuVXLVQS1ghJW/
         ovWNPpYqz6rtddUbvnA2KHTFUuoN1e0ggUn2LibJedU81qIEN8mNHWlMIJGgl1+EgkI6
         OXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFjK6BLpzT7lVhN8pP3TzuZPE19vdJc+5KwpewTGYyk=;
        b=gO0n/cmysx7jJyQJyG57pdFuJEWw6R2gDadY0QqI0cj7rSgtuqXwuiLYO4j/PqhiH+
         T5Ced7BoigGXzEj2CRXX1ZRfPRIwu0sNADQPcmHOpVnUBsXs7FageO8EByC6Rv44TcrE
         ViM6jbTQz2UynyncUUmKHKHmhPujofCQ+w5g5nMhS1JZMFjPDLCYjbEfvOZYRxQPVwQt
         XtZlc7eLFOSmE4/qR/5eHmTGJgk/s6f/jOYSiIrXoo5TbQweySug9dHNnmp8Xzpv0jws
         XUsWzwG8W+FHHOQB158RfyPiy7PGpWv2FyaIIPTUTfGpVT3QXW7Egy1EzkKkjXvtrxrX
         JY5Q==
X-Gm-Message-State: ACrzQf0eOysdJfblKjuHsGgyiqXuYs3RtWDAMy0pNv14jCcO8jlFeQNa
        IfzhlS7e4c2E58xv+PtGSrf0CCJyLmY=
X-Google-Smtp-Source: AMsMyM4y+8yci8AAqwSMJYm5S8mWYVMfjXOLsRA2ptMTSJnENDmvrsAfWV9MNZdc78w+lOLdfRqg2g==
X-Received: by 2002:a17:906:5ac2:b0:78d:3358:7694 with SMTP id x2-20020a1709065ac200b0078d33587694mr47464405ejs.276.1666971074714;
        Fri, 28 Oct 2022 08:31:14 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fj17-20020a1709069c9100b007a4e02e32ffsm2390029ejc.60.2022.10.28.08.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:31:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooRKD-009vds-1O;
        Fri, 28 Oct 2022 17:31:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Date:   Fri, 28 Oct 2022 17:01:58 +0200
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
Message-ID: <221028.867d0k7yny.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 28 2022, Patrick Steinhardt wrote:

> When serving a push, git-receive-pack(1) needs to verify that the
> packfile sent by the client contains all objects that are required by
> the updated references. This connectivity check works by marking all
> preexisting references as uninteresting and using the new reference tips
> as starting point for a graph walk.
>
> This strategy has the major downside that it will not require any object
> to be sent by the client that is reachable by any of the repositories'
> references. While that sounds like it would be indeed what we are after
> with the connectivity check, it is arguably not. The administrator that
> manages the server-side Git repository may have configured certain refs
> to be hidden during the reference advertisement via `transfer.hideRefs`
> or `receivepack.hideRefs`. Whatever the reason, the result is that the
> client shouldn't expect that any of those hidden references exists on
> the remote side, and neither should they assume any of the pointed-to
> objects to exist except if referenced by any visible reference. But
> because we treat _all_ local refs as uninteresting in the connectivity
> check, a client is free to send a packfile that references objects that
> are only reachable via a hidden reference on the server-side, and we
> will gladly accept it.
>
> Besides the correctness issue there is also a performance issue. Git
> forges tend to do internal bookkeeping to keep alive sets of objects for
> internal use or make them easy to find via certain references. These
> references are typically hidden away from the user so that they are
> neither advertised nor writeable. At GitLab, we have one particular
> repository that contains a total of 7 million references, of which 6.8
> million are indeed internal references. With the current connectivity
> check we are forced to load all these references in order to mark them
> as uninteresting, and this alone takes around 15 seconds to compute.
>
> We can fix both of these issues by changing the logic for stateful
> invocations of git-receive-pack(1) where the reference advertisement and
> packfile negotiation are served by the same process. Instead of marking
> all preexisting references as unreachable, we will only mark those that
> we have announced to the client.
>
> Besides the stated fix to correctness this also provides a huge boost to
> performance in the repository mentioned above. Pushing a new commit into
> this repo with `transfer.hideRefs` set up to hide 6.8 million of 7 refs
> as it is configured in Gitaly leads to an almost 7.5-fold speedup:

Really well explained.

>     Benchmark 1: main
>       Time (mean =C2=B1 =CF=83):     29.902 s =C2=B1  0.105 s    [User: 2=
9.176 s, System: 1.052 s]
>       Range (min =E2=80=A6 max):   29.781 s =E2=80=A6 29.969 s    3 runs
>
>     Benchmark 2: pks-connectivity-check-hide-refs
>       Time (mean =C2=B1 =CF=83):      4.033 s =C2=B1  0.088 s    [User: 4=
.071 s, System: 0.374 s]
>       Range (min =E2=80=A6 max):    3.953 s =E2=80=A6  4.128 s    3 runs
>
>     Summary
>       'pks-connectivity-check-hide-refs' ran
>         7.42 =C2=B1 0.16 times faster than 'main'

And impressive, thanks!

> Unfortunately, this change comes with a performance hit when refs are
> not hidden. Executed in the same repository:
>
>     Benchmark 1: main
>       Time (mean =C2=B1 =CF=83):     45.780 s =C2=B1  0.507 s    [User: 4=
6.908 s, System: 4.838 s]
>       Range (min =E2=80=A6 max):   45.453 s =E2=80=A6 46.364 s    3 runs
>
>     Benchmark 2: pks-connectivity-check-hide-refs
>       Time (mean =C2=B1 =CF=83):     49.886 s =C2=B1  0.282 s    [User: 5=
1.168 s, System: 5.015 s]
>       Range (min =E2=80=A6 max):   49.589 s =E2=80=A6 50.149 s    3 runs
>
>     Summary
>       'main' ran
>         1.09 =C2=B1 0.01 times faster than 'pks-connectivity-check-hide-r=
efs'
>
> This is probably caused by the overhead of reachable tips being passed
> in via git-rev-list(1)'s standard input, which seems to be slower than
> reading the references from disk.
>
> It is debatable what to do about this. If this were only about improving
> performance then it would be trivial to make the new logic depend on
> whether or not `transfer.hideRefs` has been configured in the repo. But
> as explained this is also about correctness, even though this can be
> considered an edge case. Furthermore, this slowdown is really only
> noticeable in outliers like the above repository with an unreasonable
> amount of refs. The same benchmark in linux-stable.git with about
> 4500 references shows no measurable difference:

Do we have a test that would start failing if we changed the behavior?
Perhaps such a test is peeking too much behind the curtain, but if it's
easy come up with one I think it would be most welcome to have it
alongside this.  to have exposes

> -static void write_head_info(void)
> +static void write_head_info(struct oidset *announced_objects)
>  {
> -	static struct oidset seen =3D OIDSET_INIT;
> -
> -	for_each_ref(show_ref_cb, &seen);
> -	for_each_alternate_ref(show_one_alternate_ref, &seen);
> -	oidset_clear(&seen);
> +	for_each_ref(show_ref_cb, announced_objects);
> +	for_each_alternate_ref(show_one_alternate_ref, announced_objects);
>  	if (!sent_capabilities)
>  		show_ref("capabilities^{}", null_oid());

Nit: The variable rename stands out slightly,
i.e. s/&seen/announced_objects/ not s/&seen/seen/, especially as:

>  static void execute_commands(struct command *commands,
>  			     const char *unpacker_error,
>  			     struct shallow_info *si,
> -			     const struct string_list *push_options)
> +			     const struct string_list *push_options,
> +			     struct oidset *announced_oids)

Here we have the same variable, but now it's *_oids, not *objects.

> +	if (oidset_size(announced_oids) !=3D 0) {

Nit as before: The "!=3D 0" can go here.

> @@ -2462,6 +2473,7 @@ int cmd_receive_pack(int argc, const char **argv, c=
onst char *prefix)
>  {
>  	int advertise_refs =3D 0;
>  	struct command *commands;
> +	struct oidset announced_oids =3D OIDSET_INIT;
>  	struct oid_array shallow =3D OID_ARRAY_INIT;
>  	struct oid_array ref =3D OID_ARRAY_INIT;
>  	struct shallow_info si;
> @@ -2524,7 +2536,7 @@ int cmd_receive_pack(int argc, const char **argv, c=
onst char *prefix)
>  	}
>=20=20
>  	if (advertise_refs || !stateless_rpc) {
> -		write_head_info();
> +		write_head_info(&announced_oids);
>  	}
>  	if (advertise_refs)
>  		return 0;

This introduces a memory leak to the function., We probably have other
ones in code it calls, but from a quick eyeballing not in the function
itself.

Squashing in / combining it with this should do it, as it never returns
non-zero (except for calling die()):
=09
	diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
	index 44bcea3a5b3..8d5c2fbef1c 100644
	--- a/builtin/receive-pack.c
	+++ b/builtin/receive-pack.c
	@@ -2527,7 +2527,7 @@ int cmd_receive_pack(int argc, const char **argv, co=
nst char *prefix)
	 		write_head_info();
	 	}
	 	if (advertise_refs)
	-		return 0;
	+		goto cleanup;
=09=20
	 	packet_reader_init(&reader, 0, NULL, 0,
	 			   PACKET_READ_CHOMP_NEWLINE |
	@@ -2587,6 +2587,7 @@ int cmd_receive_pack(int argc, const char **argv, co=
nst char *prefix)
	 			update_server_info(0);
	 		clear_shallow_info(&si);
	 	}
	+cleanup:
	 	if (use_sideband)
	 		packet_flush(1);
	 	oid_array_clear(&shallow);

> @@ -2591,6 +2603,7 @@ int cmd_receive_pack(int argc, const char **argv, c=
onst char *prefix)
>  		packet_flush(1);
>  	oid_array_clear(&shallow);
>  	oid_array_clear(&ref);
> +	oidset_clear(&announced_oids);
>  	free((void *)push_cert_nonce);
>  	return 0;
>  }

We'll then properly reach this new oidset_clear()> The oid_array_clear()
are all for variables we're populating after we're past htat "if
(advertise_refs)".

I think if you're re-rolling this sqashing 1/2 and 2/2 together would be
an improvement. The 1/2 is tiny, and it's an API that's not used until
this 1/2. I found myself going back & forth more than helped in
reviewing this.

Ggoing back a bit this:

> +static const struct object_id *iterate_announced_oids(void *cb_data)
> +{
> +	struct oidset_iter *iter =3D cb_data;
> +	return oidset_iter_next(iter);
> +}
> +

Is just used as (from 1/2):

> +	if (opt->reachable_oids_fn) {
> +		const struct object_id *reachable_oid;
> +		while ((reachable_oid =3D opt->reachable_oids_fn(opt->reachable_oids_d=
ata)) !=3D NULL)
> +			if (fprintf(rev_list_in, "^%s\n", oid_to_hex(reachable_oid)) < 0)
> +				break;
> +	}

After doing above:

> +	if (oidset_size(announced_oids) !=3D 0) {
> +		oidset_iter_init(announced_oids, &announced_oids_iter);
> +		opt.reachable_oids_fn =3D iterate_announced_oids;
> +		opt.reachable_oids_data =3D &announced_oids_iter;
> +	}

But I don't see the reason for the indirection, but maybe I'm missing
something obvious.

Why not just pass the oidset itself and have connected.c iterate through
it, rather than going thorugh this callback / data indirection?

