From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: git-push and $GIT_DIR/branches
Date: Fri, 7 Nov 2008 09:26:29 +0100
Message-ID: <20081107082629.GA27158@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 09:49:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyN21-0005uW-RZ
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 09:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbYKGIsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 03:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbYKGIsO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 03:48:14 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:50652 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbYKGIsN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 03:48:13 -0500
X-Greylist: delayed 1301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Nov 2008 03:48:13 EST
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 0F1346841E27
	for <git@vger.kernel.org>; Fri,  7 Nov 2008 09:26:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rXUcey65kgAy for <git@vger.kernel.org>;
	Fri,  7 Nov 2008 09:26:29 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id E41C068009A8; Fri,  7 Nov 2008 09:26:29 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100296>

I think, that the git-push behaviour is a bit unlogical in conjunction
with $GIT_DIR/branches.

If $GIT_DIR/branches/name1 contains "<repository>#name2":
- git-fetch name1
  will fetch refs/heads/name2 from <repository> and store it in refs/he=
ads/name1
- git-push name1
  will push refs/heads/master to refs/heads/master in <repository>

I would expect, that git-push would somehow honour #name2. As far as I =
remember,
cg-push name1 would have pushed HEAD to refs/heads/name2 in <repository=
>.

In remote.c, function read_branches_file the following code
would implement a similar behaviour:
        strbuf_init(&push, 0);
        strbuf_addstr(&push, "HEAD");
        if (frag) {
                strbuf_addf(&push, ":refs/heads/%s", frag);
        } else
                strbuf_addstr(&push, ":refs/heads/master");
        add_push_refspec(remote, strbuf_detach(&push, 0));

Options about this?

mfg Martin K=F6gler
