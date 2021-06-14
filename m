Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C6C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD15860FF4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 21:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhFNVZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:25:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:48191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234935AbhFNVZY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 17:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623705795;
        bh=siJzvmTRX5Ec9b7xZa57MFrU3dp7UnH+59PCxaQSps8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z5/dOgrelrCcQOlU3Q6nsqEdrqJP8S2+qpk4O5oZ1OQSsP194N7KWdj6HW1DN2WFT
         z+i08TgymmBudJ6gzfUKyF2VT4kDgqNz4RNV5i/Jiyk0zMlYLhG1HxxiccfCTJCrRK
         FsmUbmMCQZbXSypAu5gpw+CniS219pTDjYFlBJbo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1lfeUd1rV2-00M1yN; Mon, 14
 Jun 2021 23:23:15 +0200
Date:   Mon, 14 Jun 2021 23:23:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 04/28] fsmonitor-ipc: create client routines for
 git-fsmonitor--daemon
In-Reply-To: <nycvar.QRO.7.76.6.2106021320490.55@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2106142320070.57@tvgsbejvaqbjf.bet>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com> <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <e4a263728773381a64b8662c0577a3f12eff4ca0.1621691828.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2106021320490.55@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o0NAzuQ1hWnvqtstvMkicXwMeYGontOk4NJJK03CrSIIogmV0DS
 6L5Irw4N//gW8zgL1MyS+PDSu4JO1LN150PNzfCJrmOLh0l6TE0iW7X20QVW7MVOVLkyBmF
 MbD5EGO5EYuq414SAOToEnI7CA12Fpth1wVhsSgyOu4NCzxbp4Rjv5yV56StwdY3FAQ331e
 bk4LUu+FZU/DY5xX34yuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kru6kCeSBNA=:TYPjhqefmLokavHs+oux3V
 ALMVdyBUzxlc0s7WkBvC6WXer8Jp8K6/4gfnDXWC1mFdymXVpmOWTESV+G5dROUqvjaNOIVDG
 mkg+QSszw1bvgEj5lyCAcf/YOEUiIZBs4OVH/49QQ97K5i230Ty3DTKyv7Laph2p+P8BSAAjm
 LZjo8TzGc6C0LUfOSpjwWA8WgboiLa1zHlNTGYZ2oaDc7dsITf1157hvterkRELHStKyBjxCp
 3Mu4rY1Qit+pE7qlFobtuik/3aj1zHzNm863HisV+JpOHeNRFzVqBnl36L0UPrzp6wAt/zWe3
 f+OqFVLv64vjV1VTMYFlW9/NKcXbox0uLKh9/IJwkiqf2ytWb3k8j4ruoaaU84p+XxTQ7sRZq
 sz2NhmeJ9eUHHmeM0aFhYewCVSeZ2wWnpLJFyHjSMW8cHldT5RxI4EDFN9x9puy8S0Af5nBBp
 eEiWrkqcfDM52pz2uf31LXLkBN/7EkCgrOnyHuzjj4qR7sYeQuO8jgfJh49Y+UHLC0bloHa0Y
 lemf1hnBSbraxEOcoIyoGgSnnHmoCU7btEz1CAmCXn5g2OisdL5XRI+2a14GFRkc6qng0iu4+
 bq1wL8GJ4zmto4mJJSK8tl7jDyhbUVQs1Z/PLu+137xnhyKS+BQBtfksaV/6vJetp9pN1A1v6
 4LuzYjVJ1e6RHKa6Ii/2TaOBBqa8iaAIvNsLrzjo+oO3qqPU7/7n5pvoLLiJXvqpS3BEqKffJ
 H/v9lKEhDl3qTkoP+/Ltf1XMN8r+sxeNRmbxvm65XwBQGbPdSbXEqs+knoFu6kDdzRPzYe/rs
 MCtCglwkFWgR9TGHaoJZ98FE7XgxjhrvFvS4P2kmnvXBRBcG3QOmh14JT4L6N0uuCnGVWmAlm
 4YBYwxGfcKYGnjpxeDdVIb2BAY+CooWkwRe03MJW42lFu5DpTvcZZdBxUQsqF1PrrUs1hOes9
 xjaUldvtPW5BomqN4KXseuk4YN4pgpMSQkqUH08kosp71j+JtlR6EipS44A9eSt7L/P4ZLdnQ
 y0ACwb/NTsQ53d7oY6FXBbHHy+sYO3lj5oEIfB658+gBCC0fR8chfM23B+h2vY9PfD3cUXjq+
 RWkF1mtgv7PkdlOi+x5NbsGhghfxCIX76M4KM78GOuikyMUH8QHCD10Uw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Wed, 2 Jun 2021, Johannes Schindelin wrote:

> I know you're on vacation, therefore I would like to apologize for addin=
g
> to your post-vacation notification overload, but...

Now that you're back from vacation...

> On Sat, 22 May 2021, Jeff Hostetler via GitGitGadget wrote:
>
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
> > new file mode 100644
> > index 000000000000..e62901a85b5d
> > --- /dev/null
> > +++ b/fsmonitor-ipc.c
> > @@ -0,0 +1,179 @@
> > [...]
> > +
> > +int fsmonitor_ipc__send_query(const char *since_token,
> > +			      struct strbuf *answer)
> > +{
> > +	int ret =3D -1;
> > +	int tried_to_spawn =3D 0;
> > +	enum ipc_active_state state =3D IPC_STATE__OTHER_ERROR;
> > +	struct ipc_client_connection *connection =3D NULL;
> > +	struct ipc_client_connect_options options
> > +		=3D IPC_CLIENT_CONNECT_OPTIONS_INIT;
> > +
> > +	options.wait_if_busy =3D 1;
> > +	options.wait_if_not_found =3D 0;
> > +
> > +	trace2_region_enter("fsm_client", "query", NULL);
> > +
> > +	trace2_data_string("fsm_client", NULL, "query/command",
> > +			   since_token);
> > +
> > +try_again:
> > +	state =3D ipc_client_try_connect(fsmonitor_ipc__get_path(), &options=
,
> > +				       &connection);
> > +
> > +	switch (state) {
> > +	case IPC_STATE__LISTENING:
> > +		ret =3D ipc_client_send_command_to_connection(
> > +			connection, since_token, strlen(since_token), answer);
>
> Here, `since_token` can be `NULL` (and hence the `strlen(since_token)` c=
an
> lead to a segmentation fault). I ran into this situation while `git reba=
se
> -i --autostash` wanted to apply the stashed changes.
>
> Since I picked up your v2 and included it in Git for Windows v2.32.0-rc2=
,
> I needed this hotfix: https://github.com/git-for-windows/git/pull/3241

I actually noticed another similar issue and fixed it in time for Git for
Windows v2.32.0, but eventually figured out the actual culprit, with a
much better fix:

=2D- snip --
commit bc40a560d3c95040b55fd7be6fe5b7012d267f8f
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Wed Jun 9 09:49:50 2021 +0200

    fixup! fsmonitor: introduce `core.useBuiltinFSMonitor` to call the dae=
mon via IPC

    In FSMonitor v1, we made sure to only use a valid `since_token` when
    querying the FSMonitor. This condition was accidentally lost in v2, an=
d
    caused segmentation faults uncovered by Scalar's Functional Tests.

    I had tried to fix this in https://github.com/git-for-windows/pull/324=
1,
    but the fix was incomplete, and I had to follow up with
    https://github.com/git-for-windows/pull/3258. However, it turns out th=
at
    both of them were actually only work-arounds; I should have dug deeper
    to figure out _why_ the `since_token` was no longer guaranteed not to =
be
    `NULL`, and I finally did.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

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

Would you mind squashing this in when you re-roll?

Ciao,
Dscho
