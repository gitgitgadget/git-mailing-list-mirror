From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in incremental blame
Date: Wed, 25 Nov 2009 15:36:07 +0100
Message-ID: <200911251536.08993.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911250145.16472.jnareb@gmail.com> <4B0CAC2E.1060105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 15:36:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDIyk-0004xc-Vm
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 15:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758607AbZKYOgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 09:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758541AbZKYOgK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 09:36:10 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:48501 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758456AbZKYOgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 09:36:09 -0500
Received: by fxm5 with SMTP id 5so7025274fxm.28
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 06:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZvupP1U5WZpocCAjfZlKWrv12PFTvqA/0/J/3JqYpTA=;
        b=ZNQlWhmh8tg1yb/rgDUG+8UY3QsoZ2Tn0RnWFmVfsXtvDiKHhP5z4v5YRR0bL0gIIf
         iJvtjOlQ6xuFLdYV4GBQeGGPbJHWdgka6W/nUrgPVUvXcjc38KgLPrOVDRZsyFzwLd5k
         SYQQT5ycY2aAUm1DJuJ4TR0UOucFNm0g87HI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=k214N8nqfq5ZQ5cCCPipk8GQRN2KgWbfL2UNsk6MINQCPW/1NDa6p4oapaG5FRFqY8
         /85igKyVAZh6iCxT1HS2PEW6Wt+uIdcQIdXyocTRwFocZZ9tHJcOJMUlFUgH5VScUPSn
         iVhZwMkNcvAucU9U3vNLSRMrOJeWsqZ6DJ7bU=
Received: by 10.103.86.38 with SMTP id o38mr3355220mul.114.1259159774953;
        Wed, 25 Nov 2009 06:36:14 -0800 (PST)
Received: from ?192.168.1.13? (abvf67.neoplus.adsl.tpnet.pl [83.8.203.67])
        by mx.google.com with ESMTPS id j10sm560894muh.26.2009.11.25.06.36.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 06:36:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B0CAC2E.1060105@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133645>

On Wed, 25 Nov 2009 05:01, Stephen Boyd wrote:
> Jakub Narebski wrote:
> >
> > Debugging this is serious PITA.  After fix below it appears that this bug
> > is some intermittent bug, depending on XMLHttpRequest timing.  It more
> > often than not (at least when I tried to debug it using build-in IE8
> > debugger) works correctly for the folowing files: README, GIT-VERSION-GEN,
> > revision.c (once even it did fail when first running for given file, and
> > then running correctly when reloading from debugger; fun it is not).
> >
> > It does consistently fail for gitweb/gitweb.perl... but when I tried
> > to debug it IE8 would hang up when trying to use debugger (with around
> > 600MB available RAM).  Perhaps somebody else would have more luck...
> 
> Interesting. I don't have time to look into this until early December, 
> but if it's still around then I'll take a look. I wonder if IE6 or IE7 
> works (I don't think everyone is on version 8 yet).

Well, the one time I was able to run debugger (F12, select 'Script', select
'gitweb.js') with error occurring and without IE hanging (for README file)
it did show an error for the following line:

  if (xhr.readyState === 3 && xhr.status !== 200) {

When I checked 'xhr' object, it has "Unknown error" as contents of 
xhr.statusText field and as contents of xhr.status (sic!), which should
be a number: HTTP status code.

Unfortunately I had to take a break... and I was not able to reproduce this
(without hanging web browser: "program not responding") since then...

-- 
Jakub Narebski
Poland
