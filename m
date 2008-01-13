From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 09:24:02 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org> <7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
 <7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 18:25:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE6aI-00028y-TB
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 18:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbYAMRYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 12:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYAMRYx
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 12:24:53 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57362 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752394AbYAMRYw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2008 12:24:52 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0DHO2EO020860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Jan 2008 09:24:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0DHO24M022044;
	Sun, 13 Jan 2008 09:24:02 -0800
In-Reply-To: <7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70400>



On Sun, 13 Jan 2008, Junio C Hamano wrote:
> 
> The attached is a quick and dirty hack which may or may not
> help.  It all looks sane, this also is some core code, and meant
> only for discussion and not application.

I don't think this will help.

You never set CE_UPTODATE, except in the "fill_stat_cache_info()" 
function, but that one will never be called for an old file that already 
matched the stat.

So at a minimum, you should also make ie_match_stat() set CE_UPTODATE if 
it matches. Or something.

			Linus
