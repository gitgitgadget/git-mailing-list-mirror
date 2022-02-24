Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7E1C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiBXQqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBXQqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:46:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADAE1637E0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645721157;
        bh=fNtSRs3EBTzgbOFsvBbC0I0m7yrvNcPAB3YE4bmb1eY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KLClmj4uzzOUO53hzJYVM0qrxau7YKYQpWZMgdheUMErux4bP+I42MNZa6xtg2MK5
         iBoFTFr3M7Ef7PaBRlKVtQFe7HMJ4fz9JBGUcIKUQlbRNuk8WKMFqCwl+qJkjz495b
         QAj/MfJV2i52B5XL+fYdGAr6Lcepylj8UCMtwfrw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1nhdX10AUA-00WZs0; Thu, 24
 Feb 2022 17:45:57 +0100
Date:   Thu, 24 Feb 2022 17:45:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 27/30] fsmonitor--daemon: use a cookie file to sync
 with file system
In-Reply-To: <f47a763dc260c57c6f411cde7b4b8826732a8c7a.1644612979.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202241742500.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <f47a763dc260c57c6f411cde7b4b8826732a8c7a.1644612979.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ozms37UOfs0wno2iF54cUWqzar1DDR17+YbYX0hI2IjiOHVP8Wc
 ISDJpi2JXsrQnZ2lWMRJe52U+bSj5D6MwxAfkHiHvKdLcIoZinupxuX69oc7JRIV6vXvFZ3
 TRkS/X2y09gge0r0rl7ydZ3Qew1NKRhF58ucY1D4ljNnnPnAdYaRbXRQ7Z/hH5aaFIycH2B
 TDs7/oT6zKZvl9pss/VWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bncNJwAssWk=:Yrc489FfHbucW910wYc03U
 e1q3wcEv8+KiHionPWEk0eb7VrPA0JHsQHIrVgGfzHD9snqcAxl5zJfnPSdhmotvIswh83BpL
 xXu2xQGrhZ0PADhq0jBq88n3sqOZP3UKPVMo+gbrY6cUJCnZKSns6wEwm5QfhKouzXP3m14rv
 V3FV1FU94NPf6u8U9t1ITpWsmJw5RyxuBvuS6/2bDSf4L93rDiav1Wm/ZcQPbq75181SVo/Y2
 droo29QxE3uxc5gghWCN4ghEzpPbt3Su4dHUV+/8H8sGBT90ipYwOxHqEgQ1F7jAYrTkK7VcA
 fUZMTAvJApzu4XkV7FdaO7+9p073fXmfiPO+CNbNYcwb9zwIzuPFmANrCauxM6nAarcCAjn2J
 5GxipNUDPtLJKsE0Ca3/pDdnA+Eavt4wCS7/GS+ww9gAVh5u79GQa95sgHNHxzcDfyrGaFgGj
 KxAx1L8lM7I4D6CGzdPfrkaGekHCwqCOuJgWm6q4ac92xcQJuJa7NFh5t7St1w/RNKsRx5tls
 XCNIPaQNvHUSBLaMWU1vgqRKGtNhUdmhr1vEDAQgq/VDVnLdf7dUbz7fnl+JiZIHZdeiMmqF8
 +YBzt6Xr1fQvteEVkNXod/snoD5kER84wYitXsq1gy6vZ0Xc0N3peJn15/H/Hd4WRmjIZrY/Z
 c1hE30Qt7APDxlZ34QkQFR5+n++/2zMJAnvDscv9ebKF9/jUu5xKuFmagJuV48G3oJsLMcxjl
 9fldFy/dKcmGUOGRd4wSOnbfmFmniQt4MUrFSV29ANKBZiiVZCYvfDbHnb/09HYO0TMQyxB/x
 eKz1Pl9uaJGsamy7RfuVE+UaNw84Etk6svhxofpWnidrCl0YAkp3eKwedCb0rImlOHCuPFJsS
 Pv9U8FvyixvUXlLiRaj4Gfaa2F5End833OWRzmakoaYzCen0zVnOaC/un4FYSybpxwsUoZ/RF
 ByhMRQeAbVWxHPRGQLRU14O0Yg3qXjTFpSY0H8tKEaA1UfH/PaFacyNHbYq/H7yqI+8kxwrFl
 Hz7MvSEAoBq3GV6jTjVv/FE82TYcMmFtZVqeBi6ETxGnUPUspRDW+FgJmlu+WRbWV2GfRoK0M
 kd4fym18BHHEug=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach fsmonitor--daemon client threads to create a cookie file
> inside the .git directory and then wait until FS events for the
> cookie are observed by the FS listener thread.
>
> This helps address the racy nature of file system events by
> blocking the client response until the kernel has drained any
> event backlog.
>
> This is especially important on MacOS where kernel events are
> only issued with a limited frequency.  See the `latency` argument
> of `FSeventStreamCreate()`.  The kernel only signals every `latency`
> seconds, but does not guarantee that the kernel queue is completely
> drained, so we may have to wait more than one interval.  If we
> increase the frequency, the system is more likely to drop events.
> We avoid these issues by having each client thread create a unique
> cookie file and then wait until it is seen in the event stream.

It took a couple iterations of this cookie file business to become
robust... ;-)

About these NEEDSWORKs:

> +	/*
> +	 * Create the cookie file on disk and then wait for a notification
> +	 * that the listener thread has seen it.
> +	 */
> +	fd =3D open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
> +	if (fd >=3D 0) {
> +		close(fd);
> +		unlink(cookie_pathname.buf);
> +
> +		/*
> +		 * NEEDSWORK: This is an infinite wait (well, unless another
> +		 * thread sends us an abort).  I'd like to change this to
> +		 * use `pthread_cond_timedwait()` and return an error/timeout
> +		 * and let the caller do the trivial response thing.
> +		 */
> +		while (cookie->result =3D=3D FCIR_INIT)
> +			pthread_cond_wait(&state->cookies_cond,
> +					  &state->main_lock);

It would probably make sense to do this at some stage, but since we have
code that has seen quite a bit of real-world testing, I am in favor of
postponing this change to a later date.

> @@ -1063,6 +1284,11 @@ done:
>
>  	strbuf_release(&state.path_worktree_watch);
>  	strbuf_release(&state.path_gitdir_watch);
> +	strbuf_release(&state.path_cookie_prefix);
> +
> +	/*
> +	 * NEEDSWORK: Consider "rm -rf <gitdir>/<fsmonitor-dir>"
> +	 */
>
>  	return err;
>  }

In this instance, I think we can just drop the `NEEDSWORK`: it makes sense
to keep around these directories rather than destroying and re-creating
them over and over again.

Ciao,
Dscho
