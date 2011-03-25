From: "Schalk, Ken" <ken.schalk@intel.com>
Subject: RE: [PATCH 1/3] t3030: fix accidental success in symlink rename
Date: Fri, 25 Mar 2011 11:25:32 -0700
Message-ID: <EF9FEAB3A4B7D245B0801936B6EF4A251C397FCE@azsmsx503.amr.corp.intel.com>
References: <20110325160013.GA25851@sigill.intra.peff.net>
 <20110325160326.GA26635@sigill.intra.peff.net>
 <7v1v1v6qs2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:25:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Bhg-0006Cv-LO
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 19:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab1CYSZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 14:25:38 -0400
Received: from mga14.intel.com ([143.182.124.37]:40904 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525Ab1CYSZh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 14:25:37 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 25 Mar 2011 11:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.63,244,1299484800"; 
   d="scan'208";a="408768497"
Received: from azsmsx603.amr.corp.intel.com ([10.2.161.23])
  by azsmga001.ch.intel.com with ESMTP; 25 Mar 2011 11:25:35 -0700
Received: from azsmsx602.amr.corp.intel.com (10.2.121.201) by
 azsmsx603.amr.corp.intel.com (10.2.161.23) with Microsoft SMTP Server (TLS)
 id 8.2.255.0; Fri, 25 Mar 2011 11:25:35 -0700
Received: from azsmsx503.amr.corp.intel.com ([10.2.121.76]) by
 azsmsx602.amr.corp.intel.com ([10.2.121.201]) with mapi; Fri, 25 Mar 2011
 11:25:34 -0700
Thread-Topic: [PATCH 1/3] t3030: fix accidental success in symlink rename
Thread-Index: AcvrFAQ8iTujQsaoQLyf6lI5GnCVKwABYB7Q
In-Reply-To: <7v1v1v6qs2.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170012>

> > The results for the test indicate that the merge should
> > succeed, but also that "a" should no longer exist. Since
> > both sides renamed "a" to the same destination, we will end
> > up comparing those destinations for content.

> > But what about what's left? One side (the rename only),
> > replaced "a" with nothing. The other side replaced it with a
> > symlink. The common base must also be nothing, because any
> > "a" before this was meaningless (it was totally unrelated
> > content that ended up getting renamed).

> > The only sensible resolution is to keep the symlink.

> I agree.

> We should treat structural changes and do a 3-way on that, and then
> another 3-way on content changes, treating them as an independent
> thing.
> One side has "create 'e' out of 'a', removing 'a'" and "_create_ 'a',
> that
> is unrelated to the original 'a'", the other side has "create 'e' out
> of
> 'a', removing 'a'", so the end result should be that we do both,
> i.e. "create 'e' out of 'a', removing 'a'" and "create 'a'".  At the
> content level, the result in 'e' may have to be decided by 3-way.  The
> result in 'a' should be a clean merge taken from the former "with b/c
> link" branch, as this is not even a create (by the side that added a
> backward compatibility symbolic link) vs a delete (by pure-rename side)
> conflict.

I completely agree, keeping the symlink would be the right thing to do.  When I worked on the patch which added that test, my only concern was eliminating the rename/add conflict on "e" (which seemed pointless, since the content of "e" was identical in both branches).

--Ken Schalk
