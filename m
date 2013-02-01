From: Jeff King <peff@peff.net>
Subject: Re: Re: Segmentation fault with latest git (070c57df)
Date: Fri, 1 Feb 2013 04:57:09 -0500
Message-ID: <20130201095709.GA31971@sigill.intra.peff.net>
References: <17285958.791361359710080706.JavaMail.weblogic@epml01>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jongman Heo <jongman.heo@samsung.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 10:57:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1DNQ-0007Xu-4q
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 10:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660Ab3BAJ5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 04:57:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55348 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756645Ab3BAJ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 04:57:13 -0500
Received: (qmail 27771 invoked by uid 107); 1 Feb 2013 09:58:37 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 04:58:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 04:57:09 -0500
Content-Disposition: inline
In-Reply-To: <17285958.791361359710080706.JavaMail.weblogic@epml01>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215227>

On Fri, Feb 01, 2013 at 09:14:41AM +0000, Jongman Heo wrote:

> I can reproduce the issue in my machine (RedHat Enterprise 5, x86 PAE) as follows. 

Great, thanks for taking the time to reproduce.

> But in my different machine (Fedora 16 x86) I can't reproduce.

That makes me wonder if it is related to the gcc or make version. I
couldn't reproduce the problem on my gcc-4.1 system, though. My make is:

  $ make --version
  GNU Make 3.81
  [...]

>   $ git reset --hard v1.8.1       # back to v1.8.1
>   $ make clean 
>   $ make all install               # this git works fine

After this step, what does builtin/.depend/fetch.o.d contain? It should
show a dependency of builtin/fetch.o on string-list (among other
things).

>   $ git pull                          # top commit 9a6c84e6, "Merge git://ozlabs.org/~paulus/gitk"
>   $ make all install

Can you try running "make -d builtin/fetch.o" here instead of "make all
install"? Can you confirm that it reads builtin/.depend/fetch.o, and
that fetch.o gets rebuilt (you should even be able to see the list of
"newer than" dependencies in the debug output)?

Another thing to double-check: does it work if you instead run

  make all install COMPUTE_HEADER_DEPENDENCIES=no

?

-Peff
