From: Charles Bailey <charles@hashpling.org>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 13:07:40 +0000
Message-ID: <20080117130740.GA30090@hashpling.org>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net> <20080117110132.GB12285@hashpling.org> <478F4CDC.2090703@viscovery.net> <alpine.LSU.1.00.0801171256280.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 14:08:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFUTs-00015h-Fi
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 14:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbYAQNIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 08:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYAQNIA
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 08:08:00 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:40682 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbYAQNH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 08:07:59 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1JFUTB-0000qB-2M; Thu, 17 Jan 2008 13:07:45 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m0HD7fWU030534;
	Thu, 17 Jan 2008 13:07:41 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m0HD7eQu030533;
	Thu, 17 Jan 2008 13:07:40 GMT
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801171256280.17650@racer.site>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70857>

On Thu, Jan 17, 2008 at 12:58:07PM +0000, Johannes Schindelin wrote:
> 
> Just a wild guess... Could it be that the mmap() happened before contents 
> were written to that fd?  The faked mmap() is just a malloc() && pread(), 
> and would thus miss out on changes written after the mmap() call.

This would be my guess too.  As far as I can tell fast-import is
creating objects directly in a packfile.  I'm guessing here, but the
new checking code is probably being triggered to check (for example)
the parent ref for commits that fast-import is creating and the check
only works if mmap can successfully examine objects in the
still-being-written packfile.
