Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AE6C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 06:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377546AbiDDGrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 02:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbiDDGrE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 02:47:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD228E33
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 23:45:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ot30so7859148ejb.12
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 23:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TBufzerFjuj9fG0e3I/n3Sr9+F6+8lRTVLwkk1G5fbA=;
        b=S6zY8Cjwd9B8rCp1jcS9Uw+Mmm2QDzAabi6sJcetdc8VtGYFPjWp9+01dwlZLblqjP
         KbJ1mLtA37qbshJgMEa3Hcxb9cki95OXYoYOIa4quIRSwINr0e+gOKZxINdKunIv/BLj
         4xaZ35YCcyttINCd8rswMBw6Np6ighJwu2t7G3WDYsIAw3ot4nXBmb8yiQ7YERHJJr1y
         rfUWlWyfUZ93ALhT/xCZzh88vc+LNAlBsKrCE2LLfQh+S/Nb0ygSWyVH/oExrv+3gWVw
         BaYNCyHVTmvda7+rakh0dnEsrYxYWC6kMYZQZMrVieawy9bBXzD5e6wmT3F4CLHIMfx1
         9YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TBufzerFjuj9fG0e3I/n3Sr9+F6+8lRTVLwkk1G5fbA=;
        b=PQrLJcrXNqvSk927jLoW/rH5jW/vTMaTDzW9XrVAGCISmQcgWjW71hMbhp2k8iiUJg
         2zntFrapNaKZUJq25S3X0RXc1KPMnnbq85aGrU2m/VkNNT0LbDt8QlAZgu5wxd+/wicM
         t44f/zhcRwPfavuZjx9/3qdIkf4YvbL5q94NLSpfzJfDJhvIg2cGvbOjRtWpGAboCYfP
         584Zk9k6EIPtgPmGOtgZINUX+2uROUAN+8bVypV743DKbl/LK7apqZCfmGEL0FBTCnHj
         KfsH8kl3u3iFhYlnZm/GN0G7/3OqrW/QMUy2dao3JM5XvYH7C4qBucmeV8phEqgja80z
         pQGQ==
X-Gm-Message-State: AOAM530J4aGx/D6r9FzcVtNNWrBvecnxxdMtQ367NTMEtFJBEWFHmb3G
        hftcy+BkF/x5XwsfkKjeLeM=
X-Google-Smtp-Source: ABdhPJzYFe3ewox5foC+7MB3kPq2//fDb+bs/tiY0m+ygOY5jaFOvCuuXaxNME6P0MbX0He3TrVMLA==
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr9386189ejc.762.1649054706710;
        Sun, 03 Apr 2022 23:45:06 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906a29400b006e726777d38sm2060039ejz.72.2022.04.03.23.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:45:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbGRL-002KWp-1Z;
        Mon, 04 Apr 2022 08:43:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/4] Importing and exporting stashes to refs
Date:   Mon, 04 Apr 2022 08:20:29 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
 <xmqqtub9soew.fsf@gitster.g> <xmqqpmlxsnc5.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqpmlxsnc5.fsf@gitster.g>
Message-ID: <220404.86tub9jql5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>>> Changes from v2:
>>> * Fix uninitialized strbuf.
>>> * Avoid C99-style initializations.
>>
>> Thanks.
>>
>> [1] is a CI run of 'seen' without this topic, while [2] is the same
>> but with this topic.
>>
>> t3903.115-117 (stash export) are not very happy in the latter.
>>
>> e.g. https://github.com/git/git/runs/5808828105?check_suite_focus=3Dtrue=
#step:7:6623
>>
>> [References]
>>
>> *1* https://github.com/git/git/actions/runs/2086776970=20
>> *2* https://github.com/git/git/actions/runs/2086887176=20
>
> I think this is coming from a mismerge, conflicting topic being
> =C3=86var's revisions leakage series.  I'll push out an updated
> resolution later today.

It looks like it, I looked at your resolution. It seems that since the
failure you pushed out this on top:
=09
	diff --git a/builtin/stash.c b/builtin/stash.c
	index 35d7c2e828b..b4da17265a1 100644
	--- a/builtin/stash.c
	+++ b/builtin/stash.c
	@@ -150,6 +150,7 @@ static void assert_stash_like(struct stash_info *info,=
 const char *revision)
=09=20
	 static int parse_revision(struct strbuf *revision, const char *commit, in=
t quiet)
	 {
	+	strbuf_init(revision, 0);
	 	if (!commit) {
	 		if (!ref_exists(ref_stash)) {
	 			fprintf_ln(stderr, _("No stash entries found."));
	@@ -192,8 +193,10 @@ static int get_stash_info(struct stash_info *info, in=
t argc, const char **argv)
	 	if (argc =3D=3D 1)
	 		commit =3D argv[0];
=09=20
	-	if (parse_revision(&info->revision, commit, 0))
	+	if (parse_revision(&info->revision, commit, 0)) {
	+		free_stash_info(info);
	 		return -1;
	+	}
=09=20
	 	revision =3D info->revision.buf;

Which per my [1] is odd. I.e. in my topic I'd gotten rid of that
strbuf_init() entirely, see [2].

But looking again the odd interaction with brian's topic is that in his
[2] and [3] he refactored the parse_revision() into existance.

In the version he based things on we always init'd the strbuf there, but
between [2] and [3] that "strbuf_init()" was tasked with the work of a
strbuf_reset().

And on "seen" this (new code) still leaks:
=09
	$ ~/g/git/git stash export --print
	6b0514ae1f670e55f450518c4b4421a997c8d082
=09
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	=3D=3D25882=3D=3DERROR: LeakSanitizer: detected memory leaks
=09
	Direct leak of 910 byte(s) in 14 object(s) allocated from:
	    #0 0x45658d in __interceptor_realloc (/home/avar/g/git/git+0x45658d)
	    #1 0x763f6d in xrealloc /home/avar/g/git/wrapper.c:136:8
	    #2 0x71c031 in strbuf_grow /home/avar/g/git/strbuf.c:99:2
	    #3 0x71d224 in strbuf_vaddf /home/avar/g/git/strbuf.c:395:3
	    #4 0x71d1e1 in strbuf_addf /home/avar/g/git/strbuf.c:336:2
	    #5 0x546f3e in parse_revision /home/avar/g/git/builtin/stash.c:162:3
	    #6 0x547f99 in do_export_stash /home/avar/g/git/builtin/stash.c:1987:8
	    #7 0x543b2b in export_stash /home/avar/g/git/builtin/stash.c:2061:8
	    #8 0x541846 in cmd_stash /home/avar/g/git/builtin/stash.c:2109:12
	    #9 0x45a38a in run_builtin /home/avar/g/git/git.c:466:11
	    #10 0x458e21 in handle_builtin /home/avar/g/git/git.c:720:3
	    #11 0x459d65 in run_argv /home/avar/g/git/git.c:787:4
	    #12 0x458bda in cmd_main /home/avar/g/git/git.c:920:19
	    #13 0x567839 in main /home/avar/g/git/common-main.c:56:11
	    #14 0x7fb9a380f7ec in __libc_start_main csu/../csu/libc-start.c:332:16
	    #15 0x431119 in _start (/home/avar/g/git/git+0x431119)

We just don't test t3903 under linux-leaks yet.

Anyway. I belive that the correct resolution is (but see caveats below):
=09
	diff --git a/builtin/stash.c b/builtin/stash.c
	index b4da17265a1..3b9a6c5b753 100644
	--- a/builtin/stash.c
	+++ b/builtin/stash.c
	@@ -150,7 +150,6 @@ static void assert_stash_like(struct stash_info *info,=
 const char *revision)
=09=20
	 static int parse_revision(struct strbuf *revision, const char *commit, in=
t quiet)
	 {
	-	strbuf_init(revision, 0);
	 	if (!commit) {
	 		if (!ref_exists(ref_stash)) {
	 			fprintf_ln(stderr, _("No stash entries found."));
	@@ -193,10 +192,8 @@ static int get_stash_info(struct stash_info *info, in=
t argc, const char **argv)
	 	if (argc =3D=3D 1)
	 		commit =3D argv[0];
=09=20
	-	if (parse_revision(&info->revision, commit, 0)) {
	-		free_stash_info(info);
	+	if (parse_revision(&info->revision, commit, 0))
	 		return -1;
	-	}
=09=20
	 	revision =3D info->revision.buf;
=09=20
	@@ -1827,7 +1824,7 @@ static int write_commit_with_parents(struct object_i=
d *out, const struct object_
	 		goto out;
	 	}
	 out:
	-	strbuf_reset(&msg);
	+	strbuf_release(&msg);
	 	unuse_commit_buffer(this, buffer);
	 	free(author);
	 	free(committer);
	@@ -1965,6 +1962,7 @@ static int do_export_stash(const char *ref, size_t a=
rgc, const char **argv)
	 		 */
	 		for (i =3D 0; i < argc; i++) {
	 			ALLOC_GROW_BY(items, nitems, 1, nalloc);
	+			strbuf_reset(&revision);
	 			if (parse_revision(&revision, argv[i], 0) ||
	 			    get_oid_with_context(the_repository, revision.buf,
	 						 GET_OID_QUIETLY | GET_OID_GENTLY,
	@@ -1983,6 +1981,8 @@ static int do_export_stash(const char *ref, size_t a=
rgc, const char **argv)
	 			char buf[32];
	 			struct object_id oid;
=09=20
	+			strbuf_reset(&revision);
	+
	 			snprintf(buf, sizeof(buf), "%d", i);
	 			if (parse_revision(&revision, buf, 1) ||
	 			    get_oid_with_context(the_repository, revision.buf,
	@@ -2018,6 +2018,7 @@ static int do_export_stash(const char *ref, size_t a=
rgc, const char **argv)
	 		puts(oid_to_hex(&prev->object.oid));
	 out:
	 	free(items);
	+	strbuf_release(&revision);
=09=20
	 	return res;
	 }

I.e. most of that is really feedback/a bug report on [3] and [4],and the
third hunk here is really an unrelated fix where [4] conflated
strbuf_reset() with strbuf_release().

1. https://lore.kernel.org/git/cover-v2-00.27-00000000000-20220323T203149Z-=
avarab@gmail.com/
2. https://lore.kernel.org/git/patch-v5-10.27-4c5404912e9-20220402T102002Z-=
avarab@gmail.com/
2. https://lore.kernel.org/git/20220403182250.904933-3-sandals@crustytoothp=
aste.net/
4. https://lore.kernel.org/git/20220403182250.904933-4-sandals@crustytoothp=
aste.net/
