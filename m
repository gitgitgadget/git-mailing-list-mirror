Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A693A1FAFD
	for <e@80x24.org>; Sat,  4 Feb 2017 07:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753834AbdBDHPK (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 02:15:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:52739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753718AbdBDHPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 02:15:09 -0500
Received: from virtualbox ([217.136.241.150]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5GD-1cBX1P0Pof-00kdtm; Sat, 04
 Feb 2017 08:14:50 +0100
Date:   Sat, 4 Feb 2017 01:35:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] commit: Optimize number of lstat() calls
In-Reply-To: <xmqqwpd678lx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702040129430.3496@virtualbox>
References: <DA0A42D68346B1469147552440A645039A9C9988@ORSMSX115.amr.corp.intel.com> <xmqqwpd678lx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5AlWW3dhgJnY1mpXdLxbwmE8LhjQn9/f2lobOGZpslJ8kodxYo+
 MZXj7liZJcq1yo0oScWHDEjDTHEzVSY3ckprpiv7KgiecPWPT/TR19epqhPAXgElMRkxma/
 FLXVro1DtNqJvvA7cWNnBewfbYwBdXKByw8m53MoSh+1S9O2u9yMM8m8Jih6fbJ/2YuWAsp
 tsQe3K5v/fRoRhrxy3Shw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yOtYi0w/QrA=:HMu0mPYcOaQNBRNcu3aawi
 YBD2GvAMqa6jnRlmTQa+ww+rkUC1z7zSoh+zTuMiy6T71iF6OW7VSBirX6E18iA5cMKhF43Rj
 HMUp8Hc0uvK4NcMkDIACnhhxfrFop/s5kRqkZsvo1B04iwnBOMz5SzWeRAc7/pifWXHPZKJAQ
 C8Rno/WHxtClyQEypCMvdWbhN2N7b/pv3HJS+lJgmknnaoDN7q+8Xobm3cdn/A0NPI0FGfibo
 0+49l5blziXEtI520TrYKEpTd6sNolB2GNQX+ZE9VXCfBMAyXS0hJmPdOMbvIETnVtqGpcNF2
 AHbSImrl0vaBXLl1Y4Rtbs+30qPs6NbsO98J2qfgURu0+CCVl9BLzWPf7F7npIc4Z7uVIOTjt
 KVFjh77oOm9GKXHwbfcnUaoRs2WIf7QKg6ifYuTfGeYFwGcVdcM4suzqYRJgL/5KM8OaBuN1c
 9eaqOc3dXuv1NmyqzO8bXZLISHPw5LWc6SPMT0awsFhoLQg5StFyHukgbt8RCSQiluWYHGKFb
 ag0Idcv+V2tPK9jLlLxt4eGAgZv40rIzu5nY05DOvcMgabFLyfBNa1PySJv6lzVNBGW8URBJE
 EIi4rFyEEb1ELbECpWNHXSvpBCN7dW15GdqYT525pR3/X/Woj14FHbx/NWOAxicN4ggoeXD6Q
 gDFGahB8c+EaVqLq1k3uXWn0896/EYgNCY7oUE4uVVO5sDAWGaxUM08ZJFZSRUjwIxOnTOIyI
 8c4OPxWLaxIocWhw1sLj6gJvU6OUby7j3gPRUtThOG9/D2iuuGniK9XWn9oQqwpedqNHQksRX
 a9MvVi/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 3 Feb 2017, Junio C Hamano wrote:

> Aside from whitespace breakage, I think we should never skip the
> refreshing of the real index that is left after "git commit"
> finishes.
> 
> Between these two calls to refresh_cache(), the one that writes out
> a temporary index that contains the contents of HEAD plus the
> contents of the working tree for the specified paths may be fine
> without refreshing, unless somebody else (like the pre-commit hook)
> looks at it.  But the other one refreshes the real index file that
> will be used after "git commit" returns the control.  Users and
> scripts that run "git commit" inside expect that the entries in the
> resulting index are refreshed after "git commit" returns, and I do
> not think of a safe way to optimizing it out; unlike the other one,
> to which we can say "as long as there is no pre-commit hook, nobody
> will look at it after we are done", there does not an easy-to-check
> set of conditions that we can use to decide when it is safe to skip
> refreshing.
> 
> Besides, leaving the main index not refreshed would mean the user
> has to pay the refreshing cost when s/he runs other commands "git
> diff", "git status", etc. after "git commit" for the first time;
> so...

I am not sure... when you run `git diff` and `git status`, the index is
refreshed *anyway*, so with the patch under discussion we would save one
round of lstat() calls, for the same effect.

I could imagine that there is a third option we should consider, too: only
lstat() and update the paths that match the pathspec(s) provided on the
command line (this is the semantic meaning of the --only option, after
all: "I am only interested in these paths as far as this commit is
concerned"). What do you think?

Ciao,
Johannes
