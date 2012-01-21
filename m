From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Sat, 21 Jan 2012 12:11:30 -0500
Message-ID: <20120121171130.GA6235@padd.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-4-git-send-email-vitor.hda@gmail.com>
 <7vehutd59p.fsf@alter.siamese.dyndns.org>
 <4F1A98A3.2090607@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Jan 21 18:11:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoeTb-0004Sy-Mi
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 18:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820Ab2AURLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 12:11:35 -0500
Received: from honk.padd.com ([74.3.171.149]:39332 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750Ab2AURLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 12:11:34 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id 724A05B40;
	Sat, 21 Jan 2012 09:11:33 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A950731458; Sat, 21 Jan 2012 12:11:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4F1A98A3.2090607@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188924>

luke@diamand.org wrote on Sat, 21 Jan 2012 10:51 +0000:
> On 21/01/12 04:54, Junio C Hamano wrote:
> >Vitor Antunes<vitor.hda@gmail.com>  writes:
> >
> >>+		grep -q update file2&&
> >
> >Do you really need to use "-q" here?  Wouldn't it help if you wrote it
> >without it while debugging tests with "sh ./t9801-*.sh -v"?
> >
> >Also how does this series interact with the series Luke posted earlier on
> >branches and labels?
> 
> Vitor's series applies cleanly to my changes.
> 
> However, one thing I noticed in reading through is that it will
> break if you end up importing a P4 branch that has spaces (or other
> shell chars) in its name. A quick test confirms this.
> 
> - the code doesn't handle the names properly
> - git and p4 have different ideas about valid branch names
> 
> But before rejecting Vitor's changes because of that it would be
> worth considering whether we care (much). My own opinion is that if
> you have developers who are daft enough to put spaces or dollars in
> their branch names then their project is already doomed anyway....
> 
> Perhaps it would be enough just to issue a warning ("your project is
> doomed; start working on your CV") and skip such branch names rather
> than falling over with inexplicable error messages.

This doesn't seem like a big deal.  The read_pipe and
read_pipe_lines calls shoud be list-ified.  That gets rid
of the problem with shell interactions.

For git branch name reserved characters, a little function
to replace the bogus characters with "_" would avoid needing
to go work on the resume.  Anything in bad_ref_char() and
check_refname_component().  I agree this doesn't have to be
perfect.

This could be a new patch unrelated to Vitor's series, which
verifies branch names anywhere a new commit is made.

		-- Pete
