From: Adam Simpkins <simpkins@facebook.com>
Subject: Re: [PATCH] Add tests for rev-list --graph with options that
	simplify history
Date: Fri, 21 Aug 2009 14:23:26 -0700
Message-ID: <20090821212326.GX8147@facebook.com>
References: <7vk5103chi.fsf@alter.siamese.dyndns.org> <20090819022918.GO8147@facebook.com> <20090819023433.GP8147@facebook.com> <7vhbw41g3f.fsf@alter.siamese.dyndns.org> <7v4os41frm.fsf@alter.siamese.dyndns.org> <20090819225547.GR8147@facebook.com> <20090819225852.GA21187@facebook.com> <7v7hwzt94p.fsf@alter.siamese.dyndns.org> <20090821182034.GW8147@facebook.com> <7vbpm8exeo.fsf@alter.siamese.dyndns.org>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:23:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MebaE-0000oc-8k
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbZHUVX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbZHUVX0
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:23:26 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:55505 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358AbZHUVX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:23:26 -0400
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.15] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7LLNMAC013190
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Fri, 21 Aug 2009 14:23:22 -0700
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.104) with Microsoft SMTP Server (TLS) id 8.1.393.1; Fri, 21 Aug
 2009 14:23:26 -0700
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1Meba2-0005g4-5H; Fri, 21 Aug 2009 14:23:26 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vbpm8exeo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-21_10:2009-08-11,2009-08-21,2009-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908210072
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126760>

On Fri, Aug 21, 2009 at 01:15:27PM -0700, Junio C Hamano wrote:
> Adam Simpkins <simpkins@facebook.com> writes:
> 
> > +# There's more than one "correct" way to represent the history graphically.
> > +# These tests depend on the current behavior of the graphing code.  If the
> > +# graphing code is ever changed to draw the output differently, these tests
> > +# cases will need to be updated to know about the new layout.
> 
> An ideal solution to such a problem would be not to write the tests that
> way to require _the exact layout_ of the output.

Yeah.  In the past I've been hesitant to submit tests for the graph
behavior for precisely this reason.  However, having tests that check
the exact layout seems better than not having tests at all.

> What was the bug you were trying to fix?  Was it that in a simplified
> history some arcs are not connected whey they should be?

It was an issue with a missing arc between two commits that should
have been connected.  In the past, other bugs (e.g., the one fixed in
2ecbd0a0) have caused arcs to appear connected to the wrong commit.

> Can you test that without relying on other aspect (say, commits are marked
> with '*' right now but a patch might change it to '^' for some commits) of
> the output?
> 
> I am just wondering how feasible it is the problem you are trying to
> solve, not demanding you to solve it.

In general, it seems like its not worthwhile trying to solve this
problem.  I don't expect changes to the graph layout to occur often.
Modifying this test case if and when they do occur seems simpler and
less error-prone than trying to write code that attempts to anticipate
changes we might make in the future.

When I wrote this comment, I was thinking more about potential changes
in the way arcs are drawn in the output, or in the amount of padding.
The problem you mentioned (accepting other characters other than '*'
for commits) is easier, but I'm still not convinced we should try to
solve it.  For example, it's nice that the current code also tests
that boundary commits are represented differently than non-boundary
commits.  Being too permissive in what we accept could also
potentially hide bugs in the future.

-- 
Adam Simpkins
simpkins@facebook.com
