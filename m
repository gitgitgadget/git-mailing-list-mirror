From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Fri, 13 Apr 2007 08:00:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704130751560.28042@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org>
 <20070413081049.GA26649@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 17:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcNGH-0007Yq-12
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 17:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbXDMPA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 11:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbXDMPA0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 11:00:26 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36063 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028AbXDMPAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 11:00:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3DF0IIs021832
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Apr 2007 08:00:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3DF0I8n002343;
	Fri, 13 Apr 2007 08:00:18 -0700
In-Reply-To: <20070413081049.GA26649@moooo.ath.cx>
X-Spam-Status: No, hits=-0.956 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44408>



On Fri, 13 Apr 2007, Matthias Lederhofer wrote:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >  - add some actual switch to git diff generation to hide the negative side 
> >    of a unified diff, and add some way to just make gitk pass that switch 
> >    in.
> 
> This one would still allow to show the added lines still colored in
> green.  Or do I miss a way to do this?  git show --color is not very
> grep friendly because lines begin with an escape sequence.

Heh. I'm not much for color, so I've never done it. But if you want it, 
you should be able to just do

	git show --color <commit> |
		grep -v '^[^ ]*-' |
		less -RS

because every line of a diff (and even the explanations, thanks to the 
indent-by-four rule of git log printing) should either start with a "+/-" 
*or* they will have a space before they will show up, so using the "no 
spaces before the -" rule instead of "beginning of line" should work..

So the above will *literally* just remove the "---" line and the actual 
removal lines of the diff, even in the presense of color coding. 

The exception, of course, is:
 - maybe I didn't think it through and I missed some case, and it removes 
   lines it shouldn't.
 - if you make the color coding itself have spaces or something in it 
   you break my assumption (but the vt100 codes should be fine)

Hmm?

		Linus
