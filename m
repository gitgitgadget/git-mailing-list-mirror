From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Wed, 14 Apr 2010 00:30:45 +0200
Message-ID: <201004140030.47222.jnareb@gmail.com>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca> <4BC4D3F0.5020107@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 00:31:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1odw-0008Qz-HD
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 00:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab0DMWb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 18:31:28 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:44185 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab0DMWb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 18:31:27 -0400
Received: by bwz19 with SMTP id 19so60040bwz.21
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BSbmNKF3vMMv4lj8a19pyEYcM3wrE34ZpKMPGI5YwnA=;
        b=V751QGDmtdEfTRnn4v+FJuieBNnSIYNKuh4ebyka70zMR0UNICvYlVnbBEWFC7HDU1
         qbaK1DYiE10OMeWZgc5HgFQhNy04hgG8GQgBecv2MVnMb2cjQkEeOGVO40Cb21kUKfuQ
         R+Bi+GWYFomcMkXJ+wJCuNdo1k/z9KmhitH5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FAggqcXkaI3L00d81XQtzZZfmtTvfgEol0uHSzQ4r8D7ZPIZRmxhTw2+zzSLIFxO9v
         Lo1obKPmBDwTDI3IbTmtaM6HKZjFdUDY3fjlbDteGmE0QT6/FjCZsjsnj/GrHT11Ic62
         xHabe647545jv6+oY2KPQYM16r60SBxqk4eXM=
Received: by 10.102.16.19 with SMTP id 19mr3514681mup.111.1271197813787;
        Tue, 13 Apr 2010 15:30:13 -0700 (PDT)
Received: from [192.168.1.13] (abvr150.neoplus.adsl.tpnet.pl [83.8.215.150])
        by mx.google.com with ESMTPS id n7sm616195mue.45.2010.04.13.15.30.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 15:30:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BC4D3F0.5020107@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144835>

On Tue, 13 April 2010, Charles Bailey wrote:
> On 01/04/2010 06:36, Mark Rada wrote:
> > @@ -84,13 +92,14 @@ endif
> >
> >   all:: gitweb.cgi
> >
> > +FILES = gitweb.cgi
> >   ifdef JSMIN
> > -FILES=gitweb.cgi gitweb.min.js
> > -gitweb.cgi: gitweb.perl gitweb.min.js
> > -else # !JSMIN
> > -FILES=gitweb.cgi
> > -gitweb.cgi: gitweb.perl
> > -endif # JSMIN
> > +FILES += gitweb.min.js
> > +endif
> > +ifdef CSSMIN
> > +FILES += gitweb.min.css
> > +endif
> > +gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
> >
> 
> I have a question about this last line of the patch. Are GITWEB_JS and 
> GITWEB_CSS supposed to be a source path or a URI?
> 
> The documentation for install (and my previous assumption) was that they 
> represented the path on the target web server. I'm used to overriding 
> them so that gitweb.cgi can live in my /cgi-bin directory, but the 
> static files are served from /gitweb which is readable but not executable.
> 
> After this patch I had to removed $(GITWEB_JS) and $(GITWEB_CSS) from 
> the list of dependencies for gitweb.cgi otherwise make failed.
> 
> Have I got the wrong end of the stick?

Thanks a lot for noticing this bug.


GITWEB_JS and GITWEB_CSS were originally meant to be URI to file with
gitweb JavaScript code and default gitweb stylesheet,... but during work
on minification of JavaScript code and CSS file it somehow got confused
to mean source path.

If I remember correctly the original patch, before adding required
support for minified gitweb.js and gitweb.css to git-instaweb script,
and before support for CSS minification had

   ifdef JSMIN
   gitweb.cgi: gitweb.perl gitweb.min.js
   else
   gitweb.cgi: gitweb.perl
   endif

which should probably be replaced in current situation by

   ifdef JSMIN
   gitweb.cgi : gitweb.min.js
   endif
   ifdef CSSMIN
   gitweb.cgi : gitweb.min.css
   endif

just adding prerequisites to gitweb.css target in gitweb/Makefile


I guess that support for adding minifiction support to git-instaweb
would need to be more complicated.  Perhaps

  $(notdir $(GITWEB_JS))   # Makefile function

or

  $(basename $GITWEB_JS)   # shell command

But I guess that it wouldn't work for all cases...

-- 
Jakub Narebski
Poland
