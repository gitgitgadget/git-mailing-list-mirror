From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 0/2] graph API: improve printing of merges
Date: Sun,  1 Jun 2008 13:56:56 -0700
Message-ID: <1212353818-7031-1-git-send-email-adam@adamsimpkins.net>
References: <20080529085752.GA31865@adamsimpkins.net>
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 22:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ucn-0004dG-9Q
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 22:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbYFAU5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 16:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbYFAU5F
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 16:57:05 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:52360 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbYFAU5D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 16:57:03 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 991BF1B4072;
	Sun,  1 Jun 2008 16:57:00 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 715D41B4003;
	Sun,  1 Jun 2008 16:57:00 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id A828614100CD; Sun,  1 Jun 2008 13:56:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc0.54.g04bfd
In-Reply-To: <20080529085752.GA31865@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83466>

This is two minor patches to improve the display of merge commits in the
graph output.  The first fixes the "extra space" that appears sometimes,
as pointed out by Teemu Likonen.  I had previously posted 2 simple
options for fixing the problem, but neither one was best in all cases.
This patch is an improved version that dynamically chooses how the merge
commit should be displayed, based on the last line of the previous
commit's output.

For example, with the new changes, the code now prints:

$ git log --graph --pretty=format:%h -10 8d6afc1
M   8d6afc1
|\  
| M   f2fea68
| |\  
| M \   21dbe12
| |\ \  
M | \ \   41094b8
|\ \ \ \  
| M \ \ \   061ad5f
| |\ \ \ \  
| M \ \ \ \   fe041ad
| |\ \ \ \ \  
| | \ \ \ \ \     
| |  \ \ \ \ \    
| M-. \ \ \ \ \   cd1333d
| |\ \ \ \ \ \ \  
| | * | | | | | | cfcbd34
| | * | | | | | | 5398fed
| M | | | | | | |   539d84f
| |\ \ \ \ \ \ \ \  


The second patch improves the output for octopus merges, by avoiding
printing unnecessary padding lines before the commit when there aren't
any existing branch lines to the right of the merge.

Adam Simpkins (2):
  graph API: improve display of merge commits
  graph API: avoid printing unnecessary padding before some octopus
    merges

 graph.c |  123 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 101 insertions(+), 22 deletions(-)
