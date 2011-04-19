From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 00/11] gitweb: Change timezone in dates using JavaScript
Date: Tue, 19 Apr 2011 08:36:15 +0200
Message-ID: <201104190836.16221.jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com> <7vei4z6omh.fsf@alter.siamese.dyndns.org> <201104190326.29922.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 08:36:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC4Y6-0000um-8y
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 08:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab1DSGg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 02:36:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55233 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab1DSGg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 02:36:28 -0400
Received: by wya21 with SMTP id 21so4532400wya.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=q/T5uZlyWTz7zcFnEdtBGgwEfxxZuVvpYeE1siwHiu4=;
        b=N1Iurl72sK29Quk/Im2I2nPwtPX/oGryRgfN7G1IvIt3QFGwPj2rYotvITztRBQeLS
         qkY/z/LcyZDRSQbB/4svW61qQnBk1JzNRDriswAMEkO7gxJa7RtadcCTjCxAQjOlKUgl
         XBbrnofGDgADbauoyq12FzClU9TdcPWHpqPM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FeFuakyytSCGlMaf07E3f1f0Lh8CqI2ULqT0H+n1BN1pjWT11GrvzxQecDfNRwyu9v
         SFDFs7o5qPlZOvrkM8jpZwX+CkuXdnAZG1DC8F+9c7kGXcZpcO4WHfdBur5vyK8htbgn
         yETxqz4/F6p447Z1ajwB74fB1xfm8R20HBhfU=
Received: by 10.227.28.8 with SMTP id k8mr5988577wbc.159.1303194986923;
        Mon, 18 Apr 2011 23:36:26 -0700 (PDT)
Received: from [192.168.1.13] (abvc126.neoplus.adsl.tpnet.pl [83.8.200.126])
        by mx.google.com with ESMTPS id bs4sm3678656wbb.1.2011.04.18.23.36.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Apr 2011 23:36:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201104190326.29922.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171775>

Jakub Narebski wrote:
> Junio C Hamano wrote:
> 
> > This seems to break the build like this, by exposing a lack of dependency
> > somewhere in the Makefile:
> > 
> >     ...
> >     SUBDIR gitweb
> > make: *** No rule to make target `gitweb/static/gitweb.js', needed by `git-instaweb'.  Stop.
> > make: *** Waiting for unfinished jobs....
> > 
> 
> Ah, thanks for report. and sorry for the bug.
> 
> This bug is caused by the fact that main Makefile doesn't know (as it should)
> that gitweb.js is now generated file.

Perhaps something like that would be a good change, what do you think?

-- >8 --
diff --git i/Makefile w/Makefile
index cbc3fce..8960cee 100644
--- i/Makefile
+++ w/Makefile
@@ -1773,7 +1773,7 @@ gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
 endif # CSSMIN
 
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js
+git-instaweb: git-instaweb.sh gitweb
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
