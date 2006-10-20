From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Use diff3 instead of merge in merge-recursive.
Date: Fri, 20 Oct 2006 23:11:21 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061020211121.GB3024@cepheus.pub>
References: <20061018085949.GA26501@cepheus.pub> <Pine.LNX.4.63.0610181135120.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 23:05:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb1YN-0006vC-Ka
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 23:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992599AbWJTVFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 17:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946514AbWJTVFN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 17:05:13 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:12726 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1030354AbWJTVFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 17:05:11 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Gb1YD-0005JD-V8; Fri, 20 Oct 2006 23:05:10 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k9KL56IN026097;
	Fri, 20 Oct 2006 23:05:06 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k9KL56ko026096;
	Fri, 20 Oct 2006 23:05:06 +0200 (MEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610181135120.14200@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29541>

Johannes Schindelin wrote:
> Hi Uwe,
> 
> On Wed, 18 Oct 2006, Uwe Zeisberger wrote:
> 
> > If no error occurs, merge (from rcs 5.7) is nothing but:
> > 
> > 	diff3 -E -am -L label1 -L label2 -L label3 file1 file2 file3 > tmpfile
> > 	cat tmpfile > file1
> 
> Interesting.

> I wonder if we could streamline the code such that index_fd 
> is called directly on the output of diff3? Of course, the result has to be 
> removed when the call to diff3 fails.
I thought about that, too.  But my primary intention was to get rid of
'merge', because the Solaris boxes I use from time to time lack merge,
but have (GNU) diff3[1].  I already had a mental note to look into that.

If Linus is right that there are systems that have merge but lack diff3,
then a combined approach is maybe the best?  That is, try diff3 and if
that is missing, try merge.  (Or the other way round if you prefer.)

OK, I looked a bit deeper into rcs, and it seems to handle the BSD diff3
case.  So Linus might be right.

BTW, merge -p sends the merged result to stdout instead of overwriting
the first file given.  That is

	merge -p -L label1 -L label2 -L label3 file1 file2 file3

and (GNU)

	diff3 -E -am -L label1 -L label2 -L label3 file1 file2 file3

are exactly equivalent.
So if that option of merge is old enough, these are the candidates for
the "combined approach" (see above).

> > I didn't made any timing tests or further tests for correctness, but I
> > hope Johannes still has the framework from the time when he converted
> > the Python script to C?  
> > 
> > @Johannes: If so, could you test this patch?
> 
> I have to dig a little where I have it, but I think I can give it a try in 
> a few hours (imagine this lyrics to the melody of the day job blues).
Seems to be a long blues because you didn't sent any results. :-(

Best regards
Uwe

[1] They also have a version of diff3 (I guess from BSD) that is not
suited to be used for merging, at least rcs' merge cannot use it.

-- 
Uwe Zeisberger

If a lawyer and an IRS agent were both drowning, and you could only save
one of them, would you go to lunch or read the paper?
