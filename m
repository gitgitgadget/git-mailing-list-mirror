From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Hash algorithm choice
Date: Sun, 9 Aug 2009 10:46:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908091038300.3288@localhost.localdomain>
References: <f448a46a0908090907v68542e4dw1f1c4f610cb46ca2@mail.gmail.com> <f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jerome Baum <jerome@jeromebaum.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 19:46:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaCTe-0007ug-7S
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 19:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbZHIRq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 13:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZHIRq2
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 13:46:28 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36914 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972AbZHIRq1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 13:46:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n79HkPDH023175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 9 Aug 2009 10:46:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n79HkP43009360;
	Sun, 9 Aug 2009 10:46:25 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.465 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125355>



On Sun, 9 Aug 2009, Jerome Baum wrote:
> 
> How difficult would it be to allow users to choose a hash function
> during git-init which is then globally used in the repo? Are there
> many changes needed or are changes in git-hash-object and git-init
> sufficient?

If youlimit the hash size to 20 bytes, there are almost no changes 
necessary.

You'd need to hijack the 'SHA1_Init/SHA1_Update/SHA1_Final' functions, of 
course, and you'd likely want to rename them (and eventually a lot of 
other functions too), but that renaming is mechanical and isn't even 
needed for proper working.

Now, if you would ever want to extend the _size_ of the hash, that's a 
much much bigger problem, but if you're ok with just changing the hash and 
then truncating the result to 20 bytes (ie kind of like sha-512-160), or 
you're ok with limiting yourself to 20-byte hashes like REIPMD-160, the 
size of the changes should be minimal.

			Linus
