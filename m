From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Fri, 29 Feb 2008 13:05:11 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802291228560.17889@woody.linux-foundation.org>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com> <7v7igqyii9.fsf@gitster.siamese.dyndns.org> <18373.58839.636432.448970@cargo.ozlabs.ibm.com> <7v1w6yqaim.fsf@gitster.siamese.dyndns.org> <18374.39253.408961.634788@cargo.ozlabs.ibm.com>
 <7vprugdxpj.fsf@gitster.siamese.dyndns.org> <18375.58359.687664.855599@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVCSe-0001xW-Cl
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760714AbYB2VH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758384AbYB2VH2
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:07:28 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:59432 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757537AbYB2VH1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 16:07:27 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1TL5CDK010478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Feb 2008 13:05:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1TL5BDK020690;
	Fri, 29 Feb 2008 13:05:11 -0800
In-Reply-To: <18375.58359.687664.855599@cargo.ozlabs.ibm.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.141 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75563>



On Fri, 29 Feb 2008, Paul Mackerras wrote:
> 
> Well, it does, except for --merge, which is perhaps a special case.

Well, clearly --merge is a special case, but it probably really shouldn't 
be.

If you want to parse revisions, then --merge should do that. But --merge 
is really special in that it expands into *both* a revision range *and* a 
set of files, so it doesn't really work wonderfully well for the trivial 
kind of parsing that git-rev-parse does.

So we certainly *could* just add "--merge" to the list of magic flags that 
is known about by is_rev_argument(), since that's a trivial one-liner. But 
that's really only ok for the case where we are supposed to output both 
revisions *and* flags, and even then it should also suppress the default 
HEAD generation (although it won't actually hurt, since the revision 
output from --merge will include HEAD in teh "HEAD...MERGE_HEAD" logic 
anyway, so with --default always being HEAD in practice..)

So yeah, I think git-rev-list has trouble handling --merge sanely the way 
it is currently written.

		Linus
