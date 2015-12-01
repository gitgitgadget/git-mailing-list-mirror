From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] builtin/clone: support submodule groups
Date: Tue, 1 Dec 2015 07:53:05 +0100
Message-ID: <565D43D1.9030207@drmicha.warpmail.net>
References: <5656366D.4010508@web.de>
 <1448497884-2624-1-git-send-email-sbeller@google.com>
 <20151126045929.GA29107@tsaunders-iceball.corp.tor1.mozilla.com>
 <CAGZ79kbUktcGNw4C123dxGoUsi=W+h4vUPWmBm2rExipUOcXqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>,
	Trevor Saunders <tbsaunde@tbsaunde.org>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 07:53:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3eoh-0005fI-Ab
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 07:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbbLAGxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 01:53:30 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44962 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755105AbbLAGx3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2015 01:53:29 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 713DD20943
	for <git@vger.kernel.org>; Tue,  1 Dec 2015 01:53:08 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 01 Dec 2015 01:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=xsaXn3UF3ljq0idVdZXOhpRuKIk=; b=UO3Ajg
	VmQX49eOrdWu/6taGbOa5U9MNYTAGQjVU2aIiHrJ19rPZE8xS30ixx74JSXxuSA+
	IN9itUbrGXR3EoE/DGXHqfI4gg7C+yyrNzcR7WXq9YtOiL2X3qUMb+fu+DylGZFV
	rmgNel7xXUIgVjq8PhYgLkejU4KA1actg747U=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=xsaXn3UF3ljq0id
	VdZXOhpRuKIk=; b=ur/rqsdNIJNk3VL7i1cREOh0Gmk5nWf/8s6/r6nPZmQ2DrK
	tXz/co3Wgngy/iAbZAHIU/DqRBRZG65vvjZ6cyV+jBHeXYnUHwu7G6l+5RTOqX7a
	hK+66tARiF/M63Q0yDQan/udG37gpPNTzfjai/HcJM84BKrAnt8kDS1LbYTw=
X-Sasl-enc: 0uAJngtV6BvQLYX0SppCezH7DarOKJbMMekZjAZcg4QK 1448952788
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1997D6800F3;
	Tue,  1 Dec 2015 01:53:07 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kbUktcGNw4C123dxGoUsi=W+h4vUPWmBm2rExipUOcXqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281832>

Stefan Beller venit, vidit, dixit 30.11.2015 20:31:
> + cc Duy, Michael, who discussed the sparse checkout recently
> 
> On Wed, Nov 25, 2015 at 9:00 PM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
>> Seeing the recent sparse checkout discussion I realized it might be
>> useful to have a similar sort of feature for sparse checkouts.  So say I
>> had a mobile and desktop client in the same repo and wanted to be able to
>> checkout the commoncode and one client without having to explicitly list
>> all the paths I care about. It seems like UI wise you might want to use
>> --group there too, or at least explaining the difference to users might
>> be interesting, but maybe that's worrying way too much abouta possible
>> future feature.
> 
> For reference what I was proposing (coverletter [RFC PATCH 0/5]
> Submodule Groups):
> -->8--
> This is also available at
> https://github.com/stefanbeller/git/tree/submodule-groups
> It applies on top of the submodule-parallel-patch series I sent a few
> minutes ago.
> 
> Consider having a real large software project in Git with each component
> in a submodule (such as an operating system, Android, Debian, Fedora,
> no toy OS such as https://github.com/gittup/gittup as that doesn't quite
> demonstrate the scale of the problem).
> 
> If you have lots of submodules, you probably don't need all of them at once,
> but you have functional units. Some submodules are absolutely required,
> some are optional and only for very specific purposes.
> 
> This patch series adds meaning to a "groups" field in the .gitmodules file.
> 
> So you could have a .gitmodules file such as:
> 
> [submodule "gcc"]
>         path = gcc
>         url = git://...
>         groups = default,devel
> [submodule "linux"]
>         path = linux
>         url = git://...
>         groups = default
> [submodule "nethack"]
>         path = nethack
>         url = git://...
>         groups = optional,games
> 
> and by this series you can work on an arbitrary subgroup of these
> submodules such
> using these commands:
> 
>     git clone --group default --group devel git://...
>     # will clone the superproject and recursively
>     # checkout any submodule being in at least one of the groups.
> 
>     git submodule add --group default --group devel git://... ..
>     # will add a submodule, adding 2 submodule
>     # groups to its entry in .gitmodule
> 
>     # as support for clone we want to have:
>     git config submodule.groups default
>     git submodule init --groups
>     # will init all submodules from the default group
> 
>     # as support for clone we want to have:
>     git config submodule.groups default
>     git submodule update --groups
>     # will update all submodules from the default group
> 
> Any feedback welcome, specially on the design level!
> (Do we want to have it stored in the .gitmodules file? Do we want to have
> the groups configured in .git/config as "submodule.groups", any other way
> to make it future proof and extend the groups syntax?)
> -->8--
> 
> I think the biggest advantage with the groups is to have it not depending on the
> path. Consider your one repository containing both mobile and desktop code,
> where you have a sparse checkout for mobile.
> 
> Now what happens if files are renamed, i.e. the leading directory?
> As this change comes in from your dear coworker, who has no idea how
> your .git/info/sparse-checkout looks like, it may happen that more files appear
> in your worktree as your patterns did not cover the renamed case.
> Or some file contents go missing as they are in one of the ignored paths.
> 
> This groups feature would solve that as the groups are not dependent on
> the paths or the data itself. However the groups in this proposal are only
> meant to be applied on a submodule level, not in a repository itself.
> 
> How would you do that?
> I could imagine a file like .gitgroups (It should be part of the repository,
> such that everybody talks about the same groups), with a similar syntax like
> .gitattributes where some file patterns are assigned one or more groups.
> And in either .git/config (as it is for the submodules here) or in a file
> .git/info/groups (as the sparse checkouts do it in that directory)
> you'd configure the groups you are interested in.
> 
> It would be cool to have the same mechanism for both sparse-group-checkout
> and submodules, so I'd propose to use a config option in .git/config,
> such as checkout-group which covers both submodules as well as the
> pattern groups as specified by .gitgroups.
> 
> ---
> Beware, this is just a first shot spinning around some ideas.
> 
> Thanks,
> Stefan

I think we have to solve more basic issues for sparse checkouts first.
I'm using them with extra worktrees now and everything seems to be
working fine. But we need to get the UI right for the simple case (no
submodules, maybe not even extra worktrees) first: setting up patterns
before checkout etc. Having submodules in mind doesn't hurt, tough.

I still consider sparse checkouts a local "cludge" (not technically
cludgy) in the sense that it helps you cater to some specific local
needs; not something whose config you'd want to transport as part of the
object store.

Minor implementation detail: Do we have any precedence of comma
separated values for config values? I'd say we rather use multiple
entries, don't we?

Michael
