From: "Julian Phillips" <jp3@quantumfyre.co.uk>
Subject: [PU PATCH] Fix git fetch for very large ref counts
Date: Tue, 13 Feb 2007 01:21:38 +0000
Message-ID: <11713297014015-git-send-email-julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 02:28:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGmTB-0006ZR-1e
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 02:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965457AbXBMB2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 20:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965462AbXBMB2Y
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 20:28:24 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:37415 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965457AbXBMB2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 20:28:24 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Feb 2007 20:28:23 EST
Received: (qmail 25762 invoked by uid 103); 13 Feb 2007 01:21:41 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <jp3@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2553. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.023721 secs); 13 Feb 2007 01:21:41 -0000
Received: from unknown (HELO beast) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 13 Feb 2007 01:21:41 +0000
Received: by beast (sSMTP sendmail emulation); Tue, 13 Feb 2007 01:21:41 +0000
X-Mailer: git-send-email 1.4.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39474>

The updated git fetch in pu is vastly improved on repositories with very
large numbers of refs.  The time taken for a no-op fetch over ~9000 refs
drops from ~48m to ~0.5m.

However, before git fetch will actually run on a repository with ~9000
refs the calling interface between fetch and fetch--tool needs to be
changed.  The existing version passes the entire reflist on the command
line, which means that it is subject to the maxiumum environment size
passed to a child process by execve.

The following patches add a stdin based interface to fetch--tool allowing
the ~9000 refs to be passed without exceeding the environment limit.

--
Julian
