From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/5] gitweb: Incremental blame (using JavaScript)
Date: Sat, 7 Nov 2009 12:04:51 +0100
Message-ID: <200911071204.53550.jnareb@gmail.com>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com> <1251805160-5303-3-git-send-email-jnareb@gmail.com> <20091105202202.GC17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Nov 07 12:05:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6j6W-0001Uj-RY
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 12:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbZKGLE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 06:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbZKGLE4
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 06:04:56 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61870 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZKGLEz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 06:04:55 -0500
Received: by bwz27 with SMTP id 27so1980599bwz.21
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 03:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KG7Xv80PuicDEbnDyJjBZt9hUcXwvI0E+ziduqZiBnY=;
        b=OxoWdfin/HYmaAyL2s5RFYyEKl6jYY7K73evcjJcLmqpxk4EnHwj6NsMyAP4SBbL1M
         ALJ00skelGC5NjlMGkG4gYf7KobifUfmjCNvrkbG8EgcfW7BwNOT4JaMaZ4i6cVoFTJC
         KxD5/oJThD84uP7gKHjgTVR93JlH2y3Yo7tqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dCAt2qMtvhICfMGXBLUKgVm/JYZBIpFF5BFr2sxwb/PlaHVI0ibnhO3+ZDG5KeMrcO
         TcRzPSiyMC0O6RcOIbUXX3P87QMQ5ch/z3KcSUWcxvAJvoEDF20r4J5zKjahkJ3kt8Mf
         PPpNDO4Evix8fUcSiuNS1JWs+HNAB0MupA2Ns=
Received: by 10.204.48.131 with SMTP id r3mr5550589bkf.195.1257591899015;
        Sat, 07 Nov 2009 03:04:59 -0800 (PST)
Received: from ?192.168.1.13? (abuz230.neoplus.adsl.tpnet.pl [83.8.197.230])
        by mx.google.com with ESMTPS id 15sm249316bwz.12.2009.11.07.03.04.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 03:04:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20091105202202.GC17748@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132359>

On Thu, 5 Nov 2009, Petr Baudis wrote:
> 
>   Many thanks for nurturing this patch.

You are welcome.

I have learned quite a bit about JavaScript when working on this
patch...
 
> On Tue, Sep 01, 2009 at 01:39:17PM +0200, Jakub Narebski wrote:
> > Roads not taken (perhaps that should be part of commit message?):
> > * Move most (or all) of "git blame --incremental" output parsing to
> >   server side, and instead of sending direct output in text/plain,
> >   send processed data in JSON format, e.g.
> > 
> >     {"commit": {
> >        "sha1": "e83c5163316f89bfbde7d9ab23ca2e25604af290",
> >        "info": "Kay Sievers, 2005-08-07 21:49:46 +0200",
> >        "author-initials": "KS",
> >        ...
> >      },
> >      "src-line": 13,
> >      "dst-line": 16,
> >      "numlines": 3,
> >      "filename": "README"
> >      }
> > 
> >   (line wrapping added for readibility).  This would require however
> >   taking care on Perl side to send properly formatted JSON, and on
> >   JavaScript side including json2.js code to read JSON in gitweb.js
> >   (unless we rely on eval).
> 
>   I don't know that much about web programming, what is wrong with
> relying on eval?

In general it is insecure.  In this specific situation it shouldn't.

[...]
> > * Using some lightweight JavaScript library (framework), like jQuery,
> >   Prototype, ExtJS, MooTools, etc.  One one hand side this means not
> >   having to worry about browser incompatibilities as this would be
> >   taken care of by library; on the other hand side we want gitweb to
> >   have as few dependences as possible.
> 
>   Normally, particular version of the library is simply included within
> the project. E.g. in Girocco, I use MooTools for the tiny bit of
> javascript I do. It is probably overkill to include it just for
> incremental blame, but if we ever do much more, I think the much easier
> web programming is worth the little trouble.

Alternate solution would be to load for example jQuery for example hosted
on Google as described in http://code.google.com/apis/ajaxlibs/documentation/

-- 
Jakub Narebski
Poland
