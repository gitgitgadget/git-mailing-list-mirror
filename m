From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support for large files on 32bit systems.
Date: Sun, 18 Feb 2007 18:44:29 -0800
Message-ID: <7vr6smc1de.fsf@assigned-by-dhcp.cox.net>
References: <20070217091310.GD21842@admingilde.org>
	<20070217093953.GE21842@admingilde.org>
	<20070217094959.GH27864@spearce.org>
	<alpine.LRH.0.82.0702170830280.31945@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 19 03:44:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIyWA-0000rN-0Q
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 03:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbXBSCob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 21:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbXBSCob
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 21:44:31 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59943 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbXBSCoa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 21:44:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219024429.ROEQ1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Feb 2007 21:44:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id REkV1W0181kojtg0000000; Sun, 18 Feb 2007 21:44:30 -0500
In-Reply-To: <alpine.LRH.0.82.0702170830280.31945@xanadu.home> (Nicolas
	Pitre's message of "Sat, 17 Feb 2007 08:32:06 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40095>

Nicolas Pitre <nico@cam.org> writes:

>> I think the only way to do with this is to have the Makefile detect
>> if -D_FILE_OFFSET_BITS=64 is required to be added to CFLAGS based on
>> some rule (e.g. uname output?), then add that to CFLAGS when needed.
>
> Why not simply defining _FILE_OFFSET_BITS=64 unconditionally?
>
> It certainly won't cause GIT to explode if compiled against something 
> else than glibc.

I like the simplicity of that approach.  Like this?

diff --git a/git-compat-util.h b/git-compat-util.h
index 105ac28..dd5f369 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1,6 +1,8 @@
 #ifndef GIT_COMPAT_UTIL_H
 #define GIT_COMPAT_UTIL_H
 
+#define _FILE_OFFSET_BITS 64
+
 #ifndef FLEX_ARRAY
 #if defined(__GNUC__) && (__GNUC__ < 3)
 #define FLEX_ARRAY 0
