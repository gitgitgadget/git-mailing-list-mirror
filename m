From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH updated] Add "--dirstat" for some directory statistics
Date: Tue, 12 Feb 2008 17:10:04 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121701310.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org> <alpine.LFD.1.00.0802121346560.2920@woody.linux-foundation.org> <7v1w7h1xs1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP69o-0003Yp-GJ
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755017AbYBMBKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 20:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbYBMBKz
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 20:10:55 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46788 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752790AbYBMBKy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 20:10:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1D1A5bc020541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 17:10:06 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1D1A44G000381;
	Tue, 12 Feb 2008 17:10:04 -0800
In-Reply-To: <7v1w7h1xs1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.241 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73729>



On Tue, 12 Feb 2008, Junio C Hamano wrote:
> 
> You can drop the "line count" idea and instead count the "amount
> of damage" done to the preimage, just like we do in the rename
> similarity computation.
> 
> The attached patch is just an outline.  There may need special
> cases for unmerged paths.

Ouch. I like the concept and the result, but an not a huge fan of the the 
implementation. The problem with this is that it makes the whole damage 
computation something separate from the earlier phases.

So it actually seems to add a lot of cost. Right now there is basically 
zero added cost to just adding a "--dirstat" to one of my common 
operations, which is

	git diff -M --stat --summary

(that's what I do on merges). 

Wouldn't it be nicer to merge it with one of the stages we did earlier by 
simply saving the data. If not the --stat phase, then the -M phase? 

			Linus
