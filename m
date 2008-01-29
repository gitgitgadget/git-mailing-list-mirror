From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Tue, 29 Jan 2008 08:43:42 +0100
Message-ID: <479ED92E.4020709@viscovery.net>
References: <47975FE6.4050709@viscovery.net>	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>	<alpine.LSU.1.00.0801272043040.23907@racer.site>	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>	<20080128003404.GA18276@lintop>	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>	<479D805E.3000209@viscovery.net>	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>	<479D9ADE.6010003@viscovery.net>	<alpine.LSU.1.00.0801281210440.23907@racer.site>	<7vwspts9vj.fsf@gitster.siamese.dyndns.org>	<479ED3AE.5000403@viscovery.net> <7v3ashqedx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 08:44:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJl8i-0000K0-Oa
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 08:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbYA2Hnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 02:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYA2Hnq
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 02:43:46 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9213 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYA2Hnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 02:43:45 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JJl7w-0007BM-5S; Tue, 29 Jan 2008 08:43:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1B1C16D9; Tue, 29 Jan 2008 08:43:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v3ashqedx.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71961>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> I appreciate this new sanitary_copy_path() because I expect that we will
>> need at least one less #ifdef __MINGW32__/#endif compared to our current
>> Windows port.
> 
> I would have expected that the whole function would have
> platform specific implementation to deal with Windows, not just
> ifdef sprinkled everywhere that says "Oh, on this platform
> directory separator is a backslash".

I agree. Therefore, we would have *one* conditionalized definition of
is_dir_sep() upfront, and use that in place of c == '/'.

The #ifdef I'm addressing above is one that we had to introduce because in
the old implementation of prefix_path() on Windows we had to rewrite the
path more often than on *nix due to '\\' => '/' conversion. In your new
implementation this rewriting now always takes place, but on *nix it more
often turns out to be an identity operation.

> Especially I have no idea how would that drive lettter stuff
> would/should work.  When you are in C:\Documents\Panda\, how
> would you express D:\Movie\Porn\My Favorite.mpg as a relative
> path?

You can't. But when would this be necessary?

-- Hannes
