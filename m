From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/3] Implement the patience diff algorithm
Date: Wed, 7 Jan 2009 21:00:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901072056480.7496@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp>
 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
 <20090107143926.GB831@artemis.corp> <alpine.DEB.1.00.0901071610290.7496@intel-tinevez-2-302> <alpine.DEB.1.00.0901071802190.7496@intel-tinevez-2-302> <alpine.DEB.1.10.0901071001360.16651@alien.or.mcafeemobile.com>
 <alpine.LFD.2.00.0901071056470.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:03:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKec5-0005a2-Vo
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 21:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761599AbZAGUAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 15:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761593AbZAGUAt
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 15:00:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:60006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761578AbZAGUAs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 15:00:48 -0500
Received: (qmail invoked by alias); 07 Jan 2009 20:00:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 07 Jan 2009 21:00:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1976tt8Br97FujspwrIoZ9SqYtV714NzJkkRNaG0F
	JaVzVZhZpS1FXf
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LFD.2.00.0901071056470.3057@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104824>

Hi,

On Wed, 7 Jan 2009, Linus Torvalds wrote:

> On Wed, 7 Jan 2009, Davide Libenzi wrote:
> > 
> > xdiff allows for diffing ranges, and the most efficent method is 
> > exactly how you did ;)
> 
> No, the performance problem is how it needs to re-hash everything. xdiff 
> doesn't seem to have any way to use a "subset of the hash", so what the 
> patience diff does is to use a subset of the mmfile, and then that will 
> force all the rehashing to take place, which is kind of sad.
> 
> It would be nice (for patience diff) if it could partition the _hashes_ 
> instead of partitioning the _data_. That way it wouldn't need to rehash. 
> See?

Actually, for libxdiff (non-patience), this is not possible, as 
xdl_cleanup_records() rewrites the hashes so that they are in a contiguous 
interval (0, ..., N-1), where N is the number of distinct lines found.

I am also pretty certain that at least the non-patience part needs the 
maximum of that "hash" to be as small as possible.

Having said that, if Linus likes patience diff enough to want it faster, 
Dscho will improve the speed by avoiding the rehashing for the patience 
diff part (although the lines for which patience has to fall back to Myers 
diff will _still_ rehash, but that does not hurt _that_ much in practice).

Ciao,
Dscho
