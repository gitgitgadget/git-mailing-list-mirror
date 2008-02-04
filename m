From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Clean up connection correctly if object fetch wasn't
 done
Date: Mon, 4 Feb 2008 16:06:41 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802041602020.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041326260.13593@iabervon.org> <alpine.LSU.1.00.0802042023160.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8X5-000247-IQ
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbYBDVGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbYBDVGn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:06:43 -0500
Received: from iabervon.org ([66.92.72.58]:59953 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbYBDVGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:06:42 -0500
Received: (qmail 26395 invoked by uid 1000); 4 Feb 2008 21:06:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Feb 2008 21:06:41 -0000
In-Reply-To: <alpine.LSU.1.00.0802042023160.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72570>

On Mon, 4 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> 
> > Further optimization allowed the fetch_objs call to be skipped if it 
> > isn't necessary. However, this leaves the connection in need of cleaning 
> > up to avoid getting an error message from the remote end when ssh is 
> > used. Fix this.
> 
> I _think_ something similar is necessary for ls-remote, too (at least it 
> showed the same symptoms today, but I have not had time to investigate 
> yet).

Yup, exactly the same change to builtin-ls-remote that builtin-fetch 
needed.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 6dd31d1..0237549 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -94,6 +94,7 @@ int cmd_ls_remote(int argc, const char **argv, const 
char *prefix)
                transport_set_option(transport, TRANS_OPT_UPLOADPACK, 
uploadpack);
 
        ref = transport_get_remote_refs(transport);
+       transport_disconnect(transport);
 
        if (!ref)
                return 1;
