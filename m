From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [COGITO PATCH] Fixing "cg-help typo" again
Date: Wed, 15 Jun 2005 01:43:33 +0200
Message-ID: <20050614234333.GA17152@diku.dk>
References: <1118791967.3890.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 01:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiKzO-000533-PC
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 01:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVFNXnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 19:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVFNXnh
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 19:43:37 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:64744 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261422AbVFNXne (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2005 19:43:34 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 72DFD6E22FA; Wed, 15 Jun 2005 01:42:38 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 39D2F6E22D7; Wed, 15 Jun 2005 01:42:38 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id E28DB61FE0; Wed, 15 Jun 2005 01:43:33 +0200 (CEST)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1118791967.3890.11.camel@dv>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pavel Roskin <proski@gnu.org> wrote Tue, Jun 14, 2005:
> Hello!

Hi,

> "cg-help typo" is broken again (same symptom - no output) because the
> print_help() output is piped through colorize(), which never fails.

Sorry, I broke it in the cg-help colorization patch, and has already
sent a patch to pasky, off-list I am afraid ...
> 
> I don't know any way to get return status of the first command in a
> pipeline, so I changed to code to put print_help() output in a variable,
> check status and then pipe the variable contents through colorize().

Use the PIPESTATUS aray as in the patch I sent:

@@ -59,7 +59,8 @@ colorize() {
 
 if [ "$ARGS" ]; then
 	cmd=$(echo "${ARGS[0]}" | sed 's/^cg-//')
-	( print_help $cmd | colorize ) && exit
+	print_help $cmd | colorize
+	[ "${PIPESTATUS[0]}" -eq 0 ] && exit
 	echo "cg-help: no help available for command \"${ARGS[0]}\""
 	echo "Call cg-help without any arguments for the list of available commands"
 	exit 1

-- 
Jonas Fonseca
