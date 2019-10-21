Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CCB1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfJUS4g (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:56:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:59259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfJUS4f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571684185;
        bh=BhXRP7fKIlni6RHnPmRRcOKlfw8RAt6t/jR1ZGjq3T8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dwbnnydeEgLfzfL21OvhSGNHIOCsnG4bygd8dJi3TWzoqtT+qyYvvharcd/za+4l3
         5RTyB/BqXYmgKcHwSbnZHTl96zYpGDIGqf/04vMMbQOGIrqNet7Zu1ez0Py3kis9e0
         sWaVvyM3efTg8i804wFAtlvVd2cHP5OeDI/WDwkE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQeK-1iDEfX1GSc-00AYqy; Mon, 21
 Oct 2019 20:56:25 +0200
Date:   Mon, 21 Oct 2019 20:56:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 4/7] autostash: extract reset_head() from rebase
In-Reply-To: <ab064a01-eed3-f90b-df47-1f372a063e30@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910212055280.46@tvgsbejvaqbjf.bet>
References: <cover.1571246693.git.liu.denton@gmail.com> <5e0dcd7cbeb3481beef04f1d145474739f8bdea3.1571246693.git.liu.denton@gmail.com> <ab064a01-eed3-f90b-df47-1f372a063e30@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QUV7EsYYMNYu6xKmCKfE7WUCwBqNycYW09qdKZPGIe2qmUC16WP
 P9hgd8n/lYNIGXxU85QLuspeZ28kxJMHYiP8P0vO6gOvBbZs3g8bhj9vyA2/U5IBk574bB+
 7p6OE08jA5i2nWsU95QSzEry5zDrbziDpdKmpPtD1tlf5RW6rgALsEyV+NpXDZwIOWXK6qZ
 qFB99lPubvkkwEw2h6cpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j1TiIUR4Jlk=:OoGaxl0q8Vgy3vLM3uUC9S
 RH0ZZYRDUjDFyDag3fdeq8wn99+yfhwQqp8+++p8BtvwJfCMUnytaabHx5Ca0VNMFD2f01hts
 fcbNMBNt2MIxXwTcrOfLAgV3GiMLQrdWz+8HOYXvJadUD9xL3Bed6a0QHgMFFEu1FiBepqQT7
 0aFULtVsrbgH0kzvTsnvy9h0zjLh8s+UgFs6zhlgXcjW/hqGjhjn0bv+JWl9OOpAnKnkiGDHG
 aOmQkSBiQ2/iQ3xUejUk8xXxc3p5J7SWKxQD7nM8Q8/2VqB19g/O62HvXOk9isfax0JscDqzN
 qSp27MXWJaQbXUjYgsdREjB7xuS1qVhH0N4ffHYBsgyw/s3DvnkXEBuG4LlGQk3x3h6y5rIFg
 NyZi4pCRv40Zgl+d78ynm27UoxPTnc1doCaniLnvSFrq876yv+vSO5kLqtqOQowRDFh88piDj
 00cSvuPjKI7QLeKlsTFU3RsDUi3LOKMkRBCUxqADqpda3IsK5E/usM/E4zY6UINMavaSZ2jO4
 va7vsVF1bAYPxkENnwDkBADsbAA+omwgMeZZLoX3muwELTSUSGC9I72/gxbFDMqi9pXd30g/X
 EnOteo9JG1btCaSzmgpQfrGDWT/ia4r4L0yG2IQap7sZfL4Fm8j9PLiuslq5jIpyxbV+9n7+V
 k6eFG0Ml3mnvm/I92RekpNzBYQ9pskFwT0mUNQ3ph49xsMVPGHKt4WKq1H2jiBmAlxzbAb0vt
 YMn5ZIeANkksqcPt9e9Xf/unqfZv42V+nzVW+3sgJPdHIf60XUHFr4w8wHTR00ua9XP1o25ve
 H0X0Hpdd9II8ehqlKzwXHLdIvvuyK64w3Vxf1xPvPJnjG7ghptjHaGdYWAlozmcomlxu0IzOn
 Cl79IS8in+l18lcwV6JJFUskp7XxgD5nM19UnZ8KyYQUNeUrdjGfpEJ/Gh3eZuEslLin0cROP
 n4SE1x32XWdWrI6bYyh1AhNohdRuyuDUuxpDusbeNZ1Pf15kJO1TMaDm03W+iSjvnRE/Qphaf
 Xg9LYtg9A5oBNK0wzd8H6edkrV/b+PEkLKVIpKnQXB4qJ0EVOWvkDRGRu7iFEBe8rFc/3Lpad
 DIPscRKLo9hzjrhlR7tIaryq1hqS7COnFCb5siv2T7GTvXR0Gmvbr/DPaFbidRN5JnI6g+/6S
 X3DSGv0a4tmnnp6B+GShPiSQSb2MDrWjBlydAwIhw6qNJSYexd8foEWQe8qM9RqLnVsxOFpHv
 S9wHL7ajPHaEPysOF1ctFyGn8pwcFulcKVvJTe9T/JgnVldlb3Gmms7h1/rE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

[sorry, Phillip, my reply-all fu deserts me today, apparently.]


On Fri, 18 Oct 2019, Phillip Wood wrote:

> Hi Denton
>
> It's great to see this being libified, I've had it in mind to do this so=
 we
> can avoid forking 'git checkout' in sequencer.c
>
> On 16/10/2019 18:26, Denton Liu wrote:
> > Begin the process of lib-ifying the autostash code. In a future commit=
,
> >
> > This patch is best viewed with `--color-moved` and
> > `--color-moved-ws=3Dallow-indentation-change`.
> > this will be used to implement `--autostash` in other builtins.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >   autostash.c      | 137 +++++++++++++++++++++++++++++++++++++++++++++=
++
> >   autostash.h      |  12 +++++
> >   builtin/rebase.c | 137 ---------------------------------------------=
--
> >   3 files changed, 149 insertions(+), 137 deletions(-)
> >
> > diff --git a/autostash.c b/autostash.c
> > index 62ec7a7c80..eb58e0c8a4 100644
> > --- a/autostash.c
> > +++ b/autostash.c
> > @@ -1,9 +1,17 @@
> > +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>
> It might be nicer to have a preparatory step that fixes this by adding a
> 'struct repository *r' argument to the function in builtin/rebase.c befo=
re
> moving the function. You could also do the same for next patch and then =
move
> both functions together.

In addition to that, I think that `reset_head()`

- should live in its own file, not be hidden in `autostash.c`,

- its default reflog action should _not_ be "rebase".

- ideally be made the working horse of `builtin/reset.c`,

- in addition to that `struct repository *r`, it should probably accept
  a `struct index_state *index` and a `const char *worktree_directory`,
  but that can easily come in the future, as needed.

Thanks,
Dscho


>
> Best Wishes
>
> Phillip
>
> > +
> >   #include "git-compat-util.h"
> >   #include "autostash.h"
> > +#include "cache-tree.h"
> >   #include "dir.h"
> >   #include "gettext.h"
> > +#include "lockfile.h"
> > +#include "refs.h"
> >   #include "run-command.h"
> >   #include "strbuf.h"
> > +#include "tree-walk.h"
> > +#include "tree.h"
> > +#include "unpack-trees.h"
> >
> >   int read_one(const char *path, struct strbuf *buf)
> >   {
> > @@ -13,6 +21,135 @@ int read_one(const char *path, struct strbuf *buf)
> >   	return 0;
> >   }
> >
> > +int reset_head(struct object_id *oid, const char *action,
> > +	       const char *switch_to_branch, unsigned flags,
> > +	       const char *reflog_orig_head, const char *reflog_head)
> > +{
> > +	unsigned detach_head =3D flags & RESET_HEAD_DETACH;
> > +	unsigned reset_hard =3D flags & RESET_HEAD_HARD;
> > +	unsigned run_hook =3D flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> > +	unsigned refs_only =3D flags & RESET_HEAD_REFS_ONLY;
> > +	unsigned update_orig_head =3D flags & RESET_ORIG_HEAD;
> > +	struct object_id head_oid;
> > +	struct tree_desc desc[2] =3D { { NULL }, { NULL } };
> > +	struct lock_file lock =3D LOCK_INIT;
> > +	struct unpack_trees_options unpack_tree_opts;
> > +	struct tree *tree;
> > +	const char *reflog_action;
> > +	struct strbuf msg =3D STRBUF_INIT;
> > +	size_t prefix_len;
> > +	struct object_id *orig =3D NULL, oid_orig,
> > +		*old_orig =3D NULL, oid_old_orig;
> > +	int ret =3D 0, nr =3D 0;
> > +
> > +	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
> > +		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
> > +
> > +	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0=
)
> > {
> > +		ret =3D -1;
> > +		goto leave_reset_head;
> > +	}
> > +
> > +	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
> > +		ret =3D error(_("could not determine HEAD revision"));
> > +		goto leave_reset_head;
> > +	}
> > +
> > +	if (!oid)
> > +		oid =3D &head_oid;
> > +
> > +	if (refs_only)
> > +		goto reset_head_refs;
> > +
> > +	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> > +	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> > +	unpack_tree_opts.head_idx =3D 1;
> > +	unpack_tree_opts.src_index =3D the_repository->index;
> > +	unpack_tree_opts.dst_index =3D the_repository->index;
> > +	unpack_tree_opts.fn =3D reset_hard ? oneway_merge : twoway_merge;
> > +	unpack_tree_opts.update =3D 1;
> > +	unpack_tree_opts.merge =3D 1;
> > +	if (!detach_head)
> > +		unpack_tree_opts.reset =3D 1;
> > +
> > +	if (repo_read_index_unmerged(the_repository) < 0) {
> > +		ret =3D error(_("could not read index"));
> > +		goto leave_reset_head;
> > +	}
> > +
> > +	if (!reset_hard && !fill_tree_descriptor(the_repository, &desc[nr++]=
,
> > &head_oid)) {
> > +		ret =3D error(_("failed to find tree of %s"),
> > +			    oid_to_hex(&head_oid));
> > +		goto leave_reset_head;
> > +	}
> > +
> > +	if (!fill_tree_descriptor(the_repository, &desc[nr++], oid)) {
> > +		ret =3D error(_("failed to find tree of %s"), oid_to_hex(oid));
> > +		goto leave_reset_head;
> > +	}
> > +
> > +	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
> > +		ret =3D -1;
> > +		goto leave_reset_head;
> > +	}
> > +
> > +	tree =3D parse_tree_indirect(oid);
> > +	prime_cache_tree(the_repository, the_repository->index, tree);
> > +
> > +	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < =
0)
> > {
> > +		ret =3D error(_("could not write index"));
> > +		goto leave_reset_head;
> > +	}
> > +
> > +reset_head_refs:
> > +	reflog_action =3D getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> > +	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
> > +	prefix_len =3D msg.len;
> > +
> > +	if (update_orig_head) {
> > +		if (!get_oid("ORIG_HEAD", &oid_old_orig))
> > +			old_orig =3D &oid_old_orig;
> > +		if (!get_oid("HEAD", &oid_orig)) {
> > +			orig =3D &oid_orig;
> > +			if (!reflog_orig_head) {
> > +				strbuf_addstr(&msg, "updating ORIG_HEAD");
> > +				reflog_orig_head =3D msg.buf;
> > +			}
> > +			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
> > +				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
> > +		} else if (old_orig)
> > +			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
> > +	}
> > +
> > +	if (!reflog_head) {
> > +		strbuf_setlen(&msg, prefix_len);
> > +		strbuf_addstr(&msg, "updating HEAD");
> > +		reflog_head =3D msg.buf;
> > +	}
> > +	if (!switch_to_branch)
> > +		ret =3D update_ref(reflog_head, "HEAD", oid, orig,
> > +				 detach_head ? REF_NO_DEREF : 0,
> > +				 UPDATE_REFS_MSG_ON_ERR);
> > +	else {
> > +		ret =3D update_ref(reflog_head, switch_to_branch, oid,
> > +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> > +		if (!ret)
> > +			ret =3D create_symref("HEAD", switch_to_branch,
> > +					    reflog_head);
> > +	}
> > +	if (run_hook)
> > +		run_hook_le(NULL, "post-checkout",
> > +			    oid_to_hex(orig ? orig : &null_oid),
> > +			    oid_to_hex(oid), "1", NULL);
> > +
> > +leave_reset_head:
> > +	strbuf_release(&msg);
> > +	rollback_lock_file(&lock);
> > +	while (nr)
> > +		free((void *)desc[--nr].buffer);
> > +	return ret;
> > +}
> > +
> >   int apply_autostash(const char *path)
> >   {
> >   	struct strbuf autostash =3D STRBUF_INIT;
> > diff --git a/autostash.h b/autostash.h
> > index 5f4e4bd22c..1406638166 100644
> > --- a/autostash.h
> > +++ b/autostash.h
> > @@ -6,6 +6,18 @@
> >   /* Read one file, then strip line endings */
> >   int read_one(const char *path, struct strbuf *buf);
> >
> > +#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
> > +
> > +#define RESET_HEAD_DETACH (1<<0)
> > +#define RESET_HEAD_HARD (1<<1)
> > +#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
> > +#define RESET_HEAD_REFS_ONLY (1<<3)
> > +#define RESET_ORIG_HEAD (1<<4)
> > +
> > +int reset_head(struct object_id *oid, const char *action,
> > +	       const char *switch_to_branch, unsigned flags,
> > +	       const char *reflog_orig_head, const char *reflog_head);
> > +
> >   int apply_autostash(const char *path);
> >
> >   #endif
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 661928d427..c3165896cc 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -734,143 +734,6 @@ static void add_var(struct strbuf *buf, const ch=
ar
> > *name, const char *value)
> >   	}
> >   }
> >
> > -#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
> > -
> > -#define RESET_HEAD_DETACH (1<<0)
> > -#define RESET_HEAD_HARD (1<<1)
> > -#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
> > -#define RESET_HEAD_REFS_ONLY (1<<3)
> > -#define RESET_ORIG_HEAD (1<<4)
> > -
> > -static int reset_head(struct object_id *oid, const char *action,
> > -		      const char *switch_to_branch, unsigned flags,
> > -		      const char *reflog_orig_head, const char *reflog_head)
> > -{
> > -	unsigned detach_head =3D flags & RESET_HEAD_DETACH;
> > -	unsigned reset_hard =3D flags & RESET_HEAD_HARD;
> > -	unsigned run_hook =3D flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> > -	unsigned refs_only =3D flags & RESET_HEAD_REFS_ONLY;
> > -	unsigned update_orig_head =3D flags & RESET_ORIG_HEAD;
> > -	struct object_id head_oid;
> > -	struct tree_desc desc[2] =3D { { NULL }, { NULL } };
> > -	struct lock_file lock =3D LOCK_INIT;
> > -	struct unpack_trees_options unpack_tree_opts;
> > -	struct tree *tree;
> > -	const char *reflog_action;
> > -	struct strbuf msg =3D STRBUF_INIT;
> > -	size_t prefix_len;
> > -	struct object_id *orig =3D NULL, oid_orig,
> > -		*old_orig =3D NULL, oid_old_orig;
> > -	int ret =3D 0, nr =3D 0;
> > -
> > -	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
> > -		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
> > -
> > -	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0=
)
> > {
> > -		ret =3D -1;
> > -		goto leave_reset_head;
> > -	}
> > -
> > -	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
> > -		ret =3D error(_("could not determine HEAD revision"));
> > -		goto leave_reset_head;
> > -	}
> > -
> > -	if (!oid)
> > -		oid =3D &head_oid;
> > -
> > -	if (refs_only)
> > -		goto reset_head_refs;
> > -
> > -	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> > -	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> > -	unpack_tree_opts.head_idx =3D 1;
> > -	unpack_tree_opts.src_index =3D the_repository->index;
> > -	unpack_tree_opts.dst_index =3D the_repository->index;
> > -	unpack_tree_opts.fn =3D reset_hard ? oneway_merge : twoway_merge;
> > -	unpack_tree_opts.update =3D 1;
> > -	unpack_tree_opts.merge =3D 1;
> > -	if (!detach_head)
> > -		unpack_tree_opts.reset =3D 1;
> > -
> > -	if (repo_read_index_unmerged(the_repository) < 0) {
> > -		ret =3D error(_("could not read index"));
> > -		goto leave_reset_head;
> > -	}
> > -
> > -	if (!reset_hard && !fill_tree_descriptor(the_repository, &desc[nr++]=
,
> > &head_oid)) {
> > -		ret =3D error(_("failed to find tree of %s"),
> > -			    oid_to_hex(&head_oid));
> > -		goto leave_reset_head;
> > -	}
> > -
> > -	if (!fill_tree_descriptor(the_repository, &desc[nr++], oid)) {
> > -		ret =3D error(_("failed to find tree of %s"), oid_to_hex(oid));
> > -		goto leave_reset_head;
> > -	}
> > -
> > -	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
> > -		ret =3D -1;
> > -		goto leave_reset_head;
> > -	}
> > -
> > -	tree =3D parse_tree_indirect(oid);
> > -	prime_cache_tree(the_repository, the_repository->index, tree);
> > -
> > -	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < =
0)
> > {
> > -		ret =3D error(_("could not write index"));
> > -		goto leave_reset_head;
> > -	}
> > -
> > -reset_head_refs:
> > -	reflog_action =3D getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> > -	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
> > -	prefix_len =3D msg.len;
> > -
> > -	if (update_orig_head) {
> > -		if (!get_oid("ORIG_HEAD", &oid_old_orig))
> > -			old_orig =3D &oid_old_orig;
> > -		if (!get_oid("HEAD", &oid_orig)) {
> > -			orig =3D &oid_orig;
> > -			if (!reflog_orig_head) {
> > -				strbuf_addstr(&msg, "updating ORIG_HEAD");
> > -				reflog_orig_head =3D msg.buf;
> > -			}
> > -			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
> > -				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
> > -		} else if (old_orig)
> > -			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
> > -	}
> > -
> > -	if (!reflog_head) {
> > -		strbuf_setlen(&msg, prefix_len);
> > -		strbuf_addstr(&msg, "updating HEAD");
> > -		reflog_head =3D msg.buf;
> > -	}
> > -	if (!switch_to_branch)
> > -		ret =3D update_ref(reflog_head, "HEAD", oid, orig,
> > -				 detach_head ? REF_NO_DEREF : 0,
> > -				 UPDATE_REFS_MSG_ON_ERR);
> > -	else {
> > -		ret =3D update_ref(reflog_head, switch_to_branch, oid,
> > -				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> > -		if (!ret)
> > -			ret =3D create_symref("HEAD", switch_to_branch,
> > -					    reflog_head);
> > -	}
> > -	if (run_hook)
> > -		run_hook_le(NULL, "post-checkout",
> > -			    oid_to_hex(orig ? orig : &null_oid),
> > -			    oid_to_hex(oid), "1", NULL);
> > -
> > -leave_reset_head:
> > -	strbuf_release(&msg);
> > -	rollback_lock_file(&lock);
> > -	while (nr)
> > -		free((void *)desc[--nr].buffer);
> > -	return ret;
> > -}
> > -
> >   static int move_to_original_branch(struct rebase_options *opts)
> >   {
> >    struct strbuf orig_head_reflog =3D STRBUF_INIT, head_reflog =3D STR=
BUF_INIT;
> >
>
