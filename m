Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580B71F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389581AbfIERJV (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:09:21 -0400
Received: from mout.web.de ([212.227.15.3]:34539 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389559AbfIERJU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567703348;
        bh=8qcK6N8VnaBqQKn7wbKPmMpoUL4XUOengrh3+tn9SWk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SIYTj/RT9/+SkBWCfhFnm9nc1BjpiZau5PB0CvzYGLYvQL0m4PLp/K9C/3+YK6k56
         fqsrEvFMiXt8+vtgOV9apr39qqm6qNZv0jAH0UzEGTVASMsa63ImvR23h2+0ksqove
         /6b7XhkCn7l1Km9YPbP/F39ND0IcR2MblWSiPmp4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnjRP-1ieSr63eTH-00htBI; Thu, 05
 Sep 2019 19:09:07 +0200
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
To:     Stephan Beyer <s-beyer@gmx.net>, Paul Tan <pyokagan@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <20190905082459.26816-1-s-beyer@gmx.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6c6c4e71-d9e5-1ad4-74db-12c323da42f7@web.de>
Date:   Thu, 5 Sep 2019 19:08:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905082459.26816-1-s-beyer@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrYM3rghswj/Xi0wyO+08fXqITCzeRqQRqXXTtEHBfPOnDQ0TaT
 gAW/iUyQsfOwqXvCN+J7nnmBs6lyQ/1vYkbSFJu05kQuDHSQLkyLpB1pw52Nh8guJbnD1Pa
 mOhupm0OJCNukJ0xuqky/pbRiIpbojA9SlDoWtXB+UpLXlhGS2Yk6eHwmL5ckSebk17Hkvb
 oPbhat4p6tNxXwf19iijA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6fJdnfZI/mI=:DiRnOqTluoTQG+dG7P6Wgg
 Z6e9UXBCVq8kdIcb3sG7gAkA4HwHQ/FIk8800FXCw8FNs4a/CW4OYP8U3BvorCv5pDncdyorq
 fmCqospkFbzUKbJKHNaEMjMuDrw6oAfij7pmbw+ApuES80q2rzuVaiMjC83BXaXob74J9+Ahz
 gQj9lKYJ4Pors1FiE8HfBW7mtDzJ9W8+aUsk6ObLR9SNslIgM9Ee9ciS3gO0jw8U52mp94XC3
 kOhhlyll+Vur/7vWacyO87LwQlSUgC5WLPyAHSdmAW5aHobb2kCa2KRZKzbnsxypUSVBhJm8Z
 6ayKZSaGtyq6CYkgm18TK8fN8Gv5AxKDoyzO0oBLUwSCA7Cv/cRzrvFDkiI4rv6nvceOaSUZJ
 iTRodn8uh+oLCgcS6fSns2I1MtpDuLEAe4b8zfYHUm/qbKT6/IOzioB/TMc0zqUbrj+YVmQj6
 trq1pKBQkS0t/bLf1Dht91h63vgmJl1EFSlsSSqbndKwZa0zE4EtnMukdESsAxDyvjkNZGKvI
 vp+HRCwZHxut086cjw68gKDIZN8TPPzjF5QtoESSOr5SCD3yBGbaGCQOPG+J9aw8CpYZ7LF74
 uHD8NXQeBN+DotI7ZxrHYHUpWLfJIAb2+PcL97Y5UdUQTI4UCJPQC2cN6p4i96ggbwDiJTmw8
 vwlrg0JDM9p4Fvsp4KDPAFvSTm9PMxH0NWtlSVpQEtQls5joSi4Xbw2laW5xKc0AkZISuhgt9
 +9atRsXMt8Vu5ZtK8B5+jzyJ7ABSrUm8fpHzOw6VY0tZjmoyWfdHt28Ypk5SmtQ9SGrCb2zPg
 ku6soUmfrlAdpF6mwW92y+QPD6LdG2JeKVcfYNOAPDZa1DT6NYkQFqZ+ZiUKn9aCzCmYDfQSJ
 wNK5NYu+9+sOoJqmy3Drr0OqYJGr/jSNXvknL4VFNsTucR76EGBK1wm+OSbHbqU6wjskvX4B3
 6SgYANFc9HTNs+Q0XdFUsskQ2Ylg3airltFaVGHWvi2hzEoC9MtvP65D1AZWVgMrmlVzzyb9R
 6DJEXigTquAFx/6nUtjy3KD3W+8kPZLL5VbA2HZVwtlqOearjDuLz/IsNYCMfSV5mXC1JOlOt
 bXr7XXkNMZxmXR0knyGznUxRHyxH8fN6LZpr7IPOxuydj6Q4jLyFBzhSLN6o6RNc5MtUj4B05
 7Um8q9bFKlj/fNiQHEkwE4Fst3wvVwOpB8ge7wuSSlz3mgrWSa8+9lMn8JDVEdKyf6FuM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.09.19 um 10:24 schrieb Stephan Beyer:
> Compiler heuristics for detection of potentially uninitialized variables
> may change between compiler versions and enabling link-time optimization
> may find new warnings.  Indeed, compiling with gcc 9.2.1 and enabled
> link-time optimization feature resulted in a few hits that are fixed by
> this patch in the most na=C3=AFve way.  This allows to compile git using=
 the
> DEVELOPER=3D1 switch (which sets -Werror) and using the -flto flag.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  builtin/am.c               | 2 +-
>  builtin/pack-objects.c     | 2 +-
>  bulk-checkin.c             | 2 ++
>  fast-import.c              | 3 ++-
>  t/helper/test-read-cache.c | 2 +-
>  5 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 1aea657a7f..ab914fd46e 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1266,7 +1266,7 @@ static int get_mail_commit_oid(struct object_id *c=
ommit_id, const char *mail)
>  static void get_commit_info(struct am_state *state, struct commit *comm=
it)
>  {
>  	const char *buffer, *ident_line, *msg;
> -	size_t ident_len;
> +	size_t ident_len =3D 0;
>  	struct ident_split id;
>
>  	buffer =3D logmsg_reencode(commit, NULL, get_commit_output_encoding())=
;

Further context:

	ident_line =3D find_commit_header(buffer, "author", &ident_len);

	if (split_ident_line(&id, ident_line, ident_len) < 0)
		die(_("invalid ident line: %.*s"), (int)ident_len, ident_line);

find_commit_header() can return NULL.  split_ident_line() won't handle
that well.  So I think what's missing here is a NULL check.  If the
compiler is smart enough then that should silence the initialization
warning.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 76ce906946..d0c03b0e9b 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1171,7 +1171,7 @@ static int add_object_entry(const struct object_id=
 *oid, enum object_type type,
>  {
>  	struct packed_git *found_pack =3D NULL;
>  	off_t found_offset =3D 0;
> -	uint32_t index_pos;
> +	uint32_t index_pos =3D 0;
>
>  	display_progress(progress_state, ++nr_seen);
>

Further context:

	if (have_duplicate_entry(oid, exclude, &index_pos))
		return 0;

	if (!want_object_in_pack(oid, exclude, &found_pack, &found_offset)) {
		/* The pack is missing an object, so it will not have closure */
		if (write_bitmap_index) {
			if (write_bitmap_index !=3D WRITE_BITMAP_QUIET)
				warning(_(no_closure_warning));
			write_bitmap_index =3D 0;
		}
		return 0;
	}

	create_object_entry(oid, type, pack_name_hash(name),
			    exclude, name && no_try_delta(name),
			    index_pos, found_pack, found_offset);

So we call have_duplicate_entry() and if it returns 0 then we might
end up using index_pos.  So when does it return 0?

static int have_duplicate_entry(const struct object_id *oid,
				int exclude,
				uint32_t *index_pos)
{
	struct object_entry *entry;

	entry =3D packlist_find(&to_pack, oid, index_pos);
	if (!entry)
		return 0;

OK, it does that if packlist_find() returns NULL.  When does it do
that?
struct object_entry *packlist_find(struct packing_data *pdata,
				   const struct object_id *oid,
				   uint32_t *index_pos)
{
	uint32_t i;
	int found;

	if (!pdata->index_size)
		return NULL;

	i =3D locate_object_entry_hash(pdata, oid, &found);

	if (index_pos)
		*index_pos =3D i;

	if (!found)
		return NULL;

So if the packing list is empty then it returns NULL without setting
index_pos.  Hmm.  It does set it in all other cases, no matter if oid is
found or not.  Is it really a good idea to make that exception?  I
suspect always setting index_pos here would silence the compiler as well
and fix the issue closer to its root.

But I may be missing something, this code looks complicated.

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 39ee7d6107..87fa28c227 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -200,6 +200,8 @@ static int deflate_to_pack(struct bulk_checkin_state=
 *state,
>  	struct hashfile_checkpoint checkpoint;
>  	struct pack_idx_entry *idx =3D NULL;
>
> +	checkpoint.offset =3D 0;
> +
>  	seekback =3D lseek(fd, 0, SEEK_CUR);
>  	if (seekback =3D=3D (off_t) -1)
>  		return error("cannot find the current offset");

Omitting further context, even though it would help, but this reply is
long enough already.  It seems the compiler got confused -- I can't see
an execution path that would use an uninitialized offset.  If idx is
NULL then the function is exited early, and if it's not then offset is
initialized.  But perhaps I'm missing something.

Anyway, my points are that simply initializing might not always be the
best fix, and that more context would help reviewers of such a patch,
but only if functions are reasonably short and it's not necessary to
follow the rabbit into a call chain hole.

Didn't check the other cases.

Ren=C3=A9
