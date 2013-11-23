From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git issues with submodules
Date: Sat, 23 Nov 2013 21:32:45 +0100
Message-ID: <529110ED.8000501@web.de>
References: <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com> <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com> <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com> <20131122151120.GA32361@sigill.intra.peff.net> <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com> <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com> <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com> <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com> <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com> <528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Nov 23 21:32:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkJsq-0005fU-0j
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 21:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303Ab3KWUcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 15:32:48 -0500
Received: from mout.web.de ([212.227.15.14]:58859 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756311Ab3KWUcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 15:32:47 -0500
Received: from [192.168.178.41] ([91.3.173.138]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LylnX-1VYj2g4647-0164t9 for <git@vger.kernel.org>;
 Sat, 23 Nov 2013 21:32:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131122215454.GA4952@sandbox-ub>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:cJtioKpDwB2TEg1zmaGCfdlglyVj6i1HE/60Gmkne0XA18eZT2Z
 E0FOYH569pwvgHRaYLNvGtvKOjhhw/kicahTGKE3TMpksWlyQR/R5XS+RlaeDtLoJ2+fzS6
 bOUpanEnoOksZ5Rwft6kdreuPMoj/fvl9eE2Nnr7/SuLk5todnL/QNxfTX68ybq7q+D0L47
 nBczNrgQXI/V7YzoJdx6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238245>

Am 22.11.2013 22:54, schrieb Heiko Voigt:
> What I think needs fixing here first is that the ignore setting should not
> apply to any diffs between HEAD and index. IMO, it should only apply
> to the diff between worktree and index.

Not only that. It should also apply to diffs between commits/trees
and work tree but not between commits/trees. The reason the ignore
setting was added three years ago was to avoid expensive work tree
operations when it was clear that either the information wasn't
wanted or it took too much time to determine that. And I doubt you
want to see modifications to submodules in your work tree when
diffing against HEAD but not when diffing against the index.

And this behavior happens to be just what the floating branch model
needs too. I'm not sure there isn't a use case out there that also
needs to silence diff & friends regarding submodule changes between
commits/trees and/or index too (even though I cannot come up with
one at the moment). So I propose to add "worktree" as another value
for the ignore option - which ignores submodule modifications in
the work tree - and leave "all" as it is.
