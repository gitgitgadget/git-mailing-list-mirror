From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/WIP/PATCH v2] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 16 Jun 2008 02:40:17 +0200
Message-ID: <200806160240.18539.jnareb@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <200806152001.34350.jnareb@gmail.com> <4855634C.8060606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 02:41:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K82n1-0000m2-2l
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 02:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbYFPAkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 20:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYFPAkW
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 20:40:22 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:28973 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbYFPAkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 20:40:21 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3924424ika.5
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 17:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hM8znxbL+sxDqo0d0+NgGQYvaZ1T7Kljsjfsl8LOL5o=;
        b=eZCsF41aFvUMqfADkxSdvQI9jKXkpSisogcDNs5oznLdhjpqYk8yNwDN+tpNJMNT2R
         vnLb6pJWMBBEPsLb79SF0/9BXODG+SEH/aPz03hRCyp5wUTLqoM9mgvnS1BdRnCYLxmb
         Y6c6OXzEBtiZgfpzQa5KfoU5VoauOMui7pquM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HF3SYPeekTGuJgQHniwiKZMtFCvmRSA+rU2ndc39sChi+pazQxa5c0Lyo0XZKwajac
         zeBP1rZaDy7rjSxIr6wUeNKAS09FXemr/Lretdd/Qo244ym8nIfphqAIHGAr5P8EFbDp
         jAEhX0CfrXmiyw1hsRjfzKlSE+5xmIpiUVbrM=
Received: by 10.210.49.19 with SMTP id w19mr5544071ebw.69.1213576819599;
        Sun, 15 Jun 2008 17:40:19 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.105])
        by mx.google.com with ESMTPS id c24sm7651144ika.4.2008.06.15.17.40.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 17:40:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4855634C.8060606@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85155>

Lea Wiemann wrote:
> Jakub Narebski wrote:
> >
> > 1.) Should we put all tests in one file, or should they be split
> 
> I'd suggest we leave it in a single file until test execution time 
> becomes an issue.  Then (when it has become too large) we'll be able to 
> figure out good boundaries along which to split the test suite.

I wanted to split tests mainly not because of performance, but because
of making it easier to maintain.  Although perhaps single driver-test,
and do()-ing or require()-ing sub-files would be enough.

> > 2.) What invariants should we test [...]  Checking for example if all items
> >     are listed in a 'tree' view, or if all inner links (#link) are
> >     valid would be a good start... 
> 
> Yup; completeness of item lists is especially relevant for paginated 
> output.  Also check for the presence and validity of links (like 
> "parent" links, etc.), and for the presence of certain elements (like 
> the file modes in the tree view).

For example if "next" (and like) views really lead to next page.

> Also, with a $ENV{LONG_GIT_TEST} variable or so, we could automatically 
> validate all links for each page we're checking -- it takes a long time, 
> but it's still way more efficient than exhaustive spidering of the whole 
> site.

Good idea.  I would examine how it is done in other tests.

> > (by the way, is there some Perl module for RSS, Atom and OPML validation?)
> 
> I can't find anything on Google right now, 

I usually search CPAN first, not Google...

> but piping them into external  
> validators might be just as fine.  Also, since those formats are 
> generated using print statements (which is really error-prone for XML 
> formats), I'd say that a good start would be to check for XML validity.

We can use Test::XML / Test::XML::Valid / Test::XML::Simple for being
well-formed XML.  If RSS / Atom / OPML have good DTD / XML Schema /
/ Relax-NG schema / Sablotron rules, they could be checked using that
from Perl.

> > 3.) What invariants you want to test for your caching efforts, e.g.
> >     checking if cached output matches non-cached
> 
> How about this:
> 
> 1. Run the Mechanize tests (and possibly also the existing t9500 tests) 
> *without* caching, recording the URL's and contents of all pages the 
> test suite accesses.
> 
> 2. Get all those URL's again *with* caching (from a cold cache), and 
> assert that the output is identical.

How would you ensure cold cache?

> 3. Get all those URL's again *with* caching (from a warm cache), and 
> assert that the output is identical.

Well, it might be identical, but it also might have "cached output"
somewhere in the output.

> Perhaps also assert that no call  
> to the git binary is made (i.e. everything has actually been cached). 
> (Of course we might need options for the production site to not cache 
> certain things, but let's defer this discussion.)

Or at least (if we don't cache everything, and that could be good idea)
to check if there are less git binary calls.

-- 
Jakub Narebski
Poland
