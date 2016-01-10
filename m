From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH V3 0/2] specify commit by negative pattern
Date: Sun, 10 Jan 2016 07:14:17 -0700
Message-ID: <1686181.AoEpo53h6D@thunderbird>
References: <xmqq37u82apv.fsf@gitster.mtv.corp.google.com> <1452392429-2578-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 15:13:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIGkP-000806-Cm
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 15:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583AbcAJON3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 09:13:29 -0500
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:53142 "EHLO
	fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcAJON3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 09:13:29 -0500
Received: from fed1rmimpo110 ([68.230.241.159]) by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160110141327.ZWHC5597.fed1rmfepo201.cox.net@fed1rmimpo110>
          for <git@vger.kernel.org>; Sun, 10 Jan 2016 09:13:27 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo110 with cox
	id 4EDT1s0062tqoqC01EDTNH; Sun, 10 Jan 2016 09:13:27 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020201.56926707.00BC,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=B55nJpRM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=7aQ_Q-yQQ-AA:10
 a=ybZZDoGAAAAA:8 a=TSbVqHtbAAAA:8 a=yg35m-R2C9E_VScRxiwA:9 a=CjuIK1q_8ugA:10
 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id EF01E13F795;
	Sun, 10 Jan 2016 07:14:17 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.3.0-5-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283618>

On Sunday, January 10, 2016 01:25:42 PM Philip Oakley wrote:
> From: "Stephen P. Smith" <ischis2@cox.net>
> > Add support for negative pattern matching in  <at> ^{/<pattern>} style
> 
> Has this become mangled by replacing the '@' with ' <at> ' ?
It looks like the cover letter got mangled.  I will fix after I get any comments 
on the patches themselves.

> 
> When I look at the update to revisions.txt it doesn't look like its touching 
> the '@' description.
> Is this '@^' a new (for the documenation) combination. Or has the example 
> confused me?
> 
> > revision specifiers. So now you can find the first commit whose message
> > doesn't match a pattern, complementing the existing positive matching.
> > e.g.:
> >
> >    $ git rebase -i  <at> ^{/!-^WIP}
> >
> > My use-case is in having a "work, work, work, rebase, push"-style
> > workflow, which generates a lot of "WIP foo" commits. While rebasing is
> > usually handled via "git rebase -i origin/master", occasionally I will
> > already have several "good, but not yet ready to push" commits hanging
> > around while I finish work on related commits. In these situations, the
> > ability to quickly "git diff  <at> ^{/!-^WIP}" to get an overview of all
> > changes "since the last one I was happy with", can be useful.
> >
> > This is the second version of the patch series. The previous attempt
> > used the notation  <at> ^{/!WIP}, rather than  <at> ^{/!-WIP}, so the 
> > "modifier"
> > was the '!' character. Now, '!' is taken as an indicator that the
> > pattern is to be interpreted differently, and '-' is taken as an
> > indicator of how it is to be interpreted differently. This follows
> > recent discussion with "Junio C Hamano" <gitster <at> pobox.com> and 
> > much-less
> > recent discussion archived at:
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477
> >
> > In summary, '!' is to be used as an "escape hatch", for further
> > extension of the "name commit by pattern" functionality. Theorised future
> > extensions indicated things like "what was to be searched",
> > e.g.:  <at> ^{/!(a=author)}.  With only two interpretations of the '!'
> > leader, for now (including the '!!' literal notation), adding such a
> > verbose form, such as ' <at> ^{/!(negative)foo}', seemed inappropriate at 
> > this
> > time. In the event that such verbose forms are ever implemented, this new
> > form may act as a shorthand, for a basic case.
> >
> > Will Palmer (2):
> >  test for '!' handling in rev-parse's named commits
> >  object name: introduce '^{/!-<negative pattern>}' notation
> >
> > Documentation/revisions.txt | 11 +++++-----
> > sha1_name.c                 | 20 ++++++++++++-----
> > t/t1511-rev-parse-caret.sh  | 53 
> > ++++++++++++++++++++++++++++++++++++++++++++-
> > 3 files changed, 73 insertions(+), 11 deletions(-)
> >
> --
> Philip 
> 
