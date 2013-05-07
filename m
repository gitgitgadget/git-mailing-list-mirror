From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] fetch-pack: prepare updated shallow file before fetching the pack
Date: Tue, 07 May 2013 08:59:58 -0700
Message-ID: <7va9o6lr0h.fsf@alter.siamese.dyndns.org>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367584514-19806-1-git-send-email-pclouds@gmail.com>
	<1367584514-19806-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 18:00:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZkJH-0003Vb-F1
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 18:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206Ab3EGQAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 May 2013 12:00:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758011Ab3EGQAB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 12:00:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 896331C1B8;
	Tue,  7 May 2013 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IJGeQ6gGyOSr
	In9PAZfVqt+aD6w=; b=UWxRzKpKxbae7tk6KOHKqTeCOhvF6tOC0f6nFh2LN+hj
	UvL7hy+wVFWz3MQzlWwLyvVzLOwwdEvJMSVxgk0W0jSw1UxeDxuCTvZae6SDbFiv
	SbUKLuYzPLrrIo6me0ZT2bAdeZJIr8Ydn4UJPlYpDHmSZNUNiBa+BrhHjz25jOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uGam4S
	KO6mYG7jH2okyTbAPNXu3wRbzKC0QKd8lVIiHGFDtY5KU9ZjPTSKfVg3QcS8KmL9
	tsA+z9+Rec3pQEp8J8HnxbHC03qQTmii6OhHEHHFEB1F5ORIha47R09Pe69aEW1T
	ryX9+PyTM3joygmA0f8N7BF7i7F7Q2OHOP6nY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C5471C1B7;
	Tue,  7 May 2013 16:00:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90B461C1A4;
	Tue,  7 May 2013 15:59:59 +0000 (UTC)
In-Reply-To: <1367584514-19806-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 3 May
 2013 19:35:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B85686C-B72F-11E2-8C37-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223584>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> index-pack --strict looks up and follows parent commits. If shallow
> information is not ready by the time index-pack is run, index-pack ma=
y
> be lead to non-existent objects. Make fetch-pack save shallow file to
> disk before invoking index-pack.
>
> git learns new global option --shallow-file to pass on the alternate
> shallow file path. Undocumented (and not even support --shallow-file=3D
> syntax) because it's unlikely to be used again elsewhere.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  commit.h              |  2 ++
>  fetch-pack.c          | 69 +++++++++++++++++++++++++----------------=
----------
>  git.c                 |  5 ++++
>  shallow.c             | 45 +++++++++++++++++++++++++++++++--
>  t/t5500-fetch-pack.sh |  7 ++++++
>  5 files changed, 91 insertions(+), 37 deletions(-)
>
> diff --git a/commit.h b/commit.h
> index 67bd509..6e9c7cd 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -176,6 +176,8 @@ extern int for_each_commit_graft(each_commit_graf=
t_fn, void *);
>  extern int is_repository_shallow(void);
>  extern struct commit_list *get_shallow_commits(struct object_array *=
heads,
>  		int depth, int shallow_flag, int not_shallow_flag);
> +extern void check_shallow_file_for_update(void);
> +extern void set_alternate_shallow_file(const char *path);
> =20
>  int is_descendant_of(struct commit *, struct commit_list *);
>  int in_merge_bases(struct commit *, struct commit *);
> diff --git a/fetch-pack.c b/fetch-pack.c
> index f156dd4..1ca4f6b 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -20,6 +20,8 @@ static int no_done;
>  static int fetch_fsck_objects =3D -1;
>  static int transfer_fsck_objects =3D -1;
>  static int agent_supported;
> +static struct lock_file shallow_lock;
> +static const char *alternate_shallow_file;
> =20
>  #define COMPLETE	(1U << 0)
>  #define COMMON		(1U << 1)
> @@ -683,7 +685,7 @@ static int get_pack(struct fetch_pack_args *args,
>  		    int xd[2], char **pack_lockfile)
>  {
>  	struct async demux;
> -	const char *argv[20];
> +	const char *argv[22];
>  	char keep_arg[256];
>  	char hdr_arg[256];
>  	const char **av;
> @@ -724,6 +726,11 @@ static int get_pack(struct fetch_pack_args *args=
,
>  			do_keep =3D 1;
>  	}
> =20
> +	if (alternate_shallow_file) {
> +		*av++ =3D "--shallow-file";
> +		*av++ =3D alternate_shallow_file;
> +	}
> +
>  	if (do_keep) {
>  		if (pack_lockfile)
>  			cmd.out =3D -1;
> @@ -779,6 +786,23 @@ static int cmp_ref_by_name(const void *a_, const=
 void *b_)
>  	return strcmp(a->name, b->name);
>  }
> =20
> +static void setup_alternate_shallow(void)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	int fd;
> +
> +	check_shallow_file_for_update();
> +	fd =3D hold_lock_file_for_update(&shallow_lock, git_path("shallow")=
,
> +				       LOCK_DIE_ON_ERROR);
> +	if (write_shallow_commits(&sb, 0)) {
> +		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
> +			die_errno("failed to write to %s", shallow_lock.filename);
> +		alternate_shallow_file =3D shallow_lock.filename;
> +	} else
> +		alternate_shallow_file =3D "";

This "empty string, not NULL" trick needs to be commented here to
match the other place that uses this as a cue to do things
differently.

> +	strbuf_release(&sb);
> +}
> +
>  static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  				 int fd[2],
>  				 const struct ref *orig_ref,
> @@ -858,6 +882,8 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
> =20
>  	if (args->stateless_rpc)
>  		packet_flush(fd[1]);
> +	if (args->depth > 0)
> +		setup_alternate_shallow();
>  	if (get_pack(args, fd, pack_lockfile))
>  		die("git fetch-pack: fetch failed.");
> =20
> @@ -936,15 +962,9 @@ struct ref *fetch_pack(struct fetch_pack_args *a=
rgs,
>  		       struct ref **sought, int nr_sought,
>  		       char **pack_lockfile)
>  {
>  	struct ref *ref_cpy;
> =20
>  	fetch_pack_setup();
>  	if (nr_sought)
>  		nr_sought =3D remove_duplicates_in_refs(sought, nr_sought);
> =20
> @@ -955,34 +975,13 @@ struct ref *fetch_pack(struct fetch_pack_args *=
args,
>  	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lo=
ckfile);
> =20
>  	if (args->depth > 0) {
> +		struct stat st;
> +		if (!fstat(shallow_lock.fd, &st) &&
> +		    st.st_size =3D=3D 0) {
> +			unlink_or_warn(git_path("shallow"));

Are we unlinking the right file here?

> +			rollback_lock_file(&shallow_lock);
> +		} else
> +			commit_lock_file(&shallow_lock);
>  	}
> =20
>  	reprepare_packed_git();
> diff --git a/git.c b/git.c
> index 1ada169..6450a38 100644
> --- a/git.c
> +++ b/git.c
> @@ -4,6 +4,7 @@
>  #include "help.h"
>  #include "quote.h"
>  #include "run-command.h"
> +#include "commit.h"
> =20
>  const char git_usage_string[] =3D
>  	"git [--version] [--help] [-c name=3Dvalue]\n"
> @@ -146,6 +147,10 @@ static int handle_options(const char ***argv, in=
t *argc, int *envchanged)
>  			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "0", 1);
>  			if (envchanged)
>  				*envchanged =3D 1;
> +		} else if (!strcmp(cmd, "--shallow-file")) {
> +			(*argv)++;
> +			(*argc)--;
> +			set_alternate_shallow_file((*argv)[0]);

Should this count as "envchanged"?

> diff --git a/shallow.c b/shallow.c
> index 6be915f..bdae988 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -3,6 +3,16 @@
>  #include "tag.h"
> =20
>  static int is_shallow =3D -1;
> +static struct stat shallow_stat;
> +static char *alternate_shallow_file;
> +
> +void set_alternate_shallow_file(const char *path)
> +{
> +	if (is_shallow !=3D -1)
> +		die("BUG: is_repository_shallow must not be called before set_alte=
rnate_shallow_file");
> +	free(alternate_shallow_file);
> +	alternate_shallow_file =3D path ? xstrdup(path) : NULL;
> +}
> =20
>  int register_shallow(const unsigned char *sha1)
>  {
> @@ -21,12 +31,21 @@ int is_repository_shallow(void)
>  {
>  	FILE *fp;
>  	char buf[1024];
> +	const char *path =3D alternate_shallow_file;
> =20
>  	if (is_shallow >=3D 0)
>  		return is_shallow;
> =20
> -	fp =3D fopen(git_path("shallow"), "r");
> -	if (!fp) {
> +	if (!path)
> +		path =3D git_path("shallow");
> +	/*
> +	 * fetch-pack set '--shallow-file ""' as an indicator that no

s/set/&s/?

> +	 * shallow file should be used. We could just open it and it
> +	 * will likely fail. But let's do an explicit check instead.
> +	 */
> +	if (!*path ||
> +	    stat(path, &shallow_stat) ||
> +	    (fp =3D fopen(path, "r")) =3D=3D NULL) {
>  		is_shallow =3D 0;
>  		return is_shallow;
>  	}
> @@ -108,3 +127,25 @@ struct commit_list *get_shallow_commits(struct o=
bject_array *heads, int depth,
> =20
>  	return result;
>  }
> +
> +void check_shallow_file_for_update(void)
> +{
> +	struct stat st;
> +
> +	if (getenv("GIT_SHALLOW_FILE"))
> +		die("GIT_SHALLOW_FILE should not be manually set");

=46orgot to remove this?

> +	if (!is_shallow)
> +		return;
> +	else if (is_shallow =3D=3D -1)
> +		die("BUG: shallow must be initialized by now");
> +
> +	if (stat(git_path("shallow"), &st))
> +		die("shallow file was removed during fetch");
> +	else if (st.st_mtime !=3D shallow_stat.st_mtime
> +#ifdef USE_NSEC
> +		 || ST_MTIME_NSEC(st) !=3D ST_MTIME_NSEC(shallow_stat)
> +#endif
> +		   )
> +		die("shallow file was changed during fetch");
> +}
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index d574085..557b073 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -135,6 +135,13 @@ test_expect_success 'clone shallow depth 1' '
>  	test "`git --git-dir=3Dshallow0/.git rev-list --count HEAD`" =3D 1
>  '
> =20
> +test_expect_success 'clone shallow depth 1 with fsck' '
> +	git config --global fetch.fsckobjects true &&
> +	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0fs=
ck &&
> +	test "`git --git-dir=3Dshallow0fsck/.git rev-list --count HEAD`" =3D=
 1 &&
> +	git config --global --unset fetch.fsckobjects
> +'
> +
>  test_expect_success 'clone shallow' '
>  	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
>  '
