From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 05/11] Don't advertise HEAD from ReceivePack
Date: Tue, 21 Jul 2009 08:28:00 -0700
Message-ID: <20090721152800.GQ11191@spearce.org>
References: <1247343566-19025-1-git-send-email-spearce@spearce.org> <1247343566-19025-5-git-send-email-spearce@spearce.org> <1247343566-19025-6-git-send-email-spearce@spearce.org> <200907211722.09631.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:28:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHGE-0002YD-8U
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbZGUP2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbZGUP2A
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:28:00 -0400
Received: from george.spearce.org ([209.20.77.23]:35651 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbZGUP2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:28:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 643B7381FD; Tue, 21 Jul 2009 15:28:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200907211722.09631.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123666>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> l?rdag 11 juli 2009 22:19:20 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
> > index fd8aa86..1c490af 100644
> > --- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
> > +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
> > @@ -509,8 +509,11 @@ private void sendAdvertisedRefs() throws IOException {
> >  		adv.advertiseCapability(CAPABILITY_REPORT_STATUS);
> >  		if (allowOfsDelta)
> >  			adv.advertiseCapability(CAPABILITY_OFS_DELTA);
> > -		refs = db.getAllRefs();
> > +		refs = new HashMap<String, Ref>(db.getAllRefs());
> > +		final Ref head = refs.remove(Constants.HEAD);
> >  		adv.send(refs.values());
> > +		if (head != null && head.getName() == head.getOrigName())
> > +			adv.advertiseHave(head.getObjectId());
> 
> This relies on an implicit guarantee that == works here. Would equals cost
> too much? Or perhaps we should document this guarantee as part of the
> interface.

Ouch, good point, .equals would be better here.  Can you amend?
If its the only issue in the series just amend it to be .equals(),
if there are other things for me to fix I'll be happy to send an
updated patch.

-- 
Shawn.
