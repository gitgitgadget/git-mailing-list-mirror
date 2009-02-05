From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Compute the author/commiter name and email from the
 git configuration
Date: Thu, 05 Feb 2009 11:44:03 +0100
Message-ID: <498AC2F3.1010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 11:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV1jn-000697-9n
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 11:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbZBEKoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 05:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbZBEKoL
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 05:44:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:62464 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbZBEKoI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 05:44:08 -0500
Received: by fg-out-1718.google.com with SMTP id 16so119079fgg.17
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 02:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=camyrmawjDNWQ7Fzl529aBcaljobK4qacMNTU4isAR0=;
        b=Nayt8Rg+iRZOns/dZLyOB0nOV/1nuDPR1flk/2J22wfat1+Tg1Rbsxz70hqK4FSCio
         qdWhudWSB8GRTycvZLOORzktcBTma1FEZIdVnfXGElyhUIP307w7AktOBJrOP7OIBavP
         4GE0sjHC+VhZscjddWXVYdbhU54E0O3HUEh0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=YJiu3d1OikyEzBQ/hYHuK9PsEQ63jz2fi+MHyWc/40zLH6Blj63sRXkhdAWb795WKZ
         zvymbFeTcBGHnCAya7jMPO/NWyUvDjfSo4F7lA/WUDEyzjBqwaY2lKcrxvVQXZGNEfVI
         FD0RhN/6WUrMJ1YYsn1Unz6XuxR2vFYmSvQ+g=
Received: by 10.86.82.16 with SMTP id f16mr242880fgb.26.1233830645261;
        Thu, 05 Feb 2009 02:44:05 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 4sm942411fgg.55.2009.02.05.02.44.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 02:44:04 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108548>

The author/commiter name and email are retrieved from the system configuration
and the local and global git configurations.

When the name is not available, propose one default by using the system user name.

When the email is not available, propose one default by concatenating the
user name and the host name.

The author name and email are used as default value in the author field
while committing with the GUI.

Fix issue 47 (field Author don't fill)

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
Replace the last email.

This is the 3rd version of the patch.
I applied the received comments.
Changes between v2 and v3 of the patch:
- move the fakeSystemReader into RepositoryTestCase and fill it with default values.
- hange commiter -> committer.
- getHostName() never returns null. I used "localhost" when the host name is not available.
- the user name is set to a default one is no other information is available.
- change the way to form a default email using only the system property "user.name".
- add a copyright header to SystemReader. I did not know if I had to change the copyright to include my name.
I personally do not care about that.
- change SystemReader.getEnvironmentVariable to SystemReader.getenv to emulate System class.

 .../egit/ui/internal/actions/CommitAction.java     |   17 +++
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |   63 ++++++++++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   32 +++++
 .../src/org/spearce/jgit/lib/Constants.java        |   18 +++
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |  120 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/SystemReader.java    |   62 ++++++++++
 6 files changed, 312 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index 17232d6..456745c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -41,6 +41,7 @@
 import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.RefUpdate;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryConfig;
 import org.spearce.jgit.lib.Tree;
 import org.spearce.jgit.lib.TreeEntry;
 import org.spearce.jgit.lib.GitIndex.Entry;
@@ -70,8 +71,10 @@ public void run(IAction act) {
 		}
 
 		Repository[] repos = getRepositoriesFor(getProjectsForSelectedResources());
+		Repository repository = null;
 		amendAllowed = repos.length == 1;
 		for (Repository repo : repos) {
+			repository = repo;
 			if (!repo.getRepositoryState().canCommit()) {
 				MessageDialog.openError(getTargetPart().getSite().getShell(),
 					"Cannot commit now", "Repository state:"
@@ -95,12 +98,26 @@ public void run(IAction act) {
 			}
 		}
 
+		assert repository != null;
+		RepositoryConfig repositoryConfig = repository.getConfig();
+		String author = null;
+		String username = repositoryConfig.getAuthorName();
+		if (username != null && username.length() != 0) {
+			author = username;
+			String email = repositoryConfig.getAuthorEmail();
+			if (email != null && email.length() != 0) {
+				author = author + " <" + email + ">";
+			}
+		}
+
 		loadPreviousCommit();
 
 		CommitDialog commitDialog = new CommitDialog(getTargetPart().getSite().getShell());
 		commitDialog.setAmending(amending);
 		commitDialog.setAmendAllowed(amendAllowed);
 		commitDialog.setFileList(files);
+		commitDialog.setAuthor(author);
+
 		if (previousCommit != null)
 			commitDialog.setPreviousCommitMessage(previousCommit.getMessage());
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
index 34ce04a..5c14e89 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryConfigTest.java
@@ -42,6 +42,8 @@
 
 import java.io.File;
 import java.io.IOException;
+import java.net.InetAddress;
+import java.net.UnknownHostException;
 import java.util.Arrays;
 import java.util.LinkedList;
 
@@ -116,4 +118,65 @@ public void test006_readCaseInsensitive() throws IOException {
 		assertEquals(true, repositoryConfig.getBoolean("foo", null, "bar", false));
 		assertEquals("", repositoryConfig.getString("foo", null, "bar"));
 	}
+
+	public void test007_readUserInfos() throws IOException {
+		String hostname;
+		try {
+			InetAddress localMachine = InetAddress.getLocalHost();
+			hostname = localMachine.getCanonicalHostName();
+		} catch (UnknownHostException e) {
+			hostname = "localhost";
+		}
+
+		final File globalConfig = writeTrashFile("global.config", "");
+		final File localConfig = writeTrashFile("local.config", "");
+		System.clearProperty(Constants.OS_USER_NAME_KEY);
+
+		RepositoryConfig globalRepositoryConfig = new RepositoryConfig(null, globalConfig);
+		RepositoryConfig localRepositoryConfig = new RepositoryConfig(globalRepositoryConfig, localConfig);
+		fakeSystemReader.values.clear();
+
+		String authorName;
+		String authorEmail;
+
+		// no values defined nowhere
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertEquals(Constants.UNKNOWN_USER_DEFAULT, authorName);
+		assertEquals(Constants.UNKNOWN_USER_DEFAULT + "@" + hostname, authorEmail);
+
+		// the system user name is defined
+		fakeSystemReader.values.put(Constants.OS_USER_NAME_KEY, "os user name");
+		authorName = localRepositoryConfig.getAuthorName();
+		assertEquals("os user name", authorName);
+
+		if (hostname != null && hostname.length() != 0) {
+			authorEmail = localRepositoryConfig.getAuthorEmail();
+			assertEquals("os user name@" + hostname, authorEmail);
+		}
+
+		// the git environment variables are defined
+		fakeSystemReader.values.put(Constants.GIT_AUTHOR_NAME_KEY, "git author name");
+		fakeSystemReader.values.put(Constants.GIT_AUTHOR_EMAIL_KEY, "author@email");
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertEquals("git author name", authorName);
+		assertEquals("author@email", authorEmail);
+
+		// the values are defined in the global configuration
+		globalRepositoryConfig.setString("user", null, "name", "global username");
+		globalRepositoryConfig.setString("user", null, "email", "author@globalemail");
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertEquals("global username", authorName);
+		assertEquals("author@globalemail", authorEmail);
+
+		// the values are defined in the local configuration
+		localRepositoryConfig.setString("user", null, "name", "local username");
+		localRepositoryConfig.setString("user", null, "email", "author@localemail");
+		authorName = localRepositoryConfig.getAuthorName();
+		authorEmail = localRepositoryConfig.getAuthorEmail();
+		assertEquals("local username", authorName);
+		assertEquals("author@localemail", authorEmail);
+	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 20348f1..4e56b38 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -46,11 +46,14 @@
 import java.io.OutputStreamWriter;
 import java.io.Reader;
 import java.util.ArrayList;
+import java.util.HashMap;
 import java.util.List;
+import java.util.Map;
 
 import junit.framework.TestCase;
 
 import org.spearce.jgit.util.JGitTestUtil;
+import org.spearce.jgit.util.SystemReader;
 
 /**
  * Base class for most JGit unit tests.
@@ -84,6 +87,28 @@
 
 	protected boolean packedGitMMAP;
 
+	protected static class FakeSystemReader implements SystemReader {
+		Map<String, String> values = new HashMap<String, String>();
+		public String getenv(String variable) {
+			return values.get(variable);
+		}
+		public String getProperty(String key) {
+			return values.get(key);
+		}
+	}
+
+	/**
+	 * Simulates the reading of system variables and properties.
+	 * Unit test can control the returned values by manipulating
+	 * {@link FakeSystemReader#values}.
+	 */
+	protected static FakeSystemReader fakeSystemReader;
+
+	static {
+		fakeSystemReader = new FakeSystemReader();
+		RepositoryConfig.setSystemReader(fakeSystemReader);
+	}
+
 	/**
 	 * Configure JGit before setting up test repositories.
 	 */
@@ -250,6 +275,13 @@ copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".idx"), new File(packDir,
 		copyFile(JGitTestUtil.getTestResourceFile("packed-refs"), new File(trash_git,"packed-refs"));
 
 		db.scanForPacks();
+
+		fakeSystemReader.values.clear();
+		fakeSystemReader.values.put(Constants.OS_USER_NAME_KEY, Constants.OS_USER_NAME_KEY);
+		fakeSystemReader.values.put(Constants.GIT_AUTHOR_NAME_KEY, Constants.GIT_AUTHOR_NAME_KEY);
+		fakeSystemReader.values.put(Constants.GIT_AUTHOR_EMAIL_KEY, Constants.GIT_AUTHOR_EMAIL_KEY);
+		fakeSystemReader.values.put(Constants.GIT_COMMITTER_NAME_KEY, Constants.GIT_COMMITTER_NAME_KEY);
+		fakeSystemReader.values.put(Constants.GIT_COMMITTER_EMAIL_KEY, Constants.GIT_COMMITTER_EMAIL_KEY);
 	}
 
 	protected void tearDown() throws Exception {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 8f093d6..b0a5b22 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -228,6 +228,24 @@
 	/** Packed refs file */
 	public static final String PACKED_REFS = "packed-refs";
 
+	/** The environment variable that contains the system user name */
+	public static final String OS_USER_NAME_KEY = "user.name";
+
+	/** The environment variable that contains the author's name */
+	public static final String GIT_AUTHOR_NAME_KEY = "GIT_AUTHOR_NAME";
+
+	/** The environment variable that contains the author's email */
+	public static final String GIT_AUTHOR_EMAIL_KEY = "GIT_AUTHOR_EMAIL";
+
+	/** The environment variable that contains the commiter's name */
+	public static final String GIT_COMMITTER_NAME_KEY = "GIT_COMMITTER_NAME";
+
+	/** The environment variable that contains the commiter's email */
+	public static final String GIT_COMMITTER_EMAIL_KEY = "GIT_COMMITTER_EMAIL";
+
+	/** Default value for the user name if no other information is available */
+	public static final String UNKNOWN_USER_DEFAULT = "unknown-user";
+
 	/**
 	 * Create a new digest function for objects.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 7df90cd..821d8be 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -50,6 +50,8 @@
 import java.io.InputStreamReader;
 import java.io.OutputStreamWriter;
 import java.io.PrintWriter;
+import java.net.InetAddress;
+import java.net.UnknownHostException;
 import java.util.ArrayList;
 import java.util.Collections;
 import java.util.HashMap;
@@ -60,6 +62,7 @@
 import java.util.Set;
 
 import org.spearce.jgit.util.FS;
+import org.spearce.jgit.util.SystemReader;
 
 /**
  * An object representing the Git config file.
@@ -98,8 +101,20 @@ public static RepositoryConfig openUserConfig() {
 
 	private Map<String, Object> byName;
 
+	private static String hostname;
+
 	private static final String MAGIC_EMPTY_VALUE = "%%magic%%empty%%";
 
+	// default system reader gets the value from the system
+	private static SystemReader systemReader = new SystemReader() {
+		public String getenv(String variable) {
+			return System.getenv(variable);
+		}
+		public String getProperty(String key) {
+			return System.getProperty(key);
+		}
+	};
+
 	RepositoryConfig(final Repository repo) {
 		this(openUserConfig(), FS.resolve(repo.getDirectory(), "config"));
 	}
@@ -308,6 +323,83 @@ public String getString(final String section, String subsection, final String na
 		return result;
 	}
 
+	/**
+	 * @return the author name as defined in the git variables
+	 *         and configurations. If no name could be found, try
+	 *         to use the system user name instead.
+	 */
+	public String getAuthorName() {
+		return getUsernameInternal(Constants.GIT_AUTHOR_NAME_KEY);
+	}
+
+	/**
+	 * @return the committer name as defined in the git variables
+	 *         and configurations. If no name could be found, try
+	 *         to use the system user name instead.
+	 */
+	public String getCommitterName() {
+		return getUsernameInternal(Constants.GIT_COMMITTER_NAME_KEY);
+	}
+
+	private String getUsernameInternal(String gitVariableKey) {
+		// try to get the user name from the local and global configurations.
+		String username = getString("user", null, "name");
+
+		if (username == null) {
+			// try to get the user name for the system property GIT_XXX_NAME
+			username = systemReader.getenv(gitVariableKey);
+		}
+		if (username == null) {
+			// get the system user name
+			username = systemReader.getProperty(Constants.OS_USER_NAME_KEY);
+		}
+		if (username == null) {
+			username = Constants.UNKNOWN_USER_DEFAULT;
+		}
+		return username;
+	}
+
+	/**
+	 * @return the author email as defined in git variables and
+	 *         configurations. If no email could be found, try to
+	 *         propose one default with the user name and the
+	 *         host name.
+	 */
+	public String getAuthorEmail() {
+		return getUserEmailInternal(Constants.GIT_AUTHOR_EMAIL_KEY);
+	}
+
+	/**
+	 * @return the committer email as defined in git variables and
+	 *         configurations. If no email could be found, try to
+	 *         propose one default with the user name and the
+	 *         host name.
+	 */
+	public String getCommitterEmail() {
+		return getUserEmailInternal(Constants.GIT_COMMITTER_EMAIL_KEY);
+	}
+
+	private String getUserEmailInternal(String gitVariableKey) {
+		// try to get the email from the local and global configurations.
+		String email = getString("user", null, "email");
+
+		if (email == null) {
+			// try to get the email for the system property GIT_XXX_EMAIL
+			email = systemReader.getenv(gitVariableKey);
+		}
+
+		if (email == null) {
+			// try to construct an email
+			String username = systemReader.getProperty(Constants.OS_USER_NAME_KEY);
+			if (username == null){
+				username = Constants.UNKNOWN_USER_DEFAULT;
+			}
+			email = username + "@" + getHostname();
+		}
+
+		return email;
+	}
+
 	private String getRawString(final String section, final String subsection,
 			final String name) {
 		final Object o = getRawEntry(section, subsection, name);
@@ -957,4 +1049,32 @@ private static boolean eq(final String a, final String b) {
 			return a.equalsIgnoreCase(b);
 		}
 	}
+
+	/**
+	 * Gets the hostname of the local host.
+	 * If no hostname can be found, the hostname is set to the default value "localhost".
+	 * @return the canonical hostname
+	 */
+	private static String getHostname() {
+		if (hostname == null) {
+			try {
+				InetAddress localMachine = InetAddress.getLocalHost();
+				hostname = localMachine.getCanonicalHostName();
+			} catch (UnknownHostException e) {
+				// we do nothing
+				hostname = "localhost";
+			}
+			assert hostname != null;
+		}
+		return hostname;
+	}
+
+	/**
+	 * Overrides the default system reader by a custom one.
+	 * @param newSystemReader new system reader
+	 */
+	public static void setSystemReader(SystemReader newSystemReader) {
+		systemReader = newSystemReader;
+	}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
new file mode 100644
index 0000000..4a9715f
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/SystemReader.java
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2009, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2009, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.util;
+
+/**
+ * Interface to read values from the system.
+ * <p>
+ * When writing unit tests, extending this interface with a custom class
+ * permits to simulate an access to a system variable or property.
+ * </p>
+ */
+public interface SystemReader {
+
+	/**
+	 * @param variable system variable to read
+	 * @return value of the system variable
+	 */
+	String getenv(String variable);
+
+	/**
+	 * @param key of the system property to read
+	 * @return value of the system property
+	 */
+	String getProperty(String key);
+
+}
-- 
1.6.0.4
