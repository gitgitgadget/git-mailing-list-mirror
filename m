Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40D4C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9693613C0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhGNQPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:15:50 -0400
Received: from m12-16.163.com ([220.181.12.16]:36707 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhGNQPu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=mtdd2
        nsB8eaWG8gmIj8JxZ47FlqxfiUCaYaOvZp5f+E=; b=aICeGKoE2njrY2fRvAZei
        fO/dwi6IudzZqQrGMwLNNrrmOEHa4qNqyVPNgJfE/rGi7sdQ029k73UMXVi6CtMx
        e5d6ECAo3Ux+K7YpW8/5UaSjcXsI1XatAdL73+WTxD8d0IqceP9g//HEopN1rjeK
        MCXwhxgXQbUb1pmEMhPcgQ=
Received: from smtpclient.apple (unknown [60.176.228.14])
        by smtp12 (Coremail) with SMTP id EMCowADHvY7jDO9g7Vx+2Q--.63837S3;
        Thu, 15 Jul 2021 00:12:30 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
From:   Sun Chao <16657101987@163.com>
In-Reply-To: <87wnpt1wwc.fsf@evledraar.gmail.com>
Date:   Thu, 15 Jul 2021 00:11:42 +0800
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D87972E0-BF82-402B-9531-81B50531438C@163.com>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-CM-TRANSID: EMCowADHvY7jDO9g7Vx+2Q--.63837S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr4xWw17Jw1Utr1rKFyxAFb_yoWfWrWDpF
        Z8Kay7C3Z7JFy7KrsFvw1DJryFvr4rCr15X390ga4UArZ8ZFWfKr4fKrWY9Fy3Arn5uw40
        vF48Kr9xA3WUtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU8nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joKZJUUUUU=
X-Originating-IP: [60.176.228.14]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbi6x7PglXlwzueqQABsG
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> 2021=E5=B9=B47=E6=9C=8814=E6=97=A5 09:39=EF=BC=8C=C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason <avarab@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>> +The default is 'pack' which means the *.pack file will be freshened =
by
>> +default. You can configure a different suffix to use, the file with =
the
>> +suffix will be created automatically, it's better not using any =
known
>> +suffix such like 'idx', 'keep', 'promisor'.
>> +
>=20
> Hrm, per my v1 feedback (and I'm not sure if my suggestion is even =
good
> here, there's others more familiar with this area than I am), I was
> thinking of something like a *.bump file written via:
>=20
>    core.packUseBumpFiles=3Dbool
>=20
> Or something like that, anyway, the edge case in allowing the user to
> pick arbitrary suffixes is that we'd get in-the-wild user arbitrary
> configuration squatting on a relatively sensitive part of the object
> store.
>=20
> E.g. we recently added *.rev files to go with
> *.{pack,idx,bitmap,keep,promisor} (and I'm probably forgetting some
> suffix). What if before that a user had set:
>=20
>    core.packMtimeSuffix=3Drev
>=20
> In practice it's probably too obscure to worry about, but I think it's
> still worth it to only strictly write things we decide to write into =
the
> object store.

Thanks, this makes sense, allowing user to pick arbitrary suffixes may =
cause
some unpredictable problems, E.g. users who don=E2=80=99t know about the =
*.keep files
but setting core.packMtimeSuffix=3Dkeep, so I think it=E2=80=99s right =
to restrict the
suffix here.

>> core.deltaBaseCacheLimit::
>> 	Maximum number of bytes per thread to reserve for caching base =
objects
>> 	that may be referenced by multiple deltified objects.  By =
storing the
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index 3fbc5d70777..60bacc8ee7f 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -1437,19 +1437,6 @@ static void fix_unresolved_deltas(struct =
hashfile *f)
>> 	free(sorted_by_pos);
>> }
>>=20
>> -static const char *derive_filename(const char *pack_name, const char =
*strip,
>> -				   const char *suffix, struct strbuf =
*buf)
>> -{
>> -	size_t len;
>> -	if (!strip_suffix(pack_name, strip, &len) || !len ||
>> -	    pack_name[len - 1] !=3D '.')
>> -		die(_("packfile name '%s' does not end with '.%s'"),
>> -		    pack_name, strip);
>> -	strbuf_add(buf, pack_name, len);
>> -	strbuf_addstr(buf, suffix);
>> -	return buf->buf;
>> -}
>=20
>=20
> Would be more readable to split this series up into at least two
> patches, starting with just moving this function as-is to a the new
> location (just renaming it & moving it), and then using it. I don't
> think there's changes to it, but right now I'm just eyeballing the
> diff. It's more obvious if it's split up.

Thanks, I will do it.

>=20
>> +	if (!strcmp(var, "core.packmtimesuffix")) {
>> +		return git_config_string(&pack_mtime_suffix, var, =
value);
>=20
> Can drop the {} braces here, per Documentation/CodingGuidelines

Thanks, I will read the CodingGuidelines again and fix the issue.

>=20
>> +const char *pack_mtime_suffix =3D "pack";
>=20
> I can see how having a configurable suffix made the implementation
> easier, perhaps that's how it started?
>=20

yes, here is the default value.

>=20
>> int fsync_object_files;
>> size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
>> size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
>> diff --git a/object-file.c b/object-file.c
>> index f233b440b22..b3e77213c42 100644
>> --- a/object-file.c
>> +++ b/object-file.c
>> @@ -1974,12 +1974,41 @@ static int freshen_loose_object(const struct =
object_id *oid)
>> static int freshen_packed_object(const struct object_id *oid)
>> {
>> 	struct pack_entry e;
>> +	struct stat st;
>> +	struct strbuf name_buf =3D STRBUF_INIT;
>> +	const char *filename;
>> +
>> 	if (!find_pack_entry(the_repository, oid, &e))
>> 		return 0;
>> 	if (e.p->freshened)
>> 		return 1;
>> -	if (!freshen_file(e.p->pack_name))
>> -		return 0;
>> +
>> +	filename =3D e.p->pack_name;
>> +	if (!strcasecmp(pack_mtime_suffix, "pack")) {
>> +		if (!freshen_file(filename))
>> +			return 0;
>> +		e.p->freshened =3D 1;
>> +		return 1;
>> +	}
>> +
>> +	/* If we want to freshen different file instead of .pack file, =
we need
>> +	 * to make sure the file exists and create it if needed.
>> +	 */
>> +	filename =3D derive_pack_filename(filename, "pack", =
pack_mtime_suffix, &name_buf);
>=20
> You populate name_buf here, but don't strbuf_release(&name_buf) it at =
the end of this function.

Will fix it.

>=20
>> +	if (lstat(filename, &st) < 0) {
>> +		int fd =3D open(filename, O_CREAT|O_EXCL|O_WRONLY, =
0664);
>> +		if (fd < 0) {
>> +			// here we need to check it again because other =
git process may created it
>=20
> /* */ comments, not //, if it's needed at all. Covered in =
CodingGuidelines

Will fix it.

>=20
>> +			if (lstat(filename, &st) < 0)
>> +				die_errno("unable to create '%s'", =
filename);
>=20
> If we can't create this specific file here shouldn't we just continue
> silently at this point? Surely if this process is screwed we're just
> about to die on something more important?

Yes, because here we have the *.pack file exists, we can step back to =
freshen
the *.pack file if the specific file cannot be created. And when we want =
to get
the mtime, we can also read mtime from *.pack file either if the =
specific
file does not exists.=20

>=20
> And lstat() can also return transitory errors that don't indicate
> "unable to create", e.g. maybe we can out of memory the kernel is
> willing to give us or something (just skimming the lstat manpage).

Thanks, I will think about it.

>=20
>> +		} else {
>> +			close(fd);
>> +		}
>> +	} else {
>> +		if (!freshen_file(filename))
>> +			return 0;
>=20
> Style/indentatino: just do "} else if (!freshen..." ?

Will fix it.
>=20
>> +	}
>> +
>> 	e.p->freshened =3D 1;
>> 	return 1;
>> }
>> diff --git a/packfile.c b/packfile.c
>> index 755aa7aec5e..a607dda4e25 100644
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -40,6 +40,19 @@ char *sha1_pack_index_name(const unsigned char =
*sha1)
>> 	return odb_pack_name(&buf, sha1, "idx");
>> }
>>=20
>> +const char *derive_pack_filename(const char *pack_name, const char =
*strip,
>> +				const char *suffix, struct strbuf *buf)
>> +{
>> +	size_t len;
>> +	if (!strip_suffix(pack_name, strip, &len) || !len ||
>> +	    pack_name[len - 1] !=3D '.')
>> +		die(_("packfile name '%s' does not end with '.%s'"),
>> +		    pack_name, strip);
>> +	strbuf_add(buf, pack_name, len);
>> +	strbuf_addstr(buf, suffix);
>> +	return buf->buf;
>> +}
>=20
> Just have this return void?

I renamed the original 'derive_filename' here with new name =
'derive_pack_filename',
when it is used like this:

    filename =3D derive_filename(pack_name, "pack", suffix, &name_buf);

and so it looks like a more convenient way to use the strbuf object, so =
I decided to
keep it the old way.

>=20
>> static unsigned int pack_used_ctr;
>> static unsigned int pack_mmap_calls;
>> static unsigned int peak_pack_open_windows;
>> @@ -727,6 +740,17 @@ struct packed_git *add_packed_git(const char =
*path, size_t path_len, int local)
>> 	 */
>> 	p->pack_size =3D st.st_size;
>> 	p->pack_local =3D local;
>> +
>> +	/* If we have different file used to freshen the mtime, we =
should
>> +	 * use it at a higher priority.
>> +	 */
>> +	if (!!strcasecmp(pack_mtime_suffix, "pack")) {
>> +		struct strbuf name_buf =3D STRBUF_INIT;
>> +		const char *filename;
>> +
>> +		filename =3D derive_pack_filename(path, "idx", =
pack_mtime_suffix, &name_buf);
>> +		stat(filename, &st);
>=20
> I.e. the "filename" here isn't needed, just call =
derive_pack_filename()
> and use name.buf.buf to stat.

Let me thinks about it, it's a good idea then.

>=20
> Also: We should check the stat return value here & report errno if
> needed, no?

Here I think we should step back to use the mtime of *.pack file =
instead, so if the specific file does
not exists, there are some reasons like (a) the *.pack is just created =
and mtime of it has not freshened
again or (b) we can not create the specific file for some reason, and in =
this case we will freshen the
*.pack file instead. (c) someone or some process just delete it, we =
should try to go futher.

I don't know if it's right to do this, but I think we should avoid die =
here.
>=20
>> +test_expect_success 'do not bother loosening old objects with =
core.packmtimesuffix config' '
>> +	obj1=3D$(echo three | git hash-object -w --stdin) &&
>> +	obj2=3D$(echo four | git hash-object -w --stdin) &&
>> +	pack1=3D$(echo $obj1 | git -c core.packmtimesuffix=3Dbump =
pack-objects .git/objects/pack/pack) &&
>> +	pack2=3D$(echo $obj2 | git -c core.packmtimesuffix=3Dbump =
pack-objects .git/objects/pack/pack) &&
>> +	git -c core.packmtimesuffix=3Dbump prune-packed &&
>> +	git cat-file -p $obj1 &&
>> +	git cat-file -p $obj2 &&
>> +	touch .git/objects/pack/pack-$pack2.bump &&
>> +	test-tool chmtime =3D-86400 .git/objects/pack/pack-$pack2.bump =
&&
>> +	git -c core.packmtimesuffix=3Dbump repack -A -d =
--unpack-unreachable=3D1.hour.ago &&
>=20
> On command-lines we can spell it camel-cased, e.g. -c
> core.packMtimeSuffix[...].
>=20

Thanks, will do it.=

