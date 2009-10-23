From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Fri, 23 Oct 2009 23:06:48 +0200
Message-ID: <20091023210648.GA23122@mx.loc>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
 <20091023202524.GE4615@mx.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: busybox@busybox.net, git@vger.kernel.org
To: vda.linux@googlemail.com
X-From: git-owner@vger.kernel.org Fri Oct 23 23:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1RLC-0001ti-AK
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 23:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbZJWVGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 17:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbZJWVGS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 17:06:18 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41974 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbZJWVGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 17:06:18 -0400
Received: by fxm18 with SMTP id 18so10681525fxm.37
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=r3NxmgL7/eAB02zzXlHr+MeH7q3JeBCbTnf5ONvKgUw=;
        b=UYG++mBeuZKSuylrVdVIlBegcXaKXmuWAxPKHPe9ONmjm4pwL46slvMIXn4Hpw5sPN
         9oFh/1/3V1hgT0XMNAT2/PzijL7/35iBwCvZ+n52+IVaqYPOciWQ1nGTMAfoLTfVnwAu
         OiTTCO4enbPoCNTICkuXSWfoKtqwsiBfSqXfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=A4smUC2N6ssaqgyQ6GBD5EB+xTB6yHT/+CwJnZDTtOu1Ft9OnXvcSlitMwPA6QH1i4
         YB06WhfCABc3S065HEX4OiNU1XgvvfTG0CQqPdHrSbs+S/tl89nGRFffah2yZGoG0Qy6
         5fs8i5aJ08gaM4ERCJLQETO/UZJA+R4ut4Q6A=
Received: by 10.204.33.194 with SMTP id i2mr1118903bkd.146.1256331980734;
        Fri, 23 Oct 2009 14:06:20 -0700 (PDT)
Received: from s42.loc (85-127-251-67.dynamic.xdsl-line.inode.at [85.127.251.67])
        by mx.google.com with ESMTPS id 13sm447270bwz.10.2009.10.23.14.06.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Oct 2009 14:06:19 -0700 (PDT)
Received: from cow by s42.loc with local (Exim 4.69)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1N1RLU-00062P-LZ; Fri, 23 Oct 2009 23:06:48 +0200
Content-Disposition: inline
In-Reply-To: <20091023202524.GE4615@mx.loc>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131133>

On Fri, Oct 23, 2009 at 10:25:24PM +0200, Bernhard Reutner-Fischer wrote:
>On Fri, Oct 23, 2009 at 10:15:43PM +0200, Bernhard Reutner-Fischer wrote:
>>GNU tar-1.22 handles 'o' as no-same-owner only on extract,
>>on create, 'o' would be --old-archive.
>
>FYI this was prompted by:
>
>Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
>
>diff -rdup git-1.6.5.oorig/templates/Makefile git-1.6.5/templates/Makefile
>--- git-1.6.5.oorig/templates/Makefile	2009-10-11 03:42:04.000000000 +0200
>+++ git-1.6.5/templates/Makefile	2009-10-23 21:43:06.000000000 +0200
>@@ -50,4 +50,4 @@ clean:
> install: all
> 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
> 	(cd blt && $(TAR) cf - .) | \
>-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
>+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) x --no-numeric-owner -f -)

argh, sorry! --no-same-owner of course.

>Someone should try to ask the git people not to rely on getopt
>permuting options.. xof would be gentle to folks who don't want
>to turn on getopt_long though.
