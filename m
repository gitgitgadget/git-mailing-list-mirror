From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Tue, 13 Dec 2011 10:35:44 -0500
Message-ID: <4EE770D0.5080702@xiplink.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> <4EE61EED.50604@ursus.ath.cx> <CALFF=ZRYB1LkAY5WSC4Eydu-N0KNnWLLM2CfbSXZji18yO82gw@mail.gmail.com> <4EE64B04.8080405@ursus.ath.cx> <CALFF=ZRB7qjj7VMhzr12ySdHmZsySoqceu5brFht8rX1+W3NPg@mail.gmail.com> <CABURp0rFOGQ9kAbAn65W3UAHTWbk5prH7spjJnFvL5fqzbFp1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Leif Gruenwoldt <leifer@gmail.com>,
	"Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 16:36:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaUOh-0002w5-0w
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 16:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab1LMPfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 10:35:48 -0500
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:42280 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab1LMPfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 10:35:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp42.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id BF9A0148717;
	Tue, 13 Dec 2011 10:35:46 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp42.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 400C0148803;
	Tue, 13 Dec 2011 10:35:46 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <CABURp0rFOGQ9kAbAn65W3UAHTWbk5prH7spjJnFvL5fqzbFp1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187031>

On 11-12-12 05:56 PM, Phil Hord wrote:
> On Mon, Dec 12, 2011 at 2:13 PM, Leif Gruenwoldt <leifer@gmail.com> wrote:
>> On Mon, Dec 12, 2011 at 1:42 PM, Andreas T.Auer
>> <andreas.t.auer_gtml_37453@ursus.ath.cx> wrote:
>>
>>> The next question is: Wouldn't you like to have the new stable branch only
>>> pulled in, when the projectX (as the superproject) is currently on that new
>>> development branch (maybe master)?
>>>
>>> But if you checkout that fixed released version 1.2.9.8, wouldn't it be
>>> better that in that case the gitlinked version of the submodule is checked
>>> out instead of some unrelated new version? I mean, when the gitlinks are
>>> tracked with the projectX commits, this should work well.
>>>
>>> And what about a maintenance branch, which is not a fixed version but a
>>> quite stable branch which should only have bugfixes. Shouldn't the auto-pull
>>> be disabled in that case, too?
>>>
>>> I think the "auto-pull" behavior should depend on the currently checked out
>>> branch. So the configuration options should allow the definition of one or
>>> more mappings.
>>
>> Yes. I think you nailed it. The floating behaviour would best be
>> configured per branch.
> 
> Yes, I think you nailed it too.  I've been thinking the same thing for
> a while now, but I didn't know how to express it completely.  Some of
> the discussion on here last week gelled the last bits in my mind.
> 
> To wit, I think I would want something like this in my project:
> 
> Use gitlinks when the superproject HEAD is one of these:
>     refs/heads/maint/*
>     refs/heads/svn/*     (historic branches)
>     refs/tags/*
>     <SHA1> (detached)
> 
> Float on the rest, using the branch given in .gitmodules (which may be
> * to mean "use the same branch as the superproject".)
> 
> But maybe it is foolish of me to keep branches where I really want
> lightweight tags.  If so, I could get away with this:
> 
>    Float if .git/HEAD begins with "refs/heads"
>    Else, use the SHA1.

Wouldn't this break creating a bugfix topic branch based on an earlier
revision of the repo?  I wouldn't want such a branch to automatically give me
the latest submodules.

I'd prefer to have floating be explicitly configured on a per-branch (or
per-branch-glob) basis.  So in addition to what Jens described yesterday [1]
to configure an individual submodule's floating branch, I suggest there also
be a new section in the .gitmodules file for configuring the super-repo's
floating branches, e.g.

	[super]
		floaters = refs/heads/master refs/heads/dev*

	[submodule "Sub1"]
		path = foo/bar
		branch = maint
		url = ...

	[submodule "Sub2"]
		path = other/place
		url = ...

This would mean that whenever the super-repo checks out either the "master"
branch or a branch whose name starts with "dev" (assuming recursive checkouts
are on):

  * The Sub1 submodule automatically checks out the tip of its
    "maint" branch.

  * The Sub2 submodule (lacking a "branch" variable) would not float
    and would check out the commit recorded in the super-repo.

A super-repo recursive-checkout that doesn't match a floaters pattern would
work in the regular, non-floating way.

		M.

[1] http://article.gmane.org/gmane.comp.version-control.git/186969
