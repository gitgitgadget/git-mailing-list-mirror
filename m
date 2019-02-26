Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C149420248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfBZMuq (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:50:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39909 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBZMuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:50:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id p27so10615991edc.6
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=foA15n6YBPFqp4S3YyyJidRot8qcEICYQf2Re0ZpMBU=;
        b=fyEwGIvD6c6i+k/6cMdXE0hiLQRB1hhMd3PeFESRBw6nRrZuk3Px1hB5idLdm9J4SU
         seJPvlm5XrRKYgZ4bpKLS3hy6M8hBboFpDgP/FGcTixDEQ1SO2D7c7deArWEcKhin/74
         gYNxCKagLSjSZ8BH9bvn9f0OXFC/hBnHk58fLK9ucUqoNsTR6O63SKsoM2hqxsbbwy1D
         9TjfI1D+KJrWsV5tZUpEIg3hLC3jj/nbwIyL2sE+leXOReOSanA4OzEhGVlPizQ5xpRK
         tT02c1vRWuI2n/BLR8BeNw4hCs1pCUMlief9jQn8bKD1GCRDOYKvo/SIzHG29xauBwb3
         W6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=foA15n6YBPFqp4S3YyyJidRot8qcEICYQf2Re0ZpMBU=;
        b=X+Jah1M2/Bxo/Vxou0MJYwZ1rknQZeUKwgLbta5/1ruaCdVsQ8sAoSPKO3zwHsY8dX
         SGFNtjQMG5UPXj9LAFWchTENccI/DJurGN659DZbX4UekpVVtR0uQEUIfT/kOzIpeYJa
         ZMLdcCdVIB4pu11Ra1oURbMvnREzUa8Vsbjso7IrfbJHjRFnMAAXf3psE9JzlOIjarZN
         JNN8WVoDlsECMaGFG6DTpdUTRhTiI90tQ0uPrCukvFzFScykOyIEx4Y5PU62sMxKloZG
         g3weR8fTWqtxYlBg9iseq3eA3UOFA5cCKh16Cp38R+ldIYDc3z/PeoI6tEk3iCDheWWv
         3XeA==
X-Gm-Message-State: AHQUAuaeyLgj22RDC9jSWOuLgAsrB8Z0uaI/N3IZxwzp4k6gyMQOQlMo
        veMzO4LsNR/98gDTqxfXEic=
X-Google-Smtp-Source: AHgI3IZk4FjKeIPWt/pLeXVKygzbG4ufa883td440/P4R74CZ88zAW4++Z+s5TMbgF27MtGwIsmTag==
X-Received: by 2002:a17:906:1942:: with SMTP id b2mr11674495eje.5.1551185443640;
        Tue, 26 Feb 2019 04:50:43 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id i48sm1230859ede.62.2019.02.26.04.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 04:50:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP RFC PATCH v2 5/5] clone: use dir-iterator to avoid explicit dir traversal
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226051804.10631-6-matheus.bernardino@usp.br> <CACsJy8B1asF3i+G-C1aZRw7QTW7jS+a4VkCbg-17YOTyYHuw5w@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CACsJy8B1asF3i+G-C1aZRw7QTW7jS+a4VkCbg-17YOTyYHuw5w@mail.gmail.com>
Date:   Tue, 26 Feb 2019 13:50:40 +0100
Message-ID: <87tvgqvhlr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 26 2019, Duy Nguyen wrote:

> On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>>
>> Replace usage of opendir/readdir/closedir API to traverse directories
>> recursively, at copy_or_link_directory function, by the dir-iterator
>> API. This simplifies the code and avoid recursive calls to
>> copy_or_link_directory.
>>
>> This process also makes copy_or_link_directory call die() in case of an
>> error on readdir or stat, inside dir_iterator_advance. Previously it
>> would just print a warning for errors on stat and ignore errors on
>> readdir, which isn't nice because a local git clone would end up
>> successfully even though the .git/objects copy didn't fully succeeded.
>>
>> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> ---
>> I can also make the change described in the last paragraph in a separate
>> patch before this one, but I would have to undo it in this patch because
>> dir-iterator already implements it. So, IMHO, it would be just noise
>> and not worthy.
>>
>>  builtin/clone.c | 45 +++++++++++++++++++++++----------------------
>>  1 file changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index fd580fa98d..b23ba64c94 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -23,6 +23,8 @@
>>  #include "transport.h"
>>  #include "strbuf.h"
>>  #include "dir.h"
>> +#include "dir-iterator.h"
>> +#include "iterator.h"
>>  #include "sigchain.h"
>>  #include "branch.h"
>>  #include "remote.h"
>> @@ -411,42 +413,37 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
>>  }
>>
>>  static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>> -                                  const char *src_repo, int src_baselen)
>> +                                  const char *src_repo)
>>  {
>> -       struct dirent *de;
>> -       struct stat buf;
>>         int src_len, dest_len;
>> -       DIR *dir;
>> -
>> -       dir = opendir(src->buf);
>> -       if (!dir)
>> -               die_errno(_("failed to open '%s'"), src->buf);
>> +       struct dir_iterator *iter;
>> +       int iter_status;
>> +       struct stat st;
>> +       unsigned flags;
>>
>>         mkdir_if_missing(dest->buf, 0777);
>>
>> +       flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_FOLLOW_SYMLINKS;
>> +       iter = dir_iterator_begin(src->buf, flags);
>> +
>>         strbuf_addch(src, '/');
>>         src_len = src->len;
>>         strbuf_addch(dest, '/');
>>         dest_len = dest->len;
>>
>> -       while ((de = readdir(dir)) != NULL) {
>> +       while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
>>                 strbuf_setlen(src, src_len);
>> -               strbuf_addstr(src, de->d_name);
>> +               strbuf_addstr(src, iter->relative_path);
>>                 strbuf_setlen(dest, dest_len);
>> -               strbuf_addstr(dest, de->d_name);
>> -               if (stat(src->buf, &buf)) {
>> -                       warning (_("failed to stat %s\n"), src->buf);
>> -                       continue;
>> -               }
>> -               if (S_ISDIR(buf.st_mode)) {
>> -                       if (!is_dot_or_dotdot(de->d_name))
>> -                               copy_or_link_directory(src, dest,
>> -                                                      src_repo, src_baselen);
>> +               strbuf_addstr(dest, iter->relative_path);
>> +
>> +               if (S_ISDIR(iter->st.st_mode)) {
>> +                       mkdir_if_missing(dest->buf, 0777);
>
> I wonder if this mkdir_if_missing is sufficient. What if you have to
> create multiple directories?
>
> Let's say the first advance, we hit "a". The the second advance we hit
> directory "b/b/b/b", we would need to mkdir recursively and something
> like safe_create_leading_directories() would be a better fit.
>
> I'm not sure if it can happen though. I haven't re-read dir-iterator
> code carefully.

This part isn't a problem. It iterates one level at a time. So given a
structure like a/b/c/d/e/f/g/h/i/j/k/some-l you'll find that if you
instrument the loop in clone.c you get:

    dir = a
    dir = a/b
    dir = a/b/c
    dir = a/b/c/d
    dir = a/b/c/d/e
    dir = a/b/c/d/e/f
    dir = a/b/c/d/e/f/g
    dir = a/b/c/d/e/f/g/h
    dir = a/b/c/d/e/f/g/h/i
    dir = a/b/c/d/e/f/g/h/i/j
    dir = a/b/c/d/e/f/g/h/i/j/k
    dir = a/b/c/d/e/f/g/h/i/j/k/some-l

So it's like the old implementation in that way. It readdir()'s and
walks directories one level at a time.
