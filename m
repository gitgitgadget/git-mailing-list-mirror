Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80C7C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244419AbhLCNXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380409AbhLCNW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:22:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D362C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:19:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v1so11544321edx.2
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WvYbNsyyXsewCzaQaPF3bSNJ2qsH9iJ57zUA6yv4WHY=;
        b=Pm9fyZvzkvoi6sr/2/EQlPY/gEe11Yp5o87bO+lEpd+08kzp01MGuGJKENHTevPs1e
         t1qiskpDa9uR4pmY+e3J7B9cuxLgxaQW3aff2fEY/71OsiDW+VqT/C3f9JGR00lhD7So
         j4GiTlcMwyMLocptHeEIhSpaOBoZjg4SayyUgbujncr7S4aSxUHlm59OKLaO5pJTE7Ab
         l70/wocv16OaGb3gC+1HnYIr1+ZWlbAMFl//1IkQ919Timci6B3iNYujNNcmFOkOwjxQ
         S+jvQeXaAwgPZHOhZj7Wz055fgSpkqAGwxoIiNHvKFQZS2jmVkuXtDGSlQ5YpwSYjfWa
         sJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WvYbNsyyXsewCzaQaPF3bSNJ2qsH9iJ57zUA6yv4WHY=;
        b=It6sUEaW3Il9QhhJdsFFobPkDz9Sz7WNvfMQlJQEMxvS4EJ7IVRlTh27gkaMGL+7+x
         EpOyW6NPp/p7zdKjZ5DqSuUvXmSwsSpoHAANLVTlc5ZTBaZJz+zwocbWbHQAdR5cvgu4
         GYi0w1dDnyfoQGjz95RSXqmJYdEiXN+ajRqqLTe743vAnOKsL6fo90Zfxsp3Vo3zkGIo
         XGtacnehp0Mh2PFfb109Zgh26ROva6/rlwpEhRSEkEJcZOZxkjYg946Igygaq23IVkhx
         /bz/he+kF4h1OzeTemgZgYh4WxBoC+de4G//Zc07el5M5vfGDXOAyovaTYsIeyNDO8b0
         Wmkg==
X-Gm-Message-State: AOAM533H4Yw0U04JMi1NL543g/1kMgEhJUZPXrfNav2rH3ZpG2beZ4PG
        6EjzvyvnYXD2cMQkzLya5+A=
X-Google-Smtp-Source: ABdhPJxvLI+ueNecRFNXmEw2QtcvqmwyuI5U+k3lhhHAxkT5LannxiPZ4VdNI+iGv+jgev8ea4p+wg==
X-Received: by 2002:a17:907:8a13:: with SMTP id sc19mr23437896ejc.130.1638537570407;
        Fri, 03 Dec 2021 05:19:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hs8sm2063182ejc.53.2021.12.03.05.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:19:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt8TJ-0008Uf-5Z;
        Fri, 03 Dec 2021 14:19:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v4 5/5] unpack-objects: unpack_non_delta_entry() read
 data in a stream
Date:   Fri, 03 Dec 2021 14:07:58 +0100
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
 <20211203093530.93589-6-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203093530.93589-6-chiyutianyi@gmail.com>
Message-ID: <211203.86zgphsu5a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> entire contents of a blob object, no matter how big it is. This
> implementation may consume all the memory and cause OOM.
>
> By implementing a zstream version of input_stream interface, we can use
> a small fixed buffer for "unpack_non_delta_entry()".
>
> However, unpack non-delta objects from a stream instead of from an entrie
> buffer will have 10% performance penalty. Therefore, only unpack object
> larger than the "big_file_threshold" in zstream. See the following
> benchmarks:
>
>     hyperfine \
>       --setup \
>       'if ! test -d scalar.git; then git clone --bare https://github.com/=
microsoft/scalar.git; cp scalar.git/objects/pack/*.pack small.pack; fi' \
>       --prepare 'rm -rf dest.git && git init --bare dest.git' \
>       -n 'old' 'git -C dest.git unpack-objects <small.pack' \
>       -n 'new' 'new/git -C dest.git unpack-objects <small.pack' \
>       -n 'new (small threshold)' \
>       'new/git -c core.bigfilethreshold=3D16k -C dest.git unpack-objects =
<small.pack'
>     Benchmark 1: old
>       Time (mean =C2=B1 =CF=83):      6.075 s =C2=B1  0.069 s    [User: 5=
.047 s, System: 0.991 s]
>       Range (min =E2=80=A6 max):    6.018 s =E2=80=A6  6.189 s    10 runs
>
>     Benchmark 2: new
>       Time (mean =C2=B1 =CF=83):      6.090 s =C2=B1  0.033 s    [User: 5=
.075 s, System: 0.976 s]
>       Range (min =E2=80=A6 max):    6.030 s =E2=80=A6  6.142 s    10 runs
>
>     Benchmark 3: new (small threshold)
>       Time (mean =C2=B1 =CF=83):      6.755 s =C2=B1  0.029 s    [User: 5=
.150 s, System: 1.560 s]
>       Range (min =E2=80=A6 max):    6.711 s =E2=80=A6  6.809 s    10 runs
>
>     Summary
>       'old' ran
>         1.00 =C2=B1 0.01 times faster than 'new'
>         1.11 =C2=B1 0.01 times faster than 'new (small threshold)'

So before we wrote used core.bigfilethreshold for two things (or more?):
Whether we show a diff for it (we mark it "binary") and whether it's
split into a loose object.

Now it's three things, we've added a "this is a threshold when we'll
stream the object" to that.

Might it make sense to squash something like this in, so we can have our
cake & eat it too?

With this I get, where HEAD~0 is this change:
=20=20=20=20
    Summary
      './git -C dest.git -c core.bigfilethreshold=3D512m unpack-objects <sm=
all.pack' in 'HEAD~0' ran
        1.00 =C2=B1 0.01 times faster than './git -C dest.git -c core.bigfi=
lethreshold=3D512m unpack-objects <small.pack' in 'HEAD~1'
        1.00 =C2=B1 0.01 times faster than './git -C dest.git -c core.bigfi=
lethreshold=3D512m unpack-objects <small.pack' in 'origin/master'
        1.01 =C2=B1 0.01 times faster than './git -C dest.git -c core.bigfi=
lethreshold=3D16k unpack-objects <small.pack' in 'HEAD~0'
        1.06 =C2=B1 0.14 times faster than './git -C dest.git -c core.bigfi=
lethreshold=3D16k unpack-objects <small.pack' in 'origin/master'
        1.20 =C2=B1 0.01 times faster than './git -C dest.git -c core.bigfi=
lethreshold=3D16k unpack-objects <small.pack' in 'HEAD~1'

I.e. it's 5% slower, not 20% (haven't looked into why), but we'll not
stream out 16k..128MB objects (maybe the repo has even bigger ones?)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..601b7a2418f 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -424,6 +424,17 @@ be delta compressed, but larger binary media files won=
't be.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
=20
+core.bigFileStreamingThreshold::
+	Files larger than this will be streamed out to a temporary
+	object file while being hashed, which will when be renamed
+	in-place to a loose object, particularly if the
+	`core.bigFileThreshold' setting dictates that they're always
+	written out as loose objects.
++
+Default is 128 MiB on all platforms.
++
+Common unit suffixes of 'k', 'm', or 'g' are supported.
+
 core.excludesFile::
 	Specifies the pathname to the file that contains patterns to
 	describe paths that are not meant to be tracked, in addition
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index bedc494e2db..94ce275c807 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -400,7 +400,7 @@ static void unpack_non_delta_entry(enum object_type typ=
e, unsigned long size,
 	void *buf;
=20
 	/* Write large blob in stream without allocating full buffer. */
-	if (!dry_run && type =3D=3D OBJ_BLOB && size > big_file_threshold) {
+	if (!dry_run && type =3D=3D OBJ_BLOB && size > big_file_streaming_thresho=
ld) {
 		write_stream_blob(nr, size);
 		return;
 	}
diff --git a/cache.h b/cache.h
index eba12487b99..4037c7fd849 100644
--- a/cache.h
+++ b/cache.h
@@ -964,6 +964,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
+extern unsigned long big_file_streaming_threshold;
 extern unsigned long pack_size_limit_cfg;
=20
 /*
diff --git a/config.c b/config.c
index c5873f3a706..7b122a142a8 100644
--- a/config.c
+++ b/config.c
@@ -1408,6 +1408,11 @@ static int git_default_core_config(const char *var, =
const char *value, void *cb)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.bigfilestreamingthreshold")) {
+		big_file_streaming_threshold =3D git_config_ulong(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.packedgitlimit")) {
 		packed_git_limit =3D git_config_ulong(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 9da7f3c1a19..4fcc3de7417 100644
--- a/environment.c
+++ b/environment.c
@@ -46,6 +46,7 @@ size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WIND=
OW_SIZE;
 size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
 unsigned long big_file_threshold =3D 512 * 1024 * 1024;
+unsigned long big_file_streaming_threshold =3D 128 * 1024 * 1024;
 int pager_use_color =3D 1;
 const char *editor_program;
 const char *askpass_program;
