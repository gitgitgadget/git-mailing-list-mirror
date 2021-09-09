Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADCDC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 00:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6009761132
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 00:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhIIA6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 20:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348847AbhIIA6G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 20:58:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D2AC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 17:56:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i21so51248ejd.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 17:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZE808xRUAuQkf7pxq+1CPAKcToFYRMbDGZlfSVBqKPs=;
        b=Fk1A98ieFfHejhCqlUNZymUG8LyP3ndymlWZ8T720rD/3cHNGBECFf87PuVe0g2/Vu
         d9Grfej63BtWMU2w3cvBjAwxAu25rYpEGjqgj4XuvOnkl1wU1ntheRDTBt4GVPy8jMCa
         YVZjATYjvDPQwsmCecOgQ5bG7llHY/hh0tKmr/DKd0/0sDxBofWCrbullt5bJDklUfun
         XIdMM/hGWPeIg9A3CWCyPOXPzKO3YQqQ5lW6YrB09O0Sfv8omvHlRLqxE0k8QfWcpkSv
         3wS747VIf8XTNP5sugiK2P6T5L/ZA88is4fl0e8UspSO8T0X6sCkG76jU6pJUYkTsu65
         YgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZE808xRUAuQkf7pxq+1CPAKcToFYRMbDGZlfSVBqKPs=;
        b=hitTE7m5G5rgFVl+Q0qbNEVsTi1GgP2ZxSy6WdsNwnJGUhgE+pBqESfGrnxkU64JxS
         Zgtl0ClwZaOiqmDBp0p84Q6gMWCp1YUHKBbn+kZrrqZUa3sZY2wlGZY2RkfD+8TZnvsN
         HOvKFO5AIQM2SX9hp0C28PBtkkFTPMwZzynNBnbomKD3t5IVWb3k0pmqIarAYKG2mnTF
         Z4HrUiYTDxmh9m9LZ6V35iqRRI1jXzdyHt5sxsugu9kdnbz8PNjHRsXgXKBpDXI0ugd6
         f+cvNn8WzU+W+wJ7WaS64gqivuHhdPbSIzgEkLerBpYGCaz9QWsVw4Xc+5MI2ZTlBKa3
         hvNw==
X-Gm-Message-State: AOAM533Ivc7s2LyMZL/ioYMaTUtueG6GIEvuYzOZAcdV3uwM17pWBshu
        9eOfSabgxa4x+SVAUT778Qs=
X-Google-Smtp-Source: ABdhPJyucKl7gK33LYmvXqQX/WlODu56tEeNxddGLlcMQJiu5yL7rZ5S4/YHR52nV3uJDhF/wtq2WA==
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr490629ejs.197.1631149015823;
        Wed, 08 Sep 2021 17:56:55 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b13sm102886edu.27.2021.09.08.17.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 17:56:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2 0/3] prevent opening packs too early
Date:   Thu, 09 Sep 2021 02:50:59 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631139433.git.me@ttaylorr.com>
 <877dfqhb8n.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <877dfqhb8n.fsf@evledraar.gmail.com>
Message-ID: <8735qeh8h5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Sep 08 2021, Taylor Blau wrote:
>
>> Here is a very small reroll of a couple of patches to make sure that pac=
ks are
>> not read before all of their auxiliary files exist and are moved into pl=
ace, by
>> renaming the .idx file into place last.
>>
>> New since the original version is a patch to apply similar treatment to
>> index-pack, as noticed by Peff in [1]. This should be queued before =C3=
=86var's
>> series on top.
>
> I read Junio's earlier <xmqq8s063m7m.fsf@gitster.g>[1] as a suggestion
> that we combine the two into a singe series. I do think that yields a
> better end-result, in particular your 1/3 is much more readable if the
> refactoring in my 2/4.
>
> I'm mot of the way done with such a rewrite, which also incorporates
> your suggestion for how to manage memory in rename_tmp_packfile(), but
> I'll hold of on what you & Junio have to say about next steps before
> adding to the re-roll competition Junio mentioned...
>
> 1. https://lore.kernel.org/git/xmqq8s063m7m.fsf@gitster.g

I've got that at
https://github.com/git/git/compare/master...avar:avar-tb/idx-rename-race-3

Range-diff to my own v2 + your v1 follows (i.e. not my v2 + your v2
here). I can submit this as-is to the list, or something else. Junio
nominated you "team leader", so I'll go with your plan :)

I think the functional changes on top of the function refactoring make
it much easier to see what's going on, e.g.:

https://github.com/git/git/commit/832d9fa083d20abab35695037152dfeb1f9fe50a

I took the liberty of similarly creating a helper function in
index-pack.c, which turns your commit there into this:
https://github.com/git/git/commit/8c2dcbf6011c466a806491672c0d7308e8105a1d

The relevant commit messages were also adjusted to note that in the
earlier *.idx v.s. *.rev we're leaving the similar *.bitmap problem for
a later change.

3:  29f57876515 =3D 1:  4869f97408b pack.h: line-wrap the definition of fin=
ish_tmp_packfile()
4:  7b39f4599b1 ! 2:  c0b1ec90d43 pack-write: refactor renaming in finish_t=
mp_packfile()
    @@ Metadata
      ## Commit message ##
         pack-write: refactor renaming in finish_tmp_packfile()
=20=20=20=20=20
    -    Refactor the renaming in finish_tmp_packfile() so that it takes a
    -    "const struct strbuf *" instead of a non-const, and refactor the
    -    repetitive renaming pattern in finish_tmp_packfile() to use a new
    -    static rename_tmp_packfile() helper function.
    +    Refactor the renaming in finish_tmp_packfile() into a helper
    +    function. The callers are now expected to pass a "name_buffer" end=
ing
    +    in "pack-OID." instead of the previous "pack-", we then append "pa=
ck",
    +    "idx" or "rev" to it.
    +
    +    By doing the strbuf_setlen() in rename_tmp_packfile() we re-use the
    +    buffer and avoid the repeated allocations we'd get if that function
    +    had its own temporary "struct strbuf".
    +
    +    This approach of re-using the buffer does make the last user in
    +    pack-object.c's write_pack_file() slightly awkward, we needlessly =
do a
    +    strbuf_setlen() there just before the strbuf_release() for
    +    consistency. In subsequent changes we'll move that bitmap writing =
code
    +    around, so let's not skip the strbuf_setlen() now.
=20=20=20=20=20
         The previous strbuf_reset() idiom originated with
         5889271114a (finish_tmp_packfile():use strbuf for pathname
    @@ Commit message
         pre-strbuf code added in 0e990530ae (finish_tmp_packfile(): a help=
er
         function, 2011-10-28).
=20=20=20=20=20
    -    Since the memory allocation is not a bottleneck here we can afford=
 a
    -    bit more readability at the cost of re-allocating this new "struct
    -    strbuf sb".
    -
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## builtin/pack-objects.c ##
    +@@ builtin/pack-objects.c: static void write_pack_file(void)
    + 					warning_errno(_("failed utime() on %s"), pack_tmp_name);
    + 			}
    +=20
    +-			strbuf_addf(&tmpname, "%s-", base_name);
    ++			strbuf_addf(&tmpname, "%s-%s.", base_name,
    ++				    hash_to_hex(hash));
    +=20
    + 			if (write_bitmap_index) {
    + 				bitmap_writer_set_checksum(hash);
     @@ builtin/pack-objects.c: static void write_pack_file(void)
      					    &pack_idx_opts, hash);
=20=20=20=20=20=20
      			if (write_bitmap_index) {
     -				strbuf_addf(&tmpname, "%s.bitmap", hash_to_hex(hash));
    -+				struct strbuf sb =3D STRBUF_INIT;
    -+
    -+				strbuf_addf(&sb, "%s%s.bitmap", tmpname.buf,
    -+					    hash_to_hex(hash));
    ++				size_t tmpname_len =3D tmpname.len;
=20=20=20=20=20=20
    ++				strbuf_addstr(&tmpname, "bitmap");
      				stop_progress(&progress_state);
=20=20=20=20=20=20
    + 				bitmap_writer_show_progress(progress);
     @@ builtin/pack-objects.c: static void write_pack_file(void)
    - 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr,=
 -1);
    - 				bitmap_writer_build(&to_pack);
      				bitmap_writer_finish(written_list, nr_written,
    --						     tmpname.buf, write_bitmap_options);
    -+						     sb.buf, write_bitmap_options);
    + 						     tmpname.buf, write_bitmap_options);
      				write_bitmap_index =3D 0;
    -+				strbuf_release(&sb);
    ++				strbuf_setlen(&tmpname, tmpname_len);
      			}
=20=20=20=20=20=20
      			strbuf_release(&tmpname);
    @@ pack-write.c: struct hashfile *create_tmp_packfile(char **pack_tmp_n=
ame)
      	return hashfd(fd, *pack_tmp_name);
      }
=20=20=20=20=20=20
    --void finish_tmp_packfile(struct strbuf *name_buffer,
    -+static void rename_tmp_packfile(const char *source,
    -+				 const struct strbuf *basename,
    -+				 const unsigned char hash[],
    -+				 const char *ext)
    ++static void rename_tmp_packfile(struct strbuf *nb, const char *source,
    ++				const char *ext)
     +{
    -+	struct strbuf sb =3D STRBUF_INIT;
    ++	size_t nb_len =3D nb->len;
     +
    -+	strbuf_addf(&sb, "%s%s.%s", basename->buf, hash_to_hex(hash), ext);
    -+	if (rename(source, sb.buf))
    ++	strbuf_addstr(nb, ext);
    ++	if (rename(source, nb->buf))
     +		die_errno("unable to rename temporary '*.%s' file to '%s'",
    -+			  ext, sb.buf);
    -+	strbuf_release(&sb);
    ++			  ext, nb->buf);
    ++	strbuf_setlen(nb, nb_len);
     +}
     +
    -+void finish_tmp_packfile(const struct strbuf *basename,
    + void finish_tmp_packfile(struct strbuf *name_buffer,
      			 const char *pack_tmp_name,
      			 struct pack_idx_entry **written_list,
    - 			 uint32_t nr_written,
     @@ pack-write.c: void finish_tmp_packfile(struct strbuf *name_buffer,
      			 unsigned char hash[])
      {
    @@ pack-write.c: void finish_tmp_packfile(struct strbuf *name_buffer,
     -
     -	strbuf_setlen(name_buffer, basename_len);
     -
    +-	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
    +-	if (rename(idx_tmp_name, name_buffer->buf))
    +-		die_errno("unable to rename temporary index file");
    +-
    +-	strbuf_setlen(name_buffer, basename_len);
    +-
     -	if (rev_tmp_name) {
     -		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
     -		if (rename(rev_tmp_name, name_buffer->buf))
     -			die_errno("unable to rename temporary reverse-index file");
    --
    --		strbuf_setlen(name_buffer, basename_len);
     -	}
     -
    --	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
    --	if (rename(idx_tmp_name, name_buffer->buf))
    --		die_errno("unable to rename temporary index file");
    --
     -	strbuf_setlen(name_buffer, basename_len);
    -+	rename_tmp_packfile(pack_tmp_name, basename, hash, "pack");
    ++	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
    ++	rename_tmp_packfile(name_buffer, idx_tmp_name, "idx");
     +	if (rev_tmp_name)
    -+		rename_tmp_packfile(rev_tmp_name, basename, hash, "rev");
    -+	rename_tmp_packfile(idx_tmp_name, basename, hash, "idx");
    ++		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
=20=20=20=20=20=20
      	free((void *)idx_tmp_name);
      }
    -
    - ## pack.h ##
    -@@ pack.h: int encode_in_pack_object_header(unsigned char *hdr, int hd=
r_len,
    - int read_pack_header(int fd, struct pack_header *);
    -=20
    - struct hashfile *create_tmp_packfile(char **pack_tmp_name);
    --void finish_tmp_packfile(struct strbuf *name_buffer,
    -+void finish_tmp_packfile(const struct strbuf *basename,
    - 			 const char *pack_tmp_name,
    - 			 struct pack_idx_entry **written_list,
    - 			 uint32_t nr_written,
-:  ----------- > 3:  832d9fa083d pack-write.c: rename `.idx` files after `=
*.rev'
2:  a6a4d2154e8 ! 4:  9f7e005ba03 builtin/repack.c: move `.idx` files into =
place last
    @@ Commit message
         itself).
=20=20=20=20=20
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## builtin/repack.c ##
     @@ builtin/repack.c: static struct {
1:  ea3b1a0d8ed ! 5:  457d4b9787c pack-write.c: rename `.idx` file into pla=
ce last
    @@
      ## Metadata ##
    -Author: Taylor Blau <me@ttaylorr.com>
    +Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
=20=20=20=20=20
      ## Commit message ##
    -    pack-write.c: rename `.idx` file into place last
    +    index-pack: refactor renaming in final()
=20=20=20=20=20
    -    We treat the presence of an `.idx` file as the indicator of whethe=
r or
    -    not it's safe to use a packfile. But `finish_tmp_packfile()` (whic=
h is
    -    responsible for writing the pack and moving the temporary versions=
 of
    -    all of its auxiliary files into place) is inconsistent about the w=
rite
    -    order.
    +    Refactor the renaming in final() into a helper function, this is
    +    similar in spirit to a preceding refactoring of finish_tmp_packfil=
e()
    +    in pack-write.c.
=20=20=20=20=20
    -    But the `.rev` file is moved into place after the `.idx`, so it's
    -    possible for a process to open a pack in between the two (i.e., wh=
ile
    -    the `.idx` file is in place but the `.rev` file is not) and mistak=
enly
    -    fall back to generating the pack's reverse index in memory. Though=
 racy,
    -    this amounts to an unnecessary slow-down at worst, and doesn't aff=
ect
    -    the correctness of the resulting reverse index.
    +    Before e37d0b8730b (builtin/index-pack.c: write reverse indexes,
    +    2021-01-25) it probably wasn't worth it to have this sort of helpe=
r,
    +    due to the differing "else if" case for "pack" files v.s. "idx" fi=
les.
=20=20=20=20=20
    -    Close this race by moving the .rev file into place before moving t=
he
    -    .idx file into place.
    +    But since we've got "rev" as well now, let's do the renaming via a
    +    helper, this is both a net decrease in lines, and improves the
    +    readability, since we can easily see at a glance that the logic for
    +    writing these three types of files is exactly the same, aside from=
 the
    +    obviously differing cases of "*final_xyz_name" being NULL, and
    +    "else_chmod_if" being different.
=20=20=20=20=20
    -    While we're here, only call strbuf_setlen() if we actually modifie=
d the
    -    buffer by bringing it inside of the same if-statement that calls
    -    rename().
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
    -
    - ## pack-write.c ##
    -@@ pack-write.c: void finish_tmp_packfile(struct strbuf *name_buffer,
    + ## builtin/index-pack.c ##
    +@@ builtin/index-pack.c: static void write_special_file(const char *su=
ffix, const char *msg,
    + 	strbuf_release(&name_buf);
    + }
=20=20=20=20=20=20
    - 	strbuf_setlen(name_buffer, basename_len);
    ++static void rename_tmp_packfile(const char **final_xyz_name,
    ++				const char *curr_xyz_name,
    ++				struct strbuf *xyz_name, unsigned char *hash,
    ++				const char *ext, int else_chmod_if)
    ++{
    ++	if (*final_xyz_name !=3D curr_xyz_name) {
    ++		if (!*final_xyz_name)
    ++			*final_xyz_name =3D odb_pack_name(xyz_name, hash, ext);
    ++		if (finalize_object_file(curr_xyz_name, *final_xyz_name))
    ++			die(_("unable to rename temporary '*.%s' file to '%s"),
    ++			    ext, *final_xyz_name);
    ++	} else if (else_chmod_if) {
    ++		chmod(*final_xyz_name, 0444);
    ++	}
    ++}
    ++
    + static void final(const char *final_pack_name, const char *curr_pack_=
name,
    + 		  const char *final_index_name, const char *curr_index_name,
    + 		  const char *final_rev_index_name, const char *curr_rev_index_name,
    +@@ builtin/index-pack.c: static void final(const char *final_pack_name=
, const char *curr_pack_name,
    + 		write_special_file("promisor", promisor_msg, final_pack_name,
    + 				   hash, NULL);
=20=20=20=20=20=20
    --	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
    --	if (rename(idx_tmp_name, name_buffer->buf))
    --		die_errno("unable to rename temporary index file");
    +-	if (final_pack_name !=3D curr_pack_name) {
    +-		if (!final_pack_name)
    +-			final_pack_name =3D odb_pack_name(&pack_name, hash, "pack");
    +-		if (finalize_object_file(curr_pack_name, final_pack_name))
    +-			die(_("cannot store pack file"));
    +-	} else if (from_stdin)
    +-		chmod(final_pack_name, 0444);
     -
    --	strbuf_setlen(name_buffer, basename_len);
    +-	if (final_index_name !=3D curr_index_name) {
    +-		if (!final_index_name)
    +-			final_index_name =3D odb_pack_name(&index_name, hash, "idx");
    +-		if (finalize_object_file(curr_index_name, final_index_name))
    +-			die(_("cannot store index file"));
    +-	} else
    +-		chmod(final_index_name, 0444);
     -
    - 	if (rev_tmp_name) {
    - 		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
    - 		if (rename(rev_tmp_name, name_buffer->buf))
    - 			die_errno("unable to rename temporary reverse-index file");
    -+
    -+		strbuf_setlen(name_buffer, basename_len);
    - 	}
    -=20
    -+	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
    -+	if (rename(idx_tmp_name, name_buffer->buf))
    -+		die_errno("unable to rename temporary index file");
    -+
    - 	strbuf_setlen(name_buffer, basename_len);
    +-	if (curr_rev_index_name) {
    +-		if (final_rev_index_name !=3D curr_rev_index_name) {
    +-			if (!final_rev_index_name)
    +-				final_rev_index_name =3D odb_pack_name(&rev_index_name, hash, "re=
v");
    +-			if (finalize_object_file(curr_rev_index_name, final_rev_index_name=
))
    +-				die(_("cannot store reverse index file"));
    +-		} else
    +-			chmod(final_rev_index_name, 0444);
    +-	}
    ++	rename_tmp_packfile(&final_pack_name, curr_pack_name, &pack_name,
    ++			    hash, "pack", from_stdin);
    ++	rename_tmp_packfile(&final_index_name, curr_index_name, &index_name,
    ++			    hash, "idx", 1);
    ++	if (curr_rev_index_name)
    ++		rename_tmp_packfile(&final_rev_index_name, curr_rev_index_name,
    ++				    &rev_index_name, hash, "rev", 1);
=20=20=20=20=20=20
    - 	free((void *)idx_tmp_name);
    + 	if (do_fsck_object) {
    + 		struct packed_git *p;
-:  ----------- > 6:  8c2dcbf6011 builtin/index-pack.c: move `.idx` files i=
nto place last
5:  1205f9d0c25 ! 7:  3a0ee7e4a99 pack-write: split up finish_tmp_packfile(=
) function
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      					    written_list, nr_written,
     -					    &pack_idx_opts, hash);
     +					    &pack_idx_opts, hash, &idx_tmp_name);
    -+			rename_tmp_packfile_idx(&tmpname, hash, &idx_tmp_name);
    ++			rename_tmp_packfile_idx(&tmpname, &idx_tmp_name);
=20=20=20=20=20=20
      			if (write_bitmap_index) {
    - 				struct strbuf sb =3D STRBUF_INIT;
    + 				size_t tmpname_len =3D tmpname.len;
     @@ builtin/pack-objects.c: static void write_pack_file(void)
    - 				strbuf_release(&sb);
    + 				strbuf_setlen(&tmpname, tmpname_len);
      			}
=20=20=20=20=20=20
     +			free(idx_tmp_name);
    @@ bulk-checkin.c: static struct bulk_checkin_state {
      	uint32_t nr_written;
      } state;
=20=20=20=20=20=20
    -+static void finish_tmp_packfile(const struct strbuf *basename,
    ++static void finish_tmp_packfile(struct strbuf *basename,
     +				const char *pack_tmp_name,
     +				struct pack_idx_entry **written_list,
     +				uint32_t nr_written,
    @@ bulk-checkin.c: static struct bulk_checkin_state {
     +
     +	stage_tmp_packfiles(basename, pack_tmp_name, written_list, nr_writte=
n,
     +			    pack_idx_opts, hash, &idx_tmp_name);
    -+	rename_tmp_packfile_idx(basename, hash, &idx_tmp_name);
    ++	rename_tmp_packfile_idx(basename, &idx_tmp_name);
     +
     +	free(idx_tmp_name);
     +}
    @@ bulk-checkin.c: static struct bulk_checkin_state {
      static void finish_bulk_checkin(struct bulk_checkin_state *state)
      {
      	struct object_id oid;
    +@@ bulk-checkin.c: static void finish_bulk_checkin(struct bulk_checkin=
_state *state)
    + 		close(fd);
    + 	}
    +=20
    +-	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
    ++	strbuf_addf(&packname, "%s/pack/pack-%s.", get_object_directory(),
    ++		    oid_to_hex(&oid));
    + 	finish_tmp_packfile(&packname, state->pack_tmp_name,
    + 			    state->written, state->nr_written,
    + 			    &state->pack_idx_opts, oid.hash);
=20=20=20=20=20
      ## pack-write.c ##
    -@@ pack-write.c: static void rename_tmp_packfile(const char *source,
    - 	strbuf_release(&sb);
    +@@ pack-write.c: static void rename_tmp_packfile(struct strbuf *nb, co=
nst char *source,
    + 	strbuf_setlen(nb, nb_len);
      }
=20=20=20=20=20=20
    --void finish_tmp_packfile(const struct strbuf *basename,
    -+void rename_tmp_packfile_idx(const struct strbuf *basename,
    -+			      unsigned char hash[], char **idx_tmp_name)
    +-void finish_tmp_packfile(struct strbuf *name_buffer,
    ++void rename_tmp_packfile_idx(struct strbuf *name_buffer,
    ++			     char **idx_tmp_name)
     +{
    -+	rename_tmp_packfile(*idx_tmp_name, basename, hash, "idx");
    ++	rename_tmp_packfile(name_buffer, *idx_tmp_name, "idx");
     +}
     +
    -+void stage_tmp_packfiles(const struct strbuf *basename,
    ++void stage_tmp_packfiles(struct strbuf *name_buffer,
      			 const char *pack_tmp_name,
      			 struct pack_idx_entry **written_list,
      			 uint32_t nr_written,
    @@ pack-write.c: static void rename_tmp_packfile(const char *source,
      		die_errno("unable to make temporary index file readable");
=20=20=20=20=20=20
      	rev_tmp_name =3D write_rev_file(NULL, written_list, nr_written, hash,
    -@@ pack-write.c: void finish_tmp_packfile(const struct strbuf *basenam=
e,
    - 	rename_tmp_packfile(pack_tmp_name, basename, hash, "pack");
    +@@ pack-write.c: void finish_tmp_packfile(struct strbuf *name_buffer,
    + 	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
      	if (rev_tmp_name)
    - 		rename_tmp_packfile(rev_tmp_name, basename, hash, "rev");
    --	rename_tmp_packfile(idx_tmp_name, basename, hash, "idx");
    + 		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
    +-	rename_tmp_packfile(name_buffer, idx_tmp_name, "idx");
     -
     -	free((void *)idx_tmp_name);
      }
    @@ pack.h: int encode_in_pack_object_header(unsigned char *hdr, int hdr=
_len,
      int read_pack_header(int fd, struct pack_header *);
=20=20=20=20=20=20
      struct hashfile *create_tmp_packfile(char **pack_tmp_name);
    --void finish_tmp_packfile(const struct strbuf *basename,
    -+void stage_tmp_packfiles(const struct strbuf *basename,
    +-void finish_tmp_packfile(struct strbuf *name_buffer,
    ++void stage_tmp_packfiles(struct strbuf *name_buffer,
      			 const char *pack_tmp_name,
      			 struct pack_idx_entry **written_list,
      			 uint32_t nr_written,
    @@ pack.h: int encode_in_pack_object_header(unsigned char *hdr, int hdr=
_len,
     -			 unsigned char sha1[]);
     +			 unsigned char hash[],
     +			 char **idx_tmp_name);
    -+void rename_tmp_packfile_idx(const struct strbuf *tmp_basename,
    -+			     unsigned char hash[], char **idx_tmp_name);
    ++void rename_tmp_packfile_idx(struct strbuf *basename,
    ++			     char **idx_tmp_name);
=20=20=20=20=20=20
      #endif
6:  70f4a9767d3 ! 8:  b1b232b80de pack-write: rename *.idx file into place =
last (really!)
    @@ Metadata
     Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
=20=20=20=20=20
      ## Commit message ##
    -    pack-write: rename *.idx file into place last (really!)
    +    pack-objects: rename .idx files into place after .bitmap files
=20=20=20=20=20
    -    Follow-up a preceding commit (pack-write.c: rename `.idx` file into
    -    place last, 2021-08-16)[1] and rename the *.idx file in-place afte=
r we
    -    write the *.bitmap. The preceding commit fixed the issue of *.idx
    -    being written before *.rev files, but did not do so for *.idx file=
s.
    +    In preceding commits the race of renaming .idx files in place befo=
re
    +    .rev files and other auxiliary files was fixed in pack-write.c's
    +    finish_tmp_packfile(), builtin/repack.c's "struct exts", and
    +    builtin/index-pack.c's final(). As noted in the change to pack-wri=
te.c
    +    we left in place the issue of writing *.bitmap files after the *.i=
dx,
    +    let's fix that issue.
=20=20=20=20=20
         See 7cc8f971085 (pack-objects: implement bitmap writing, 2013-12-2=
1)
         for commentary at the time when *.bitmap was implemented about how
         those files are written out, nothing in that commit contradicts wh=
at's
         being done here.
=20=20=20=20=20
    -    Note that the referenced earlier commit[1] is overly optimistic ab=
out
    -    "clos[ing the] race", i.e. yes we'll now write the files in the ri=
ght
    -    order, but we might still race due to our sloppy use of fsync(). S=
ee
    -    the thread at [2] for a rabbit hole of various discussions about
    -    filesystem races in the face of doing and not doing fsync() (and if
    -    doing fsync(), not doing it properly).
    +    Note that this commit and preceding ones only close any race condi=
tion
    +    with *.idx files being written before their auxiliary files if we'=
re
    +    optimistic about our lack of fsync()-ing in this are not tripping =
us
    +    over. See the thread at [1] for a rabbit hole of various discussio=
ns
    +    about filesystem races in the face of doing and not doing fsync() =
(and
    +    if doing fsync(), not doing it properly).
=20=20=20=20=20
    -    1. https://lore.kernel.org/git/a6a4d2154e83d41c10986c5f455279ab249=
a910c.1630461918.git.me@ttaylorr.com/
    -    2. https://lore.kernel.org/git/8735qgkvv1.fsf@evledraar.gmail.com/
    +    In particular, in this case of writing to ".git/objects/pack" we o=
nly
    +    write and fsync() the individual files, but if we wanted to guaran=
tee
    +    that the metadata update was seen in that way by concurrent proces=
ses
    +    we'd need to fsync() on the "fd" of the containing directory. That
    +    concern is probably more theoretical than not, modern OS's tend to=
 be
    +    more on the forgiving side than the overly pedantic side of
    +    implementing POSIX FS semantics.
    +
    +    1. https://lore.kernel.org/git/8735qgkvv1.fsf@evledraar.gmail.com/
=20=20=20=20=20
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
    @@ builtin/pack-objects.c: static void write_pack_file(void)
      			stage_tmp_packfiles(&tmpname, pack_tmp_name,
      					    written_list, nr_written,
      					    &pack_idx_opts, hash, &idx_tmp_name);
    --			rename_tmp_packfile_idx(&tmpname, hash, &idx_tmp_name);
    +-			rename_tmp_packfile_idx(&tmpname, &idx_tmp_name);
=20=20=20=20=20=20
      			if (write_bitmap_index) {
    - 				struct strbuf sb =3D STRBUF_INIT;
    + 				size_t tmpname_len =3D tmpname.len;
     @@ builtin/pack-objects.c: static void write_pack_file(void)
    - 				strbuf_release(&sb);
    + 				strbuf_setlen(&tmpname, tmpname_len);
      			}
=20=20=20=20=20=20
    -+			rename_tmp_packfile_idx(&tmpname, hash, &idx_tmp_name);
    ++			rename_tmp_packfile_idx(&tmpname, &idx_tmp_name);
     +
      			free(idx_tmp_name);
      			strbuf_release(&tmpname);
