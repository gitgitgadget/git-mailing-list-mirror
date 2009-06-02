From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] Add USER environment variable to executed git commands
	when serving
Date: Tue, 2 Jun 2009 15:56:59 +0200
Message-ID: <20090602135659.GA4320@macbook.lan>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tv@eagain.net
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBUUI-0002zH-Sm
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 15:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbZFBN5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 09:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbZFBN5A
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 09:57:00 -0400
Received: from darksea.de ([83.133.111.250]:38739 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753458AbZFBN5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 09:57:00 -0400
Received: (qmail 9085 invoked from network); 2 Jun 2009 15:56:51 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 2 Jun 2009 15:56:51 +0200
Content-Disposition: inline
In-Reply-To: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120511>

This is useful if you want to implement access rights by branchname.
The update hook can check this variable and react accordingly.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Tue, Jun 02, 2009 at 09:32:40AM +0530, Sitaram Chamarty wrote:
> I'd like it to set an additional env var which will contain "username"
> so that hooks etc can get that info and use it as they they see fit.

Here is a trivial patch. This is totally untested as I wanted to
implement something similar but never had the time to work more on it.

cheers Heiko

 gitosis/serve.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitosis/serve.py b/gitosis/serve.py
index 867249e..0e2c4af 100644
--- a/gitosis/serve.py
+++ b/gitosis/serve.py
@@ -201,6 +201,7 @@ class Main(app.App):
             sys.exit(1)
 
         main_log.debug('Serving %s', newcmd)
+        os.putenv('USER', user)
         os.execvp('git', ['git', 'shell', '-c', newcmd])
         main_log.error('Cannot execute git-shell.')
         sys.exit(1)
-- 
1.6.2.1.424.g0b27.dirty
