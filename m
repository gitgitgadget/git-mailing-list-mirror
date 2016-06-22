Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0085D20189
	for <e@80x24.org>; Wed, 22 Jun 2016 15:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbcFVPSP (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:18:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:52280 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbcFVPSM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:18:12 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MIu7d-1bDo6e1hxR-002YZv; Wed, 22 Jun 2016 17:17:57
 +0200
Date:	Wed, 22 Jun 2016 17:17:56 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 2/9] Disallow diffopt.close_file when using the log_tree
 machinery
In-Reply-To: <xmqqa8iepcbx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606221716180.10382@virtualbox>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de> <973f9f676225aa98377f607ced1ff474f39b863f.1466505222.git.johannes.schindelin@gmx.de> <xmqqfus6quii.fsf@gitster.mtv.corp.google.com>
 <xmqqlh1ypdk8.fsf@gitster.mtv.corp.google.com> <xmqqa8iepcbx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RZEvPdMVKMHeAGAAgWQTfN6kGn/ROzsT2yO1xP9l7y53nQNSfdL
 m/fn2nqJNQBIjBKNpca1yly5qfabA7Mg15W7q2xOZhGmRCHymXnr+YtDl3Pi/W2YR5uDM1n
 YeRENeai/qPSHkKsxn4FDgymMZCi1+kTbb/fyeVNOs3Al+ATPd0eszRHs5/78tJ/e+Vd24z
 z8LTPHHUccsbzTiURccrA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:efNNz6BkgDE=:Vq3qOASaOfi9qA5vNoF8Uh
 jw7RcS0pYlCX+dqBjps9K3kF04qnUwQ4w9ZLkOaMjTNT3dUsRfI5Fj0xdvR8w2uc3ATbvpk59
 7Ur8syUpY3Q1ify4USCYkvSIdrtyMqQli5/aFeho1tXX2cSPzle1H7R3S47/8o70EkhfTFhUK
 7rGEKnTV5J0PkEbIdi+zaii8SRy8YjgAGVdLEoF7PWaesa5o6RLnffxGeJLqRtUfhy51F0o8L
 XYOQAWi64Z57ufjSB8ATIIuzcvrtcoTI0pBwAF87TCUgzLZiJMKqN3JZEf628SK/yPZRca3We
 kN36n9NHPXL+i0m7w/l6cWEjxP+w80YHcbv5+Z3IHC8AA9pmOdkeG7VDNLqVuuBhJx1g02Zs2
 2BPtjL1uNx9qb5ydURHbmOJRwlNF5tMQJ2nIggUySAtyhKhG5iycCqoty68sgoQShQ3+WTb09
 rj2fkTPwKh0BQEjTF6ZnsYtrtMhq64nkin8Hegec9687H2iS3o5rrpKOaIKQaX7IUi4md1LPk
 8VRfimr+6Pc3569QnmMyN2YoY4TNgOK8o3mmn0EzAc8VM90J5qYzD4sqiE+RYs45u+/wBu7Q7
 WfdAyHgViwHmCA0BgWO49PlQ1YcKuYyZZRsWHML2sdJnEHgYgTunAewVebHIgqebWN/40gmp5
 7uRlXUVYaGKJMTkmclgEotM+S2JcsEgiGCbT8CXtm0kuob2KuyJUm170NUw3uW4VuANmjwPZ3
 QKQAQHsJCFT1LceIwRXWf0zjALxaDdtE1sMR5JDDqKlg6tMIJjDHPTqRMOpNfVruu5lT51Feb
 lO0TMFg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 21 Jun 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >>
> >>> We are about to teach the log_tree machinery to reuse the diffopt.file
> >>> setting to output to a file stream different from stdout.
> >>>
> >>> This means that builtin am can no longer ask the diff machinery to
> >>> close the file when actually calling the log_tree machinery (which
> >>> wants to flush the very same file stream that would then already be
> >>> closed).
> >>
> >> Sorry for being slow, but I am not sure why the first paragraph has
> >> to mean the second paragraph.  This existing caller opens a new
> >> stream, sets .fp to it, and expects that the log_tree_commit() to
> >> close it if told by setting .close_file to true, all of which sounds
> >> sensible.
> >>
> >> If a codepath wants to use the same stream for two or more calls to
> >> log_tree by pointing the stream with .fp, it would be of course a
> >> problem for the caller to set .close_file to true in its first call,
> >> as .fp will be closed and no longer usable for second and subsequent
> >> call, and that would be a bug, but for a single-shot call it feels
> >> entirely a sensible request to make, no?
> >>
> >> Obviously you have looked at the codepaths involved a lot longer
> >> than I did, and I do not doubt your conclusion, but I cannot quite
> >> convince myself with the above explanation.
> >>
> >> The option parser of "git diff" family sets ->close_file to true
> >> when the --output option is given.
> >>
> >> Wouldn't this patch break "git log --output=foo -3"?
> >
> > I wonder if the right approach is to stop using .close_file
> > everywhere.
> >
> > With this "do not set .close_file if you use log_tree_commit()",
> > "git log --output=/dev/stdout -3" gets broken, but removing that
> > check is not sufficient to correct the same command with "-p", as
> > letting .close_file to close the output file after finishing a
> > single diff would mean that subsequent write to the same file
> > descriptor will trigger a failure.
> 
> We could say "git log --output=foo -3 [-p]" without any of your
> patches is already broken, and it is a valid excuse to take this
> change that we are not making things worse with it.
> 
> It is just 3/9 is a logical first step to correct that exact
> problem, i.e. some codepaths, even though there is a place that
> holds the output stream and command line parser does prepare one for
> "foo" when --output=foo is given, ignore it and send thigns to the
> standard output stream.  You might not have written 3/9 in order to
> fix that "git log --output=foo" problem, but a fix for it should
> look exactly like your 3/9, I would think.
> 
> And it is sad that this step makes that fix impossible.

Okay, I ended up seeing that there is no way I can avoid Doing The Right
Thing.

It is not quite as pretty as I hoped it would be (callers of
log_tree_commit() that want to call it in a loop still have to override
close_file manually), but it does produce a nicer story.

Please see the fixes in the latest iteration I just sent out.

Ciao,
Dscho
