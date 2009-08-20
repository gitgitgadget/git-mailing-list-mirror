From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Ensure created test repositories use canonical paths
Date: Fri, 21 Aug 2009 00:35:10 +0200
Message-ID: <200908210035.10825.robin.rosenberg.lists@dewire.com>
References: <1250687891-17916-1-git-send-email-fonseca@diku.dk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Aug 21 00:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeGEK-000429-De
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 00:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425AbZHTWfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 18:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755419AbZHTWfP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 18:35:15 -0400
Received: from mail.dewire.com ([83.140.172.130]:9621 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322AbZHTWfM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 18:35:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A972D1494313;
	Fri, 21 Aug 2009 00:35:12 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iB0Rs52IDUjM; Fri, 21 Aug 2009 00:35:12 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.12])
	by dewire.com (Postfix) with ESMTP id 07AFA1434E80;
	Fri, 21 Aug 2009 00:35:11 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1250687891-17916-1-git-send-email-fonseca@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126654>

onsdag 19 augusti 2009 15:18:11 skrev Jonas Fonseca <fonseca@diku.dk>:
> Fixes breakage in the RepositoryCacheTest when running tests using:
> 
> 	mvn -f ./jgit-maven/jgit/pom.xml test
> 
> which in turn will lead to test repositories using paths, such as:
> 
> 	/path/to/jgit/./jgit-maven/jgit/trash/trash1250647279819.186/.git
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
>  .../org/spearce/jgit/lib/RepositoryTestCase.java   |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
> index b1adde9..d1aef78 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
> @@ -217,7 +217,7 @@ public void setUp() throws Exception {
>  		final String name = getClass().getName() + "." + getName();
>  		recursiveDelete(trashParent, true, name, false); // Cleanup old failed stuff
>  		trash = new File(trashParent,"trash"+System.currentTimeMillis()+"."+(testcount++));
> -		trash_git = new File(trash, ".git");
> +		trash_git = new File(trash, ".git").getCanonicalFile();
>  		if (shutdownhook == null) {
>  			shutdownhook = new Thread() {
>  				@Override
> @@ -307,7 +307,7 @@ protected Repository createNewEmptyRepo() throws IOException {
>  	protected Repository createNewEmptyRepo(boolean bare) throws IOException {
>  		final File newTestRepo = new File(trashParent, "new"
>  				+ System.currentTimeMillis() + "." + (testcount++)
> -				+ (bare ? "" : "/") + ".git");
> +				+ (bare ? "" : "/") + ".git").getCanonicalFile();
>  		assertFalse(newTestRepo.exists());
>  		final Repository newRepo = new Repository(newTestRepo);
>  		newRepo.create();

We use getCanonicalFile here and Repository.gitDir  is initialized with getAbsoluteDir. Does this work on all platforms?
Seems linux normalized things when you do things like, but I'm not sure that happens everywhere.

ln -s JGIT x;cd x;pwd;jev 'System.out.println(System.getProperty("user.dir"));'
/home/me/SW/x
/home/me/SW/JGIT


-- robin
