From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] Make pack creation always fsync() the result
Date: Mon, 2 Jun 2008 15:23:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806021522120.3473@woody.linux-foundation.org>
References: <20080529205743.GC17123@redhat.com> <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org> <20080530152527.GF4032@redhat.com> <alpine.LFD.1.10.0805300844310.3141@woody.linux-foundation.org> <alpine.LFD.1.10.0805300905080.3141@woody.linux-foundation.org>
 <20080531141927.GC32168@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 00:26:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ISi-0007Nt-VW
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 00:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYFBWYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 18:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbYFBWYJ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 18:24:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38337 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752639AbYFBWYH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jun 2008 18:24:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m52MNfT4024109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jun 2008 15:23:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m52MNebe002922;
	Mon, 2 Jun 2008 15:23:40 -0700
In-Reply-To: <20080531141927.GC32168@redhat.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.89 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83585>



On Sat, 31 May 2008, Frank Ch. Eigler wrote:
> 
> If you stabilize the outputs of the pack procedure rather than its
> inputs, this makes me wonder if ordinary unpacked git objects would
> also need some sort of fsync treatment.

No, see the earlier discussion about the difference between "old" and 
"new" objects.

Pack-files can contain old objects that were _previously_ stable, so we 
need to make sure that they are at least as stable as the objects they 
replace. In contrast, new loose objects never replace old data, so they 
can always be re-created by just re-doing the git operation.

		Linus
