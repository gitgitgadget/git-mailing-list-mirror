From: John Chapman <thestar@fussycoder.id.au>
Subject: Re: New script to convert p4 repositories to git - git-p4c version
	1.
Date: Tue, 16 Dec 2008 08:52:32 +1100
Message-ID: <1229377952.18839.11.camel@therock.nsw.bigpond.net.au>
References: <1228818317.5504.23.camel@localhost>
	 <20081215193058.GA5098@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 00:30:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCMtY-0007ta-VT
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 00:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbYLOX3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 18:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbYLOX3K
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 18:29:10 -0500
Received: from nskntqsrv01p.mx.bigpond.com ([61.9.168.231]:16651 "EHLO
	nskntqsrv01p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752078AbYLOX3J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Dec 2008 18:29:09 -0500
Received: from nskntotgx01p.mx.bigpond.com ([58.173.132.215])
          by nskntmtas06p.mx.bigpond.com with ESMTP
          id <20081215214211.DOXW17301.nskntmtas06p.mx.bigpond.com@nskntotgx01p.mx.bigpond.com>;
          Mon, 15 Dec 2008 21:42:11 +0000
Received: from therock.local ([58.173.132.215])
          by nskntotgx01p.mx.bigpond.com with ESMTP
          id <20081215214210.KUHY17478.nskntotgx01p.mx.bigpond.com@therock.local>;
          Mon, 15 Dec 2008 21:42:10 +0000
In-Reply-To: <20081215193058.GA5098@osc.edu>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150201.4946CF33.0031,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103217>

On Mon, 2008-12-15 at 14:30 -0500, Pete Wyckoff wrote:
<snip>
> I'm running into a different limitation with p4c.
> 
> The command:
> 
>     p4 -G changes -l -t
> 
> is adminstratively limited to a paltry six-digit number, and
> produces only an error message.
Hmm, I'm not sure how to resolve this, the repo I use this with so far
only uses 6 digit numbers, will have to review the p4 client documents
on this.
> 
> The other feature I need is the ability to use a client
> specification.  We merge together 40-odd different chunks of //depot
> into a single checked-out client, and use some other number of
> "-//depot/..." rules to exclude some parts of the full depot.
> 
> If I hack p4c to limit the changes with "-m 10" or so, then things
> are a bit better in that I get two objects (changesets) but no
> diffs.  Had to hack the on_branch() code somewhat, in that no form
> of --branches seemed to produce an "interesting" changeset by your
> definition.  Could be my lack of understanding here.
Modifying the on_branch code is the right place to do what you want,
however I was hoping that specifying your 'interesting' branches by
regexp would be sufficient?  All those places that do not get matched
are effectively ignored and do not become part of the git repo.

There is a bug in which the case of the branch name sometimes seems to
change in my repo, and thus my newer version always lower-cases the
names.

Do you need to use a client spec here, or is it possible to just use
regexps?  I'd like to try and avoid the need to parse the clientspec,
that's all.

> If you think you want to handle client specifications, and can think
> of a way around the "p4 changes" limitation, I'll be happy to poke
> at your next version.  Perhaps I'm not in your target audience,
> though.  I don't necessarily need to have a full git history of the
> entire p4, but this seems to be a fundamental part of your approach.

I'm not sure about client specifications, but I definetly do want to
think of a way around the p4 changes limitation.
I'll get a new version out to you soon (Which includes several bug
fixes), however before I go, I should mention that a deliberate design
decision was to allow the git administrator maximum flexibility.

The script does try to import the full history, however it starts that
history only at the most recent change, which is defined as a tag.

Thus, if your main branch is 'trunk', then you should be able to
manually import your changes, tag it as 'trunk/102388', to indicate
that's p4's revision 102388 of trunk, and the script should then begin
checking out changeset 102389.  I haven't had a chance to test that
theory yet, but it should work.

Thankyou for your valuable feedback.

> 
> 		-- Pete
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
