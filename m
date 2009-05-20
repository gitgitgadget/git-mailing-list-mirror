From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/6] Make sure we get the right storage for
	loose/pack/loose and packed refs
Date: Wed, 20 May 2009 14:43:59 -0700
Message-ID: <20090520214359.GQ30527@spearce.org>
References: <20090507155117.GS30527@spearce.org> <1242774798-23639-1-git-send-email-robin.rosenberg@dewire.com> <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6ta3-0000Hc-A7
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 23:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbZETVn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 17:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbZETVn6
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 17:43:58 -0400
Received: from george.spearce.org ([209.20.77.23]:36784 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbZETVn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 17:43:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EC32F381FD; Wed, 20 May 2009 21:43:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1242774798-23639-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119635>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Also adds a few some more test for refs, though not complete.

Hmm, tests fail, wrong expected values?
 
> +	public void testReadSymRefToPacked() throws IOException {
> +		assertEquals(Ref.Storage.LOOSE, ref.getStorage());

Actual was LOOSE_PACKED.

> +	public void testReadSymRefToLoosePacked() throws IOException {
> +		assertEquals(Ref.Storage.LOOSE, ref.getStorage());

Actual was LOOSE_PACKED.

> +	public void testDeleteLoosePacked() throws IOException {
> +		ObjectId pid = db.resolve("refs/heads/master^");
> +		RefUpdate updateRef = db.updateRef("refs/heads/master");
> +		updateRef.setNewObjectId(pid);
> +		updateRef.setForceUpdate(true);
> +		Result update = updateRef.update();
> +		assertEquals(Result.FORCED, update); // internal
> +
> +		RefUpdate updateRef2 = db.updateRef("refs/heads/master");
> +		Result delete = updateRef2.delete();
> +		assertEquals(Result.FORCED, delete);

Actual was Result.REJECTED_CURRENT_BRANCH.

> @@ -349,12 +355,20 @@ private synchronized Ref readRefBasic(final String origName,
> +
> +		if (!origName.equals(name)) {
> +			ref = new Ref(Ref.Storage.LOOSE, origName, name, id);
> +			looseRefs.put(origName, ref);
> +		}

Seems fine, but I'm starting to hate our current way of handling
symrefs.  Not for this series.  But its starting to worry me.

-- 
Shawn.
