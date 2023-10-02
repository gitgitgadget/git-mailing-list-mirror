Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CFBE784A7
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjJBCLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbjJBCLt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:11:49 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E118DC9
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:11:45 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-351365e47f6so39709975ab.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696212705; x=1696817505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CngnftDso5ICSX83YI0ilTzK0gGW3M29C6O27O/5e5I=;
        b=ntohDL/QXin4RdYDbW0OaoAJ2SCh07zdgX4oRsbKkKfCOSPpAIyh2t464+2s3n8Z6a
         8AEG05y3lEKNtFa1UlzJsItXs6qDjsFZdackJYOYsUooGsB6WvPsI3nwwX7j7amCAwuf
         4odd+nDKTkqR0RP1Hh9Ry2YcwDr+T4N737YZCijtJDYWOp4LqpUXoN9rpvomDTLZ7ujA
         33alefbvqIV95N6fcamTo8JZPfcGWNbjt/s8XmF45QBlv8O3kdg7SsoK4uhp2DFx5FwW
         bUukOKsiA5wAYNzXdpyx/u02zA57lDQ3qXPjF9UNkEQ68cIM2NcXQIgQCXwFWQVzzTAr
         NdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696212705; x=1696817505;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CngnftDso5ICSX83YI0ilTzK0gGW3M29C6O27O/5e5I=;
        b=CIfUPhY2aOuFoARkeHqoZJiZkxhB7vB9uK5gQdEc9nC9iklog40Q2VMm2idVQO+HzV
         trBZWOEPsUQmTwYNvQJfJwRGA4fLj36xp0nZl1nfutf9qSIzR1PgsvdzXLFX1e7/cUaz
         79lBj7vLDEeove8W5kAkWARh7zSUvo0Q68UJC0QJBbGvKQrnTYlyiSNQ0++Uwqea1Gy2
         NuQH95BIBP9VErsU8UbrkgS1Au4tGI49OtZEW/hTktoTVGPY95014Obha1qReKPmvCqo
         5iJo8CLuqJTEtE85lVSFDF+8HTT27yaMLekliKi5I2REuWtrak3VB2A1BvX7whnTUTQr
         L24A==
X-Gm-Message-State: AOJu0Yw1Okmr/OiYgii8cMP6VOrdU0Wo1d3VmJe1RUXd/CYBa10d21uF
        I066GBBIId23PeMd0Up7pLQ=
X-Google-Smtp-Source: AGHT+IGjPP7AKQU7z18SxmJSffv9S27EBi3NxIv3iLZBxk1XPDQ4abB8nX5v07aVGY1g9IPTsfbtgQ==
X-Received: by 2002:a05:6e02:1288:b0:351:4f0c:b95d with SMTP id y8-20020a056e02128800b003514f0cb95dmr9865581ilq.22.1696212705229;
        Sun, 01 Oct 2023 19:11:45 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id fy9-20020a0566381e8900b0043a2299df39sm6858265jab.61.2023.10.01.19.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:11:44 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 05/30] loose: add a mapping between SHA-1 and SHA-256
 for loose objects
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
        <20230927195537.1682-5-ebiederm@gmail.com>
        <CAPig+cS02ushqgw+u39Tmnoy3rgp8BzqT4T9D=-01m5fsLxC6Q@mail.gmail.com>
Date:   Sun, 01 Oct 2023 21:11:42 -0500
In-Reply-To: <CAPig+cS02ushqgw+u39Tmnoy3rgp8BzqT4T9D=-01m5fsLxC6Q@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 28 Sep 2023 03:14:31 -0400")
Message-ID: <87v8bp93j5.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 27, 2023 at 3:56=E2=80=AFPM Eric W. Biederman <ebiederm@gmail=
.com> wrote:
>> As part of the transition plan, we'd like to add a file in the .git
>> directory that maps loose objects between SHA-1 and SHA-256.  Let's
>> implement the specification in the transition plan and store this data
>> on a per-repository basis in struct repository.
>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>> diff --git a/loose.c b/loose.c
>> @@ -0,0 +1,245 @@
>> +static int load_one_loose_object_map(struct repository *repo, struct ob=
ject_directory *dir)
>> +{
>> +       struct strbuf buf =3D STRBUF_INIT, path =3D STRBUF_INIT;
>> +       FILE *fp;
>> +
>> +       if (!dir->loose_map)
>> +               loose_object_map_init(&dir->loose_map);
>> +
>> +       insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empt=
y_tree, repo->compat_hash_algo->empty_tree);
>> +       insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_al=
go->empty_tree, repo->hash_algo->empty_tree);
>> +
>> +       insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empt=
y_blob, repo->compat_hash_algo->empty_blob);
>> +       insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_al=
go->empty_blob, repo->hash_algo->empty_blob);
>> +
>> +       insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->null=
_oid, repo->compat_hash_algo->null_oid);
>> +       insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_al=
go->null_oid, repo->hash_algo->null_oid);
>> +
>> +       strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
>> +       fp =3D fopen(path.buf, "rb");
>> +       if (!fp)
>> +               return 0;
>
> This early return leaks `path`. At minimum, call
> `strbuf_release(&path)` before returning.

yep.  Fixed.

>> +       errno =3D 0;
>> +       if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose=
_object_header))
>> +               goto err;
>> +       while (!strbuf_getline_lf(&buf, fp)) {
>> +               const char *p;
>> +               struct object_id oid, compat_oid;
>> +               if (parse_oid_hex_algop(buf.buf, &oid, &p, repo->hash_al=
go) ||
>> +                   *p++ !=3D ' ' ||
>> +                   parse_oid_hex_algop(p, &compat_oid, &p, repo->compat=
_hash_algo) ||
>> +                   p !=3D buf.buf + buf.len)
>> +                       goto err;
>> +               insert_oid_pair(dir->loose_map->to_compat, &oid, &compat=
_oid);
>> +               insert_oid_pair(dir->loose_map->to_storage, &compat_oid,=
 &oid);
>> +       }
>> +
>> +       strbuf_release(&buf);
>> +       strbuf_release(&path);
>> +       return errno ? -1 : 0;
>> +err:
>> +       strbuf_release(&buf);
>> +       strbuf_release(&path);
>> +       return -1;
>> +}
>> +
>> +int repo_write_loose_object_map(struct repository *repo)
>> +{
>> +       kh_oid_map_t *map =3D repo->objects->odb->loose_map->to_compat;
>> +       struct lock_file lock;
>> +       int fd;
>> +       khiter_t iter;
>> +       struct strbuf buf =3D STRBUF_INIT, path =3D STRBUF_INIT;
>> +
>> +       if (!should_use_loose_object_map(repo))
>> +               return 0;
>> +
>> +       strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
>> +       fd =3D hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_D=
IE_ON_ERROR, -1);
>> +       iter =3D kh_begin(map);
>> +       if (write_in_full(fd, loose_object_header, strlen(loose_object_h=
eader)) < 0)
>> +               goto errout;
>> +
>> +       for (; iter !=3D kh_end(map); iter++) {
>> +               if (kh_exist(map, iter)) {
>> +                       if (oideq(&kh_key(map, iter), the_hash_algo->emp=
ty_tree) ||
>> +                           oideq(&kh_key(map, iter), the_hash_algo->emp=
ty_blob))
>> +                               continue;
>> +                       strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(=
map, iter)), oid_to_hex(kh_value(map, iter)));
>> +                       if (write_in_full(fd, buf.buf, buf.len) < 0)
>> +                               goto errout;
>> +                       strbuf_reset(&buf);
>> +               }
>> +       }
>
> Nit: If you call strbuf_reset() immediately before strbuf_addf(), then
> you save the reader of the code the effort of having to scan backward
> through the function to verify that `buf` is empty the first time
> through the loop.

I am actually perplexed why the code works this way.

My gut says we should create the entire buffer in memory and then
write it to disk all in a single system call, and not perform
this line buffering.

Doing that would remove the need for the strbuf_reset entirely,
and would just require the buffer to be primed with the
loose_object_header.

But what is there works and I will leave it for now.

It isn't a bug, and it can be improved with a follow up patch.

>> +       strbuf_release(&buf);
>> +       if (commit_lock_file(&lock) < 0) {
>> +               error_errno(_("could not write loose object index %s"), =
path.buf);
>> +               strbuf_release(&path);
>> +               return -1;
>> +       }
>> +       strbuf_release(&path);
>> +       return 0;
>> +errout:
>> +       rollback_lock_file(&lock);
>> +       strbuf_release(&buf);
>> +       error_errno(_("failed to write loose object index %s\n"), path.b=
uf);
>> +       strbuf_release(&path);
>> +       return -1;
>> +}
>> +
>> +int repo_loose_object_map_oid(struct repository *repo,
>> +                             const struct object_id *src,
>> +                             const struct git_hash_algo *to,
>> +                             struct object_id *dest)
>> +
>> +{
>
> Style: unnecessary blank line before opening `{`

Yep. Fixed.
>
>> +       struct object_directory *dir;
>> +       kh_oid_map_t *map;
>> +       khiter_t pos;
>> +
>> +       for (dir =3D repo->objects->odb; dir; dir =3D dir->next) {
>> +               struct loose_object_map *loose_map =3D dir->loose_map;
>> +               if (!loose_map)
>> +                       continue;
>> +               map =3D (to =3D=3D repo->compat_hash_algo) ?
>> +                       loose_map->to_compat :
>> +                       loose_map->to_storage;
>> +               pos =3D kh_get_oid_map(map, *src);
>> +               if (pos < kh_end(map)) {
>> +                       oidcpy(dest, kh_value(map, pos));
>> +                       return 0;
>> +               }
>> +       }
>> +       return -1;
>> +}

Eric
