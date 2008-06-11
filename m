From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 07:52:05 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806110749230.3101@woody.linux-foundation.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>  <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>  <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>  <7v1w34dfn3.fsf@gitster.siamese.dyndns.org> 
 <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>  <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org>  <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>  <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org> 
 <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>  <alpine.LFD.1.10.0806101935130.3101@woody.linux-foundation.org> <832adb090806102258v3fd63605p8c45513690b78fe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 16:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Rib-0005JC-Ue
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 16:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759360AbYFKOxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756322AbYFKOxf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 10:53:35 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48917 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754761AbYFKOxf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2008 10:53:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BEq7Il016686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jun 2008 07:52:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BEq55x003007;
	Wed, 11 Jun 2008 07:52:05 -0700
In-Reply-To: <832adb090806102258v3fd63605p8c45513690b78fe8@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.374 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84612>



On Tue, 10 Jun 2008, Ben Lynn wrote:
>
> Am I going crazy? All of a sudden I think I can get away without a
> size zero hack. How about this smudging routine:
> 
> if (!ce_match_stat_basic(ce, &st)) {
>   recompute_sha1_and_update_index();  // no other checks required
> }

No.

You can't recompute the sha1. That SHA1 is what the user asked us to 
remember - whether smudged or not. So you mustn't change it, until the 
user does a "git add" or "git update-index" (or anything that implicitly 
does the same).

You can change the _stat_ information, since that is only used for 
matching the tree (positively or negatively), but the SHA1 itself is not 
just a cache, it's the "pending state" in the index.

So smudging must change some piece of data that is only about the stat 
cache - the st_size, the mtime, anything like that.

			Linus
