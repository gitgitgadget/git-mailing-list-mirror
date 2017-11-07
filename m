Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7940720A10
	for <e@80x24.org>; Tue,  7 Nov 2017 05:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbdKGFud (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 00:50:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54604 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753828AbdKGFuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 00:50:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2A5DA0334;
        Tue,  7 Nov 2017 00:50:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2Bic7QrP40dy
        vQ20HFZMEllayt0=; b=HSki9SohD29lYtEdQ7TaTM3ElhoYlJr6oqDTiZ6r3XDw
        UsLJgkmjOHW/ejX/iJnU/b9H4nD7KFpyDKAICZXjnD38t8AsWtc5yx4h7Oze2xln
        eega0zbznLmgwoh0x3YDPwVRF60Ws+8+gUHYGJ7VM4y1AQTk4OfQL9ELDJBSRf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wV3oyo
        Wk/K/GOrAT9vni6OfgglgMHaDsuhPisM2jI9m/bSi0mjWQgSn7mcYIfzfwC//Tuo
        /0V8tlJqjm1OuDPQB4bnD7OpgSC1XqajMjgkzFG9aygyaQE1GHSlR3hah3VkCEbK
        Nmh4leY+7pLC18ZyKXjQ5L9OL7rPpwsgL9Jqk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99EE2A0330;
        Tue,  7 Nov 2017 00:50:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06FA8A032E;
        Tue,  7 Nov 2017 00:50:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Introduce git add --renormalize .
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
        <20171030162913.23164-1-tboegi@web.de>
Date:   Tue, 07 Nov 2017 14:50:29 +0900
In-Reply-To: <20171030162913.23164-1-tboegi@web.de> (tboegi@web.de's message
        of "Mon, 30 Oct 2017 17:29:13 +0100")
Message-ID: <xmqqvaimeixm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 907CFC60-C37F-11E7-BEAD-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Make it safer to normalize the line endings in a repository:
> Files that had been commited with CRLF will be commited with LF.
> ...
> Helped-By: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Nicely explained.

> @@ -175,6 +175,12 @@ for "git add --no-all <pathspec>...", i.e. ignored=
 removed files.
>  	warning (e.g., if you are manually performing operations on
>  	submodules).
> =20
> +--renormalize::
> +	Normalizes the line endings from CRLF to LF of tracked files.
> +	This applies to files which are either "text" or "text=3Dauto"
> +	in .gitattributes (or core.autocrlf is true or input)
> +	--renormalize implies -u
> +

OK.

> +static int renormalize_tracked_files(const struct pathspec *pathspec, =
int flags)
> +{
> +	int i, retval =3D 0;
> +
> +	for (i =3D 0; i < active_nr; i++) {
> +		struct cache_entry *ce =3D active_cache[i];
> +
> +		if (ce_stage(ce))
> +			continue; /* do not touch unmerged paths */
> +		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
> +			continue; /* do not touch non blobs */
> +		if (pathspec && !ce_path_match(ce, pathspec, NULL))
> +			continue;
> +		retval |=3D add_file_to_cache(ce->name, flags | HASH_RENORMALIZE);

We are removing the entry and then adding the same entry under the
same name, and iteration over the active_cache[] from 0 through
active_nr should be safe, I guess.

> ...
> -	add_new_files =3D !take_worktree_changes && !refresh_only;
> +	add_new_files =3D !take_worktree_changes && !refresh_only && !add_ren=
ormalize;

If renormalize is given, we will *not* take new files, good.

> @@ -500,7 +521,10 @@ int cmd_add(int argc, const char **argv, const cha=
r *prefix)
> =20
>  	plug_bulk_checkin();
> =20
> -	exit_status |=3D add_files_to_cache(prefix, &pathspec, flags);
> +	if (add_renormalize)
> +		exit_status |=3D renormalize_tracked_files(&pathspec, flags);
> +	else
> +		exit_status |=3D add_files_to_cache(prefix, &pathspec, flags);
> =20
>  	if (add_new_files)
>  		exit_status |=3D add_files(&dir, flags);

OK.

> ...
>  	int add_option =3D (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
>  			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
> +	int newflags =3D HASH_WRITE_OBJECT;
> +
> +	if (flags & HASH_RENORMALIZE)
> +		newflags |=3D HASH_RENORMALIZE;
> ...
> @@ -678,19 +682,23 @@ int add_to_index(struct index_state *istate, cons=
t char *path, struct stat *st,
>  	if (ignore_case) {
>  		adjust_dirname_case(istate, ce->name);
>  	}
> +	if (!(flags & HASH_RENORMALIZE)) {
> +		alias =3D index_file_exists(istate, ce->name,
> +					  ce_namelen(ce), ignore_case);
> +		if (alias &&
> +		    !ce_stage(alias) &&
> +		    !ie_match_stat(istate, alias, st, ce_option)) {
> +			/* Nothing changed, really */
> +			if (!S_ISGITLINK(alias->ce_mode))
> +				ce_mark_uptodate(alias);
> +			alias->ce_flags |=3D CE_ADDED;

OK, so RENORMALIZE option forces the code to skip the "does the path
exist already?  maybe we can do without adding it?" check.

>  	if (!intent_only) {
> -		if (index_path(&ce->oid, path, st, HASH_WRITE_OBJECT)) {
> +		if (index_path(&ce->oid, path, st, newflags)) {

And then we do hash it.  We later do add_index_entry() on this thing
and we have OK_TO_REPLACE bit in the add_option, so we are good to go.

> diff --git a/sha1_file.c b/sha1_file.c
> index 10c3a0083d..15abb184c2 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -74,6 +74,18 @@ static struct cached_object *find_cached_object(cons=
t unsigned char *sha1)
>  	return NULL;
>  }
> =20
> +
> +static enum safe_crlf get_safe_crlf(unsigned flags)
> +{
> +	if (flags & HASH_RENORMALIZE)
> +		return SAFE_CRLF_RENORMALIZE;
> +	else if (flags & HASH_WRITE_OBJECT)
> +		return safe_crlf;
> +	else
> +		return SAFE_CRLF_FALSE;
> +}
> +
> +
>  int mkdir_in_gitdir(const char *path)
>  {
>  	if (mkdir(path, 0777)) {
> @@ -1680,7 +1692,7 @@ static int index_mem(unsigned char *sha1, void *b=
uf, size_t size,
>  	if ((type =3D=3D OBJ_BLOB) && path) {
>  		struct strbuf nbuf =3D STRBUF_INIT;
>  		if (convert_to_git(&the_index, path, buf, size, &nbuf,
> -				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
> +				   get_safe_crlf(flags))) {
>  			buf =3D strbuf_detach(&nbuf, &size);
>  			re_allocated =3D 1;
>  		}
> @@ -1714,7 +1726,7 @@ static int index_stream_convert_blob(unsigned cha=
r *sha1, int fd,
>  	assert(would_convert_to_git_filter_fd(path));
> =20
>  	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
> -				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
> +				 get_safe_crlf(flags));
> =20
>  	if (write_object)
>  		ret =3D write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),

OK.  We used to force CRLF_FALSE when we are not writing it out; now
we have three choices, and a new helper helps us isolating the logic
to make that choice.

> diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
> new file mode 100755
> index 0000000000..fb1ed631d2
> --- /dev/null
> +++ b/t/t0025-crlf-renormalize.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +
> +test_description=3D'CRLF renormalization'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	git config core.autocrlf false &&
> +	printf "LINEONE\nLINETWO\nLINETHREE"     >LF.txt &&
> +	printf "LINEONE\r\nLINETWO\r\nLINETHREE" >CRLF.txt &&
> +	printf "LINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF.txt &&

Did you mean to make all these files end with an incomplete line?  I
think it does not hurt but it is misleading---the reader would try
to see if the incomplete lines are significant and necessary part of
the test, which is not, and would end up wasting time, no?

> +	git add . &&
> +	git commit -m initial
> +'
> +
> +test_expect_success 'renormalize CRLF in repo' '
> +	echo "*.txt text=3Dauto" >.gitattributes &&
> +	git add --renormalize "*.txt" &&
> +cat >expect <<EOF &&
> +i/lf w/crlf attr/text=3Dauto CRLF.txt
> +i/lf w/lf attr/text=3Dauto LF.txt
> +i/lf w/mixed attr/text=3Dauto CRLF_mix_LF.txt
> +EOF

Perhaps use the <<-\EOF pattern?

I'd suggest squashing this in (or I can do so myself if there is no
other change needed).

Thanks.  Looks mostly good.

 t/t0025-crlf-renormalize.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
index fb1ed631d2..ea4f82ea27 100755
--- a/t/t0025-crlf-renormalize.sh
+++ b/t/t0025-crlf-renormalize.sh
@@ -6,9 +6,9 @@ test_description=3D'CRLF renormalization'
=20
 test_expect_success setup '
 	git config core.autocrlf false &&
-	printf "LINEONE\nLINETWO\nLINETHREE"     >LF.txt &&
-	printf "LINEONE\r\nLINETWO\r\nLINETHREE" >CRLF.txt &&
-	printf "LINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF.txt &&
+	printf "LINEONE\nLINETWO\nLINETHREE\n"       >LF.txt &&
+	printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n" >CRLF.txt &&
+	printf "LINEONE\r\nLINETWO\nLINETHREE\n"     >CRLF_mix_LF.txt &&
 	git add . &&
 	git commit -m initial
 '
@@ -16,11 +16,11 @@ test_expect_success setup '
 test_expect_success 'renormalize CRLF in repo' '
 	echo "*.txt text=3Dauto" >.gitattributes &&
 	git add --renormalize "*.txt" &&
-cat >expect <<EOF &&
-i/lf w/crlf attr/text=3Dauto CRLF.txt
-i/lf w/lf attr/text=3Dauto LF.txt
-i/lf w/mixed attr/text=3Dauto CRLF_mix_LF.txt
-EOF
+	cat >expect <<-\EOF &&
+	i/lf w/crlf attr/text=3Dauto CRLF.txt
+	i/lf w/lf attr/text=3Dauto LF.txt
+	i/lf w/mixed attr/text=3Dauto CRLF_mix_LF.txt
+	EOF
 	git ls-files --eol |
 	sed -e "s/	/ /g" -e "s/  */ /g" |
 	sort >actual &&
