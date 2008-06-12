From: Yves Orton <yves.orton@booking.com>
Subject: Re: git-fast-export bug, commits emmitted in incorrect order
	causing parent data to be lost from commits turning essentially linear repo
	into "islands"
Date: Thu, 12 Jun 2008 14:16:02 +0200
Message-ID: <1213272962.6940.231.camel@gemini>
References: <1213266100.6940.207.camel@gemini>
	 <48510E2E.6090508@viscovery.net>  <1213272285.6940.222.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 14:17:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ljj-0004IH-7n
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 14:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbYFLMQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 08:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755731AbYFLMQH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 08:16:07 -0400
Received: from msx2.activehotels.net ([62.190.24.12]:55721 "EHLO
	mx2.activehotels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752842AbYFLMQG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 08:16:06 -0400
Received: from p5098d9db.dip0.t-ipconnect.de ([80.152.217.219] helo=[192.168.250.20])
	by mx2.activehotels.net with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.50)
	id 1K6lil-0000PE-QH; Thu, 12 Jun 2008 13:16:04 +0100
In-Reply-To: <1213272285.6940.222.camel@gemini>
X-Mailer: Evolution 2.22.2 
X-AH-Spam-Helo: [192.168.250.20]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84750>

On Thu, 2008-06-12 at 14:04 +0200, Yves Orton wrote:
> On Thu, 2008-06-12 at 13:53 +0200, Johannes Sixt wrote:
> > Yves Orton schrieb:
> > > Hi,
> > > 
> > > Ive been working with git-fast-export a bit recently and Ive hit a bug
> > > that is causing some trouble. 
> > > 
> > > Essentially it seems that one of our repos git-fast-export fails to emit
> > > the proper 'from' information for several commits in the repo. These
> > > commits are emitted first without parent data even though their parents
> > > ARE emitted later.
> > 
> > Does it make a difference if you pass --topo-order to git fast-export?
> > (But I don't know for certain that this is even legal.)
> 
> Yes it does make a difference. A big difference. That would be the
> workaround I really needed.  At least currently thats the way it looks,
> i havent thoroughly tested the result yet but it certainly looks right.
> 
> Perhaps this should be enabled by default to avoid the problem i
> encountered? At least until whatever the cause of the root problem is
> identified and fixed.
> 
> Thanks a lot. ++ to you.

I should add that with this switch enabled the output order is correct,
HOWEVER the mark number of the first commit is unchanged from the
original. However the parent relationships are correctly restored and
the resulting repo has the correct SHA1 stamps. So it looks like the
original traversal order is wrong somehow, and that --topo-order fixes
it up after the fact.

But for my immediate needs this is the solution I needed. Again many
thanks.

BTW, for the record this was needed because we are trying to merge
multiple git repos into a single new git repo with each original repo
mapped into a subdirectory of the new repo, and with commit trees merged
in more or less the correct order (by date applied more or less). IOW we
dont want to have multiple "root commits" that are later merged. 

We want a more or less linear repo as the result. This bug with
fast-export was the main showstopper in our efforts.  However, I can
imagine that this is a problem that many people will want to solve. It
would be nice if there was an easier way to do it that what we currently
are doing (merging and munging multiple fast-export streams into a
single fast-import process). While at this point its probably academic
any suggestions as to the Best Way to do this would be very much
welcome.

Cheers and thanks to all you git developers for a great tool!
Yves
