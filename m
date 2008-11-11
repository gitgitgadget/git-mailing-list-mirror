From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 5/7] Add a method to get refs by object Id
Date: Tue, 11 Nov 2008 10:26:26 -0800
Message-ID: <20081111182626.GP2932@spearce.org>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-6-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzxyD-0004CV-E5
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 19:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbYKKS02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 13:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbYKKS02
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 13:26:28 -0500
Received: from george.spearce.org ([209.20.77.23]:38614 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbYKKS01 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 13:26:27 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D2D4838200; Tue, 11 Nov 2008 18:26:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1226095664-13759-6-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100667>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> @@ -952,6 +955,37 @@ public Ref peel(final Ref ref) {
>  	}
>  
>  	/**
> +	 * @return a map with all objects referenced by a peeled ref.
> +	 */
> +	public Map<AnyObjectId, Set<Ref>> getAllRefsByPeeledObjectId() {
> +		Map<String, Ref> allRefs = getAllRefs();
> +		Map<AnyObjectId, Set<Ref>> ret = new HashMap<AnyObjectId, Set<Ref>>(allRefs.size());
> +		for (Ref ref : allRefs.values()) {
> +			if (ref == null)
> +				continue;

How did we get a null Ref inside the allRefs collection?

> +			if (!ref.isPeeled()) {
> +				ref = peel(ref);
> +				allRefs.put(ref.getOrigName(), ref);

Hmm.  Mutating a HashMap while you are traversing it with an Iterator
is *not* a good idea.  Its a ConcurrentModificationException waiting
to happen.

-- 
Shawn.
