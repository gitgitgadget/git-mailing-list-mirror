From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Fri, 09 Mar 2012 13:30:29 -0500
Message-ID: <4F5A4C45.7070406@xiplink.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr>  <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr> <1331288715.21444.38.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Mar 09 19:41:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S64l2-0005tv-UG
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 19:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630Ab2CISlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 13:41:37 -0500
Received: from smtp202.iad.emailsrvr.com ([207.97.245.202]:40431 "EHLO
	smtp202.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758599Ab2CISlg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 13:41:36 -0500
X-Greylist: delayed 665 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Mar 2012 13:41:36 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp40.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id D9DEC3500B9;
	Fri,  9 Mar 2012 13:30:30 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp40.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 90D8E35022B;
	Fri,  9 Mar 2012 13:30:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1331288715.21444.38.camel@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192733>

On 12-03-09 05:25 AM, Carlos Mart=C3=ADn Nieto wrote:
> On Fri, 2012-03-09 at 09:31 +0100, Matthieu Moy wrote:
>> More inexperienced users will often push right after committing, and=
 at
>> that time they're still very much in the "working-on-one-branch" sta=
te of
>> mind.  "upstream" would be a safer default mode of operation for 'gi=
t push'
>> for them even when they have their personal publishing repository (a=
lso in
>> a shared public repository settings, "matching" is rarely the right
>> default mode).
>>
>> In preparation for flipping the default to the "upstream" mode from =
the
>> "matching" mode that is the upstream default, start warning users wh=
en they
>> rely on unconfigured "git push" to default to the "matching" mode.
>>
>> Original patch and commit message by: Junio C Hamano<gitster@pobox.c=
om>
>>
>> Signed-off-by: Matthieu Moy<Matthieu.Moy@imag.fr>
>> ---
>>
>> This patch prepares a transition to 'upstream', unlike the previous
>> version which was advertizing 'current'. In most case, this would be
>> the same, but 'upstream' is probably more sensible in case it points
>> to a branch other than 'current'. I don't care much either way.
>>
>
> For people using git as VCS that happens to have local history rather
> than taking full advantage of the distributed nature (or who aren't
> aware of it or don't get it), 'matching' is bound to be confusing.
> However, IMO 'current' makes more sense. Consider
>
>      git clone ../foo; cd foo;
>      git checkout -b topic origin/develop
>      ed main.c
>      git push
>
> With upstream I've just updated origin's dev branch, even though I mi=
ght
> have meant to create a new 'topic' branch. Alternatively, I might hav=
e
> run
>
>      git checkout -b topic
>
> in which case I certainly want 'current'. I don't see that workflow
> where the upstream branch is named differently from the local one sho=
uld
> be that big a consideration when trying to determine a default to hel=
p
> people unfamiliar as they'd be certainly more likely to consider bran=
ch
> names to be binding. Maybe you have seen this differently in your
> students, but that's the impression I get from #git.

I disagree and consider "upstream" to be the more reasonable default.

I think that an incantation like

	git checkout -b topic origin/master

makes it pretty clear that topic is meant to be merged into origin's=20
master branch.  And so a simple "git push" as you describe I think=20
*should* update origin's master branch.

OTOH, with a default of "current" I believe the simple "git push" will=20
create a new branch named topic in the origin repo.  To me that's=20
implying too much from the simple "git push" command.  If the user=20
really wants a branch named topic in the origin repo, I think it's=20
reasonable for git's default behaviour to require the user to say so=20
explicitly ("git push origin topic").

I also disagree that an incantation like

	git checkout -b topic

means that the user wants "current" when they "git push".  There's no=20
indication here that the user is at all interested in remote branches=20
with this topic, and I think it would be presumptuous for git to make=20
such a link by default.  (Besides, what if the user has more than one=20
remote?  Which should be used?)

In this case the "upstream" default would mean that git couldn't=20
identify a remote for the topic branch and so the "git push" would fail=
=2E=20
  I think that's appropriate, because the user never told git how the=20
topic branch relates to any remote branches.

		M.
