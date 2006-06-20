From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] gitweb: Use $hash_base as $search_hash if possible
Date: Tue, 20 Jun 2006 16:41:05 +0300
Message-ID: <20060620164105.7276a45f.tihirvon@gmail.com>
References: <20060620152515.23e59396.tihirvon@gmail.com>
	<7v64iw80uo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 15:42:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsgU1-0006f0-Th
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 15:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWFTNla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 09:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWFTNla
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 09:41:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:32107 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750944AbWFTNla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 09:41:30 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1407214nfa
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 06:41:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=II0KlxeJW7jpoODXgPWut4nRNaAxidUHfg4TTJGNgLpGa97IXUJz/WNnl0Sfi9Z/1C8VcwQa/ADDeHa8ZMrrQXV3HYLN2r7ahjz1V/eApHZBEvuc4yPuFu/Br5rw9MLE1EIan/QKY1wiRSKWrDxiZDxelkuKsL5ez1tDOoSiL6A=
Received: by 10.49.36.1 with SMTP id o1mr6651025nfj;
        Tue, 20 Jun 2006 06:41:28 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id y24sm6821731nfb.2006.06.20.06.41.27;
        Tue, 20 Jun 2006 06:41:28 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64iw80uo.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22201>

$hash (h parameter) does not always point to a commit. Use $hash_base as
$search_hash when it is defined.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---

  Junio C Hamano <junkio@cox.net> wrote:
  
  > Timo Hirvonen <tihirvon@gmail.com> writes:
  > 
  > > Starting search from whatever the current "h" parameter points to is
  > > wrong.  Sometimes it doesn't give all the expected results or may even
  > > fail if h points to an object which is not a commit.
  > 
  > If h is not a commit, perhaps, but wouldn't you expect it to
  > find things from "next" branch if "h" points at it?

  I did not change it to start search from tip of the branch. The
  current behavior is somewhat confusing but at least it is consistent
  with rest of gitweb.  For example clicking shortlog link from commit
  view shows the current commit at top of the list, not tip of the
  current branch.

 gitweb/gitweb.cgi |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 78e6dd0..7318512 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -293,7 +293,9 @@ EOF
 			$searchtext = "";
 		}
 		my $search_hash;
-		if (defined $hash) {
+		if (defined $hash_base) {
+			$search_hash = $hash_base;
+		} elsif (defined $hash) {
 			$search_hash = $hash;
 		} else {
 			$search_hash  = "HEAD";
-- 
1.4.0.gd281
