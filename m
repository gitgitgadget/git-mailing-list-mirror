From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGit 2/5] Create abstract method on ObjectDatabase for
	accessing the list of local pack files.
Date: Mon, 21 Sep 2009 12:40:35 -0700
Message-ID: <20090921194035.GM14660@spearce.org>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "mike.gaffney" <mike.gaffney@asolutions.com>
To: mr.gaffo@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 21 21:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpoka-0002Ay-UE
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 21:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbZIUTkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 15:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbZIUTkb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 15:40:31 -0400
Received: from george.spearce.org ([209.20.77.23]:58854 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbZIUTkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 15:40:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 628D738151; Mon, 21 Sep 2009 19:40:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128904>

mr.gaffo@gmail.com wrote:
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
> +	public void testListLocalPacksWhenThereIsAPack() throws Exception {
> +		createTestDir();
> +		File packsDir = new File(testDir, "pack");
> +		packsDir.mkdirs();

Why not allow the ObjectDirectory code to create the directory
before copying the pack into it?

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
> +	/**
> +	 * The list of Packs THIS repo contains

Don't you mean the list of packs this object database contains?
An object database may not be a git repository.  Though yes, the
common case is that it is a repository.

> +	 * @return List<PackFile> of package names contained in this repo. 
> +	 * 		   Should be an empty list if there are none.
> +	 */
> +	public abstract List<PackFile> listLocalPacks();

I think you should define this to be an unmodifiable list, not just
any list.  Its sad that the Java type system didn't support this
idea back when they added the new collections APIs.

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
> +	@Override
> +	public List<PackFile> listLocalPacks() {
> +		tryAgain1();
> +		return new ArrayList<PackFile>(Arrays.asList(packList.get().packs));

Instead of copying, why not return an unmodifiableList wrapped
around the array?  PackList will never modify its internal array.

-- 
Shawn.
