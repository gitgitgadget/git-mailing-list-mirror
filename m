From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 08:19:28 +0300
Message-ID: <20070301051928.GH57456@codelabs.ru>
References: <20070228151516.GC57456@codelabs.ru> <87tzx6i6hw.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Thu Mar 01 06:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMdhY-00017M-NP
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 06:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbXCAFTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 00:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbXCAFTf
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 00:19:35 -0500
Received: from pobox.codelabs.ru ([144.206.177.45]:61125 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932652AbXCAFTf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 00:19:35 -0500
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HMdhV-000GPQ-D0; Thu, 01 Mar 2007 08:19:33 +0300
Content-Disposition: inline
In-Reply-To: <87tzx6i6hw.fsf@mid.deneb.enyo.de>
X-Spam-Status: No, score=-2.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41038>

Florian, good day!

> > Spotted the memory overrun in the http-push.c. Exists at least in
> > 1.5.0.x, not sure about latest development branch. The patch is
> > attached.
> 
> Is this issue security-relevant?  After all, the misplaced pointer is
> dereferenced and written to.

It can be relevant: basically, it is the heap overflow, because
'url' is allocated by xmalloc. Did not tried to exploit it, but
old sudo exploit proved that even one byte off memory dereference
can be exploited. But this particular exploit will work only for
the URLs where the 'path' is shorter than 10 bytes. And I doubt
that many people are running http-push in the set-uid mode, so
the exploit target will be the person running git-push over HTTP,
not the root user. But it does not mean that this is not an issue.

Sorry for the long letter.
-- 
Eygene
