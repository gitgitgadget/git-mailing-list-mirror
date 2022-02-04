Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2505C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiBDXLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:11:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:33443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234597AbiBDXLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644016255;
        bh=Ul60IFM8L18WxEdMECQCkmGkGr6OlQobIoLveqrVBS8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BCMXLiFy6GVKrz0d8jjiqM4x3LAY8LXLndJcu3yQe2zl3c3nPYHMcpKF3TGdEajjL
         3tj6e+hbChpftLJTVX6n1xN4+9dUzvGUbLr/t1nNr/idn/WT5RJdDHQUI+GIcTJ9YX
         ZoT0RWGX/jcWO4D+4GA4EQSnjAmrfVg2JBHufkuc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.215.8]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1n1mF10epw-00EMAQ; Sat, 05
 Feb 2022 00:10:55 +0100
Date:   Sat, 5 Feb 2022 00:10:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
In-Reply-To: <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rkbCzoEOn1VsGyYksDvxWWFGpebJHvJr6F1Ryp9svly9pxTZ+Ae
 KZEis1Gc25ahbrxF6PeVXU1B+KcLCOU9PmVUYZLyQlltp+j5XZD44qxGXlA/DFUmC2RZDAv
 bJaizP06UM1qDi9h0bVBjS/jcfdrcp5Q7aBvfS+S30aQXHTLd4wa4voIi+CFm1Vb3KqN+dO
 c55+vsvRJ76xvsHoMQcpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aP0fGNZ/y6I=:9UMQzlrQb9SwkwGkbeSJcf
 uTdbHiwsefaw+GHzMYSl01WROt5sFWKpzsKZY101PBOqiU0Zu8oQWlH7MRX+VZlW99n94nrlm
 7apKmzd4KER/DcHgIban2kulvBwefZF+6MDD2MNkTRdXI1/3MCaZHWv45MBb0cSpMWQvqEr11
 Yaaej6eQ8rW1VQQZe+8tZhuIapkqkZueN/UX6W5xiSv8vO2cTz0VLJVph92M3hgM3RurXecVz
 zKovW7glEMLxNpD4nKn+Z6zG327Q55ha850MjiOr+GWyGNNAMNOT0ktJtovDQ7D8mlKlPmfpF
 H+bi4ejelPXkXqWCOkEFQOgtSYHrG5wAOitt6ErUg3EC+uppwCg6j1l1qIKYhA1+nzJoPdOHE
 j5DMkHVbS55d/gkyKXT4YHK1ldmf20hdO/waQkQu8/t1mQ8pCzQh3g2R+/jKlJzabe9hQs8wI
 oqS1tY7GIbz9VM0KiZ26MDvSfkBMeZ1fXDRdoXzRsG+sP0qoMgDjtRJ3WvN5Tr46f7UPlS50w
 Kk0DsP8q5GHG3LP7dGUO2TSHCnhRfJnUkDI1lpJQL02jTIetjWx5Hhkg33iq4gQrgmeaZIfK8
 l/eqVODkkrnsl4uDI1jSuEhYLxwLRrpF5PKEEdlgca74EHJQajssq3Rq0qkvxW+G6a4L7uyLL
 O67X/rakswTjtjVa6eQ6aZr8bQtDainwZ7RyJ//5FdeuMAfDv0yGckbJx1/2NSOUq0aw7EOXv
 apxVsY5sWTzdzaxXF7QUfm+O76e2wM/Z08OVcPLdGJyEqo8xtmY8B7I6w5rNRR7Ps0woQIWwm
 UZHnU4CbEOOu9q0EnAiG+Qz62FVmpmALQOUo6KlEC0pgS0N5twrdGHO0nmkYlEO+1hGLLTPhh
 Nuk8JN5po9v8giQGoY2m+TNDW8m7VFRQv+qUJ1KlPPsWI89Z3WBbXxY0bRYgXhXCy9ehpON6p
 j2eSErmA1YDgAB5A+shChtRzk5LJ0VRDEaR1Lak9qP3I+dgzJIFdXi4nL56q4Pp6Nh72NLxme
 wqd11mmvpT9PA3qdzkeenDtsCch2zWpz8h4n2PR6eUY8EeFFew9A1Jk0WxJkNIPKP7/emq4qW
 eiIsRJGvp+Yutw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 29 Jan 2022, Elijah Newren wrote:

> On Sat, Jan 29, 2022 at 12:23 AM Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > Just a heckling from the peanut gallery...
> >
> > Am 29.01.22 um 07:08 schrieb Elijah Newren:
> > > On Fri, Jan 28, 2022 at 8:55 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > >> Meaning: Even if stage 3 is missing from the first conflict and sta=
ge 1 is
> > >> missing from the second conflict, in the output we would see stages=
 1, 2,
> > >> 2, 3, i.e. a duplicate stage 2, signifying that we're talking about=
 two
> > >> different conflicts.
> > >
> > > I don't understand why you're fixating on the stage here.  Why would
> > > you want to group all the stage 2s together, count them up, and then
> > > determine there are N conflicting files because there are N stage 2'=
s?
> >
> > Looks like you are misunderstanding Dscho's point: When you have two
> > conflicts, the first with stages 1 and 2, the second with stages 2 and
> > 3, then the 2s occur lumped together when the 4 lines are printed in a
> > row, and that is the cue to the parser where the new conflict begins.
> > Dscho did not mean that all N 2s of should be listed together.
>
> Ah, so...I didn't understand his misunderstanding?  Using stages as a
> cue to the parser where the new conflict begins is broken; you should
> instead check for when the filename listed on a line does not match
> the filename on the previous line.

But that would break down in case of rename/rename conflicts, right?

> In particular, if one conflict has stages 1 and 2, and the next conflict
> has only stage 3, then looking at stages only might cause you to
> accidentally lump unrelated conflicts together.

Precisely. That's why I would love to have a way to deviate from the
output of `ls-files -u`'s format, and have a reliable way to indicate
stages that belong to the same merge conflict.

Thanks,
Dscho
