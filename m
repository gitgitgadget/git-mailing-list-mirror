From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 12:05:32 -0700 (PDT)
Message-ID: <m363rylknc.fsf@localhost.localdomain>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
	<alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Ian Hilt <Ian.Hilt@gmx.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:07:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDr5-0002Tl-Ud
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbYFXTFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYFXTFi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:05:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:53901 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYFXTFh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:05:37 -0400
Received: by nf-out-0910.google.com with SMTP id d3so51248nfc.21
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=r6vB5qNAagx/cCyCJ8m9iidD6LhpM0NpS1moN20trpw=;
        b=vrCPqHpyyyWc4J1lEOwSYhNvCSzcoxCJyf1d9lWcLS76ij56sTBg2+koTbpUaOlVGg
         2Y5O4Toa8lTLhwM8FYhVAR7n4lxQDTg8pXST62+aX5yZ4frDdCJq11MRUYOdzTysY94e
         TfrY5HyLb7lCkk5K0vNH3NBnn3YQ0sD2qgdHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=xWdJdi8K9k3ihR3ssf3gz35P5UwZ6RAiDBJXDqoGcV3IIVM6KC+1k9aX9l4uyq95G/
         iIJZJ7oHkGYyAf7pxHEIv9RhjwzzSpMPG6VYCijHcx7GmBUSvzBO0EX0/iPlRf6GG3E9
         ch8zoWjA7YFB0EppPC5CAJKO4Ox9RKXvuj0bc=
Received: by 10.210.21.13 with SMTP id 13mr631938ebu.75.1214334334178;
        Tue, 24 Jun 2008 12:05:34 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.44])
        by mx.google.com with ESMTPS id c25sm10810246ika.11.2008.06.24.12.05.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 12:05:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5OJ4lgQ010298;
	Tue, 24 Jun 2008 21:04:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5OJ4NUe010293;
	Tue, 24 Jun 2008 21:04:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86108>

Ian Hilt <Ian.Hilt@gmx.com> writes:

> On Tue, 24 Jun 2008 at 12:23pm -0400, Christian Holtje wrote:

> > --- a/templates/hooks--pre-commit
> > +++ b/templates/hooks--pre-commit
> > @@ -55,8 +55,14 @@ perl -e '
> > 	if (s/^\+//) {
> > 	    $lineno++;
> > 	    chomp;
> > -	    if (/\s$/) {
> > -		bad_line("trailing whitespace", $_);
> > +	    if (/\r$/) {
> 
> Wouldn't it be less redundant to do a test for \s\r$ here instead of
> testing for \r$ and then \s\r$?

I don't think so, because you want next to test for whitespace
where it _doesn't_ end in \r, i.e. this condition is here
because of the 'else' clause.  IIRC.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
