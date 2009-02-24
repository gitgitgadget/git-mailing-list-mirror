From: Charles Bailey <charles@hashpling.org>
Subject: Re: how do I resolve this merge manually + mergetool bug
Date: Tue, 24 Feb 2009 09:13:30 +0000
Message-ID: <20090224091330.GB23927@hashpling.org>
References: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com> <20090224074727.GA23927@hashpling.org> <81bfc67a0902240032t783abcabgaf8fa13b2a43e48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbtNX-0006vA-53
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbZBXJNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbZBXJNe
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:13:34 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:31536 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752980AbZBXJNd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 04:13:33 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAPZIo0nUnw4T/2dsb2JhbADWWIQRBg
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.ptn-ipout02.plus.net with ESMTP; 24 Feb 2009 09:13:31 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1LbtM2-0005FZ-HE; Tue, 24 Feb 2009 09:13:30 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n1O9DUlI025046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Feb 2009 09:13:30 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n1O9DU9n025045;
	Tue, 24 Feb 2009 09:13:30 GMT
Content-Disposition: inline
In-Reply-To: <81bfc67a0902240032t783abcabgaf8fa13b2a43e48@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 631c99262412c28da376a175c0c0496a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111245>

On Tue, Feb 24, 2009 at 03:32:50AM -0500, Caleb Cushing wrote:
> On Tue, Feb 24, 2009 at 2:47 AM, Charles Bailey <charles@hashpling.org> wrote:
> > I'll look at adding
> > a test case to mergetool and see how easy it is to get it to handle
> > this case better.
> 
> few weeks back I created a patch for mergetool, it was rejected
> ultimately on the basis that it had to cleanup temporary files and in
> reality this was a problem with a lot of mergetool, the suggestion was
> made that mergetool needs refactoring. I believe this problem is a
> similar symptom. basically mergetool should touch my files before I
> tell it what to do. if it has to move and back up my files before
> deciding then at the very least it should copy them back into place if
> I delete the remote. preferably in this case though it would just
> delete the remote or backup my local files and copy the remote in
> after I told it what to do (or maybe even delete my local files).

Coincidentally, last night I started looking at a mergetool
refactoring but more with unifying the handling of temporaries and
actions between the different types of merge (symlink, deleted file
and 'normal').

I'm more of the opinion that in any non-trivial case (i.e. not a
regular file/file merge), it *shouldn't* do anything until you tell it
what you want it to do. Clearly, between a tree and a blob, mergetool
is not going to be able to invoke a mergetool on set of three blobs,
but it should work out what it can do before prompting for a choice
from the user of what they want it to do.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
