From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 15:09:27 +0200
Message-ID: <4AAE4087.5030607@viscovery.net>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>	 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>	 <20090914105750.GB9216@sigill.intra.peff.net>	 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>	 <20090914120311.GA17172@sigill.intra.peff.net> <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 15:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBJH-0002og-Tm
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbZINNJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbZINNJ1
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:09:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:24022 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbZINNJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:09:26 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MnBJ9-0005WV-FJ; Mon, 14 Sep 2009 15:09:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 43BEA9F88; Mon, 14 Sep 2009 15:09:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128456>

Erik Faye-Lund schrieb:
> Compiling the following code gives a warning about unreachable code,
> so it's clear that msvc doesn't simply ignore the directive. I'm not
> saying that anyone suggested otherwise, I just wanted to know for
> sure.
> 
> #include <stdio.h>
> #include <stdlib.h>
> void (*exit_fun)(int) = exit;
> void __declspec(noreturn) die(void);
> void die(void) { exit_fun(1); }
> int main(void) { printf("hello!\n"); die(); printf("world!\n"); }

In order to countermand any clever optimizations you should make it

-void (*exit_fun)(int) = exit;
+extern void (*exit_fun)(int);

(of course, this fails to link). But if this results in only *one* warning
(that the printf() call is unreachable), then I wouldn't bother with this
problem anymore, because you really should also have been warned that a
__declspec(noreturn) function actually does return.

-- Hannes
