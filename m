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
	by dcvr.yhbt.net (Postfix) with ESMTP id AE35E1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfJUTBR (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 15:01:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:46345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfJUTBR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 15:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571684469;
        bh=xQqqmcZnzVZGaggKd/yhh9kJ+JL1gvHE67IrnVuF9kU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Fq+E+xhcmtUjCEzsBThFOmvHXroMz8BsFtio2eOm0caz36LAt0O+O1G591Bz3jQGL
         GdIIft7Umgcdgwk6KvTeMt+VkxN38R0Jbpl0GXzQXpw/lenUqBIBP3IDUoE5cUsF9z
         IOJzLK3W6YXqc03K8Y9m42b2KB7VVSPayxxr6v2U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1i2ltW1wSZ-00u4eb; Mon, 21
 Oct 2019 21:01:09 +0200
Date:   Mon, 21 Oct 2019 21:00:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 5/7] autostash: extract perform_autostash() from
 rebase
In-Reply-To: <0518b0b187245e807987457cd558a1ab38476c5c.1571246693.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910212057460.46@tvgsbejvaqbjf.bet>
References: <cover.1571246693.git.liu.denton@gmail.com> <0518b0b187245e807987457cd558a1ab38476c5c.1571246693.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MPdNXNy8OFY7z8X3mYlSPH6ICvTI7tDb0x5voz3Jk3VRAT44qbp
 XN9s42T1fegkJDD1KnMm2Xb7OKG8Nk5cNVPKR2cFvZV8ooFH5gjDXYq2K0Orvdun3cj8aZI
 5dJNr4ws086WXUHaWYLQg4+U00V8ep1K7gurPF4wFOJhjf6Yd/AaYuSW9tK4OrJbuHdH+X1
 ng1g8JZ11fW03AT6wzaig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OvCAi60QfHs=:oBa3+snJOMkl2C4ikmB1/v
 aPv1/6hMrnEILg5UwcKZTJdWG0r406xviEUORyRL+gdpceptC6Ltv0SwlX5z6eG8xMYFJEA5E
 hmLd+Wskl2vacQW5VUKOb4ZTr0BF8X33/lEqz4y8VY20JBuo22T27/0qXdefxwSVMycy7lgGz
 tGCU9q0Py1Pbtv7bTnJb6ZW2NRX/MbjRkwLUgPrK1it6DFx1Xajw9tZQbIbnbGL+nEhvKLjfK
 2U/Bk4s+4fQNtpevBMS7I8UBoBdX2oJkxbygtp4twNzZIYOLXtNjC8lLV2p+xHIKaKSfZO8Wm
 Dd4cfUBYX+CXRdLCysiMcN2ubkiBf7CQpuX1YHZN5LoSA5htCkDYwIbD94Obf0+oRjuNJT83A
 d9vRHzwdksXLZRHLALMIQAXHvOh40ny45gq6SWg/iO7uj5jNisVBOUKzfmneKdOsaavsqgj19
 QF4ykUz2BDZCYnEr4r+imy5vatu3rPSKEjdmsuFPfoy4ZAMj/JT9Sp+boEZ2DvI5zSDRZxgJF
 3pWkr1QYv3zegP1DKAGfyEVmYaL1bUbeJnHYcF4u1dV02uiHkJ592GX0+6GJLCtm2NLpOO//m
 9h78ZzfCYRpucA1X0ua83OgtKPFIFqHVq0YsuS1dP3woOKs48VLbHO23mxhn1HIVxwMgvyGwH
 Y11O6RBIe3RLY1P45uY+NfSUXQf1KCCNEvvlwsvHtPa4EZQaJYYh7Vu4FdcY1YsPiUA4kcKP1
 y1eKs3nD5JEHIrd2lu2ONTHYk55dpK83eFH9SIj9jRhjj3I+8Euut+mv+8IlOH+WgUmwjoEQY
 6NH9LAP62sfZwvi31Sfz5TY5f1s9oyLqtCHo/PygIn+32iubp0IqOWPIe/qDaR0nLE5Tgar3X
 ohx9mfDFLpJqBVM1ejgyZEZzCteJWD9OopgyxKUiiCW1jPmmIAA5BPzrrwNKlwpvrqy25mXfc
 DO3JntexWsnTZoK0loOdQT0BnxbQ0b7t87q8ukq7nUt1JYxTGci/8mxLgQAtsfAkOHMbaspP4
 Tye6pLCrlSnwS9omu9UbxL2I4prUEnJgZATa/jmwr7l7rshq1sNH2JmA9wDA2FAh9PsgRX7ib
 ATJvR8f14KQDR/MjNQ1HjcSI2h+tataF/rB6Hh7zJ1GSwmVRoqV6yho+KILq9ZdEKHJ6Xbemx
 acbclr+EiEF7Gnoz9846GbpLVvVvg0ow8ICXN5MJt083cEZ9NkRv+ipcOUMZRDv9Rpj/uyTlG
 e/RPtMbmcV9d//xIAGci2SiUCXebhGIWGA5NX1GfAUaKpEVkYrjiYxPvQ+w0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, 16 Oct 2019, Denton Liu wrote:

> Continue the process of lib-ifying the autostash code. In a future
> commit, this will be used to implement `--autostash` in other builtins.
>
> This patch is best viewed with `--color-moved` and
> `--color-moved-ws=3Dallow-indentation-change`.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  autostash.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  autostash.h      |  1 +
>  builtin/rebase.c | 44 +-------------------------------------------
>  3 files changed, 48 insertions(+), 43 deletions(-)
>
> diff --git a/autostash.c b/autostash.c
> index eb58e0c8a4..722cf78b12 100644
> --- a/autostash.c
> +++ b/autostash.c
> @@ -12,6 +12,7 @@
>  #include "tree-walk.h"
>  #include "tree.h"
>  #include "unpack-trees.h"
> +#include "wt-status.h"
>
>  int read_one(const char *path, struct strbuf *buf)
>  {
> @@ -150,6 +151,51 @@ int reset_head(struct object_id *oid, const char *a=
ction,
>  	return ret;
>  }
>
> +void perform_autostash(const char *path)

Maybe we can find a better name than "perform_autostash"? It is not
clear whether this is the "saving" or "applying" part of the autostash,
I think.

Maybe `save_autostash()`? And maybe instead of `path`, the parameter
could be `save_hash_to_path` or something similar?

Now that I think of it, I forgot to mention in a reply to an earlier
patch in this series that `reset_head()` might be too generic a name to
be a global function...

Ciao,
Dscho

> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	struct lock_file lock_file =3D LOCK_INIT;
> +	int fd;
> +
> +	fd =3D hold_locked_index(&lock_file, 0);
> +	refresh_cache(REFRESH_QUIET);
> +	if (0 <=3D fd)
> +		repo_update_index_if_able(the_repository, &lock_file);
> +	rollback_lock_file(&lock_file);
> +
> +	if (has_unstaged_changes(the_repository, 1) ||
> +	    has_uncommitted_changes(the_repository, 1)) {
> +		struct child_process stash =3D CHILD_PROCESS_INIT;
> +		struct object_id oid;
> +
> +		argv_array_pushl(&stash.args,
> +				 "stash", "create", "autostash", NULL);
> +		stash.git_cmd =3D 1;
> +		stash.no_stdin =3D 1;
> +		if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
> +			die(_("Cannot autostash"));
> +		strbuf_trim_trailing_newline(&buf);
> +		if (get_oid(buf.buf, &oid))
> +			die(_("Unexpected stash response: '%s'"),
> +			    buf.buf);
> +		strbuf_reset(&buf);
> +		strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
> +
> +		if (safe_create_leading_directories_const(path))
> +			die(_("Could not create directory for '%s'"),
> +			    path);
> +		write_file(path, "%s", oid_to_hex(&oid));
> +		printf(_("Created autostash: %s\n"), buf.buf);
> +		if (reset_head(NULL, "reset --hard",
> +			       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
> +			die(_("could not reset --hard"));
> +
> +		if (discard_index(the_repository->index) < 0 ||
> +			repo_read_index(the_repository) < 0)
> +			die(_("could not read index"));
> +	}
> +}
> +
>  int apply_autostash(const char *path)
>  {
>  	struct strbuf autostash =3D STRBUF_INIT;
> diff --git a/autostash.h b/autostash.h
> index 1406638166..e08ccb9881 100644
> --- a/autostash.h
> +++ b/autostash.h
> @@ -18,6 +18,7 @@ int reset_head(struct object_id *oid, const char *acti=
on,
>  	       const char *switch_to_branch, unsigned flags,
>  	       const char *reflog_orig_head, const char *reflog_head);
>
> +void perform_autostash(const char *path);
>  int apply_autostash(const char *path);
>
>  #endif
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index c3165896cc..c4decdfb5b 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1797,49 +1797,7 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>  		die(_("could not read index"));
>
>  	if (options.autostash) {
> -		struct lock_file lock_file =3D LOCK_INIT;
> -		int fd;
> -
> -		fd =3D hold_locked_index(&lock_file, 0);
> -		refresh_cache(REFRESH_QUIET);
> -		if (0 <=3D fd)
> -			repo_update_index_if_able(the_repository, &lock_file);
> -		rollback_lock_file(&lock_file);
> -
> -		if (has_unstaged_changes(the_repository, 1) ||
> -		    has_uncommitted_changes(the_repository, 1)) {
> -			const char *autostash =3D
> -				state_dir_path("autostash", &options);
> -			struct child_process stash =3D CHILD_PROCESS_INIT;
> -			struct object_id oid;
> -
> -			argv_array_pushl(&stash.args,
> -					 "stash", "create", "autostash", NULL);
> -			stash.git_cmd =3D 1;
> -			stash.no_stdin =3D 1;
> -			strbuf_reset(&buf);
> -			if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
> -				die(_("Cannot autostash"));
> -			strbuf_trim_trailing_newline(&buf);
> -			if (get_oid(buf.buf, &oid))
> -				die(_("Unexpected stash response: '%s'"),
> -				    buf.buf);
> -			strbuf_reset(&buf);
> -			strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
> -
> -			if (safe_create_leading_directories_const(autostash))
> -				die(_("Could not create directory for '%s'"),
> -				    options.state_dir);
> -			write_file(autostash, "%s", oid_to_hex(&oid));
> -			printf(_("Created autostash: %s\n"), buf.buf);
> -			if (reset_head(NULL, "reset --hard",
> -				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
> -				die(_("could not reset --hard"));
> -
> -			if (discard_index(the_repository->index) < 0 ||
> -				repo_read_index(the_repository) < 0)
> -				die(_("could not read index"));
> -		}
> +		perform_autostash(state_dir_path("autostash", &options));
>  	}
>
>  	if (require_clean_work_tree(the_repository, "rebase",
> --
> 2.23.0.897.g0a19638b1e
>
>
