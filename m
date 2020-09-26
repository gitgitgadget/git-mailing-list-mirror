Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205B7C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71782371F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CdWtsAdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgIZV2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:28:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:47115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIZV2W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601155697;
        bh=AtrUOFrMtB6aNPq2UDhUST/m/IroJ1FxKtXt3KJGNNA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CdWtsAdleC3GkFvXPsvfc6AV/trx6FiGopCXDImQL7qk6hY6/UmtMK9vXP/dRuqUW
         lUdaA/rW1or9+RJxfsL7IT5jYTyvoIzsmT4s1A9OebfCn14bKSuFWc7nymE6gnLaQX
         /At9FFeSxbWNdxyUVCcLoteiB7XqGKAM8m8VRVrk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.213.116]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bWr-1kU9hr3CBX-010ZVP; Sat, 26
 Sep 2020 23:28:16 +0200
Date:   Sat, 26 Sep 2020 23:28:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [RFH] sequencer: simplify logic around stopped-sha file
In-Reply-To: <xmqq8scymmo1.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009262320530.50@tvgsbejvaqbjf.bet>
References: <xmqq8scymmo1.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y/Eq4dIcONsyVnyQ7CPFRk5Hj07vl7XE0KIwMYPTk95xOwmpXWX
 TPU18mD+Rxn8mD+DT4qx4yU5HwHEbT5jo7ZDxsD/9WKsaI1isVwMboOnfEQVXO8vtuzb/UU
 8jEdAXhcqg/YyhtdeRywuFPUZm0nRMMvG1Z2bHNt0T0Qk+iFq20OAv75ySwXzvDcby6b2TH
 7YdzaMJAUROgdRGa4g9Wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nfCecrc2m+0=:DQvKek06ybk34vTlNz6o/y
 /1maKSes/B5GCbedSuuBMxmRiXLs4xOhvDW678C/i3Ob9+ltdst/fBQ52mLegJikee5rywyg4
 oXXqvNXv2kQRo0yhaevVgprkL9t5RUw9DrgOcFWzL7Y22RRqnwXuLzzxzW+uai13lt4SzYFkX
 rlIkOnGNlajYvhrZh9x2K655NajTfR59cVa9h0qrMRMQ/JIRP/c0/gztNwiLL6BgooWm8L5td
 p7JzVgicw8KdkKCuzeDwz7KoRmmTI36sWruhpWYVeRZPvNQ24GhUnITQ7fbmJotvdfYwUNnpz
 2JJiG7BzHRRM74STZM3F8mO1Xj62NZWfV4fagxi0vSa4wjyK1yo5/vuc0j+VJ1BY2tMY9taGU
 TcmjO0xRugcScxNjQuE70fw343wZiUxIBoxHQ85jrw9W/PhmeGzzSIWv3JdZQ7EBbGOEfAFwt
 P+K+p7Zm6GKo+FOPfYK2dATIQ2HgoDrJPOMf2SCAU1FohWEX+K1N+XYfHaLBGUZWnHxKQkgnQ
 1RbWcmPndaXDaheu4/kdjVm1AqdLa+HUyDyqI9zZmh+ayAi19LoZJbM7Rao0Arf0u/gMYqwUv
 zOL51H+b3mh0aBVzWJofbdGfg6e8zEzk6cPVKDWC9ghLHHcJsXuinLCbKsyf2+fpd3jaefY/m
 sXL/uHI3einmpl6PwXYGilO3B0S4Ku4OKXDEEwAMlwNQQXl4mxsjursqnbfq2GQC+wQnPgOy7
 CJ709kwn5SbsSRvIpXZS41WnRuWfmtdbjQg83bYoKrGC2C6h5FT09nKappAwlcwesoJ+6VNDM
 wkzrRa/qHU7uzjWjFyWIjRqAzTGBlhE7KWfPkoiouC5YAp/d95snqU6LJ1ABjvCtK16PThyn5
 C1dHjXcRUh4xWKxxxDH/9+BstwDMU4SUOzoFgM9CsMuJ9V2ZnM52DKCFjqUwQK1A9/D3/rgxf
 qHapjlncTJxS65f3h1JR5FCkzAueiLejKmUUAZiNrxOtCm4u/bRh4UX4U57YxL+IQZJfHbLVq
 i47uh+ZX9XYpLIV95FZDgSYn5V5fZ4HCfkkK2cYGG9IJ7/qg4zxkKaFOZX+Mezb02d7eJf+gz
 HegIhFMOQz+oMTBNBV1AqYabkpMKniJIBAdfWVvCIiZRihSEsnOYqbaq73FW0xxKwoy/AntaZ
 SBUJSe7LrBgS6J72H0zsBvIXjU0ETpvBHDw7kzkO68qOb3XN4AcsBgOOqnJSFpWwWOkT3BliZ
 fNfcbzdFX18oOnY+mQZJLwVTb6xLMi1xOD+HrWQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 24 Sep 2020, Junio C Hamano wrote:

> While I was auditing the use of get_oid_committish(), I noticed that
> an abbreviated object name is written to rebase-merge/stopped-sha
> only to be read later and expanded to a full object name to be
> passed to record_in_rewritten().  Nobody seems to expose this to the
> end-user and it is unclear if there is a point in keeping it short
> by abbreviating and risking to make it ambiguous as the rebase
> progresses and creates new objects.
>
> The attached patch tries to simplify the logic involved around this
> file, to write and read full object names to/from the file, and the
> result seems to pass testsuite---which in the ideal world would be
> sufficient signal that this change is safe and sane, but it could be
> that original authors thought that a change to stop abbreviating is
> nonsense and not worth protecting the code against, hence RFH here.
>
> Is there something obvious I am not seeing that makes this change a
> bad idea (other than "somebody may be in the middle of a rebase and
> all of a sudden, version of Git gets updated to contain this one,
> which is unable to read abbreviated object name the current version
> left on disk", which I am deliberately ignoring)?

At least in my understanding, you are not missing anything:

- this file is an implementation detail,

- it is not exposed directly via any user-visible interface,

- any reader will _have_ to be prepared for an unabbreviated object ID (in
  the highly unlikely case that an object ID would be ambiguous if
  abbreviated even by one hex character),

- and most importantly: just like we expand the commit IDs in the todo
  list, we actually want to expand them in `stopped-sha` because it _is_
  possible that a new object is written that makes the previous
  unambiguously abbreviated object ID now ambiguous (e.g. when the user
  commits in a separate worktree while the rebase is interrupted, before
  continuing the rebase).

In short: ACK

Thank you,
Dscho

>
> Thanks.
>
>
>  sequencer.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index fd7701c88a..7dc9088d09 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -120,7 +120,7 @@ static GIT_PATH_FUNC(rebase_path_author_script, "reb=
ase-merge/author-script")
>  static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
>  /*
>   * When we stop at a given patch via the "edit" command, this file cont=
ains
> - * the abbreviated commit name of the corresponding patch.
> + * the commit object name of the corresponding patch.
>   */
>  static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha=
")
>  /*
> @@ -3012,11 +3012,12 @@ static int make_patch(struct repository *r,
>  {
>  	struct strbuf buf =3D STRBUF_INIT;
>  	struct rev_info log_tree_opt;
> -	const char *subject, *p;
> +	const char *subject;
> +	char hex[GIT_MAX_HEXSZ + 1];
>  	int res =3D 0;
>
> -	p =3D short_commit_name(commit);
> -	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
> +	oid_to_hex_r(hex, &commit->object.oid);
> +	if (write_message(hex, strlen(hex), rebase_path_stopped_sha(), 1) < 0)
>  		return -1;
>  	res |=3D write_rebase_head(&commit->object.oid);
>
> @@ -4396,7 +4397,7 @@ int sequencer_continue(struct repository *r, struc=
t replay_opts *opts)
>
>  		if (read_oneliner(&buf, rebase_path_stopped_sha(),
>  				  READ_ONELINER_SKIP_IF_EMPTY) &&
> -		    !get_oid_committish(buf.buf, &oid))
> +		    !get_oid_hex(buf.buf, &oid))
>  			record_in_rewritten(&oid, peek_command(&todo_list, 0));
>  		strbuf_release(&buf);
>  	}
>
