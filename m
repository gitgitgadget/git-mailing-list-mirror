From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE:
Date: Thu, 7 May 2009 16:18:56 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905071613130.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <alpine.DEB.1.10.0905071521130.15782@asgard> <alpine.LFD.2.01.0905071531030.4983@localhost.localdomain>
 <alpine.DEB.1.10.0905071543120.15782@asgard> <alpine.LFD.2.01.0905071553570.4983@localhost.localdomain> <alpine.DEB.1.10.0905071607080.15782@asgard>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri May 08 01:22:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Cv7-0002Sc-9u
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 01:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbZEGXWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 19:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbZEGXWF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 19:22:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54612 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752278AbZEGXWD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 19:22:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47NIvke003415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 May 2009 16:19:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47NIuWT012129;
	Thu, 7 May 2009 16:18:56 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.10.0905071607080.15782@asgard>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118539>



On Thu, 7 May 2009, david@lang.hm wrote:
> 
> what about a reset --hard? (is there any command that would force the files to
> be re-written, no matter what git thinks is already there)

No, not "git reset --hard" either, I think. Git very much tries to avoid 
rewriting files, and if you've told it that file contents are stable, it 
will believe you.

In fact, I think people used CE_VALID explicitly for the missing parts of 
"partial checkouts", so if we'd suddenly start writing files despite them 
being marked as ok in the tree, I think we'd have broken that part.

(Although again - I'm not sure who would use CE_VALID and friends).

If you want to force everything to be rewritten, you should just remove 
the index (or remove the specific entries in it if you want to do it just 
to a particular file) and then do a "git checkout" to re-read and 
re-populate the tree.

But I'm not really seeing why you want to do this. If you told git that it 
shouldn't care about the working tree, why do you now want it do care?

			Linus
