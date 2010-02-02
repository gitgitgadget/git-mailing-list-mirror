From: Markus Elfring <Markus.Elfring@web.de>
Subject: Fix signal handler
Date: Tue, 02 Feb 2010 17:14:23 +0100
Message-ID: <4B684F5F.7020409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 17:14:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcLOc-00067H-R8
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 17:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387Ab0BBQO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 11:14:27 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:43548 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab0BBQO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 11:14:26 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 9803114CF7AF1
	for <git@vger.kernel.org>; Tue,  2 Feb 2010 17:14:25 +0100 (CET)
Received: from [78.49.150.133] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcLOT-0001TY-00
	for git@vger.kernel.org; Tue, 02 Feb 2010 17:14:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX18VYEkZYpV/aE8fvDbq5Y+Hkcz88HjyVD1u9GQX
	ZnhT7upGG0gW/G9o39olYD9sijx1x52Epf71pfCcdlQDjDFhZC
	8VlOXF0pHyStGjoxi/Jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138728>

Hello,

The function "early_output" that is set as a signal handler by the
function "setup_early_output" contains a simple looking instruction.
http://git.kernel.org/?p=git/git.git;a=blob;f=builtin-log.c;h=8d16832f7e9483f7903009459a72efc39e267c98;hb=HEAD#l173

A global variable gets a function pointer assigned.
http://git.kernel.org/?p=git/git.git;a=blob;f=revision.h;h=a14deefc252bd641fba5e16f7859b4a985a72578;hb=HEAD#l138

I find that this approach does not fit to standard rules because the
data type "sig_atomic_t" is the only type that can be safely used for
global write access in signal handlers.
https://www.securecoding.cert.org/confluence/display/seccode/SIG31-C.+Do+not+access+or+modify+shared+objects+in+signal+handlers

Would you like to change any details in the design of your software
because of this issue to avoid undefined behaviour?

Regards,
Markus
