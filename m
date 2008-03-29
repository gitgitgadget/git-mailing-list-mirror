From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Sat, 29 Mar 2008 13:54:10 +0100
Message-ID: <200803291354.10368.robin.rosenberg.lists@dewire.com>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291038.48847.robin.rosenberg.lists@dewire.com> <20080329095238.GB21814@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 29 13:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfab6-00077H-D5
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 13:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbYC2MzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 08:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbYC2MzF
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 08:55:05 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27889 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbYC2MzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 08:55:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 314BB8026E9;
	Sat, 29 Mar 2008 13:55:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2WJoCdAvaCdV; Sat, 29 Mar 2008 13:55:01 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7EBF5800782;
	Sat, 29 Mar 2008 13:55:01 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080329095238.GB21814@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78464>

Den Saturday 29 March 2008 10.52.38 skrev Jeff King:
> On Sat, Mar 29, 2008 at 10:38:48AM +0100, Robin Rosenberg wrote:
> > The environment variables are only part of the story. There is a langinfo
> > API for this. See I18N::Langinfo(3pm) that knows about those and
> > something else.
> >
> > # perl -e 'require I18N::Langinfo; I18N::Langinfo->import(qw(langinfo
> > CODESET)); $codeset = langinfo(CODESET()); print "My codeset=".
> > $codeset."\n";'
> > My codeset=ISO-8859-15
>
> Hmm, neat. So perhaps it would make sense to just use this value instead
> of utf-8, and not worry about examining the actual text (since any such
> examination is at best a guess, anyway)?

I think you really should try the UTF-8 guess, since a file may well be UTF-8 
even if the user locale is something else. Especially for XML files, UTF-8
is common, but there are many more cases. Look into git-gui/po for more 
examples. The probability of a UTF-8 test being wrong is just so unimaginable 
low.

> PS Your 'require' is more simply written as 'use I18N::Langinfo

> qw(langinfo CODESET)', or perhaps even simpler:

See the man page, from which I stole it. It suggests you wrap it all inside 
eval {}, just in case your perl does not have langinfo.

As for the is_utf8() i'm not sure what it does, but I can't make it work.

-- robin
