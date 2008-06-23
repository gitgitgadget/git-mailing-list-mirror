From: <Patrick.Higgins@cexp.com>
Subject: RE: [PATCH/RFC] Bugfix for AIX tmpfile creation
Date: Mon, 23 Jun 2008 17:07:30 -0600
Message-ID: <911589C97062424796D53B625CEC0025E46183@USCOBRMFA-SE-70.northamerica.cexp.com>
References: <alpine.LFD.1.10.0806231552510.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
To: <torvalds@linux-foundation.org>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:08:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAv99-0008Lz-Q1
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 01:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYFWXHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 19:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbYFWXHc
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 19:07:32 -0400
Received: from mx02.cexp.com ([170.131.136.83]:3308 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbYFWXHa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 19:07:30 -0400
Received: from uscobrmfa-se-05 (uscobrmfa-se-05.cexp.com [170.131.144.36])
	by mx02.cexp.com (Postfix) with ESMTP id 1AA9C41594C
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 17:07:30 -0600 (MDT)
Received: from USCOBRMFA-SE-70.northamerica.cexp.com ([10.128.26.36]) by USCOBRMFA-SE-51.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 23 Jun 2008 17:07:30 -0600
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <alpine.LFD.1.10.0806231552510.2926@woody.linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH/RFC] Bugfix for AIX tmpfile creation
Thread-Index: AcjVhGPnUb7oq7JATt+vhouqYTYpKgAANReQ
X-OriginalArrivalTime: 23 Jun 2008 23:07:30.0396 (UTC) FILETIME=[E97191C0:01C8D585]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85950>

On Behalf Of Linus Torvalds
> To: Junio C Hamano
> 
> On Mon, 23 Jun 2008, Junio C Hamano wrote:
> >
> > Hmm, we have quite a few calls to mkstemp(), so adding the 
> workaround to
> > this specific call site does not scale well as a fix, I am afraid.
> 
> All other callers of mkstemp() always rewrite the _entire_ 
> path and don't 
> care about the result after failure (since it failed)
> 
> The new 'create_tmpfile()' usage was/is special in that it 
> re-uses the 
> path without recreating it all, just the final part.
> 
> So I think Patrick's patch is fine and sufficient. Maybe I 
> missed some in 
> my quick grep, but it does look ok, and the create_tmpfile() 
> usage really 
> was pretty special.

This is the only problem I've seen with it so far on AIX. I was really surprised because I hadn't seen any problems with any of the release candidates and had been using them all as they came out so I got lazy and didn't test the final release, but one of my co-workers let me know that it is broken this morning. Even the most basic things like git-add stopped working, and applying this small patch fixed all test cases. The irony is of course that I wanted 1.5.6 for the improved AIX support and the final release is completely broken on AIX!
