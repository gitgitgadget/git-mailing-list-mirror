From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Location-agnostic submodules
Date: Tue, 1 May 2012 18:19:38 +0100
Organization: OPDS
Message-ID: <732A8D2DB3374CD6BC12A5E7C4384313@PhilipOakley>
References: <20120427143710.GA13953@pape.arcanes.fr.eu.org> <CABURp0qA9hK1fBd3rmLG61ErpbbzrcxO=AAmFOsoxjt=ozu09Q@mail.gmail.com> <20120430220244.GL22827@pape.arcanes.fr.eu.org> <CABURp0rUKubfWXxX2ABG2E4dRTEQh4zA0bZFOeXGwv2m4b0YaA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Jens Lehmann" <Jens.Lehmann@web.de>
To: "Phil Hord" <phil.hord@gmail.com>,
	"Pierre Thierry" <pierre@nothos.net>
X-From: git-owner@vger.kernel.org Tue May 01 19:33:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGxV-0005Jh-8w
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758184Ab2EARds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:33:48 -0400
Received: from out1.ip08ir2.opaltelecom.net ([62.24.128.244]:15178 "EHLO
	out1.ip08ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757961Ab2EARdq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 13:33:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmwGACMeoE9cHlxl/2dsb2JhbABEizGibYFPgwCBCIIEAQQBAQQBCAEBLh4BASELAgMFAgEDFQECCSUUAQQIEgYHFwYBEggCAQIDAYU3B4IoCAMGCbARDYlPBIoHhh9jBIgwhUqTQ4UDgmk
X-IronPort-AV: E=Sophos;i="4.75,512,1330905600"; 
   d="scan'208";a="526475182"
Received: from host-92-30-92-101.as13285.net (HELO PhilipOakley) ([92.30.92.101])
  by out1.ip08ir2.opaltelecom.net with SMTP; 01 May 2012 18:33:37 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196709>

From: "Phil Hord" <phil.hord@gmail.com> Sent: Tuesday, May 01, 2012 4:16 PM
> Adding Jens Lehmann, in case he hasn't noticed this thread yet.
>
> On Mon, Apr 30, 2012 at 6:02 PM, Pierre Thierry <pierre@nothos.net> wrote:
>> Scribit Phil Hord dies 30/04/2012 hora 16:39:
>>> Maybe something like this:
>>> [submodule "foo"]
>>> path = foo-mod
>>> url = ../foo ../foo-alternate
>>> https://someplace.com/git/foo.git https://kernel.org/git/foo
>>
>> <rant>That is typically the kind of occasion when I wish every config
>> file were sexprs...</rant>
>
> Interesting.  But at least it's not yaml.  :-)
>
>>> But if one of them lags behind the others by a day or even an hour,
>>> then you may have gitlinks in your superproject which have not made
>>> it into the lagging mirror yet. And this will cause problems.
>>
>> I see your point, but what if your only repository is lagging behind?
>> I.e. in what way is it worse than now?
>
> I actually do not think it is very much worse than now.  But the
> specific way it fails in this case is as follows:
>
> Suppose I have mirrors A and B, each containing a superproject and its
> submodule.
>
>  A:super:master => A:sub:master
>  B:super:master => B:sub:master
>
> A and B are coherent, meaning their superproject gitlinks point to
> commits which do exist in the submodule repositories.
>
> Now, I push new commits to A:super and A:sub, giving this:
>  A:super:new' => A:sub:new
>  B:super:master => B:sub:master
>
> Now, A and B are both internally coherent, but I have a problem if I
> try to do this:
>  A:super:master' => B:sub:new
>
> This is because the sub:new commit has not made it to B yet, perhaps
> intentionally or perhaps because of latency.
>
> This problem still can occur without your change, so I do not think it
> is a fatal flaw.  It is just a scenario to consider.
>
>>> Moreover, each time you clone the repository you may get different
>>> results. This would be confusing.
>>
>> Again, I fail to see the difference with the current state. If the
>> commit is specified, you will always get the same results, now or with
>> my suggested addition.
>
> The existing implementation has some flaws, and think the multiple
> URLs option may expose the flaws further.  Again, not a fatal flaw to
> your idea; just something to keep in mind.

Would an alternative be something like:
    git submodule update <module> --from <remote>

so that the user can state which of the current submodule's remotes should 
be used for fetching the desired update.

For compatibility, the update may need to use the '--reference' or something 
similar, or perhaps a different command word
    `git submodule fetch <module> --from <remote>`

I was just stung on msysgit (submodule `git`) because its NetInstall clones 
from the main repos, but I had forked my own copies, so the submodule URLs 
weren't right for me (doh). Luckily I have a patch of my silenty overwritten 
changes...

>
> Something else to keep in mind:  What you are proposing amounts to a
> feature which identifies mirror repositories to use for submodules
> when the primary remote repo cannot be reached.  Superprojects have no
> such feature.  Why not?
>
> Meanwhile, I really like the other feature you started off with, where
> the "embedded" submodule repos could be used as the primary origin.
>
>>> I don't think there is any need for a new 'clone' command since the
>>> clone porcelain already understands submodules.
>>
>> What do you mean? When I clone a repo with submodules, they are not
>> cloned as well.
>
> Since git v1.6.5 or so, clone has known the --recursive option.
>
>  git clone --recursive superproject
>
> Since about v1.7.3, fetch and pull also know how to recurse and can do
> so by default.
>
> Phil

Philip 
