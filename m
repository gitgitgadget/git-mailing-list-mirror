From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] git p4: add support for 'p4 move' in P4Submit
Date: Mon, 9 Jul 2012 06:56:29 -0400
Message-ID: <20120709105629.GA23746@padd.com>
References: <1341409220-27954-1-git-send-email-pw@padd.com>
 <1341409220-27954-3-git-send-email-pw@padd.com>
 <7v7guhpfmn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gary Gibbons <ggibbons@perforce.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 12:56:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoBdv-0006vE-JB
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 12:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab2GIK4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 06:56:34 -0400
Received: from honk.padd.com ([74.3.171.149]:34580 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128Ab2GIK4e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 06:56:34 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 0F8853162;
	Mon,  9 Jul 2012 03:56:33 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E26AB313C9; Mon,  9 Jul 2012 06:56:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v7guhpfmn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201198>

gitster@pobox.com wrote on Thu, 05 Jul 2012 23:28 -0700:
> Pete Wyckoff <pw@padd.com> writes:
> 
> > diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
> > index 84fffb3..8be74b6 100755
> > --- a/t/t9814-git-p4-rename.sh
> > +++ b/t/t9814-git-p4-rename.sh
> > @@ -77,16 +77,16 @@ test_expect_success 'detect renames' '
> >  		git commit -a -m "Rename file1 to file4" &&
> >  		git diff-tree -r -M HEAD &&
> >  		git p4 submit &&
> > -		p4 filelog //depot/file4 &&
> > -		p4 filelog //depot/file4 | test_must_fail grep -q "branch from" &&
> > +		p4 filelog //depot/file4 | tee filelog &&
> > +		! grep -q " from //depot" filelog &&
> 
> I am not a huge fan of using "tee" in our test scripts, especially
> as it means piping output of another command whose output (and
> presumably the behaviour) we care about, hiding its exit status.
> 
> Fixing the incorrect use of piping to "test_must_fail grep" is a
> good change, but is there anything wrong to do the above like this?
> 
> 	p4 filelog //depot/file4 >filelog &&
> 	! grep -q " from //depot" filelog &&

I'd started growing fond of "tee" as it shows all the
output, and isolates the grep as a separate step.  Much
easier to see the bad output when a test fails.

I'll switch around to your approach, adding a "cat filelog" line
for interesting cases.

		-- Pete
