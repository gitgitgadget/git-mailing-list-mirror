From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 18:22:14 +0100
Message-ID: <45EC51C6.5080505@lu.unisi.ch>
References: <esgm1m$33f$1@sea.gmane.org> <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45EC3905.7070406@lu.unisi.ch> <Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45EC4B55.3090505@lu.unisi.ch> <Pine.LNX.4.63.0703051812030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOGt9-0007c7-5E
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 18:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXCERWP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 12:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752812AbXCERWP
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 12:22:15 -0500
Received: from server.usilu.net ([195.176.178.200]:38152 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751791AbXCERWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 12:22:15 -0500
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Mar 2007 18:22:13 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.63.0703051812030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 05 Mar 2007 17:22:13.0651 (UTC) FILETIME=[D0AC2630:01C75F4A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41463>


> Yes, you also check real_ref instead of checking if dwim_ref() returned 0. 
> I feel a little bit uneasy about that, since there is no guarantee that 
> these values are left untouched, whereas the return value is guaranteed to 
> behave as expected.

There is.  The man page says "Scanning stops when an input character does not match such a format character."  Scanning includes not processing %n elements, either.

Regarding dwim_ref, dwim_ref says:

int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
{
        const char **p, *r;
        int refs_found = 0;

        *ref = NULL;

and since this "*ref" is not used anyway in the rest of the routine, I figured out that it's part of the interface to set "*ref" to NULL if no ref is found.  Of course it could help (hint hint) if extern functions had a comment stating the interface.

I see however that I also have a "real_ref = NULL" that is actually pointless; I can take it away of course.

> I also feel a little uneasy about having to parse a format in order to 
> parse a string, when you know what that string should look like. For 
> example, you could make the code even more compact by asking 
> "(p = strstr(value, "/*:refs/remotes/"))".

Go down this way and you will say that printf is useless too.

Paolo
