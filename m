From: Ka-Hing Cheung <kcheung@riverbed.com>
Subject: git svn clone -r HEAD
Date: Thu, 16 Jul 2009 12:12:12 -0700
Message-ID: <1247771532.7382.115.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 21:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRWWf-0000fV-2z
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 21:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933071AbZGPTVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 15:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933019AbZGPTVp
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 15:21:45 -0400
Received: from incomingmail.riverbed.com ([208.70.196.45]:58460 "EHLO
	smtp1.riverbed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439AbZGPTVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 15:21:45 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2009 15:21:45 EDT
Received: from unknown (HELO tlssmtp) ([10.16.4.52])
  by smtp1.riverbed.com with ESMTP; 16 Jul 2009 12:12:15 -0700
Received: from [10.35.98.21] (unknown [216.52.20.2])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tlssmtp (Postfix) with ESMTP id A621B6B943;
	Thu, 16 Jul 2009 12:14:45 -0700 (PDT)
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123416>

Hi (not subscribed),

git-svn uses $ra->get_latest_revnum to find out the latest revision, but
that can be problematic, because get_latest_revnum returns the latest
revnum in the entire repository, not restricted by whatever URL you used
to construct $ra. So if you do git svn clone -r HEAD
svn://blah/blah/trunk, it won't work if the latest checkin is in one of
the branches (it will try to fetch a rev that doesn't exist in trunk,
making the clone useless).

This change seems to work, sorry it's not a proper diff:
@sub fetch_all {
-       my $head = $ra->get_latest_revnum;
+       my $head = undef;
+       $ra->get_log("", -1, 0, 1, 0, 1, sub { $head = $_[1] });

-khc
