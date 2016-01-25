From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 13/19] mingw: outsmart MSYS2's path substitution in
 t1508
Date: Mon, 25 Jan 2016 17:30:37 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601251727370.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <1a4477f951edc9f58a24163d3935a7b35a3f14b2.1453650173.git.johannes.schindelin@gmx.de> <xmqqa8nubekj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Thomas Braun <thomas.braun@byte-physics.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 17:31:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNk2c-0001LW-8F
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 17:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbcAYQaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 11:30:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:54752 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889AbcAYQax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 11:30:53 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MS5QA-1aY9N147II-00TGNd; Mon, 25 Jan 2016 17:30:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqa8nubekj.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:My1vXPifq6jIrAuQVePl7I/Wm1gLGQr+oWKIaRLvos6BZMYZPNL
 w+SjC9A3BNN+pXLqIDWw4wFzwPANny9PERBiOxaRmkoRjH8KRYSjVrw09kApAPjJMTV7r0q
 YlK1npdTv9k0BqALHQJ5egY9VL4TFQ8Mtx2kCu1JhaAJx/bMtUveVLqTJ+r/LB6LMWlfwDw
 xFQnls78/6K+lsSdwxzjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6B7WxdmeKdw=:qX79TcqY5pEMebt3CEqf4J
 QAf21nzo5ArH2s5YMaw1nDAQtIsMjNs9/rH3/qnOiuLlgt4KgcJBcaUi/YLkUh1ZihT151GWq
 0AR3SthcTtqJvGymN+vYrx1hwrSarGY3sMRIn2Nq4AEb+JTDF58QzC6bRJLEGYujfdwClxxFc
 S1j4Z4/oJQ8jBMwhMqfeqQLJfuqeYVyN7QkIlfoVutQuQEpQZosBvsIth6BF7HiHg68x43feJ
 hc1wTjovM43XdkFP0/1k8g0KuA2uwZFxq3m53ph0leI38UnN5TXAaeUp3vre5hYUSaiCczHFo
 hANrHYzHvIr6txerSvr919UNupAhWi/poqxxYSyCuN6tJOhyyMRbXMkKWcQxfRsKir8F09QQa
 8omWu2ENwdPUWeBtGxRMByD+/MujGQehrR1rzVW+l9XCpd2cWpDXU0BuYLNu9t8cuJyIcAOba
 j2Jn9b6U46w3OCa1XT5C6AIq7JpIyfajRPQsOYh5UXgomjMPwYM+7QCzEwNYDusqtm2SljY/U
 jDJkrMIgiHTFiMX8c7T9zVisyQAh+SkXCgCrXTu8ssjzW/UEE58RKS9wu70qE8BcNWs/kSAmb
 8XpnSigHFWpNCVkZvqOsHf7nI7Zx1VpTRfrA5ESGl/o2Z/Ccsw9/BFCl0HKKV/Y1iFyImMtQL
 M2fuPvAu1TZu1989Ulbne3wUavPk5tfQ19DzLmtkzciIpXVxbQU8lzAGRacvoovGscwSDEOSW
 O1SWXn9kxZhDfk+NUwLUUKJyAk4qNgPUNWkNrraCR30yZjuD0J4sDM5q3iip8wm0CLG5amOe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284738>

Hi Junio,

On Sun, 24 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > From: Thomas Braun <thomas.braun@byte-physics.de>
> >
> > A string of the form "@/abcd" is considered a file path
> > by the msys layer and therefore translated to a Windows path.
> >
> > Here the trick is to double the slashes.
> >
> > The MSYS2 patch translation can be studied by calling
> >
> > 	test-path-utils print_path <path>
> >
> > Signed-off-by: Thomas Braun <thomas.braun@byte-physics.de>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> This feels wrong.
> 
> The point of this test is that you can ask to checkout a branch
> whose name is a strangely looking "@/at-test", and a ref whose name
> is "refs/heads/@/at-test" indeed is created.
> 
> The current "checkout" may be lazy and not signal an error for a
> branch name with two consecutive slashes, but I wouldn't be
> surprised if we tighten that later, and more importantly, I do not
> think we ever promised users if you asked a branch "a//b" to be
> created, we would create "refs/heads/a/b".
> 
> The new test hardcodes and promises such an incompatible behaviour,
> i.e. a request to create "@//b" results in "@/b" created, only to
> users on MINGW, fracturing the expectations of the Git userbase.
> 
> Wouldn't it be better to declare "On other people's Git, @/foo is
> just as normal a branch name as a/foo, but on MINGW @/foo cannot be
> used" by skipping some tests using prerequisites instead?

As Eric points out, this is not so much a behavior on Git as of the MSYS2
Bash. In fact, if you call `git.exe checkout -b @/at-test` from a cmd
window, it works just as advertised.

But your comment made me inspect the entire t9100 again, wondering why
things work when we copy the contents instead of symlinking them. And you
know what, even if I could have sworn that I verified for every patch in
this series that it is actually necessary to pass the test suite, it is
*not* necessary.

So I backed it out and it won't be part of v2 anymore.

Ciao,
Dscho
