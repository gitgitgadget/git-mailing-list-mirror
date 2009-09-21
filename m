From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGit 1/5] adding tests for ObjectDirectory
Date: Mon, 21 Sep 2009 12:30:49 -0700
Message-ID: <20090921193049.GL14660@spearce.org>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com> <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "mike.gaffney" <mike.gaffney@asolutions.com>
To: mr.gaffo@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 21 21:30:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpob9-00071z-Ci
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 21:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbZIUTaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 15:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbZIUTaq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 15:30:46 -0400
Received: from george.spearce.org ([209.20.77.23]:33943 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbZIUTap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 15:30:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B2F58381FF; Mon, 21 Sep 2009 19:30:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128903>

mr.gaffo@gmail.com wrote:
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
> +	private File testDir;
> +
> +	@Override
> +	protected void setUp() throws Exception {
> +		testDir = new File(new File(System.getProperty("java.io.tmpdir")), UUID.randomUUID().toString());
> +	}

Can't we use the same logic we use in RepositoryTestCase to create
the temporary directory for this test?  I would rather keep the
temporary space under target/ when testing under Maven, as it
makes it far easier to clean up the directory.  Plus we know we
have sufficient write space there.

> +	@Override
> +	protected void tearDown() throws Exception {
> +		if (testDir.exists()){

Style nit: Space between ) and {

> +	public void testExistsWithNonExistantDirectory() throws Exception {
> +		assertFalse(new ObjectDirectory(new File("/some/nonexistant/file")).exists());

Please create a path name below your testDir which you know won't
exist.  I don't want this test to rely upon the fact that some
absolute path doesn't exist that is outside of our namespace control.

> +	private void createTestDir(){

You use this method once, inline it inside
testExistsWithExistingDirectory().

Otherwise, the test case is OK, but is still quite sparse with
regards to functionality of the class being tested.  Was it your
intention to only cover the most basic parts at this time?  Its more
coverage than we have now, so I'm happy, but just wanted to point
out it certainly isn't complete (e.g. no pack support).

-- 
Shawn.
