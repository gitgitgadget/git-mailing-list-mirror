From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 1/3] Implement the patience diff algorithm
Date: Wed, 7 Jan 2009 10:59:03 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071056470.3057@localhost.localdomain>
References: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp>
 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
 <20090107143926.GB831@artemis.corp> <alpine.DEB.1.00.0901071610290.7496@intel-tinevez-2-302> <alpine.DEB.1.00.0901071802190.7496@intel-tinevez-2-302> <alpine.DEB.1.10.0901071001360.16651@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 20:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKddy-0006Rt-3u
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 20:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677AbZAGS7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 13:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbZAGS7S
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 13:59:18 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40986 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752491AbZAGS7R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 13:59:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07Ix472019103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 10:59:05 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07Ix4fd017059;
	Wed, 7 Jan 2009 10:59:04 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.10.0901071001360.16651@alien.or.mcafeemobile.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104821>



On Wed, 7 Jan 2009, Davide Libenzi wrote:
> 
> xdiff allows for diffing ranges, and the most efficent method is exactly 
> how you did ;)

No, the performance problem is how it needs to re-hash everything. xdiff 
doesn't seem to have any way to use a "subset of the hash", so what the 
patience diff does is to use a subset of the mmfile, and then that will 
force all the rehashing to take place, which is kind of sad.

It would be nice (for patience diff) if it could partition the _hashes_ 
instead of partitioning the _data_. That way it wouldn't need to rehash. 
See?

		Linus
