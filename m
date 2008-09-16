From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Grafts workflow for a "shallow" repository...?
Date: Tue, 16 Sep 2008 15:27:43 +0200
Message-ID: <48CFB44F.8060609@drmicha.warpmail.net>
References: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com> <20080916052425.GA14644@spearce.org> <7v3ak08v5l.fsf@gitster.siamese.dyndns.org> <20080916080908.GA14272@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 15:30:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfacY-0005H4-C2
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 15:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbYIPN1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 09:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbYIPN1s
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 09:27:48 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47434 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753630AbYIPN1r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2008 09:27:47 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0A2D1163453;
	Tue, 16 Sep 2008 09:27:47 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 16 Sep 2008 09:27:47 -0400
X-Sasl-enc: B0GTMlXyJ3FjvO6QpDpmLXRqnNnYFY9ZRHES/Wqufzp+ 1221571666
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BCD84283C7;
	Tue, 16 Sep 2008 09:27:45 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <20080916080908.GA14272@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96002>

Bj=F6rn Steinbrink venit, vidit, dixit 16.09.2008 10:09:
> On 2008.09.15 23:25:10 -0700, Junio C Hamano wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>
>>> Martin Langhoff <martin.langhoff@gmail.com> wrote:
>>>> Here is my attempt at a "let's publish a shallow repository for br=
anch
>>>> of moodle". Let me show you what I did...
>>> ...
>>>>  # 1.7 was a significant release, anything earlier than that
>>>>  # is just not interesting -- even for pickaxe/annotate purposes
>>>>  # so add a graft point right at the branching point.
>>> ...
>>>> Is this kind of workflow (or a variation of it) supported? For thi=
s to
>>>> work, we should communicate the grafts in some push operations and
>>>> read them in clone ops - and perhaps in fetch too.
>>> ...
>>> I think that in this case the best thing to do is give users
>>> a shell script that does roughly:
>>>
>>> 	git init
>>> 	echo $BASE >.git/info/grafts
>>> 	git remote add -f origin $url
>>> 	git checkout -b master origin/master
>>>
>>> Sign the script, and let users verify it before executing.  You may
>>> also want a script to drag in the history behind by removing the
>>> graft and fetching $BASE^, but that is hard because your repository
>>> already "has" that.
>> Why not just filter-branch _once at the origin_ and publish the resu=
lt?
>=20
> I think the idea was to have a shallow clone starting at a certain
> point, as opposed to the --depth option, where you cannot specify a
> starting point, but only the depth of the clone.

That's what Junio suggests:

chop the history by introducing an appropriate graft
make it "permanent" by filter-branching (and remove from info/grafts).

Now you have a disconnect dag. clone/push/whatever works on the
"components" given by connected branches.

Note that in this approach all history after the "chopping point" will
be rewritten, i.e. get new sha1's.

Michael
