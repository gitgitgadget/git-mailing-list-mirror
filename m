Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D41DFF7
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035621; cv=none; b=drcdby+cIoGMO0K/ZnxOPpzAmIvAffmydmVyXp4oCqNfbBXjorQvR8jL1z4WQNWALAaNYuATZ1WOP8OBpprrflYhTQrmayJVBBT8EQNlhmqOwgp/+ebA+P25j2CuXeBYSv5ZQdUdM/cSyJE01ViNQ3XC/AY50yImxEjo1KYu0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035621; c=relaxed/simple;
	bh=Sfb+VCp/eNGC8ZGHMHLW3BpCeS/TtTO2NHNstiBg8KA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YIOrxxgpS3ZxbdFfC62pso2lCmU6bZoa7HiQiwRV7aPFgg2mPQBsGjFu2vyyhfVWoli4up0wHmajvMEjw67rsbC63AVDsO3RjYHYsNXxpokoMvQ1GoN2JlfNDOACkHPB+b4Yp9fCcRThwYgpVNV3zkpoYEe5NRbGwbuJgUvkPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k+YHAMYM; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k+YHAMYM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E1BE81F89A;
	Mon, 10 Jun 2024 12:06:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Sfb+VCp/eNGC
	8ZGHMHLW3BpCeS/TtTO2NHNstiBg8KA=; b=k+YHAMYMp6Q+zNej5pqUD9jW74iq
	MQ5IQN6Vb8wnI9cQastjZd8DXm7oLJ6Rkgt0VfAS+7ILINsh5kQXEUIDrWXsV1aO
	s6Sg9IGO/+ymcV+Kap0MDDmaSjq0FP64GaXqFbZEHZHnlFuKiRXXhjPfWzCpcq7Q
	/HxfDC6D1yWzhXk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D8B511F899;
	Mon, 10 Jun 2024 12:06:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2DE761F898;
	Mon, 10 Jun 2024 12:06:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/2] ci: compile "linux-gcc-default" job with -Og
In-Reply-To: <03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 10 Jun 2024 08:38:25 +0200")
References: <cover.1717655210.git.ps@pks.im> <cover.1718001244.git.ps@pks.im>
	<03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
Date: Mon, 10 Jun 2024 09:06:51 -0700
Message-ID: <xmqqed946auc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7345D0C0-2743-11EF-B528-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> While we could adapt all jobs to compile with `-Og` now, that would
> potentially mask other warnings that only get diagnosed with `-O2`.

I would say it is not just "potentially".  It is likely that higher
optimization levels will diagnose breakage more correctly, while
lower optimization levels may trigger warnings more often.  I
suspect a large part of those that lower optimization levels alone
find may be due to false positives.

So, ... I had a strong knee-jerk reaction against "While we could
adapt all" with "why would anybody sane would even want to do such a
thing in the first place?"  If it were phrased like "as we have
plenty of jobs compiling with -O2, we can afford to switch a few of
them to different optimization levels, and we may find bugs that the
exiting level did not notice, as the compilers' understanding of the
data and control flow is affected by these -O levels", I would have
understood it, and I think that is what happens in this patch.

I just tried compiling pack-mtimes.c (untouced between maint and
seen) with -Og using gcc-11, gcc-12, and gcc-13, using the exact
copy of the command line with V=3D1 output I see at the GitHub CI
[*1*] (after all, this was a good use case, even though it was
dropped from this round ;-)

The earlier versions of the compiler mark the use of mtimes_size
that is guarded in "if (data)" as maybe-uninitialized:

        pack-mtimes.c: In function =E2=80=98load_pack_mtimes_file=E2=80=99=
:
        pack-mtimes.c:89:25: error: =E2=80=98mtimes_size=E2=80=99 may be =
used uninitialized [-Werror=3Dmaybe-uninitialized]
           89 |                         munmap(data, mtimes_size);
              |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
        pack-mtimes.c:32:16: note: =E2=80=98mtimes_size=E2=80=99 was decl=
ared here
           32 |         size_t mtimes_size, expected_size;
              |                ^~~~~~~~~~~
        cc1: all warnings being treated as errors
        make: *** [Makefile:2750: pack-mtimes.o] Error 1

But as I already reported elsewhere, this is a false positive.  The
place "data" can possibly become non-NULL happens only after the
control passes the place mtimes_size get assigned a meaningful
value.  If the control reached here and data were non-NULL, the
control flow guarantees that mtimes_size has been assigned
xsize_t(st.st_size) and cannot be uninitialized.

We can squelch the warning by initializing the variable to a
meaningless value, like 0, but I consider that such a change makes
the resulting code a lot worse than the original, and that is not
because I do not want an extra and meaningless assignment emitted
[*2*] in the resulting binary whose performance impact cannot be
measured by anybody.

It is bad because it defeats efforts by compilers that understand
the data flow a bit better to diagnose a true "used uninitialized"
bugs we may introduce in the future.  Adding such a workaround goes
against the longer-term health of the codebase.

For example, I could add another use of mtimes_size that is not
guarded by "if (data)" right next to it, i.e.

        @@ -87,6 +87,7 @@ static int load_pack_mtimes_file(char *mtimes_f=
ile,
                if (ret) {
                        if (data)
                                munmap(data, mtimes_size);
        +		printf("debug %d\n", (int)mtimes_size);
                } else {
                        *len_p =3D mtimes_size;
                        *data_p =3D data;

gcc-13 does notice that we are now truly using the variable
uninitialized and flags it for us (gcc-12 also does notice but the
important difference is that gcc-13 refrained from warning at the
safe use of the variable that is guarded by "if (data)").

Once we initialize the variable to meaninless 0 as a workaround,
however, the compiler cannot help us with the "used uninitialized"
warning, and there is no "the program uses the variable what was
initialized with meaningless value before it get set a meaningful
value" warning, unfortunately X-<.  And that, not an extra
assignment, is why such a workaround  goes against the longer-term
health of the codebase.

By the way, it is not just pack-mtimes.c [*3*]; there are quite a few
obvious false positives, e.g.

builtin/branch.c: In function =E2=80=98print_current_branch_name=E2=80=99=
:
builtin/branch.c:509:17: error: =E2=80=98shortname=E2=80=99 may be used u=
ninitialized [-Werror=3Dmaybe-uninitialized]
  509 |                 puts(shortname);
      |                 ^~~~~~~~~~~~~~~

where after skip_prefix() computed shortname like so:

	else if (skip_prefix(refname, "refs/heads/", &shortname))
		puts(shortname);

and the compiler at that low optimization level does not even notice
that the static inline function skip_prefix() never returns true
without updating its third parameter to a valid pointer X-<.

And adding a workaround for each and every uses of variable that are
set by skip_prefix() like so?  I am not sure if that is a good move

If you saw some diagnosis that "-Og" made but not with higher
optimization levels (with better understanding of the data and
control flow on the compiler's part), I am somewhat curious.

With gcc-13 everything seems to pass locally for me, so I personally
do not mind this patch, but from what I've seen "gcc-12 -Wall -Og"
so far, especially given that GitHub CI (and GitLab CI as well?
otherwise you wouldn't be sending this change, I would imagine)
seems to use a version of compiler whose "-Og -Wall" notices and
flags these "bugs", I am not sure if we want to enable this option
for us.  At least, -Werror and more stupid compilers is not a mix I
would want to live with and I am sure I would not want to add
workaround for such a mix to make our code worse (to end users and
builders who want to use older comiplers with different optimization
levels, we can tell them not to enable -Werror in their build).

Also, with "-Os", we seem to find different set of "bugs" that "-Og"
did not see.  For example, "gcc-13 -Os -Wall" flags that ppid may be
uninitialized in compat/linux/procinfo.c:push_ancestry_name(), but
that is because it does not read stat_parent_pid() [*4*] and realize
that the only time ppid is left unset is when the function returns
-1:

        static void push_ancestry_name(struct strvec *names, pid_t pid)
        {
                int ppid;

                if (stat_parent_pid(pid, &name, &ppid) < 0)
                        goto cleanup;
                ...
                if (ppid)
                        push_ancestry_name(names, ppid);
        cleanup:
                strbuf_release(&name);
		...

It is the same pattern as how "gcc-12 -Og" mishandles skip_prefix().
Another one "-Os" found is in builtin/fast-import.c:file_change_m()
where the compiler does not notice that parse_mode() never returns
non-NULL without setting "mode".  It is exactly the same pattern.


[Footnotes]

 *1* https://github.com/git/git/actions/runs/9432273715/job/25981831882#s=
tep:4:132

 *2* We used to do the (IIRC GCC only) trick to initialize the
     variable to itself, i.e.

        @@ -29,7 +29,7 @@ static int load_pack_mtimes_file(char *mtimes_f=
ile,
                int fd, ret =3D 0;
                struct stat st;
                uint32_t *data =3D NULL;
        -	size_t mtimes_size, expected_size;
        +	size_t mtimes_size =3D mtimes_size, expected_size;
                struct mtimes_header header;

                fd =3D git_open(mtimes_file);

     to work around stupid compilers that flag a variable whose use
     is safe as potentially-used-uninitialized but these days we got
     rid of the trick as some other compiler did not like it (for
     legitimate reasons).  Using the trick is not any better than
     initializing the variable to a meaningless value, like 0, as
     both will prevent smarter compilers from noticing real bugs
     (after all, that is the point of the workaround--not to flag
     use of variable the compiler thinks uninitialized as a bug).

 *3* I was planning to send "these are horrible workarounds to work
     around the recent -Og build failures that has a huge negative
     consequences in the longer term" patch on top of your series.

     But I do not think it is a good idea to add such a huge number
     of workarounds for various optimization levels.  If we could
     add -Og with -Werror disabled, those who may be interested in
     sifting through false positives to find real errors may be able
     to do so without breaking build for others.

 *4* As "-Os" is for smaller code, I would imagine that it didn't
     try to auto inline the function.  Come to think of it, "-Og" is
     to forbid optimizations that interfere with debugging, and code
     inlining may be considered as one, which would certainly
     explain why it has problem with skip_prefix().
