From: Jeff King <peff@peff.net>
Subject: Re: How do I resolve conflict after popping stash without adding the
 file to index?
Date: Tue, 21 Apr 2015 18:52:29 -0400
Message-ID: <20150421225228.GB26322@peff.net>
References: <5535697E.2030204@yandex.ru>
 <xmqqsibujyit.fsf@gitster.dls.corp.google.com>
 <553583C0.6090404@yandex.ru>
 <20150421212922.GC13230@peff.net>
 <5536D099.1000103@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Gutov <dgutov@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Apr 22 00:52:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykh1y-0007xI-So
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 00:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbbDUWwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 18:52:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:48347 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965256AbbDUWwb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 18:52:31 -0400
Received: (qmail 10069 invoked by uid 102); 21 Apr 2015 22:52:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 17:52:31 -0500
Received: (qmail 5647 invoked by uid 107); 21 Apr 2015 22:52:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 18:52:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2015 18:52:29 -0400
Content-Disposition: inline
In-Reply-To: <5536D099.1000103@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267566>

On Wed, Apr 22, 2015 at 01:35:05AM +0300, Dmitry Gutov wrote:

> >But we seem to skip that safety valve when the content has been staged,
> >which seems questionable to me (technically we are slightly better off
> >than the protected case because "bbbbb" was written to a git blob
> >object, so you can recover it.  But it may be difficult to find the
> >correct blob in the object database).
> 
> Any suggestions how to restore that content in the index programmatically?
> If it's non-trivial to do, maybe that is indeed a bug, and 'git stash pop'
> should abort before creating the conflict.

Right, I am suggesting that latter: that stash should abort if the index
has modified entries. The abort for modified working tree files is done
by git-merge, which can be selective about which entries will be changed
(since it knows which ones need written).  I haven't thought hard enough
to say whether it should be doing the same for the index (i.e., whether
this is a "merge" problem or a "stash" problem).

-Peff
