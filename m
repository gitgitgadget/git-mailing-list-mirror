From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Composing git repositories
Date: Thu, 28 Mar 2013 21:25:09 +0100
Message-ID: <5154A725.7030609@web.de>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com> <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com> <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com> <20130327192630.GF28148@google.com> <7vppyklhot.fsf@alter.siamese.dyndns.org> <CALkWK0=GcxBh9o+sF1Q8t6SC0JU=NmPyRg6tqaOKmkJ6qDvRCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 21:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULJOW-0001Ok-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 21:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab3C1UZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 16:25:25 -0400
Received: from mout.web.de ([212.227.17.11]:51249 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600Ab3C1UZY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 16:25:24 -0400
Received: from [192.168.178.41] ([91.3.172.174]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MNLRJ-1UJPZs1ipN-007bKy; Thu, 28 Mar 2013 21:25:10
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0=GcxBh9o+sF1Q8t6SC0JU=NmPyRg6tqaOKmkJ6qDvRCA@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:W6WZoX1lnQuMGwToyD1CvjP6wRIShaj2l4cHKn3e5Hm
 w2eAAt/hMZ5qqDh+g+H5rdmp2zBuceyTeMZIjT8pdf0v3W1oFT
 u4VWgRFYL/sWhBxAV6yJg0eiAaHaoQTIqTQkHKIeE9jmDDwhnv
 wa016O0PmistMEVDKNgPQ8I1/dwhocQbhqteGTjQendK17uyRq
 J8an73IzTcNdwsIyXKLgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219457>

Am 28.03.2013 12:48, schrieb Ramkumar Ramachandra:
> Okay, here's a first draft of the new design.  The new mediator object
> should look like:
> 
>     name = git
>     ref = v1.7.8
> 
> The name is looked up in refs/modules/<branch>, which in turn looks like:
> 
>     [submodule "git"]
>         origin = gh:artagnon/git
>         path = git
>     [submodule "magit"]
>         origin = gh:magit/magit
>         path = git/extensions/magit

What happens when you rename "magit" to "foo" in that branch and want
to check out an older commit of the same branch? That is one of the
reasons why that belongs in to a checked in .gitmodules and not
someplace untracked.

> This solves the two problems that I brought up earlier:
> - Floating submodules (which are _necessary_ if you don't want to
> propagate commits upwards to the root).

If you don't want that either don't use submodules or set the ignore
config so you won't be bothered with any changes to the submodules.
Floating up to the submodule's tip can be easily achieved with a
script (possibly checked in in the superproject). You loose the
reproducibility by doing that, but that's what you asked for. No
problem here.

> - Initializing a nested submodule without having to initialize all the
> submodules in the path leading up to it.

You cannot access a nested sub-submodule without its parent telling
you what submodules it has. Otherwise the first level submodule would
not be self-contained, so you'll need to check it out too to access
the sub-submodules. Nothing to fix here either.

> However, I suspect that we can put more information the mediator
> object to make life easier for the parent repository and make seams
> disappear.  I'm currently thinking about what information git core
> needs to behave smoothly with submodules.

To me your proposal is trying to fix non-issues and breaking stuff
that works, so I see no improvement.
