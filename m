Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B2C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 21:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986706100B
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 21:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhFNVa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:30:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:36599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234143AbhFNVa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 17:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623706100;
        bh=NzWPweDt+g9bpYg9GBKkTKJ1oTlzWl6hsibDV4yeAcQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OhbOtCjIkEXFz42JSQjG2vcPyOWzP45QcPbHWCR2VciSXU8NAmi6Lkwqw1vdBFWox
         eIPRguho6WaNRh7YgIlhye4D81+ypTjy+PKDXAWayEeS/qc24K5zcCtUhwHjnVEksV
         pl16YJp+xKnmqBnOV0MZft0gg4+CuEM9VxWRfxzU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1lTlmR2d4d-00lAeO; Mon, 14
 Jun 2021 23:28:20 +0200
Date:   Mon, 14 Jun 2021 23:28:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 07/28] fsmonitor: introduce `core.useBuiltinFSMonitor`
 to call the daemon via IPC
In-Reply-To: <7e097cebc14328bc1ec6e30fc164270e0889ff06.1621691828.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106142324250.57@tvgsbejvaqbjf.bet>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com> <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <7e097cebc14328bc1ec6e30fc164270e0889ff06.1621691828.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4XwJzzxbtPtm8OtfsL1KobPg0bgg+j6F1q0Uc1w3yuJvBH7fpV7
 ww+HDBVk8ZVyFvxtdda0nDL+j6DtNNyO51pCyvTh6zQieqloS5tCtaYT3NkLM/wHjitwV3k
 8TbXgp9n4Z/ivf3mEyOJCCF1SV/qVpyG8KAiCdSwA1vsMxM5ZGde+V+OTre3J6TE70EBn6b
 YJTQDMF/LLH93Yzu0Si7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rWj3eb8qR3U=:y4IRIoeat7ViQXu37kqavu
 c7RsEoGvxZ5t1kT4T8SNs0+JVVJbbzlGEbguzF8DZ4WkWkJwY1WnzcD5xAovsxmrciRV45vTN
 ioOBZ31XAieZaVh2bb0UWVvTcc6mQ6TSEtIcefvMs28n7TGLWcIJB9ZsDHDxQZtJpoYQ6Ji8v
 ldapfXLn43TWbci1FZUWxtHIdKpWm3nnet47bLYX1Gg4bAjnWxwOjsdFzyif9w8Cw0K/2ywqZ
 1Ub2ELeA2YDXM5O3twZ18IG62+/33LKFjmramrTbzqC2IgEWmP4YaXH5eT7dMP19UTwXQjtl7
 NW6snsjsqHu2GWL0OrPvmsphe5r2BKiI3Qtuxh2E0SeIMhf5YIDkDRyGacYKBewDUH3zsCleO
 8ANoYW7cxYOBfyin3hnWKPl14Cb0YPJb/yzr9pE5jIOxEHYMwFRLXANdXL7FajaqGWmZYKzhn
 6QEBEPpBCVOby7weMHK4C3YVrtb5mbVnvCTvkay/RrWMPJ2g3P0MMv8eISH+ut4HV1HNYhbh8
 GssqOwKS/fnNVXRxkJFZgvtFxMex26UoU5P/jdPT5ZuKlzuyDuaXTMv8zBKLp4e/k6xHu8rnM
 dtwX1qyPs6ny8rQRc9uQIwhYz2uhLNJqjxxrZW8ry+7LXov+XHUj2Yro2EmpgqFIQtwLbR9OK
 +Gy6+YPe5ul+JjUxSwRbfHjMnZ5GF2gGak4pbU5a3pzoY2Q/9GNyuf1A+LIjuDOQ60c8np04n
 ZLXfaIFhtkrgfRIVHmdP5Ua32AtVFcDybPsZGpNmFDxo2VE9dEM3uNAqIXAxkVjAw74uUzwfa
 UlLP05CamjRYXr+6MvzhUQ/VASC8wSZSQqTy2C64WNem43zZG8Ou1QPvbwAmsj+yfWRrW7gf+
 JwXRcFXs+n3Mlw2j2/uLXS/n6mhb19a3Sa453tepVWllKNzOYUt7nX9uWRKA977N7DUQMHKbs
 6ltSYka2e2KBddPtvPODRycb65qM2Ed+K/fbFZuTkCpAaEErFqy6rhCv7Gk0lDVji9Xso4tQs
 dLSeuRDexPMSYFd//YL7qWXY2XLfEptA5HCBJbjwuAvUlguK53doPa7KvXKl6y3h/er2WvCHE
 Kjmgj0VQ+gPxviyJXR2Gn3KIOpBeHt7PNn/4YYSLTMqKEqC9gSPODpJJQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Sat, 22 May 2021, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/fsmonitor.c b/fsmonitor.c
> index 9c9b2abc9414..c6d3c34ad78e 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -3,6 +3,7 @@
>  #include "dir.h"
>  #include "ewah/ewok.h"
>  #include "fsmonitor.h"
> +#include "fsmonitor-ipc.h"
>  #include "run-command.h"
>  #include "strbuf.h"
>
> @@ -231,6 +232,7 @@ static void fsmonitor_refresh_callback(struct index_=
state *istate, char *name)
>
>  void refresh_fsmonitor(struct index_state *istate)
>  {
> +	struct repository *r =3D istate->repo ? istate->repo : the_repository;
>  	struct strbuf query_result =3D STRBUF_INIT;
>  	int query_success =3D 0, hook_version =3D -1;
>  	size_t bol =3D 0; /* beginning of line */
> @@ -247,6 +249,46 @@ void refresh_fsmonitor(struct index_state *istate)
>  	istate->fsmonitor_has_run_once =3D 1;
>
>  	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
> +
> +	if (r->settings.use_builtin_fsmonitor > 0) {
> +		query_success =3D !fsmonitor_ipc__send_query(
> +			istate->fsmonitor_last_update, &query_result);

As I pointed out elsewhere in the thread, this is a slight change in
behavior: in the previous iteration, we had this call in
`query_fsmonitor()`, which was only ever called if
`istate->fsmonitor_last_update` is non-`NULL`.

The code in `fsmonitor_ipc__send_query()` does actually depend on this,
therefore we need this change to be squashed in:

=2D- snip --
diff --git a/fsmonitor.c b/fsmonitor.c
index 22623fd228f..0b40643442e 100644
=2D-- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -290,8 +290,9 @@ void refresh_fsmonitor(struct index_state *istate)
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");

 	if (r->settings.use_builtin_fsmonitor > 0) {
-		query_success =3D !fsmonitor_ipc__send_query(
-			istate->fsmonitor_last_update, &query_result);
+		query_success =3D istate->fsmonitor_last_update &&
+			!fsmonitor_ipc__send_query(istate->fsmonitor_last_update,
+						   &query_result);
 		if (query_success) {
 			/*
 			 * The response contains a series of nul terminated
=2D- snap --

Thanks,
Dscho

> +		if (query_success) {
> +			/*
> +			 * The response contains a series of nul terminated
> +			 * strings.  The first is the new token.
> +			 *
> +			 * Use `char *buf` as an interlude to trick the CI
> +			 * static analysis to let us use `strbuf_addstr()`
> +			 * here (and only copy the token) rather than
> +			 * `strbuf_addbuf()`.
> +			 */
> +			buf =3D query_result.buf;
> +			strbuf_addstr(&last_update_token, buf);
> +			bol =3D last_update_token.len + 1;
> +		} else {
> +			/*
> +			 * The builtin daemon is not available on this
> +			 * platform -OR- we failed to get a response.
> +			 *
> +			 * Generate a fake token (rather than a V1
> +			 * timestamp) for the index extension.  (If
> +			 * they switch back to the hook API, we don't
> +			 * want ambiguous state.)
> +			 */
> +			strbuf_addstr(&last_update_token, "builtin:fake");
> +		}
> +
> +		/*
> +		 * Regardless of whether we successfully talked to a
> +		 * fsmonitor daemon or not, we skip over and do not
> +		 * try to use the hook.  The "core.useBuiltinFSMonitor"
> +		 * config setting ALWAYS overrides the "core.fsmonitor"
> +		 * hook setting.
> +		 */
> +		goto apply_results;
> +	}
> +
>  	/*
>  	 * This could be racy so save the date/time now and query_fsmonitor
>  	 * should be inclusive to ensure we don't miss potential changes.
> @@ -301,6 +343,7 @@ void refresh_fsmonitor(struct index_state *istate)
>  			core_fsmonitor, query_success ? "success" : "failure");
>  	}
>
> +apply_results:
>  	/* a fsmonitor process can return '/' to indicate all entries are inva=
lid */
>  	if (query_success && query_result.buf[bol] !=3D '/') {
>  		/* Mark all entries returned by the monitor as dirty */
> diff --git a/repo-settings.c b/repo-settings.c
> index f7fff0f5ab83..93aab92ff164 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -58,6 +58,9 @@ void prepare_repo_settings(struct repository *r)
>  		r->settings.core_multi_pack_index =3D value;
>  	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
>
> +	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && va=
lue)
> +		r->settings.use_builtin_fsmonitor =3D 1;
> +
>  	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
>  		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
>  		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE=
_WRITE);
> diff --git a/repository.h b/repository.h
> index b385ca3c94b6..d6e7f61f9cf7 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -29,6 +29,8 @@ enum fetch_negotiation_setting {
>  struct repo_settings {
>  	int initialized;
>
> +	int use_builtin_fsmonitor;
> +
>  	int core_commit_graph;
>  	int commit_graph_read_changed_paths;
>  	int gc_write_commit_graph;
> --
> gitgitgadget
>
>
