From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: gc considered dangerous
Date: Sun, 8 Feb 2009 03:47:25 +0100
Message-ID: <200902080347.25970.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 08 15:07:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWAJR-0002MP-4q
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 15:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbZBHOF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 09:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbZBHOFZ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 09:05:25 -0500
Received: from mail.dewire.com ([83.140.172.130]:18129 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbZBHOFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 09:05:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 814B78026F9;
	Sun,  8 Feb 2009 15:05:19 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B0UiJhWpr0rz; Sun,  8 Feb 2009 15:05:17 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 840DC800258;
	Sun,  8 Feb 2009 03:47:27 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108976>


I've seen this. Running git gc on Windows, while having Elipse open can kill your
object database. 

Eclipse keeps the pack files open most of the time. Then you 
launch git gui which recommends the user to do a git gc. I never
do (it *always* wants to do this), so I haven't encountered the 
issue, but if gc doesn't find a new optimal pack it tries to rewrite a 
new pack with the same id. So it rm's the idx file (fine) and the the
pack file (not ok) and gives up, which means it has a .pack file with 
no index, so it cannot use it. Trying git gc again after eclipse exits 
will execute the final stab on your objects. 

The underlying bug is ofcource that Windows locks files when
they are open. A *nix* user does not suffer from this problem.

I'll investigate more at some other time. This is a preliminary
analysis.

-- robin
