Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD3320193
	for <e@80x24.org>; Sat, 29 Oct 2016 08:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965728AbcJ2IZg (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 04:25:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:56819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934337AbcJ2IZc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 04:25:32 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LmJsk-1caHvn3o7W-00Zxl7; Sat, 29 Oct 2016 10:25:06
 +0200
Date:   Sat, 29 Oct 2016 10:25:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
In-Reply-To: <xmqqr370vtba.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610291022120.3264@virtualbox>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox> <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com> <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net> <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
 <xmqqoa254czs.fsf@gitster.mtv.corp.google.com> <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com> <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com> <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com> <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com> <xmqq60od42s0.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610281306320.3264@virtualbox> <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
 <xmqqshrg1ksv.fsf@gitster.mtv.corp.google.com> <CA+55aFwUEzfvWVSZfhBi85QaKWSo-gVMOk1BJFrR0ZsdCRHRsg@mail.gmail.com> <xmqqr370vtba.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qB6w60XjbPpdzk2HqLQLHw8GhIdPM+GAc7OhZZcO+LSo94fM79c
 o9nq3vEnUMheF95SFZZLK0fExZkZ89xJ7df7UldbV6awHrK2rR9t5XRQMSLaRg7xZBDyuK3
 QKywzUCGKsa+qWh5ZQcWn0qQ6diBESbL9sApgPjJDJ3+gn5PBbmyzW4H1fLY65/6jY6GKJX
 2qDc3B4ozo8xuyw5wOX8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9JEntN6RjTA=:39koR9UHUl866SrnHqiLgw
 SwSM2Np6B37ig5VP+OpTCuXMoQxRVN8MsXFZOj8gAYTp9J14RQybMNi7tzRR586b6+MFVDqsU
 v3BCSebXDLprFYG1XMpUkGOm41g7SS1hq4FxAcCVQMPBWmLStnPzfqOVhi3JDdiSpZjPFFCEG
 ke7VcOj9YfIo0+qFyU0pLzyNWs8/n4m8RFmz+uy6Rf+P7vOBnRb7pMORpMfqWZ77WFnkDw0ci
 I/0gv89axJgWfH9f0aFkgha88wJ8J4wZ5SdUlEqEIRZ8o4fG3wcJUiX0DnRk7kO2VtbLfHIEI
 6xos5sQ7wfGQ+Dt8V41mWRzhm9kX5L9f3U42qKtPn+8jWUXwQi0pJ0p4Ns3jIVvSubY7WUyWr
 OuuNKaFk5ZSNwRyiR9zHqsgj4bJxKGg/ybHsseal7c1HNIOm1U/g4quQ5xPb87vhd4NfP4RrB
 U6g5kdFt1QiPqkdUenr1MslqkaAukd1q+LgFtmBOlfWgOO1YaokacA4XOX/WzxrhzGXDhiLDk
 50yd4nz7MeOiGhvGc77HDvWZ7q5Yadpwf+HTzlE41gn0JrL6wxhqOgwzZiU3evroAfC+fZBce
 8zzBUbnG4I/FNw6bAK+C55Tp20YxErk0ssUwzVrE0KefcThzPjc8E9C9rrga+mZLp4T7Az+f0
 uR5bgPhNg1bQrG7q/eTgxkw5qSE5mdmOUw0UcT1X7mw+Sr2IiMCpROUW2Ndhgy69fGAAIoykB
 Pj/h4mN/NSj7WFMfrn/9Ng9XTUZwa1n1t/X4xbIv61S5daaF5RSb/lSW8SJQFiOiZX4Jle0/A
 NVViJ6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 28 Oct 2016, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Apparently windows doesn't even support it, at least not mingw....
> 
> Assuming that the above was a misunderstanding, assuming that we can
> do O_CLOEXEC (but not FD_CLOEXEC) on Windows just fine, where stray
> file descriptors held open in the children matter more, and ...

Correct. We cannot change an open file handle's state ("FD_CLOEXEC") on
Windows, but we can ask open() to open said file handle with the correct
flag ("O_CLOEXEC", which is mapped to O_NOINHERIT on Windows.

And for the record: I agree with Junio that we cannot simply drop this
O_CLOEXEC business.

Because it was introduced to fix bugs.

Thank you for your time,
Johannes
