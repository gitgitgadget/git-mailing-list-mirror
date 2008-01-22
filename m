From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Tue, 22 Jan 2008 09:25:25 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801220919390.2957@woody.linux-foundation.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org> <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> <7vtzl71x1c.fsf@gitster.siamese.dyndns.org> <7vprvv1wnu.fsf@gitster.siamese.dyndns.org> <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org>
 <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org> <7vabmyykvg.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801211242330.2957@woody.linux-foundation.org> <7v3asqry28.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 18:27:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHMth-0002Oe-A1
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 18:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYAVR0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 12:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbYAVR0N
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 12:26:13 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41108 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751101AbYAVR0L (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 12:26:11 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MHPQrZ020941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2008 09:25:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MHPPng031463;
	Tue, 22 Jan 2008 09:25:26 -0800
In-Reply-To: <7v3asqry28.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71462>



On Tue, 22 Jan 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > The stupid thing is that I literally _grepped_ for the code testing 
> > "ce_mode".
> >
> > I had missed that one because I had looked for things like
> >
> > 	if ([!].*ce_mode)
> >
> > but that switch statement meant that the comparison to zero was 
> > non-local and my grep didn't see it.
> 
> Would a patch to sparse help you in cases like this?

Heh. Sparse can do anything, but some things are more specialized than 
others. In this case, I could possibly have added a type modifier that 
says "don't compare against zero", and that kind of thing may even make 
sense (ie you can mark pointers that are known not to be NULL), and yes, 
it would have caught this.

But sparse right now doesn't have that kind of flag (the "safe expression" 
thing comes pretty close).

So yes, sparse could do things like this, but it's generally a fair amount 
of work to add specialized sparse rules.

		Linus
