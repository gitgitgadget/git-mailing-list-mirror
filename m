From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 16:49:50 -0500
Message-ID: <1299275390.24965.17.camel@drew-northup.unet.maine.edu>
References: <4D70EBC3.3010400@colin.guthr.ie>
	 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
	 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
	 <7v39n27llq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Colin Guthrie <gmane@colin.guthr.ie>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 22:50:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvcta-0001F6-Kk
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 22:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760321Ab1CDVul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 16:50:41 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:35152 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760278Ab1CDVuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 16:50:40 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p24Lnulq026470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 Mar 2011 16:50:01 -0500
In-Reply-To: <7v39n27llq.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p24Lnulq026470
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299880205.00179@zlKsWCdPqhstkV+0fhHb/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168469>


On Fri, 2011-03-04 at 11:05 -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Looking at it closer, however, I noticed that the false hit (i.e. "two
> > blocks closed, a blank line, return 0 and the end of function") in this
> > particular case only appears because we applied the previous hunk.  In the
> > version of the file in 0ce3017b, there is only one such place and there
> > should be no ambiguity in the patch application.
> >
> > The problem we are seeing is caused only because we look at the result of
> > application of the previous hunks in the patch and incrementally try to
> > apply the remaining hunks.  So clearly "git apply" can and should be fixed
> > for this case by teaching find_pos() not to report a match on a line that
> > was touched by application of the previous hunk.
> 
> And here is a quick and dirty fix to do something like that.  It assumes
> that the hunks for a single file being patched are already sorted in the
> ascending order (which should be the case), and may regress cases where we
> used to find a match even when the version you are patching has moved
> functions around in the file by failing to notice a match.  And it does
> get the same result as your GNU patch test.
> 

It checks out here applied against master. I don't know how I got it to
work the first time without this patch--but I'm pretty sure I don't want
to know at this point.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
