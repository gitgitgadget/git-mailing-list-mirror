From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Quick merge status updates.
Date: Sun, 2 Jul 2006 17:00:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607021655440.12404@g5.osdl.org>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net> <1151471040.4940.17.camel@dv>
 <7v7j3164xd.fsf@assigned-by-dhcp.cox.net> <1151489103.28036.6.camel@dv>
 <20060702204906.GG29115@pasky.or.cz> <7v64if3d50.fsf@assigned-by-dhcp.cox.net>
 <20060702214931.GJ29115@pasky.or.cz> <7vveqf1v05.fsf@assigned-by-dhcp.cox.net>
 <7vejx31sav.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 02:00:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxBrx-0002NN-9B
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 02:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWGCAAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 20:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWGCAAt
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 20:00:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750775AbWGCAAt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 20:00:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6300enW002212
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Jul 2006 17:00:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6300eqA028318;
	Sun, 2 Jul 2006 17:00:40 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejx31sav.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23138>



On Sun, 2 Jul 2006, Junio C Hamano wrote:
> Yuck; that means we would need to have something evil like this.

That's just disgusting.

How about a _much_ simpler approach.

Just make it do

	BEGIN { push ENV{'GIT_PERL_EXEC_DIR'}; }

And then simply _require_ that the setup code sets up GIT_PERL_EXEC_DIR.

Which is usually simple enough to do. For git.c, something like this will 
do it, other places you can reach things through can have something 
similar.

		Linus

---

diff --git a/git.c b/git.c
index ca8961f..e8f25ee 100644
--- a/git.c
+++ b/git.c
@@ -294,6 +294,7 @@ int main(int argc, const char **argv, ch
 		prepend_to_path(exec_path, strlen(exec_path));
 	exec_path = git_exec_path();
 	prepend_to_path(exec_path, strlen(exec_path));
+	setenv(exec_path, "GIT_PERL_EXEC_DIR", 0);
 
 	while (1) {
 		/* See if it's an internal command */
