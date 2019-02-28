Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCCB720248
	for <e@80x24.org>; Thu, 28 Feb 2019 07:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfB1HyE (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 02:54:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35720 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1HyE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 02:54:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so16182836edp.2
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 23:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4lmUY+SfGiEIifIPthTF91QWDat/NId/p24EFPaVa5I=;
        b=O+hMFXX88mavX2LFxmdemmuqxZD/ZajAKyw0SBoioi3GzpYNuyQ2rYNjcqRws4s1u4
         CGw3LFJ7TsNYIhkO57Q0dccVDBMIqbFeU9fDAbHotxXM2RRKo4Wuur11xxe1wYhqoe2T
         KRrde823PBCUxFERX8SO5wutqfr/bTb30jBczjJ9WPO9O5P2hhZz+/kLlFBSgcNl5VDe
         uYZmKUv/a5yqs7urTAPEcRJTBCawuhrd1xMFrmwjJ/q29mvyK4n6VEYgg95hK1+wh5ec
         yIPTrlccbu/mL3V6pzp203NW6/L13s/rj+VCvSN71uk/6n++/FdCJddCUZrsdO45wBzq
         gkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4lmUY+SfGiEIifIPthTF91QWDat/NId/p24EFPaVa5I=;
        b=mAchraM2PLsUq7dAhXRXtKdz862EuPXM/4EucDCGkuAEWqFupeaYvLRFBHvmochB0a
         8r6/G/mwpJOpssa67cha1sVD+JrYqyru11vRmrdIkk2HknAbivtGB4Y0n5iVIrT2yPKm
         d+Pdy5jZmxouYsd/cLoXXENUjme5JZtP4zTTTVocY2eQ5/WBAMAXFOW43hBmJjp2gzg9
         SLbgveeJuuhESG9AupKZjw5qiB4vJVaXZxL0bfpDyhEKdZw/8q9lyhWAvQaDnVwWMpW3
         zvzEaFoW6bAPQPf+ffGxoSVDTadJSykcpQsO8tJMHe7Z1iBUkSK+a96JE+53nPrX2ag/
         ZJ5Q==
X-Gm-Message-State: AHQUAua7EdXblfJVkquhqlWIexFjcG5Ey6/7tXMc705QHQqMJvNdTgsa
        UT7B3lx16igU24la0EGplJM=
X-Google-Smtp-Source: AHgI3IaurBhMcoIhawKEwC/ODfjFEEvKtBAsm1+12vxgJ94dFVa4lpMf6xEpVXJ2FkIr1V1VQU9wQg==
X-Received: by 2002:aa7:dc46:: with SMTP id g6mr5717610edu.162.1551340441794;
        Wed, 27 Feb 2019 23:54:01 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 3sm2519192ejx.2.2019.02.27.23.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 23:54:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP RFC PATCH v2 5/5] clone: use dir-iterator to avoid explicit dir traversal
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226051804.10631-6-matheus.bernardino@usp.br> <CACsJy8B1asF3i+G-C1aZRw7QTW7jS+a4VkCbg-17YOTyYHuw5w@mail.gmail.com> <CAHd-oW6WJ5JSRAbcy+5kcEA4V8qKEUc9B=6WQZvdqaHz4XHBTA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAHd-oW6WJ5JSRAbcy+5kcEA4V8qKEUc9B=6WQZvdqaHz4XHBTA@mail.gmail.com>
Date:   Thu, 28 Feb 2019 08:53:59 +0100
Message-ID: <87pnrcuz54.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 27 2019, Matheus Tavares Bernardino wrote:

> On Tue, Feb 26, 2019 at 9:32 AM Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
>> <matheus.bernardino@usp.br> wrote:
>> >
>> > Replace usage of opendir/readdir/closedir API to traverse directories
>> > recursively, at copy_or_link_directory function, by the dir-iterator
>> > API. This simplifies the code and avoid recursive calls to
>> > copy_or_link_directory.
>> >
>> > This process also makes copy_or_link_directory call die() in case of an
>> > error on readdir or stat, inside dir_iterator_advance. Previously it
>> > would just print a warning for errors on stat and ignore errors on
>> > readdir, which isn't nice because a local git clone would end up
>> > successfully even though the .git/objects copy didn't fully succeeded.
>> >
>> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> > ---
>> > I can also make the change described in the last paragraph in a separate
>> > patch before this one, but I would have to undo it in this patch because
>> > dir-iterator already implements it. So, IMHO, it would be just noise
>> > and not worthy.
>> >
>> >  builtin/clone.c | 45 +++++++++++++++++++++++----------------------
>> >  1 file changed, 23 insertions(+), 22 deletions(-)
>> >
>> > diff --git a/builtin/clone.c b/builtin/clone.c
>> > index fd580fa98d..b23ba64c94 100644
>> > --- a/builtin/clone.c
>> > +++ b/builtin/clone.c
>> > @@ -23,6 +23,8 @@
>> >  #include "transport.h"
>> >  #include "strbuf.h"
>> >  #include "dir.h"
>> > +#include "dir-iterator.h"
>> > +#include "iterator.h"
>> >  #include "sigchain.h"
>> >  #include "branch.h"
>> >  #include "remote.h"
>> > @@ -411,42 +413,37 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
>> >  }
>> >
>> >  static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>> > -                                  const char *src_repo, int src_baselen)
>> > +                                  const char *src_repo)
>> >  {
>> > -       struct dirent *de;
>> > -       struct stat buf;
>> >         int src_len, dest_len;
>> > -       DIR *dir;
>> > -
>> > -       dir = opendir(src->buf);
>> > -       if (!dir)
>> > -               die_errno(_("failed to open '%s'"), src->buf);
>> > +       struct dir_iterator *iter;
>> > +       int iter_status;
>> > +       struct stat st;
>> > +       unsigned flags;
>> >
>> >         mkdir_if_missing(dest->buf, 0777);
>> >
>> > +       flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_FOLLOW_SYMLINKS;
>> > +       iter = dir_iterator_begin(src->buf, flags);
>> > +
>> >         strbuf_addch(src, '/');
>> >         src_len = src->len;
>> >         strbuf_addch(dest, '/');
>> >         dest_len = dest->len;
>> >
>> > -       while ((de = readdir(dir)) != NULL) {
>> > +       while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
>> >                 strbuf_setlen(src, src_len);
>> > -               strbuf_addstr(src, de->d_name);
>> > +               strbuf_addstr(src, iter->relative_path);
>> >                 strbuf_setlen(dest, dest_len);
>> > -               strbuf_addstr(dest, de->d_name);
>> > -               if (stat(src->buf, &buf)) {
>> > -                       warning (_("failed to stat %s\n"), src->buf);
>> > -                       continue;
>> > -               }
>> > -               if (S_ISDIR(buf.st_mode)) {
>> > -                       if (!is_dot_or_dotdot(de->d_name))
>> > -                               copy_or_link_directory(src, dest,
>> > -                                                      src_repo, src_baselen);
>> > +               strbuf_addstr(dest, iter->relative_path);
>> > +
>> > +               if (S_ISDIR(iter->st.st_mode)) {
>> > +                       mkdir_if_missing(dest->buf, 0777);
>>
>> I wonder if this mkdir_if_missing is sufficient. What if you have to
>> create multiple directories?
>>
>> Let's say the first advance, we hit "a". The the second advance we hit
>> directory "b/b/b/b", we would need to mkdir recursively and something
>> like safe_create_leading_directories() would be a better fit.
>>
>> I'm not sure if it can happen though. I haven't re-read dir-iterator
>> code carefully.
>>
>> >                         continue;
>> >                 }
>> >
>> >                 /* Files that cannot be copied bit-for-bit... */
>> > -               if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
>> > +               if (!strcmp(iter->relative_path, "info/alternates")) {
>>
>> While we're here, this should be fspathcmp to be friendlier to
>> case-insensitive filesystems. You probably should fix it in a separate
>> patch though.
>>
>
> Nice! I will make this change in a separate patch in the series. Thanks!
>
>> >                         copy_alternates(src, dest, src_repo);
>> >                         continue;
>> >                 }
>> > @@ -463,7 +460,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>> >                 if (copy_file_with_time(dest->buf, src->buf, 0666))
>> >                         die_errno(_("failed to copy file to '%s'"), dest->buf);
>> >         }
>> > -       closedir(dir);
>> > +
>> > +       if (iter_status != ITER_DONE) {
>> > +               strbuf_setlen(src, src_len);
>> > +               die(_("failed to iterate over '%s'"), src->buf);
>> > +       }
>>
>> I think you need to abort the iterator even when it returns ITER_DONE.
>> At least that's how the first caller in files-backend.c does it.
>>
>
> Hm, I don't think so, since dir_iterator_advance() already frees the
> resources before returning ITER_DONE. Also, I may be wrong, but it
> doesn't seem to me, that files-backend.c does it. The function
> files_reflog_iterator_advance() that calls dir_iterator_advance() even
> sets the dir-iterator pointer to NULL as soon as ITER_DONE is
> returned.

As Duy notes you're right about this. Just to add: This pattern is
usually something we avoid in the git codebase, i.e. we try not to make
it an error to call the whatever_utility_free() function twice.

See e.g. stop_progress_msg for such an implementation, i.e. we'll check
if it's NULL already and exit early, and maybe use FREE_AND_NULL()
instead of NULL.

It means that for the cost of trivial overhead you don't need to worry
about double freeing or maintaining a "was this freed?" state machine.

Now, whether you want to fix that while you're at it is another matter,
just pointing out that we usually try to avoid this problem entirely...
