Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FB9C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 14:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A12F6191F
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 14:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhGCOUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhGCOUp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 10:20:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6623C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 07:18:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ga42so3984075ejc.6
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=u77vLJHafbc9iFGjY9sNbgUURfpGYEoQv4+tj4UkMqc=;
        b=a3TpmIUnS5c+61i+2RfZ4BtpjVj4iodZxDhcaKDUE5KY1ansZy4+qo5ILXd6Q+t1Ey
         IzkLjWMvCHPnvO5m6x+EF4Jt4AHN9hjDGQZTif6/C/zKsVmNS0XHh4r/Z2pX1mlOZbv8
         /YJDqReqhCHJPWTdeFHSrhoimunhHQOHsulmN2NMfnZuo/pWCRdOcPzlw+ij8sk3jUKu
         FarudhhpB4lNno6Ni7Y1l5JdUrRlJWrT6itcxDrzhYHIR79Iv7zqwCoemqXM5uWRt6K6
         2hEIpz6oC+WX2+sFGASPNRWyMxEk66oUzalhtXFFWJ4v/sZJ2DuntjgzpHUwJ8wZ4pws
         kOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=u77vLJHafbc9iFGjY9sNbgUURfpGYEoQv4+tj4UkMqc=;
        b=oNGcieWCkdF/YubZ+THCOzfwWBWohPIirfhlx0c5UrEgE1QmXo9qmyuyIJ4patvT+V
         gwh+C91mM02tVwff1ZpAA5S8kBsLZKi962uQ2YAh4PDSG7lN9ZwAUrWlyYNmhB9lU0UI
         +xxlTBTYu32EAh0nGA7gh9ZyT/tryRCCoopbMnnzJzVgIDVO62OCaUge4S1CTbvQNjJy
         0nkm+Ny0n7k0iZgP2FVlnSjNd0WTX0n/XJ54J1zIaWKXPh75a8PXuQw8H4+fBJjJ2Vdi
         +jCdZCH27aKTigvyLfeylJ6mlf/8xL0F16igP8VSbvI60NMxc6Izf1GDCyp49TY5l6fE
         yrSw==
X-Gm-Message-State: AOAM530V0s8GqKStExYGIMoM2opf9K8YcQ2VTcGu5S9MoZ07btNW4aQE
        lr7zjJYWsmYQeAEeStXScIPx2N1+mWM=
X-Google-Smtp-Source: ABdhPJzdWfJkQwAz3G5YSJuSNgmXu3yZW7c1swqfiG/88Hagitt4yVD7kfm1Zap3agIkz3Zcyf2ccg==
X-Received: by 2002:a17:906:478d:: with SMTP id cw13mr4916576ejc.543.1625321889078;
        Sat, 03 Jul 2021 07:18:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id zn21sm2200357ejb.78.2021.07.03.07.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 07:18:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/15] [GSOC] cat-file: reuse ref-filter logic
Date:   Sat, 03 Jul 2021 15:37:33 +0200
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <e04b970ccb0cad8c0b651ab11f5f52063bd84606.1625155693.git.gitgitgadget@gmail.com>
 <877di8al8n.fsf@evledraar.gmail.com>
 <CAOLTT8RdujpQ2uKEWPyG0HGkUz_EsONw3hEZ6YAhpmQc5rgohA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAOLTT8RdujpQ2uKEWPyG0HGkUz_EsONw3hEZ6YAhpmQc5rgohA@mail.gmail.com>
Message-ID: <87eecf8ork.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 03 2021, ZheNing Hu wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B47=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:39=E5=
=86=99=E9=81=93=EF=BC=9A
>>
>>
>> On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:
>>
>> > From: ZheNing Hu <adlternative@gmail.com>
>> >
>> > In order to let cat-file use ref-filter logic, let's do the
>> > following:
>> >
>> > 1. Change the type of member `format` in struct `batch_options`
>> > to `ref_format`, we will pass it to ref-filter later.
>> > 2. Let `batch_objects()` add atoms to format, and use
>> > `verify_ref_format()` to check atoms.
>> > 3. Use `format_ref_array_item()` in `batch_object_write()` to
>> > get the formatted data corresponding to the object. If the
>> > return value of `format_ref_array_item()` is equals to zero,
>> > use `batch_write()` to print object data; else if the return
>> > value is less than zero, use `die()` to print the error message
>> > and exit; else if return value is greater than zero, only print
>> > the error message, but don't exit.
>> > 4. Use free_ref_array_item_value() to free ref_array_item's
>> > value.
>> >
>> > Most of the atoms in `for-each-ref --format` are now supported,
>> > such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
>> > `%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
>> > `%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
>> > `%(flag)`, `%(HEAD)`, because these atoms are unique to those objects
>> > that pointed to by a ref, "for-each-ref"'s family can naturally use
>> > these atoms, but not all objects are pointed to be a ref, so "cat-file"
>> > will not be able to use them.
>> >
>> > The performance for `git cat-file --batch-all-objects
>> > --batch-check` on the Git repository itself with performance
>> > testing tool `hyperfine` changes from 669.4 ms =C2=B1  31.1 ms to
>> > 1.134 s =C2=B1  0.063 s.
>> >
>> > The performance for `git cat-file --batch-all-objects --batch
>> >>/dev/null` on the Git repository itself with performance testing
>> > tool `time` change from "27.37s user 0.29s system 98% cpu 28.089
>> > total" to "33.69s user 1.54s system 87% cpu 40.258 total".
>>
>> This new feature is really nice, but that's a really bad performance
>> regression. A lot of software in the wild relies on "cat-file --batch"
>> to be *the* performant interface to git for mass-extrction of object
>> data.
>>
>
> Thanks, this performance is indeed worrying.
>
>> That's in increase of ~70% and ~20%, respectively. Have you dug into
>> (e.g. with a profiler) where we're now spending all this time?
>
> See this two attachment about performance flame graph,
> oid_object_info_extended() in get_object() is the key to performance
> limitations.

Most of the problem, although this may not entirely fix the performance
regression, is that you're either looking up everything twice now, or
taking a much more expensive path.

I think using gprof is probably much more handy here. See [1. I did a
`git rev-list --all >rla` and ran that piped into 'git cat-file --batch'
with/without your pathces. Results:
=20=20=20=20
    $ gprof ./git-master ./gmon-master.out | head -n 10
    Flat profile:
=20=20=20=20
    Each sample counts as 0.01 seconds.
      %   cumulative   self              self     total=20=20=20=20=20=20=
=20=20=20=20=20
     time   seconds   seconds    calls  ms/call  ms/call  name=20=20=20=20
     14.29      0.02     0.02   475186     0.00     0.00  nth_packed_object=
_offset
     14.29      0.04     0.02   237835     0.00     0.00  hash_to_hex_algop=
_r
      7.14      0.05     0.01  5220425     0.00     0.00  hashcmp_algop
      7.14      0.06     0.01  4757120     0.00     0.00  hex2chr
      7.14      0.07     0.01  1732023     0.00     0.00  find_entry_ptr

And:
=20=20=20=20
    $ gprof ./git-new ./gmon-new.out |head -n 10
    Flat profile:
=20=20=20=20
    Each sample counts as 0.01 seconds.
      %   cumulative   self              self     total
     time   seconds   seconds    calls  ms/call  ms/call  name
      7.32      0.06     0.06   764570     0.00     0.00  lookup_object
      7.32      0.12     0.06   237835     0.00     0.00  parse_commit_date
      4.88      0.16     0.04   712779     0.00     0.00  nth_packed_object=
_offset
      3.66      0.19     0.03   964574     0.00     0.00  bsearch_hash
      3.66      0.22     0.03   237835     0.00     0.00  grab_sub_body_con=
tents

If you e.g. make lookup_object() simply die when it's called you'll see
that before we don't call it at all, after your patch it's our #1
function.

Before when we have the simplest case of writing out an object this is
our callstack:
=20=20=20=20
    (gdb) bt
    #0  batch_write (opt=3D0x7fffffffde50, data=3D0x555555ab9470, len=3D52)=
 at builtin/cat-file.c:298
    #1  0x000055555558b160 in batch_object_write (obj_name=3D0x55555597cef0=
 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd8c0,
        opt=3D0x7fffffffde50, data=3D0x7fffffffd7f0) at builtin/cat-file.c:=
375
    #2  0x000055555558b36e in batch_one_object (obj_name=3D0x55555597cef0 "=
504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd8c0, opt=3D=
0x7fffffffde50,
        data=3D0x7fffffffd7f0) at builtin/cat-file.c:431
    #3  0x000055555558b8ed in batch_objects (opt=3D0x7fffffffde50) at built=
in/cat-file.c:588
    #4  0x000055555558c0d3 in cmd_cat_file (argc=3D0, argv=3D0x7fffffffe1e0=
, prefix=3D0x0) at builtin/cat-file.c:716
    #5  0x0000555555573adb in run_builtin (p=3D0x555555941870 <commands+240=
>, argc=3D2, argv=3D0x7fffffffe1e0) at git.c:461
    #6  0x0000555555573f00 in handle_builtin (argc=3D2, argv=3D0x7fffffffe1=
e0) at git.c:714
    #7  0x0000555555574182 in run_argv (argcp=3D0x7fffffffe08c, argv=3D0x7f=
ffffffe080) at git.c:781
    #8  0x000055555557460f in cmd_main (argc=3D2, argv=3D0x7fffffffe1e0) at=
 git.c:912
    #9  0x000055555565b508 in main (argc=3D3, argv=3D0x7fffffffe1d8) at com=
mon-main.c:52

After (well, here we're not even to writing it, just looking it up), the
BUG() is my addition:
=20=20=20=20
    (gdb) bt
    #0  BUG_fl (file=3D0x5555558ade71 "object.c", line=3D91, fmt=3D0x555555=
8ade6e "yo") at usage.c:290
    #1  0x00005555557441ca in lookup_object (r=3D0x5555559755c0 <the_repo>,=
 oid=3D0x555555975160 <oi>) at object.c:91
    #2  0x000055555569dfc8 in lookup_commit (r=3D0x5555559755c0 <the_repo>,=
 oid=3D0x555555975160 <oi>) at commit.c:62
    #3  0x00005555557445f5 in parse_object_buffer (r=3D0x5555559755c0 <the_=
repo>, oid=3D0x555555975160 <oi>, type=3DOBJ_COMMIT, size=3D342, buffer=3D0=
x555555ab48e0,
        eaten_p=3D0x7fffffffd36c) at object.c:215
    #4  0x0000555555785094 in get_object (ref=3D0x7fffffffd6b0, deref=3D0, =
obj=3D0x7fffffffd520, oi=3D0x555555975160 <oi>, err=3D0x7fffffffd860) at re=
f-filter.c:1803
    #5  0x0000555555785c99 in populate_value (ref=3D0x7fffffffd6b0, err=3D0=
x7fffffffd860) at ref-filter.c:2030
    #6  0x0000555555785d7b in get_ref_atom_value (ref=3D0x7fffffffd6b0, ato=
m=3D0, v=3D0x7fffffffd628, err=3D0x7fffffffd860) at ref-filter.c:2064
    #7  0x000055555578742f in format_ref_array_item (info=3D0x7fffffffd6b0,=
 format=3D0x7fffffffde30, final_buf=3D0x7fffffffd880, error_buf=3D0x7ffffff=
fd860)
        at ref-filter.c:2659
    #8  0x000055555558ab1c in batch_object_write (obj_name=3D0x55555597e3f0=
 "504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd880,
        err=3D0x7fffffffd860, opt=3D0x7fffffffde10, data=3D0x7fffffffd800) =
at builtin/cat-file.c:225
    #9  0x000055555558ade5 in batch_one_object (obj_name=3D0x55555597e3f0 "=
504fe6b39f7747be6427f28d9ca97decf5e6cecf", scratch=3D0x7fffffffd880, err=3D=
0x7fffffffd860,
        opt=3D0x7fffffffde10, data=3D0x7fffffffd800) at builtin/cat-file.c:=
298
    #10 0x000055555558b394 in batch_objects (batch=3D0x7fffffffde10, option=
s=3D0x7fffffffd900) at builtin/cat-file.c:458
    #11 0x000055555558bbd5 in cmd_cat_file (argc=3D0, argv=3D0x7fffffffe1d0=
, prefix=3D0x0) at builtin/cat-file.c:585
    #12 0x0000555555573adb in run_builtin (p=3D0x555555942850 <commands+240=
>, argc=3D2, argv=3D0x7fffffffe1d0) at git.c:461
    #13 0x0000555555573f00 in handle_builtin (argc=3D2, argv=3D0x7fffffffe1=
d0) at git.c:714
    #14 0x0000555555574182 in run_argv (argcp=3D0x7fffffffe07c, argv=3D0x7f=
ffffffe070) at git.c:781
    #15 0x000055555557460f in cmd_main (argc=3D2, argv=3D0x7fffffffe1d0) at=
 git.c:912
    #16 0x000055555565afc1 in main (argc=3D3, argv=3D0x7fffffffe1c8) at com=
mon-main.c:52

I.e. before in batch_object_write() we could use a cheap path of doing
oid_object_info_extended() and directly emitting the content. With your
version we're all the way down to parse_object_buffer(). Meaning that
we're going to be creating a "struct commit" or whatever if we're
looking at a commit, just to print out the raw contents.

I think the best next step here is to add a t/perf/t1006-cat-file.sh
test to stress these various cases, i.e. a plain --batch without a
format, with format, with --batch-all-objects etc. Try to then run that
on each of your commits against the preceding one and see if/when you
have regressions.

Aside from any double-lookups etc, the problem is also that you're
trying to handle a really general case (e.g. with textconv) in a
codepath that needs to be really fast. If anything we should be
inserting some more more optimization shortcuts for common cases into
it. E.g. I was able to trivially speed up 'cat-file --batch-check' on
"master" by hardcoding a path for our default format (patch at the end
of this mail):
=20=20=20=20
    # passed all 2 test(s)
    1..2
    Test                             origin/master     HEAD
    -----------------------------------------------------------------------=
--
    1006.2: cat-file --batch-check   0.60(0.37+0.23)   0.35(0.33+0.02) -41.=
7%

Anything that needs to handle general format patching is going to be
slower. I think /some/ performance regression if we're using something
that's not just the current light strbuf_expand() probably can't be
avoided, but we could/should try to make up the difference at least for
the common case of --batch or --batch-check without --textconv and
perhaps hardcode (and document that it's faster) a path for the default
formats).

1. https://sourceware.org/binutils/docs/gprof/Output.html

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e8..775b7dd1b01 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -360,6 +360,11 @@ static void batch_object_write(const char *obj_name,
 			       struct batch_options *opt,
 			       struct expand_data *data)
 {
+	int default_format =3D !strcmp(opt->format, "%(objectname) %(objecttype) =
%(objectsize)");
+	struct strbuf type_name =3D STRBUF_INIT;
+	if (default_format)
+		data->info.type_name =3D &type_name;
+=09=09
 	if (!data->skip_object_info &&
 	    oid_object_info_extended(the_repository, &data->oid, &data->info,
 				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
@@ -369,14 +374,20 @@ static void batch_object_write(const char *obj_name,
 		return;
 	}
=20
-	strbuf_reset(scratch);
-	strbuf_expand(scratch, opt->format, expand_format, data);
-	strbuf_addch(scratch, '\n');
-	batch_write(opt, scratch->buf, scratch->len);
-
-	if (opt->print_contents) {
-		print_object_or_die(opt, data);
-		batch_write(opt, "\n", 1);
+	if (default_format && !opt->print_contents) {
+		fprintf(stdout, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
+			data->info.type_name->buf,=20
+			(uintmax_t)*data->info.sizep);
+	} else {
+		strbuf_reset(scratch);
+		strbuf_expand(scratch, opt->format, expand_format, data);
+		strbuf_addch(scratch, '\n');
+		batch_write(opt, scratch->buf, scratch->len);
+
+		if (opt->print_contents) {
+			print_object_or_die(opt, data);
+			batch_write(opt, "\n", 1);
+		}
 	}
 }
=20
diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
new file mode 100755
index 00000000000..a295d334715
--- /dev/null
+++ b/t/perf/p1006-cat-file.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+test_description=3D'Basic sort performance tests'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'setup' '
+	git rev-list --all >rla
+'
+
+test_perf 'cat-file --batch-check' '
+	git cat-file --batch-check <rla
+'
+
+test_done
