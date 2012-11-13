From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Tue, 13 Nov 2012 11:15:21 +0100
Message-ID: <50A21DB9.7070700@drmicha.warpmail.net>
References: <CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com> <509E8EB2.7040509@drmicha.warpmail.net> <CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com> <509EAA45.8020005@gmail.com> <CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com> <509FD9BC.7050204@gmail.com> <20121111171518.GA20115@sigill.intra.peff.net> <CAMP44s1mny-fBCxywM0V=AgEoxV5EZdDWc_0NK3gepcKf32nww@mail.gmail.com> <20121111181406.GA21654@sigill.intra.peff.net> <CAMP44s1m8sAD9D0F-6b=+dm_AvLb_4_f7h=3A_VMYMDUEcTW7g@mail.gmail.com> <20121112214127.GA10531@sigill.intra.peff.net> <CAMP44s1gA1P-Lr1M=7RDRqFQmvQAtNnB+yAJfKC1gk3XUjbfCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, A Large Angry SCM <gitzilla@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 11:15:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYDWs-0007ai-7G
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 11:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab2KMKPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 05:15:25 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43462 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754054Ab2KMKPX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 05:15:23 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 34611208C2;
	Tue, 13 Nov 2012 05:15:23 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 13 Nov 2012 05:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=W8PlFSBp8TxpgaF8Tv9Z3C
	ALwao=; b=p65rVnclxMefAZpOhk+TipcSyHEOZjApaRqD+ESwE9aRUGvEZ4HrsM
	C+hM0/OD1HMQSL9k76kdQtrkWCwCXa9P7a9CGquyAZsRpijyfldKbm+2HemFBaki
	HqTrIIGB3rB+fuapfii2ZJ945Z+/Ru0gdMpR3egh78ypVRTBvlzlI=
X-Sasl-enc: ozVkx69DkrtiyZ9sOF/UWqveMmMnNIGoEL8wGXIsJijx 1352801722
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 607DC8E050E;
	Tue, 13 Nov 2012 05:15:22 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMP44s1gA1P-Lr1M=7RDRqFQmvQAtNnB+yAJfKC1gk3XUjbfCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209592>

Felipe Contreras venit, vidit, dixit 12.11.2012 23:47:
> On Mon, Nov 12, 2012 at 10:41 PM, Jeff King <peff@peff.net> wrote:
>> On Sun, Nov 11, 2012 at 07:48:14PM +0100, Felipe Contreras wrote:
>>
>>>>   3. Exporters should not use it if they have any broken-down
>>>>      representation at all. Even knowing that the first half is a human
>>>>      name and the second half is something else would give it a better
>>>>      shot at cleaning than fast-import would get.
>>>
>>> I'm not sure what you mean by this. If they have name and email, then
>>> sure, it's easy.
>>
>> But not as easy as just printing it. What if you have this:
>>
>>   name="Peff <angle brackets> King"
>>   email="<peff@peff.net>"
>>
>> Concatenating them does not produce a valid git author name. Sending the
>> concatenation through fast-import's cleanup function would lose
>> information (namely, the location of the boundary between name and
>> email).
> 
> Right. Unfortunately I'm not aware of any DSCM that does that.
> 
>> Similarly, one might have other structured data (e.g., CVS username)
>> where the structure is a useful hint, but some conversion to name+email
>> is still necessary.
> 
> CVS might be the only one that has such structured data. I think in
> subversion the username has no meaning. A 'felipec' subversion
> username is as bad as a mercurial 'felipec' username.

In subversion, the username has the clearly defined meaning of being a
username on the subversion host. If the host is, e.g., a sourceforge
site then I can easily look up the user profile and convert the username
into a valid e-mail address (<username>@users.sf.net). That is the
advantage that the exporter (together with user knowledge) has over the
importer.

If the initial clone process aborts after every single "unknown" user
it's no fun, of course. On the other hand, if an incremental clone
(fetch) let's commits with unknown author sneak in it's no fun either
(because I may want to fetch in crontab and publish that converted beast
automatically). That is why I proposed neither approach.

Most conveniently, the export side of a remote helper would

- do "obvious" automatic lossless transformations
- use an author map for other names
- For names not covered by the above (or having an empty map entry):
Stop exporting commits but continue parsing commits and amend the author
map with any unknown usernames (empty entry), and warn the user.
(crontab script can notify me based on the return code.)

If the cloning involves a "foreign clone" (like the hg clone behind the
scene) then the runtime of the second pass should be much smaller. In
principle, one could even store all blobs and trees on the first run and
skip that step on the second, but that would rely on immutability on the
foreign side, so I dunno. (And to check the sha1, we have to get the
blob anyways.)

As for the format for incomplete entries (foo <some@where>), a technical
guideline should suffice for those that follow guidelines.

Michael
