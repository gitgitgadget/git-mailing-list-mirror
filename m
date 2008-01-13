From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 08:57:03 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801130850460.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org> <alpine.LNX.1.00.0801130028460.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 17:59:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE6Al-0002X2-0e
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 17:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbYAMQ6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 11:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbYAMQ6V
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 11:58:21 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33801 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752969AbYAMQ6S (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2008 11:58:18 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0DGv421019842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Jan 2008 08:57:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0DGv3O6021162;
	Sun, 13 Jan 2008 08:57:03 -0800
In-Reply-To: <alpine.LNX.1.00.0801130028460.13593@iabervon.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70398>



On Sun, 13 Jan 2008, Daniel Barkalow wrote:
> 
> The only issue I know about with using unpack_trees in C as a replacement 
> for read-tree in shell is that unpack_trees leaves "deletion" index 
> entries in memory which are not written to disk, but may surprise some 
> code (these are used to allow -u to remove the files from the working 
> tree).

I certainly agree that this patch should be double-checked. I'm pretty 
sure the issue you mention wouldn't be an issue, since the end result is 
only used for actually updating the index and writing it out as a tree 
(both of which should handle the magic zero ce_mode case ok), but it would 
certainly be good to walk through all cases.

			Linus
