From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH rev-list.c] max-count in terms of intersection
Date: Fri, 18 Nov 2005 13:47:22 -0800 (PST)
Message-ID: <20051118214722.4449.qmail@web31813.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Nov 18 22:47:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdE4s-0003M0-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 22:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbVKRVrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 16:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbVKRVrX
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 16:47:23 -0500
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:52093 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161257AbVKRVrX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 16:47:23 -0500
Received: (qmail 4451 invoked by uid 60001); 18 Nov 2005 21:47:22 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HpKaCjs9PjKr6bIf0wsIDc6q6TMsjZBTl7CNvbS07fyTvlaInykxLpcodfEulMofWQ69eiib8atyQRQVbQ1jqT6/9fdaM4PDD3nCEbLbzbnr4PWV2aSkCYARvgBCbWupBhLwm19m+L26NkeK+BRsg69dkc5/zRdNrBnJQndn6dw=  ;
Received: from [68.221.46.29] by web31813.mail.mud.yahoo.com via HTTP; Fri, 18 Nov 2005 13:47:22 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12267>

diff-tree 768b79de9eadc38a839332df0fcce021f7174d6d (from 2e67a5f449f4026097494569f871d79bf263ab28)
tree 6403fc730f8d5843043788f4c2f466727ba94bc0
parent 2e67a5f449f4026097494569f871d79bf263ab28
author Luben Tuikov <ltuikov@yahoo.com> 1132349344 -0500
committer Luben Tuikov <ltuikov@yahoo.com> 1132349344 -0500

    [PATCH rev-list.c] max-count in terms of intersection
    
    When a path designation is given, max-count counts the number
    of commits therein (intersection), not globally.
    
    This avoids the case where in case path has been inactive
    for the last N commits, --max-count=N and path designation
    at git-rev-list is given, would give no commits.
    
    Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

diff --git a/rev-list.c b/rev-list.c
index 6e6ffde..e17f928 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -124,8 +124,6 @@ static int filter_commit(struct commit *
                stop_traversal=1;
                return CONTINUE;
        }
-       if (max_count != -1 && !max_count--)
-               return STOP;
        if (no_merges && (commit->parents && commit->parents->next))
                return CONTINUE;
        if (paths && dense) {
@@ -148,6 +146,9 @@ static int process_commit(struct commit 
                return CONTINUE;
        }
 
+       if (max_count != -1 && !max_count--)
+               return STOP;
+
        show_commit(commit);
 
        return CONTINUE;
