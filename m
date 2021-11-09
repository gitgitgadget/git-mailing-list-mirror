Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB0BC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D46261208
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 16:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhKIQIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:08:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:49671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236857AbhKIQH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 11:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636473901;
        bh=B7JiLsY1hChLHRHtcw1MLsbN9rVFRSRsllhDREE4E1w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BdMmt9zUPMn3oDn1bMpZga5yOn4YBqJZdDeoSfCJ9cq+tv7/CUgw/+mV1TIQy2tcp
         LGZt1Gwf2KojYp7XtgGdrTS1oXLVZ4BIK0IEQx0xTwpp6K3Ma8Cu3+VPrDO4wLPHpu
         mG/LSo9IVzdGeUMCx24G8TSAtvAj1UZaHWqo1VSE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.201.164] ([89.1.212.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGi9-1nAhrj3cep-00RF6J; Tue, 09
 Nov 2021 17:05:01 +0100
Date:   Tue, 9 Nov 2021 17:04:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Anders Kaseorg <andersk@mit.edu>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v3 2/2] receive-pack: Protect current branch for bare
 repository worktree
In-Reply-To: <xmqqpmra40p6.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111091638110.54@tvgsbejvaqbjf.bet>
References: <alpine.DEB.2.21.999.2111081515380.100671@scrubbing-bubbles.mit.edu> <xmqqzgqe448a.fsf@gitster.g> <xmqqpmra40p6.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uo+IKFGrMO4IoM2MtgvWiWEQw7eY0dHenKisQUU6oCCCxf7l/C/
 7AjtrHuYoR8cxRWKvO9j8U0hTBDM3V8S4ytEnYT2u/dGG+Jn6Rv+nRlljBNnBCNmtG7Qgfv
 KQP+T5WjPcgDuY2/hVlFPF+ceFh/dTwE54NYE9j8JkVrdZRa5i76/TwP74DiDDqRWcyjOvF
 PqMt5TL+Yhroe2h2RPfRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UykUiI6dSB8=:TR1CdCl6qYIRj8222vgwpD
 5nERq+9pHLXfcD2v8bKbTWoI4Q5JgAqvWlbCVr8n+IjLgybVtXHiq/I6Cn5mw1Gud2DGaPDny
 luzdM/DzPo87jKSh5d+XcRWKJsqlaJ7Ra4VPzejEqxxI5U6LkKsjoNdDTA+8AO+kUwA1jTTMC
 GFK53yFp10DnSb3N6aY93+7Xj+G5XszVPAvXh/qu4Or2d2/+u45HxxK36XpphaHxDS2g0LCSq
 ShjTb9AMR0nyY3l3MiPypVflCWPIjaiAJ9tv4LCdTUrA55Ll4XuhM5zwDgZhw1MDta/+hKF3/
 GWtJyl3kdVl8yWsv276EmGeKAmFFh6G3ikYjWWN/O9jGHY2XFkPEA3jQBik9Tdl/jn2/yZwhy
 ygZ0L9zZ8Ui2K75QRymCcW2ZHi8s1PJGWlQF0cJcYqGY9OMWkI6oLtOMQRvPJfvAOxVAgGHkE
 ml97fl0VJV3b1QxxcS5BS7CNEWLF91xasl/vg0nHfQRtXj15ynh6zN6MKrehe+PNoT0Xy5GTD
 Q5R2Ekhi/6+7GQmD6qhedYOsyvH4lQW+Z2B77S0QgsmPo7hmY3EOL9H3+K2EVMWOvKn/fEKX7
 lk7/Tkl1b6puqsTip3g3mGhBB6qBcTfe64fztoRtqwPFqrBdGl2QKcWSf0rII4I09QVjNK7J9
 ZwGW3SNi9QGseCT3lAc+oEMymnyyX2Tz+u7qrHrdmU8lCLmj8B8/1h+U3k2fXbvOsM/yusfCU
 G5TKTABqZMTBHUIHp6lvc3YvcIF7OqxCL4SOC8lQvEgi3NEfqmtSpnNfXkwCcaqc9xbQ9ewzf
 Mj1v7X1TciKfw2w9sBCCOq/x0tc9ezo8po3Dul3zHHZ2nVDpNjn7oEnSeooBFanDHFXG4kNsy
 L32RsOyPI4uhwpOTnXlNd9Ol0fmTdZ1N4xJQHcuHykHGwNaaRD1L18IhZDFSiKbAROMmhFBbw
 eAVdHaPZ9E1azQppH9bDIyqdGJ9e5jzo6JzSe6qMgGvV91sTYFNOnadHuTwniPK6Ic+eV7nlP
 +Aru45W98Eq0iNAoCA8ga92awekij4ifjiCISISUNyhI45M/gFdCDDuETerzf47yzt+tNci1C
 XUhSCzWMPOJCeo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 8 Nov 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >> @@ -1456,11 +1456,11 @@ static const char *update_worktree(unsigned c=
har *sha1, const struct worktree *w
> >>  		work_tree =3D worktree->path;
> >>  	else if (git_work_tree_cfg)
> >>  		work_tree =3D git_work_tree_cfg;
> >
> > Not a fault of this patch at all, but I am not sure if this existing
> > bit of code is correct.  Everything else in this function works by
> > assuming that the worktree that comes from the caller was checked
> > with find_shared_symref("HEAD", name) to ensure that, if not NULL,
> > it has the branch checked out and updating to the new commit given
> > as the other parameter makes sense.
> >
> > But this "fall back to configured worktree" is taken when the gave
> > us NULL worktree or worktree without the .path member (i.e. no
> > checkout), and it must have come from a NULL return from the call to
> > find_shared_symref().  IOW, the function said "no worktree
> > associated with the repository checks out that branch being
> > updated."  I doubt it is a bug to update the working tree of the
> > repository with the commit pushed to some branch that is *not* HEAD,
> > only because core.worktree was set to point at an explicit location.
>
> Not "I doubt", but I suspect it is a bug.  Sorry.
>
> But in practice, especially with the new code structure, we'd never
> flip do_update_worktree on unless find_shared_symref() says that the
> ref we are updating in the function is what is checked out, which
> means worktree is always non-NULL when we call update_worktree().
>
> So, unless there is some situation where worktree->path is NULL for
> a worktree with a checkout, the "else if" above is a dead code, I
> think.
>
> Similarly, I suspect that is_bare_repository() call the patch moved
> into the if/else if/ chain is even reachable with the updated
> caller.  find_shared_symref() is always called, and unless it gives
> a non-NULL worktree, do_update_worktree never becomes true.
>
> Anyway, enough bug finding in the existing code.  I think the
> update-instead was Dscho's invention and when the codepath was
> updated to be worktree ready, Dscho helped Hariom to do so, so
> I'll CC Dscho to see if he has input.

It's such a blast from the past! I first worked on this in 1404bcbb6b3
(receive-pack: add another option for receive.denyCurrentBranch,
2014-11-26), and Hariom & I worked on this last year, before the pandemic
hit over here (and therefore it feels like a decade ago).

The `worktree` variable was introduced in 4ef346482d6
(receive.denyCurrentBranch: respect all worktrees, 2020-02-23), and since
the patch under discussion does away with the `is_bare_repository()` call,
I think that we now can safely change these lines:

        if (do_update_worktree) {
                ret =3D update_worktree(new_oid->hash, find_shared_symref(=
"HEAD", name));
                if (ret)
                        return ret;
        }

to pass `worktree` directly to the `update_worktree()` function, rather
than calling `find_shared_symref()` again.

And since that is the case, I think your analysis is correct, we always
call `update_worktree()` with a `worktree` parameter that is non-`NULL`.

As to the riddle about why we check `git_work_tree_cfg` at all? Back when
I introduced support for `denyCurrentBranch =3D updateInstead`, there were
no worktrees, the only way to give a bare repository a worktree was via
that config.

And from how I read the code in `worktree`, both "main" and "linked"
worktrees do have a `path` attribute that is non-`NULL`. We therefore
really have to look at the `is_bare` attribute to know whether
`worktree->path` _actually_ refers to a worktree. But as you also pointed
out, `find_shared_symref()` skips any worktree with non-zero `is_bare`.

We also can be pretty certain that only the `if (worktree &&
worktree->path)` arm is hit, we should probably turn the code into:

	if (!worktree || (!worktree->path && !worktree->is_bare))
                BUG("update_worktree() called without a path");

	if (worktree->is_bare)
		return "denyCurrentBranch =3D updateInstead needs a worktree";

	work_tree =3D worktree->path;

Ciao,
Dscho
