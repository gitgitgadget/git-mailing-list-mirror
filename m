Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD6BC4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE61220872
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dK5D8OMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgJGVup (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:50:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:34437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbgJGVuo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 17:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602107441;
        bh=c4DjqpynEKiHtfvtGF6tPFWyEaR5n6rrEtvYCQtBOWE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dK5D8OMWHSgYHXT55UZTGVLPcu3ivZL9LMdXA9tAQIY+v32uOxusWiQaWr1VypyRf
         6yuq/ojY41mJRS2Rh3OlJuCLAUALqoKcWhYv+qZSQVrGuDB/xGsfL3cVo/bSNVi6CY
         miGmTTJu+NfFNWdOlt/mH5DPiswOAtNi2XKV3nmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1kdObX0l0N-00wEPX; Wed, 07
 Oct 2020 23:50:36 +0200
Date:   Wed, 7 Oct 2020 23:49:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] help: do not expect built-in commands to be hardlinked
In-Reply-To: <xmqqh7r62ah2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010072349280.50@tvgsbejvaqbjf.bet>
References: <pull.745.git.1602074589460.gitgitgadget@gmail.com> <xmqqpn5u2bps.fsf@gitster.c.googlers.com> <xmqqh7r62ah2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GOdOEtOdZDkOaPoob4ihtn3bE86mA1OsN+AXtp5+YOimxtD/6H2
 tLPaKQDgEMbQyApoZG60dzUIzgpGqxs7/U75VnVn3Bjg3ucTjgfkevNY0QrcPYs4Vl15gfQ
 wqJCCAuYrpHpWiSC2TSmehYU5RiDywXxpCaP/asrfSeqN2C5MGN5W+BD6stUhLxOODlqm6F
 FIQ2WaXz9pZRW1MEHZMIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bvjF+P2xM0E=:X2yfMonOrUn+PkSlQy5hPc
 nRfSnpdnW97Kuss158RsWGK8aNJxDQ16EGBS/mK4GOvPzqN2zWs22bMJaCZ85PI8L//pNHM9U
 YzqaOvS93CzOBecZvw7TSYTfF70HylBgsER3pMrRXmlrV4QO4XqCBkziiZ+moUSpOVw4v3vnZ
 kNRltyAJiamr8DT5YYHNH63f1sisuckieOuvUNiBqv3xEr24KtWCksgFmjllrHqZykGbLmkPE
 DMqJzwRJ63z7N13LqYJwaM/ubq1tbdvDFvrMgk4PwDIgnTGfKpii+ZViGIkfvKJBTpvmT/tGP
 ZieWSEBrbB298CV2Qhlz6neoALqHT2qHd7VuZ19v0GXpuCuueSEm5+GXXpDy71pKXMak76bof
 NzZwSgETOhwjIfrhjIALMLesDHUu+B7BftXEl9uKo+psLTpNuTAD4rFarbTOKIVSs3sdAQ7vV
 roI4su1zZcR4zGYyf4EeMHnEL1Zj7/OR19LKDPR9ANurQbZWvrtpEQNBT0ADwUwQ1q+LwKG82
 77amVNm0PdfryQ2mC4JQVHgjDiuIsv+cov91xMzDPK0VR2QIEcOXI/M7Gv+JJJC+QPskDqn0+
 enEJCGpQihqK4JOi17RCEhE0jNKxb8RP+JVfDFANaHZS+E0pjjX3iIOGmxDOUcdRHKterzmVo
 Dr4JhGumCwrNChzcL0n9LSp3qDz9T/NpUJSPndFbYw2zG/H/sbWWKC+saeysAbJaTmbD9hOLa
 89nuourovAGXz2R44BwtMclgGwaQkmgTL1YpcApraYO7HaRkyoQ/ysbOlxdfAQzLIDlNFzWI+
 m0W598ydL5w73qO6I24uMCfm/ysZOwZ4A6/T77cQts4jkcT8AhWzekDiyFQCVu7/35xLXYD0K
 5YPsRXe+F/R98KACtoMXEBkkqzKsmLmbd86yO1IU/3OiUZbf1hkZscMzFYrbwl7TqNdhMGcBj
 Qo9X77wP0+NQZ8MEZQCvhSwcXyV4/p8jIeQXHnFRCDgae89SmNmY6wRj8CpJOiVIp8sGTcMnf
 1xamIyg+1wRt69valcjb0/1hDj00LqyvnRBIKPFmynGnFRnNlFe4i80yRuZWkmXuj+v0suyHB
 +YsDf/Ab+yk+xJi6o/AnHtDfdFB25gUJApv2iihDk9aQAZyoMbiRAE4eXUahfUX/3NVSP8oJw
 2Gx6BwBhJq9lnXiP3dJ+HH2Rl9KoJG/iRGo97xJVU718ILE7QrFLYR3rc9W4LZNZVxGllJGMf
 h1j9uIrqLNAqL/VnlCm5DlZFnUG+yU3FSBSh+2A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 7 Oct 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > ... in the new world order, what we see on disk plus what
> > we have in the built-in table are the set of subcommands available
> > to us, and the rule that was valid in the old world order can no
> > longer be relied upon, and nobody noticed  the breakage while
> > developing or reviewing.
>
> >> diff --git a/help.c b/help.c
> >> index 4e2468a44d..919cbb9206 100644
> >> --- a/help.c
> >> +++ b/help.c
> >> @@ -263,6 +263,8 @@ void load_command_list(const char *prefix,
> >>  	const char *env_path =3D getenv("PATH");
> >>  	const char *exec_path =3D git_exec_path();
> >>
> >> +	load_builtin_commands(prefix, main_cmds);
> >> +
> >>  	if (exec_path) {
> >>  		list_commands_in_dir(main_cmds, exec_path, prefix);
> >>  		QSORT(main_cmds->names, main_cmds->cnt, cmdname_compare);
>
> I wondered if we need, after this change, to worry about duplicates,
> because some Git subcommands, even after they made into a built-in
> and callable internally, must have on-disk footprint.
>
> It turns out that after the post-context in this hunk we do make a
> call to uniq(main_cmds) so it is fine.
>
> This was unexpected to me, as we read only from a single directory
> "exec_path" and the need to call uniq() in the old world order would
> have meant that readdir in exec_path gave us duplicate entries.
>
> In fact, the very original version of load_command_list() did not
> have this unnecessary call to uniq().  It was introduced in 1f08e5ce
> (Allow git help work without PATH set, 2008-08-28); perhaps Alex saw
> 12 years into the future and predicted that we would start needing
> it ;-)
>
> In any case, the patch is good thanks to that existing uniq() call.

Yep, I was fully prepared to add that `uniq()` call and was surprised to
find it. I guess it was "for good measure" because the same commit also
added the same `qsort(); uniq()` combo another time, a little further down
in that function.

Now, what I would have expected you to say when you found the `uniq()`
function is: Johannes, why don't you call `QSORT(); uniq()` after the call
to `load_builtin_commands()`? After all, `exec_path` and `env_path` might
both be `NULL`...

Well, the answer to that question is _not_ "but without `env_path` nothing
works anyway" even if that would be pretty valid. The answer is that the
`commands[]` list in `git.c` is already sorted alphabetically.

Thanks,
Dscho

>
> >> diff --git a/help.h b/help.h
> >> index dc02458855..5871e93ba2 100644
> >> --- a/help.h
> >> +++ b/help.h
> >> @@ -32,6 +32,7 @@ const char *help_unknown_cmd(const char *cmd);
> >>  void load_command_list(const char *prefix,
> >>  		       struct cmdnames *main_cmds,
> >>  		       struct cmdnames *other_cmds);
> >> +void load_builtin_commands(const char *prefix, struct cmdnames *cmds=
);
> >>  void add_cmdname(struct cmdnames *cmds, const char *name, int len);
> >>  /* Here we require that excludes is a sorted list. */
> >>  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
> >>
> >> base-commit: 8f7759d2c8c13716bfdb9ae602414fd987787e8d
>
