From: YONETANI Tomokazu <qhwt+git@les.ath.cx>
Subject: 65c042d4 broke `remote update' without named group
Date: Wed, 30 Dec 2009 08:49:59 +0900
Message-ID: <20091229234959.GA94644@les.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 01:01:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPm01-0005JO-P9
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 01:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbZL3ABJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 19:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbZL3ABI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 19:01:08 -0500
Received: from x219233.ppp.asahi-net.or.jp ([122.249.219.233]:1637 "EHLO
	les.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbZL3ABH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 19:01:07 -0500
X-Greylist: delayed 665 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2009 19:01:07 EST
Received: by les.ath.cx (Postfix, from userid 1000)
	id A107E86654; Wed, 30 Dec 2009 08:49:59 +0900 (JST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135843>

Hello.
It seems that with 65c042d4 (and v1.6.6), git-remote update without
specifying a group on the command line ends up with the following error
message if you define remotes.default in the config file:
  $ git remote update
  fatal: 'default' does not appear to be a git repository
  fatal: The remote end hung up unexpectedly

The document still says that when you don't specify the named group,
remotes.default in the configuration will get used, so this should work
(and it used to work with v1.6.4).

After the commit 65c042d4, the commands are translated as follows:
  $ git remote update
  ==> git-fetch default		(with remotes.default defined)		NG
  ==> git-fetch --all		(without remotes.default defined)	OK

  $ git remote update default
  ==> git-fetch --multiple default					OK

So just adding "--multiple" in front of "default" in the first case
above should fix it.

Best regards,
YONETANI Tomokazu.
