From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file
 descriptor
Date: Tue, 15 Jan 2008 12:09:16 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151207150.2806@woody.linux-foundation.org>
References: <4787E981.7010200@nrlssc.navy.mil> <478C1D7A.6090103@nrlssc.navy.mil> <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org> <478CECAB.2030906@nrlssc.navy.mil> <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>
 <478CFAFF.6010006@nrlssc.navy.mil> <alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org> <478D0CDA.5050709@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Kristian H?gsberg <krh@redhat.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:11:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEs7v-0002B5-N1
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbYAOUKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYAOUKe
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:10:34 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38550 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751102AbYAOUKc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 15:10:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FK9Htw017851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 12:09:18 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FK9G26000873;
	Tue, 15 Jan 2008 12:09:16 -0800
In-Reply-To: <478D0CDA.5050709@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70547>



On Tue, 15 Jan 2008, Brandon Casey wrote:
> 
> In that same vein, just above your changes in prepare_index() is:
> 
> 	if (!pathspec || !*pathspec) {
> 		fd = hold_locked_index(&index_lock, 1);
> 		refresh_cache(REFRESH_QUIET);
> 		if (write_cache(fd, active_cache, active_nr) ||
> 		    close(fd) || commit_locked_index(&index_lock))
> 			die("unable to write new_index file");
> 		commit_style = COMMIT_AS_IS;
> 		return get_index_file();
> 	}

Yeah, I think that may be the one that got you. I obviously couldn't 
follow the exact path through the code, I was just looking at the trace of 
system calls and found that one thing that looked like it was your case, 
but it's entirely possible that it was another path of the index lock file 
that causes it.

Your patch seems "ObviouslyCorrect(tm)".

		Linus
