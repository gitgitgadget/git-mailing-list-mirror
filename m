From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [JGIT] help needed to create a siimple commit
Date: Tue, 3 Feb 2009 12:07:33 +0100
Message-ID: <551f769b0902030307s2a9204cch7967df17c1f2c8a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 12:10:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUJ9f-0004LZ-95
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 12:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbZBCLHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 06:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbZBCLHg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 06:07:36 -0500
Received: from mail-bw0-f12.google.com ([209.85.218.12]:33092 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbZBCLHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 06:07:35 -0500
Received: by bwz5 with SMTP id 5so1824785bwz.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 03:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=75rwCpzYOiQspdx1poj96JTVUXqb0y4BvGZXQLSfFDk=;
        b=T6kZ7f552JZ7Z3rDJLO503pvyfnywrgJJ8ju0XSRY1Ve0AmEMeASc1vNRn6AfOJDav
         Lo6VtzOFV8Xt7lb55ec88Dst8Hb/I4ndaQuFlDGsyrnt4tpEbpqBuAJT5qTUhl33hFIP
         O5JVJHc2VZacPscb/kYitmMD7BtyIyoUhJ+rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=PMhc0bVKppQZL7+3sYmMDjDVexyF5t1p2rs7TqcTU6DURDvLBazvoaLxpldfdDUmJC
         FhHI42to/S0UsGOkp8icfzdaZtm5M5+vzSx7qHThY2lr1/1bcnhBf3/PG0dc6YzpGkO1
         qCu5T7YZTGjJe6VUAEs/jh4dnNvPHmso4n/XU=
Received: by 10.223.114.68 with SMTP id d4mr4203812faq.86.1233659253638; Tue, 
	03 Feb 2009 03:07:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108178>

Hi,

I wrote the following unit test to learn how to make a commit with JGIT:

package org.spearce.jgit.lib;

import java.io.File;
import java.io.IOException;

public class CommitTest extends RepositoryTestCase {

	public void testASimpleCommit() throws IOException {
		
		GitIndex index = new GitIndex(db);
		index.filemode = Boolean.TRUE;
		
		File file;
		file = writeTrashFile("file1", "file1");
		
		index.add(trash, file);
		index.write();
		ObjectId objectId = index.writeTree();
		Tree tree = db.mapTree(objectId);
		tree.accept(new WriteTree(trash, db), TreeEntry.MODIFIED_ONLY);
		
		final Commit c1 = new Commit(db);
		c1.setAuthor(new PersonIdent(jauthor, 1154236443000L, -4 * 60));
		c1.setCommitter(new PersonIdent(jcommitter, 1154236443000L, -4 * 60));
		c1.setMessage("A Commit\n");
		c1.setTree(tree);
		assertEquals(tree.getTreeId(), c1.getTreeId());
		c1.commit();
		
	}
}

But the result is not brillant.
In the trash workspace, git log does not show me my commit.
git diff --cached shows me that my file is in the index but not committed...

Thank for the help.

Yann
