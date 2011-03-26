From: Holger Freyther <zecke@selfish.org>
Subject: Re: Unable to clone via git protocol / early EOF / index-pack failed
Date: Sat, 26 Mar 2011 17:34:31 +0000 (UTC)
Message-ID: <loom.20110326T183100-349@post.gmane.org>
References: <20110324102703.GH4534@prithivi.gnumonks.org> <loom.20110326T180713-801@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 18:35:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3XOc-0001Fa-FR
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 18:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab1CZRfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 13:35:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:56197 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197Ab1CZRfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 13:35:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q3XOE-00010y-2m
	for git@vger.kernel.org; Sat, 26 Mar 2011 18:35:06 +0100
Received: from 91-64-83-241-dynip.superkabel.de ([91.64.83.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 18:35:06 +0100
Received: from zecke by 91-64-83-241-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 18:35:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.64.83.241 (Mozilla/5.0 (X11; U; Linux i686; en-us) AppleWebKit/534.16+ (KHTML, like Gecko) Version/5.0 Safari/534.16+ Epiphany/2.30.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170060>

Holger Freyther <zecke <at> selfish.org> writes:


> It is a bit difficult to track all the processes that get started and what they
> should do and to figure out at which point the fd for the tcp socket is really
> closed.

If I do the below hack it is working fine. Adding a fflush(NULL).. or a
close(fileno(stdout)).. fsync... sched_yield() is not fixing it though.

diff --git a/upload-pack.c b/upload-pack.c
index 72aa661..4cd12c9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -695,6 +695,8 @@ static void upload_pack(void)
                get_common_commits();
                create_pack_file();
        }
+
+       sleep(1);
 }
 
 int main(int argc, char **argv)
