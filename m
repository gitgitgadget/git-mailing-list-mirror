From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 7/3] Make index preloading check the whole path to the
 file
Date: Thu, 9 Jul 2009 20:40:09 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907092039140.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain> <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344530.3352@localhost.localdomain> <alpine.LFD.2.01.0907091347080.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907091348490.3352@localhost.localdomain> <7v8wixw7s0.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907092028480.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 05:40:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP6yG-00056J-Re
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 05:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbZGJDkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 23:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbZGJDkR
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 23:40:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40754 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325AbZGJDkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 23:40:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6A3eAnY012742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 20:40:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6A3e9Jl016496;
	Thu, 9 Jul 2009 20:40:10 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907092028480.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123034>



On Thu, 9 Jul 2009, Linus Torvalds wrote:
> 
> It should be memset() to zero. Good catch.

IOW, just this on top. It's the same initialization  that 'default_cache' 
has, except in the case of default_cahe it was implicit in the "static", 
which is why I missed it when I did the "obvious" version.

		Linus
---
 preload-index.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index c3462dc..14d5281 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -36,6 +36,7 @@ static void *preload_thread(void *_data)
 	struct cache_entry **cep = index->cache + p->offset;
 	struct cache_def cache;
 
+	memset(&cache, 0, sizeof(cache));
 	nr = p->nr;
 	if (nr + p->offset > index->cache_nr)
 		nr = index->cache_nr - p->offset;
