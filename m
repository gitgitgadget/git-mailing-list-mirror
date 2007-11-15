From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New repo quickly corrupted
Date: Thu, 15 Nov 2007 14:37:29 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711151434290.4260@woody.linux-foundation.org>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com> <alpine.LFD.0.9999.0711151358180.4260@woody.linux-foundation.org> <alpine.LFD.0.9999.0711151708470.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsnMa-00072h-Ce
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbXKOWiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757271AbXKOWiw
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:38:52 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38083 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754229AbXKOWiv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 17:38:51 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFMbUdc003254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Nov 2007 14:37:31 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAFMbTHC019533;
	Thu, 15 Nov 2007 14:37:29 -0800
In-Reply-To: <alpine.LFD.0.9999.0711151708470.21255@xanadu.home>
X-Spam-Status: No, hits=-2.734 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65178>



On Thu, 15 Nov 2007, Nicolas Pitre wrote:
> 
> Does "dos2unix" override file access bits?  Because the object store is 
> always made read-only.

Almost all programs like that will entirely ignor the fact that something 
is read-only.

Why? Becuase you end up having to create a new file *anyway*. So nobody 
does modify-in-place, they literally end up doing

 - create temp-file
 - while (data) 
	read old file, write to tempfile
 - rename temp-file over oldfile

and unless you *explicitly* look at the permission bits you'll never even 
notice that the old file was read-only, because none of the steps above 
care at all!

So marking things read-only will give only limited protection. It will 
protect against most editors, and will protect against things that change 
files in-place and literally try to open the original file as read-write, 
but not much else.

			Linus
