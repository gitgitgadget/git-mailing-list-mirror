From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Tue, 13 Dec 2011 17:42:40 -0500
Message-ID: <4EE7D4E0.5000305@xiplink.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com> <4EE61EED.50604@ursus.ath.cx> <CALFF=ZRYB1LkAY5WSC4Eydu-N0KNnWLLM2CfbSXZji18yO82gw@mail.gmail.com> <4EE64B04.8080405@ursus.ath.cx> <CALFF=ZRB7qjj7VMhzr12ySdHmZsySoqceu5brFht8rX1+W3NPg@mail.gmail.com> <CABURp0rFOGQ9kAbAn65W3UAHTWbk5prH7spjJnFvL5fqzbFp1w@mail.gmail.com> <4EE770D0.5080702@xiplink.com> <4EE7C15A.3040501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Leif Gruenwoldt <leifer@gmail.com>,
	"Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RabCF-0005kK-4A
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 23:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab1LMWve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 17:51:34 -0500
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:50106 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1LMWve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 17:51:34 -0500
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Dec 2011 17:51:34 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp12.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 63A7A3C1270;
	Tue, 13 Dec 2011 17:42:43 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp12.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 625653C1383;
	Tue, 13 Dec 2011 17:42:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <4EE7C15A.3040501@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187070>

On 11-12-13 04:19 PM, Jens Lehmann wrote:
> Am 13.12.2011 16:35, schrieb Marc Branchaud:
>> I'd prefer to have floating be explicitly configured on a per-branch (or
>> per-branch-glob) basis.  So in addition to what Jens described yesterday [1]
>> to configure an individual submodule's floating branch, I suggest there also
>> be a new section in the .gitmodules file for configuring the super-repo's
>> floating branches, e.g.
>>
>> 	[super]
>> 		floaters = refs/heads/master refs/heads/dev*
>>
>> 	[submodule "Sub1"]
>> 		path = foo/bar
>> 		branch = maint
>> 		url = ...
>>
>> 	[submodule "Sub2"]
>> 		path = other/place
>> 		url = ...
> 
> Hmm, but you can have different .gitmodules files in different branches of
> the superproject, no?

Yes.  I'm not sure I see that as a problem though.

> Why not just have the "branch = maint" setting for
> "Sub1" in the master and the dev branches .gitmodules file and drop it in
> the other branches?

Because I think that's an error-prone approach.

If the user creates a topic branch off (an ancestor) of master, git doesn't
know if the user wants floating submodules or not.  If this is a bugfix
topic, the user would have to edit .gitmodules to turn off floating.  But
that modified .gitmodules is too easily committed to the branch, and once it
gets merged back into master suddenly master loses its "floating" feature.

What's more, less-sophisticated users would be wary of editing an "internal"
file like .gitmodules.

Instead I think it's more intuitive for the repository to define which
branches get floating submodules and which don't, and IMO a list of
names/globs is a good way to do that.  The repo's users would need to be
aware of what the magic branch names are, but I think that's easily
communicated in the floating-submodule scenarios I've seen posted.  Git could
also help by telling the user, when a branch is created or it's name is
displayed, whether or not it's got floating submodules.

		M.
