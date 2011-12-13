From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Tue, 13 Dec 2011 22:19:22 +0100
Message-ID: <4EE7C15A.3040501@web.de>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> <4EE61EED.50604@ursus.ath.cx> <CALFF=ZRYB1LkAY5WSC4Eydu-N0KNnWLLM2CfbSXZji18yO82gw@mail.gmail.com> <4EE64B04.8080405@ursus.ath.cx> <CALFF=ZRB7qjj7VMhzr12ySdHmZsySoqceu5brFht8rX1+W3NPg@mail.gmail.com> <CABURp0rFOGQ9kAbAn65W3UAHTWbk5prH7spjJnFvL5fqzbFp1w@mail.gmail.com> <4EE770D0.5080702@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Leif Gruenwoldt <leifer@gmail.com>,
	"Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 22:19:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaZlA-0003qu-Db
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 22:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab1LMVTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 16:19:31 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:32937 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab1LMVTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 16:19:30 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id 3B27D6F5B48E
	for <git@vger.kernel.org>; Tue, 13 Dec 2011 22:19:29 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M6Df8-1QpeOf2iDK-00xtZZ; Tue, 13 Dec 2011 22:19:27
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EE770D0.5080702@xiplink.com>
X-Provags-ID: V02:K0:nPRXrr+q3cGRdpOh2kM/HjTHTXNfP8KCIkDpUY5ASbH
 AlJK9w59/8CYg7bCS4jbOVLrIVnp9YhLYJMqjosobwSmGXXxci
 eIsqrfWO1zRTubwVXCyvXALreBlaRLkGwLVlyHBhCUjihT6iED
 tqOHm4OsCjBMNiEtUsvk+I52oFNlHbi33bjq1y5KZfE9tT65oX
 o0Pp3BP2/7E0IyWlgclfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187062>

Am 13.12.2011 16:35, schrieb Marc Branchaud:
> I'd prefer to have floating be explicitly configured on a per-branch (or
> per-branch-glob) basis.  So in addition to what Jens described yesterday [1]
> to configure an individual submodule's floating branch, I suggest there also
> be a new section in the .gitmodules file for configuring the super-repo's
> floating branches, e.g.
> 
> 	[super]
> 		floaters = refs/heads/master refs/heads/dev*
> 
> 	[submodule "Sub1"]
> 		path = foo/bar
> 		branch = maint
> 		url = ...
> 
> 	[submodule "Sub2"]
> 		path = other/place
> 		url = ...

Hmm, but you can have different .gitmodules files in different branches of
the superproject, no? Why not just have the "branch = maint" setting for
"Sub1" in the master and the dev branches .gitmodules file and drop it in
the other branches?

> This would mean that whenever the super-repo checks out either the "master"
> branch or a branch whose name starts with "dev" (assuming recursive checkouts
> are on):
> 
>   * The Sub1 submodule automatically checks out the tip of its
>     "maint" branch.
> 
>   * The Sub2 submodule (lacking a "branch" variable) would not float
>     and would check out the commit recorded in the super-repo.
> 
> A super-repo recursive-checkout that doesn't match a floaters pattern would
> work in the regular, non-floating way.

Which would just work with my proposal too if git would honor the
.gitmodules file of the currently checked out branch.

> [1] http://article.gmane.org/gmane.comp.version-control.git/186969
