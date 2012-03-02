From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [RFC/PATCH] build: avoid possible confusion between GNU/XPG4
 make on Solaris
Date: Fri, 02 Mar 2012 20:00:31 +0100
Message-ID: <4F5118CF.6030402@gmail.com>
References: <df98ed215324f521f3aaff7fa4ba41ba2a1894dc.1330679536.git.stefano.lattarini@gmail.com> <7vhay6etqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 20:00:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Xii-0003az-Bx
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 20:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759085Ab2CBTAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 14:00:43 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:45348 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759034Ab2CBTAm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 14:00:42 -0500
Received: by wejx9 with SMTP id x9so1239352wej.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 11:00:41 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.180.24.7 as permitted sender) client-ip=10.180.24.7;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.180.24.7 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.180.24.7])
        by 10.180.24.7 with SMTP id q7mr7965578wif.14.1330714841683 (num_hops = 1);
        Fri, 02 Mar 2012 11:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=zsejb1SR1Er/JWrM/GlAVJMRq4VCHkIxh6x0rDdpYRU=;
        b=cb7cZ8c4i5fktd5Jo8LA4h7/Ext8lFgnrNwI22n2BWFt5BWmz71bLFGtlowBo1AQVf
         YfxIkBn51CBo625Lx1iMchM0N3T5hG1QCk5cfz1TUIMWNFdh4+vN2SD/BIHz7k2jMc8h
         srl1ZTrS6j9aGwbcEfmEQB9vtE+6HRjFhLdO7t6kFhDk6zE9HX69TnAVAkn/or2GqpeD
         fJdMGu+iQuFf8g4tMVDFZL+zQm/gvhaUHxJBQpxhYq0jm5JMzfVKDFUKUvcQ/zpzl5pR
         smMNaDFSiW/s9REzVazaI54a2PoCPcrs/1p8K9kzOc7yQEInfrwFPVr/Ao356PRcA+Yi
         PwwA==
Received: by 10.180.24.7 with SMTP id q7mr6390237wif.14.1330714841582;
        Fri, 02 Mar 2012 11:00:41 -0800 (PST)
Received: from [79.7.93.100] (host100-93-dynamic.7-79-r.retail.telecomitalia.it. [79.7.93.100])
        by mx.google.com with ESMTPS id hb10sm14174872wib.10.2012.03.02.11.00.39
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 11:00:40 -0800 (PST)
In-Reply-To: <7vhay6etqc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192063>

On 03/02/2012 07:35 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> On a Solaris 10 system with Solaris XPG4 make installed as /usr/xpg4/bin/make,
>> GNU make installed as /usr/local/bin/make, and with /usr/local/bin appearing
>> in $PATH *before* /usr/xpg4/bin, I was seeing errors like this upon invoking
>> "make all":
> 
> After reading this explanation, my first reaction is that the prefixing of
> path _is_ what is wrong.  The prefixing is done to help a subset of
> Solaris users who are unaware of /usr/xpg4/bin that are more POSIX than
> what they have in /usr/bin, and that is what is hurting people like you
> who know what you are doing and have suitable tools in other places, like
> you do in /usr/local/bin.
> 
> And the real fix for your problem is _not_ an ugly override of $(MAKE)
> like you do in this patch, I think.  After all, somebody else who have a
> tool in /usr/local/bin that is saner than what is in /usr/xpg4/bin may
> suffer from the same issue for commands other than "make".
> 
> So the real solution would probably be to let you override how the
> BROKEN_PATH_FIX works, no?
> 
> Ah... and I think we already have such a solution in our Makefile.  Can't
> you override SANE_TOOL_PATH in your config.mak instead?
>
Yes and no.  While in hindsight I agree that using this already-provided
solution is much better than my ugly automatic munging of $(MAKE) (so yes,
let's scrap the present patch), I also think that if one is setting up the
configuration of the Git tree using the the autoconf-generated configure
script (as I do), he wants configure to Do The Right Thing automatically
in this regard too -- thus recognizing that /usr/xpg4/bin is already in
$PATH before /bin and /usr/bin, and setting up an appropriate default for
SANE_TOOL_PATH in 'config.make.autogen' accordingly.

What would you think of a patch in this direction?

Thanks,
  Stefano
