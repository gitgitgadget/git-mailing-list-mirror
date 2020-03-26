Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198F3C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 14:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48AB206F8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 14:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LnRw6oIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgCZOek (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:34:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:44985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZOek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 10:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585233272;
        bh=ycYYvIzZR7nRAXNv9ahNRjmrEWxEnAWqBa5f10Yc1WY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LnRw6oIwnMGQ8x52AwNuC1G8d8lmB60B+is8a8XLvayQabiVBEi3Is6Pd97MdPoTx
         0F7pqDy17dm31B2Jw2N6W5ycIIgFQEdtuWt+4eOZevkWccI/WvIOHPLhFYDKb6dUlP
         XOu8YMapTCEdc7m6g3gKBJlDaAAtYC5VIBCg1uIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.82]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Msq6M-1jWnY004Vs-00tCwJ; Thu, 26 Mar 2020 15:34:32 +0100
Date:   Thu, 26 Mar 2020 15:34:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] tests: do not let lazy prereqs inside `test_expect_*`
 turn off tracing
In-Reply-To: <20200326084903.GE2200716@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2003261528050.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com> <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com> <0767c8b77c820cfc03bbc617da4dc9f20ba4a46a.1585114881.git.gitgitgadget@gmail.com> <20200326084903.GE2200716@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fwJLTNZb8OsH8h78MPPaPyu7LK7Np9aOw7IDmThpEoohjha66um
 JCGvbLEzesvlBiG9FZ7RDBeYwKVH+fDhIjTdfYVBlvDPQX4D+8YRmcSD0wzzl9KQc5mHB5I
 hzAz6VEYwczPi+us9Z10kaGIc96Ho4dGY10jLOelMOIb50lBy/RkKswOLOwu3Zkry4fRkZX
 cx39JmuQqQ3pETxCF3OXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wmzECgsy1K0=:Z0z30mSddty+KJC/IWlkg2
 JLjKcdiE0FI8SPqI97zbABlrKnj7PImLV5zkub+Hsj17zKvpILqtbrD+4I/MSycQgvy6RWXji
 Zb48AhV49W8QjL7jr7mseRFNrSSYS2nAICpHVhOgECgyAFLi1Upx7vMJgyLy/5IJ94SVB8qn/
 HeHe60TQeIWTnLvoDmXqj2hbFf8UddOC3TTolrTiJEr1CFile8t936Aoj0Df228EJgR9OqaB2
 xvKF97d6ZsV9PTBqXSB6Qr0etAkNnA907sF1hs6XJq+7JChnVAvOIntwvHG/JEmSc3IGNyP6y
 SexFvfJ8B6gH78S5JG9697wK+pOB86Irx5QB8kcwfXUF/imxdnVTLUyQNBxiZ/NenM65z3atg
 7UNnOyy4sigGwHppe7l/bpIgWTJECqPK0M1cF39p2wYqa5Vo57NgKMdtxwM3JubGYTvQbK5qU
 dInakd1O86j1Ve6k0PE3eC5E25svoIESa7O8Gx4Y5RSeLg66ObjHG/UYBHnmw+OmQau4szCOd
 /hFSXti24vlCuBELlxPuRe2RTJvSDVNJotlT7YtXiND5GGWyo7ztizlLu1lPoJy+Gdrf8QNXZ
 nbWqjd1HiXaokMO44X7+txwMP3VQSy55EB9VzNH8dPLLHfr3SPjHgq4VwkcTtqHGct6MgAMIM
 xQKYDKO8+KzZNzZfxG5XmL4nDzIrhj27PTPuvi7d5TfNJH22GRoYng3/pudz8A8Td49YTk/Sy
 OYkg++6PyNr+NVIw92/W+J3t+e63MV7D9znSOJ9KbkRq6SA0jcieh5BVeQkaibtHhLRtFwMMc
 6vE5m4SVHNLc+OOcithHIcVBmisKKPq6ODEWjqQ6Dgks71j0VHj0It+0LWz6Jkeom5KCX4x8I
 +Tc4RC5eUrUo3Ty4xRQXABOhR1BlXLIKCB3Fi+it6i1Td8/ClDcjPBDxsKsKQIy7I73cOb4Tp
 xbVscAnb78EWd0GMUUQhDRfxSm6HbsxvdwYoXjAb2JH/TU3hbPhVkSs7QMDtbGlXi8Bbr1l5i
 YlD/FF9tBqqS//F6uxQG2/VMKfhDFyepETCpJNLkGn9Py0DBxf/1fdMExGgguObSkhwxe6d33
 qlMI+KJoirVVbI35M3Q7V0OBE7pi4Zc4r84ATpxnb6rQ4Rld6VLAv4pmR3S4uUdGOA3mzlzhN
 iZhS+8H1qikkk1ZPX91uEalyjXkRn3WIEtWz3YizWT07dld3rou4mwonNu/zwS4DY/1qwBMgG
 ZnIBHEAjikABaOMbn
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 26 Mar 2020, Jeff King wrote:

> On Wed, Mar 25, 2020 at 05:41:20AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `test_expect_*` functions use `test_eval_` and so does
> > `test_run_lazy_prereq_`. If tracing is enabled via the `-x` option,
> > `test_eval_` turns on tracing while evaluating the code block, and tur=
ns
> > it off directly after it.
> >
> > This is unwanted for nested invocations.
> >
> > One somewhat surprising example of this is when running a test that
> > calls `test_i18ngrep`: that function requires the `C_LOCALE_OUTPUT`
> > prereq, and that prereq is a lazy one, so it is evaluated via
> > `test_eval_`, the command tracing is turned off, and the test case
> > continues to run _without tracing the commands_.
>
> Good catch. I didn't see this when looking at the GPG stuff earlier
> because I didn't nest the lazy prereqs. But it is worth fixing
> regardless, because as you note it comes up in other places.
>
> > @@ -926,7 +927,8 @@ test_eval_ () {
> >  		test_eval_ret_=3D$?
> >  		if want_trace
> >  		then
> > -			set +x
> > +			test 1 =3D $_trace_level && set +x
> > +			_trace_level=3D$(($_trace_level-1))
> >  		fi
> >  	} 2>/dev/null 4>&2
>
> I briefly wondered if adding more logic here might upset our delicate
> balance of avoiding writing cruft to the "-x" output. But the answer is
> "no", due to the descriptor hackery at the end of that {} block.
>
> Of course, any test evaluating a lazy prereq already gets tons of cruft
> anyway, because the outer level of tracing sees all of our internal
> function calls checking the prereq and setting up the inner level of
> tracing. But there's not much we can do about that.

We could turn off the tracing specifically in those cases. At some point,
though, it strikes me as rather ridiculous through how many hoops we jump
just because our test suite framework is implemented in portable Unix
shell script, as opposed to a more powerful language such as, say, C.

For example, we could prevent the `test_eval_ret_=3D$?` line from being
traced by default, simply by redirecting fd `4` to `/dev/null`. At that
stage, we would of course have to open yet another fd to support the use
case where the `-x` is passed to `sh` itself (`sh -x t0000-*.sh -i -v`).

In the context of this here patch series, which really is about enabling
the GPG-related tests on Windows, I will refrain from going down that
particular rabbit hole. My ego might get stuck.

Ciao,
Dscho

