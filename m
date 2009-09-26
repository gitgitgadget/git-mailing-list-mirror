From: Jason Merrill <jason@redhat.com>
Subject: Re: git clone sending unneeded objects
Date: Sat, 26 Sep 2009 09:33:12 -0400
Message-ID: <4ABE1818.6010007@redhat.com>
References: <m2tz0j154o.fsf@igel.home> <alpine.LFD.2.00.0908082246020.440@xanadu.home> <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com> <vpqvdj6izt6.fsf@bauges.imag.fr> <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com> <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com> <4ABD9C2C.60800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Hin-Tak Leung <hintak.leung@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 15:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrXOu-0000Hr-5p
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 15:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbZIZNdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 09:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbZIZNdO
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 09:33:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7365 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbZIZNdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 09:33:14 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8QDXDX6020419;
	Sat, 26 Sep 2009 09:33:13 -0400
Received: from [IPv6:::1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8QDXCb0025578;
	Sat, 26 Sep 2009 09:33:12 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.4pre) Gecko/20090924 Shredder/3.0pre
In-Reply-To: <4ABD9C2C.60800@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129153>

On 09/26/2009 12:44 AM, Jason Merrill wrote:
> git config remote.origin.fetch 'refs/remotes/*:refs/remotes/origin/*'
> git fetch

git count-objects -v before:

count: 44
size: 1768
in-pack: 1399509
packs: 1
size-pack: 600456
prune-packable: 0
garbage: 0

and after (transferred 278MB):

count: 44
size: 1768
in-pack: 1947339
packs: 2
size-pack: 1178408
prune-packable: 8
garbage: 0

and then after git gc --prune=now:

count: 0
size: 0
in-pack: 1399613
packs: 1
size-pack: 839900
prune-packable: 0
garbage: 0

So I only actually needed 104 more objects, but fetch wasn't clever 
enough to see that, and my new pack is much less efficient.

I've run into the same issue using alternates to set up multiple working 
directories for different branches; if the alternate directory isn't 
completely up-to-date, fetch wants to pull down lots of data again 
rather than use what I have and only fetch the last one or two commits.

Jason
