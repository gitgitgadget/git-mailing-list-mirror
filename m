From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Dec 2009, #01; Tue, 01)
Date: Tue, 1 Dec 2009 23:50:43 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0912012340060.14365@iabervon.org>
References: <7vaay2tkfh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 05:50:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFhB3-0007TZ-Ol
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 05:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbZLBEui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 23:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZLBEuh
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 23:50:37 -0500
Received: from iabervon.org ([66.92.72.58]:33212 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbZLBEuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 23:50:37 -0500
Received: (qmail 27328 invoked by uid 1000); 2 Dec 2009 04:50:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Dec 2009 04:50:43 -0000
In-Reply-To: <7vaay2tkfh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134297>

On Tue, 1 Dec 2009, Junio C Hamano wrote:

> * sr/vcs-helper (2009-11-18) 12 commits
>   (merged to 'next' on 2009-11-27 at 83268ab)
>  + Add Python support library for remote helpers
>  + Basic build infrastructure for Python scripts
>  + Allow helpers to report in "list" command that the ref is unchanged
>  + Fix various memory leaks in transport-helper.c
>  + Allow helper to map private ref names into normal names
>  + Add support for "import" helper command
>  + Allow specifying the remote helper in the url
>  + Add a config option for remotes to specify a foreign vcs
>  + Allow fetch to modify refs
>  + Use a function to determine whether a remote is valid
>  + Allow programs to not depend on remotes having urls
>  + Fix memory leak in helper method for disconnect

The bottom one here now needs another hunk that reverts a free of the same 
memory (including in cases that this series will need to keep it) that 
snuck in unannounced with ef08ef9ea0a271e5be5844408d2496a946d6e8d9.

diff --git a/transport-helper.c b/transport-helper.c
index 5078c71..d729146 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -72,7 +72,6 @@ static int disconnect_helper(struct transport 
*transport)
                free(data->helper);
                data->helper = NULL;
        }
-       free(data);
        return 0;
 }
