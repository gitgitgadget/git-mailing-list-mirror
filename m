From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: Numeric constants as strings
Date: Mon, 19 Feb 2007 10:04:12 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnetitgs.sbe.mdw@metalzone.distorted.org.uk>
References: <200702190916.35813.andyparkins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 11:04:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ5Nb-0006cc-JF
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 11:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbXBSKEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 05:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbXBSKEP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 05:04:15 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:14617 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1750817AbXBSKEP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 05:04:15 -0500
Received: (qmail 23808 invoked by uid 110); 19 Feb 2007 10:04:12 -0000
Received: (qmail 23792 invoked by uid 9); 19 Feb 2007 10:04:12 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1171879452 23790 172.29.199.2 (19 Feb 2007 10:04:12 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Mon, 19 Feb 2007 10:04:12 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40114>

Andy Parkins <andyparkins@gmail.com> wrote:

> I'm working on bringing my hash width literals patch up to date now
> that 1.5.0 has passed.  It's all been trivial apart from one line:
>
> #define HASH_WIDTH_ASCII 40
> -               printf("%-40s %s%s (%d subtrees)\n",
> +               printf("%-" HASH_WIDTH_ASCII "s %s%s (%d subtrees)\n",

The standard two-step goes

#define STRINGIFY(foo) STRINGIFY_REALLY(foo)
#define STRINGIFY_REALLY(foo) #foo

The purpose of STRINGIFY_REALLY is to macro-expand the argument foo.  If
you just invoked STRINGIFY_REALLY

  printf("%-" STRINGIFY_REALLY(HASH_WIDTH_ASCII) "s %s%s (%d subtrees)\n", 

you'd get

  printf("%-HASH_WIDTH_ASCIIs %s%s (%d subtrees)\n", ...

which is not what you wanted.  However,

  printf("%-" STRINGIFY(HASH_WIDTH_ASCII) "s %s%s (%d subtrees)\n", 

will do the right thing.

-- [mdw]
