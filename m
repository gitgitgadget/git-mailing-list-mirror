From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 7 May 2008 13:51:46 +0100
Message-ID: <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>
References: <1210149355875-git-send-email-mike@abacus.co.uk>
	 <4821992F.4060201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Brandon Casey" <casey@nrlssc.navy.mil>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 07 14:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtj8P-0001KX-Qc
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 14:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbYEGMvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 08:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbYEGMvt
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 08:51:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:20559 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbYEGMvr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 08:51:47 -0400
Received: by rv-out-0506.google.com with SMTP id l9so350395rvb.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3OGV4ud3Ig51nzCSVHJIb0Bhbimpo2wMzkGNI1etYPc=;
        b=vNYcBRBo3Xyi2ro2DmXH1Uhfy0mt2ggM+4ZuEP0ph0AtQBGz7J4P8UeAGtH7i40RrcePOu9qmqQGFylmVjn21YKS1/cik7puwPLXSV8cNc1gKKuXb0gKDVKMgGQoTd2LuiGoeap7ljJb6rhXhBvbyte7mRg8mNGAN0Wfz4tD4AM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lclJSvfdADWVlCW/dIV/ShlCjyDD63ll40lmGh4Cztz4WUx+2PAIhI1IU08nsyqVSJIYphr6e3bbLSihXbJA/xpol8V28xKEOleEdtIonjgw0xlGwzCBVeffGaVzjtxgebeHELNqDs5Jg/rMB2+waHmaa64Bs1FCIOC7e8QZxI0=
Received: by 10.141.71.8 with SMTP id y8mr948016rvk.32.1210164706964;
        Wed, 07 May 2008 05:51:46 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Wed, 7 May 2008 05:51:46 -0700 (PDT)
In-Reply-To: <4821992F.4060201@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81432>

2008/5/7 Johannes Sixt <j.sixt@viscovery.net>:
>
>  I'm trying this patch on AIX 4.3.3 (sigh!) with gcc3. I get this:
>
>  git-compat-util.h:209:1: warning: "fopen" redefined
>  In file included from git-compat-util.h:51,
>                  from builtin.h:4,
>                  from git.c:1:
>  /usr/local/lib/gcc-lib/powerpc-ibm-aix4.3.2.0/3.2.1/include/stdio.h:110:1:
>  warning: this is the location of the previous definition
>
>  Line 110 in ...include/stdio.h is inside a #ifdef _LARGE_FILES section and
>  says:
>
>  #define fopen fopen64
>
>  Did you also get this warning? Is _LARGE_FILES support solved in a
>  different way on 5.3?

The warning (I get rather a lot of them) is caused by the
compat/fopen.c included when FREAD_READS_DIRECTORIES is defined. I
tried moving the #undef fopen to git-compat-util.h but that resulted
in a broken build and me reaching the end of my limited ability with
c.

In file included from cache.h:4,
                 from daemon.c:1:
git-compat-util.h:209:1: warning: "fopen" redefined
In file included from git-compat-util.h:51,
                 from cache.h:4,
                 from daemon.c:1:
/opt/freeware/lib/gcc-lib/powerpc-ibm-aix5.3.0.0/3.3.2/include/stdio.h:110:1:
warning: this is the location of the previous definition

The warnings are harmless, though untidy.

I don't believe it's anything to do with _LARGE_FILES. Could you try
building first with one commented out, then the other? I don't think I
have access to a 4.3.3 box any more.

Mike
