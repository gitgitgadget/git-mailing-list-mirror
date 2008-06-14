From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] gitweb: Use Test::WWW::Mechanize::CGI to test gitweb output
Date: Sat, 14 Jun 2008 20:31:46 +0200
Message-ID: <200806142031.46556.jnareb@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <48540B68.1050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 20:32:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aYP-0003wu-1r
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbYFNSbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbYFNSbv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:31:51 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:14915 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbYFNSbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:31:50 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3452928ika.5
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6nJH254IwTggtFNSCN9qMnror7jyuo6JX4saluDhFGs=;
        b=ErKGATrVGnVnv30HwstTQNwsWivE0oDbLYDIfRkyL3vEt3Wdynrx0xGu77rK2J2tXt
         msKBRm2uGa6bPdHIa40udw2CB3WIYXwtmBX+Ajw5nlFNMHpcLumRHj0RA65UCkp3tqzw
         fmWn4x7sNKvyUw/IEzFEBXd+mjQ9aJRnEy+ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VWiHIUO4tEywMWP8HNCLgvdq1VUyEJ47ppIwG53wMyZO21YqENYY8sZHsSGG7ZliWA
         40dtzEMKU4tQ93W8vFDDnwSVG4LRhinT93wi/jZF0xa4piyFonT2pTlVAUuMx/JhaoTJ
         bVQZNTG2m8QWmXHMFzFLPtv0j2890+P3O5F98=
Received: by 10.210.112.4 with SMTP id k4mr4163352ebc.115.1213468308552;
        Sat, 14 Jun 2008 11:31:48 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.84])
        by mx.google.com with ESMTPS id c24sm5771836ika.4.2008.06.14.11.31.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 11:31:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48540B68.1050108@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85035>

Lea Wiemann wrote:
> Jakub Narebski wrote:
> >
> > +	skip "Could not get $pagename", 2 + $lint_installed
> > +		unless $mech->get_ok('http://localhost/', "GET $pagename");
> 
> Just noticed this -- here's the cause of the problem I encountered in my 
> previous post.
> 
> You can't really probe for a running gitweb installation on localhost, 
> because even if there's one, you don't know if you're testing against 
> your tree and your test repo.

Errr... WWW::Mechanize::CGI does not access web server, but runs CGI
script (or CGI subroutine) as if it was installed in the root directory
of localhost.  'http://localhost' simply means installed CGI script.

For example tests works for me, even though I have gitweb installed
somewhere deeper than directly at locahost:
  http://localhost/cgi-bin/gitweb/gitweb.cgi
Besides you can check output and see that it is consistent with set
and used gitweb config in t9503* test.

Test::WWW::Mechanize::CGI has the following description:
http://search.cpan.org/~mramberg/Test-WWW-Mechanize-CGI-0.1/lib/Test/WWW/Mechanize/CGI.pm

  Provides a convenient way of testing CGI applications without a external
  daemon.

The documentation of module (0.1 in the case of TWM::CGI, 0.3 in the
case of WM::CGI) leaves something to be desired, so I mainly used
examples provided as guideline.

-- 
Jakub Narebski
Poland
