From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Wed, 14 Apr 2010 22:04:56 +0200
Message-ID: <201004142204.57323.jnareb@gmail.com>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca> <201004141922.20213.jnareb@gmail.com> <4BC614D8.2000208@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:04:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O28p0-0000Pl-4y
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab0DNUEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:04:21 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:53610 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615Ab0DNUEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:04:20 -0400
Received: by bwz25 with SMTP id 25so672000bwz.28
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yZ0BNUI1Bb0tRmNrZrPq6RXhK0sSrP7vTwYxHoz0g1o=;
        b=dNNvvqAVDZ9oI8MJvdCFk7lxhtSuMgkI4xgb0jz5vESmufaXXxEJ0e9Bksq+PbOoyf
         3KQf1r/CGN/y8xlqbhYDIhgmtcm12Jc2H7Imkrne3BA/dS2n0qqDfhlrZFmascYWqHl/
         kBUBz1fXu01W+00YzhmM71N/NYnT6hNsZ8e4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DQgJlcGkas97yibbP6xsegc6LKrvaVWDbChPMuGyT4hmwOg5Y5UpTZ2XgIle2oM+Bs
         Kqad1RCUc5ZRsB5s3hv1ZhkplD3FeHq8h9xFInqObMthGUKgcjph8xbfD8esi/a8WUAT
         CXXEyz1WAwCDrvx5aj550Li2vMZkEsKMl+mpM=
Received: by 10.204.33.206 with SMTP id i14mr8901520bkd.52.1271275458725;
        Wed, 14 Apr 2010 13:04:18 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id 15sm696945bwz.8.2010.04.14.13.04.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 13:04:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BC614D8.2000208@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144899>

On Wed, 14 April 2010, Mark Rada wrote:
> On 10-04-14 1:22 PM, Jakub Narebski wrote:

> > For git-instaweb I think that best solution would be to introduce new
> > variables holding _source_ of gitweb JavaScript code and CSS, e.g.
> > 
> >             -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \
> > 
> > in place of
> > 
> >             -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS_SOURCE)' \
> > 
> > ...although GITWEB_CSS might mean something different for Makefile
> > and git-instaweb than for gitweb/Makefile and gitweb itself.
> 
> Did you get those lines mixed up? I might be not understanding something
> here.

Ah, I'm sorry, I mixed up those two lines.  They should be in reverse
direction:


             -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS_SOURCE)' \
 
  in place of
 
             -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \


Actually I'd like to rename @@GITWEB_CSS@@ placeholder etc. in 
git-instaweb.sh, as  @@GITWEB_CSS@@ in git-instaweb.sh means something
quite different from ++GITWEB_CSS++ in gitweb/gitweb.perl...

> 
> I was actually planning something along the lines of 
> 
>              -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS_NAME)' \
>              -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS_NAME)|' \
> 
> where I introduce the GITWEB_CSS_NAME variable, to be consistent with the
> token in instaweb. This way we don't touch GITWEB_JS in the top level
> makefile.

Why not:

            -e '/@@GITWEB_CSS_SOURCE@@/r $(GITWEB_CSS_SOURCE)' \
            -e '/@@GITWEB_CSS_SOURCE@@/d' \
            ...
            -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' \

(assuming that $(GITWEB_CSS) does not include '|' in it, I guess...
but see below).

> 
> Also, I should update dependancies for instaweb, since those were
> forgotten last time around. Just creating a short list of what the fix will
> need for when I get home tonight.

Something like

   git-instaweb: git-instaweb.sh gitweb/gitweb.cgi $(GITWEB_CSS_SOURCE) $(GITWEB_JS_SOURCE)


P.S. I have noticed additional complication: git-instaweb really needs
gitweb compiled with *specific* values of GITWEB_CSS and GITWEB_JS,
so that they point to git-instaweb's installed files.

-- 
Jakub Narebski
Poland
