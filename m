From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] gitweb: Use Test::WWW::Mechanize::CGI to test
 gitweb output
Date: Sat, 14 Jun 2008 20:18:16 +0200
Message-ID: <48540B68.1050108@gmail.com>
References: <200806141447.28052.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 20:18:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aKn-0000cC-1c
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbYFNSRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbYFNSRr
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:17:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:49108 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbYFNSRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:17:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3011222fgg.17
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=PGYGeGREp9R/oQTIY+DDpVh9XNPqq4MyXygcveZFYmk=;
        b=LhcAtcvjBFDVxlTz63o664eVj/TWVQfLInlQcjBq3zBcDvh4jNHbLkWH/gKGmI8O2B
         UpuPp2RWt2nHtqtxFZH0UEI0kFS3+Ggp0fhoAYfSOMh11HrFawFgiIylktq34JOqXbov
         WNwGiRZVhW/ba7YOuJA/OGbQqJuZXHmtlriCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=Ol1O3KuoAOhPInNX6oQOmHIOQtHkYYTju9MunKQes1CghiCJ+EJ1XWPqhWcyS0+XbU
         Aa2nhs6hfMofBN77P2SOzDlCNxGIJYB4b+/gOGirfcOCnR3BcxEqWsMvtHZYEVn4lVof
         A2KRmV7r8q+Uu3U7Ie88JN/TQS6fWFWYGkym4=
Received: by 10.86.87.13 with SMTP id k13mr6134958fgb.1.1213467464716;
        Sat, 14 Jun 2008 11:17:44 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.200.93])
        by mx.google.com with ESMTPS id e20sm9212320fga.1.2008.06.14.11.17.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 11:17:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200806141447.28052.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85031>

Jakub Narebski wrote:
> +	skip "Could not get $pagename", 2 + $lint_installed
> +		unless $mech->get_ok('http://localhost/', "GET $pagename");

Just noticed this -- here's the cause of the problem I encountered in my 
previous post.

You can't really probe for a running gitweb installation on localhost, 
because even if there's one, you don't know if you're testing against 
your tree and your test repo.

So unless it's (easily) possible to force Mechanize to eat gitweb.cgi's 
output in lieu of making actual HTTP requests, I'd suggest that we 
simply use an environment variable (e.g. 
GITWEB_TEST_BASE_URL=http://localhost/cgi-bin/gitweb.cgi) -- if it's 
unset, the tests get skipped, otherwise they're run against that base URL.

*wanders-off-to-write-a-patch*

-- Lea
