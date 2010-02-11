From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: XML Parsing Error: junk after document element
Date: Thu, 11 Feb 2010 03:01:36 -0800 (PST)
Message-ID: <m3ocjw82ai.fsf@localhost.localdomain>
References: <b713df2c1002102347g70cc212et21d507d44bb5aead@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Siju George <sgeorge.ml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 12:01:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfWnw-0006cz-B5
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 12:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab0BKLBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 06:01:42 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37073 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab0BKLBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 06:01:40 -0500
Received: by bwz19 with SMTP id 19so214935bwz.28
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 03:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=oYCvDk0qmFWVctwSMzf391qBUrxStnwDnX63OoKJ8EU=;
        b=UQSokru+1boMJ3sz4be3oPg0KmvMvrgkbdPBhP5dUQBfugXnJ0luXyxwJk+YGSMoQJ
         U1C6ene6TTPmIMp4hCvoOJH6oDfvNwwBOhTVNXRPFNef7FfbvkgEkuQYCRFjx6v6tPFf
         kildpDrH28qIntA7rLMIevQW06jjxBuBb0ImI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=t/gx6Akh4OER/uKQ+nNFtgL8Orvitm2IOQ2xbkmI1EacLkKoz3P6BFBRN8GwQTNnXh
         YRC+a5X0tqQ8J+ykM9U7fM1LXsLN1FNu6xhYGWrmXo4vQ8Y/aJfLU7ua2kYqh4JPWiTB
         EqGUURjfqRkgGSQFmyBOLF25OWJj5u/GBYDvE=
Received: by 10.204.34.208 with SMTP id m16mr1051320bkd.180.1265886098734;
        Thu, 11 Feb 2010 03:01:38 -0800 (PST)
Received: from localhost.localdomain (abwf229.neoplus.adsl.tpnet.pl [83.8.229.229])
        by mx.google.com with ESMTPS id 14sm997280bwz.13.2010.02.11.03.01.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 03:01:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1BB17Ox030280;
	Thu, 11 Feb 2010 12:01:17 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o1BB0shp030274;
	Thu, 11 Feb 2010 12:00:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <b713df2c1002102347g70cc212et21d507d44bb5aead@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139584>

Siju George <sgeorge.ml@gmail.com> writes:

> Hi,
> 
> I get this error when I take gitweb in a browser.
> 
> XML Parsing Error: junk after document element
> Location: http://172.16.3.27/cgi-bin/gitweb.cgi
> Line Number 28, Column 8:</html><!DOCTYPE HTML PUBLIC "-//IETF//DTD
> HTML 2.0//EN">
> -------^
> 
> How can I solve it?

Which version of gitweb?[1]  Which version of git?[2]  What web server?
Which version of CGI.pm is used by web server?[3]

The included fragment after closing '</html>' tag doesn't look like
something coming from gitweb, as gitweb uses XHTML 1.0 DTD since it's
first version.

Try to view source, or use different web browser that doesn't do
strict XML validation to find the source of this error.

If everything else fals, you can always edit gitweb.cgi to comment out
content-type negotiation, to always serve as text/html mimetype -
which should torn off XML validation, as below:

	my $content_type;
	# require explicit support from the UA if we are to send the page as
	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
	# we have to do this because MSIE sometimes globs '*/*', pretending to
	# support xhtml+xml but choking when it gets what it asked for.
	# Disable content-type negotiation when caching (use mimetype good for all).
	#if (defined $cgi->http('HTTP_ACCEPT') &&
	#    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
	#    $cgi->Accept('application/xhtml+xml') != 0) {
	#	$content_type = 'application/xhtml+xml';
	#} else {
		$content_type = 'text/html';
	#}


The commands below are _examples_ only:
[1] grep -F 'our $version' /var/www/cgi-bin/gitweb.cgi
[2] git --version
[3] perl -MCGI -le 'print $CGI::VERSION'
-- 
Jakub Narebski
Poland
ShadeHawk on #git
