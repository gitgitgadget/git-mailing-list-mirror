From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [RFC/PATCH] build: avoid possible confusion between GNU/XPG4
 make on Solaris
Date: Fri, 02 Mar 2012 10:41:42 +0100
Message-ID: <4F5095D6.6050401@gmail.com>
References: <df98ed215324f521f3aaff7fa4ba41ba2a1894dc.1330679536.git.stefano.lattarini@gmail.com> <87obsfcpnc.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:42:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Ozv-0000Va-Bw
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 10:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291Ab2CBJlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 04:41:51 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33955 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252Ab2CBJls (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 04:41:48 -0500
Received: by bkcik5 with SMTP id ik5so1303515bkc.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 01:41:46 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.204.133.220 as permitted sender) client-ip=10.204.133.220;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.204.133.220 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.204.133.220])
        by 10.204.133.220 with SMTP id g28mr4877910bkt.16.1330681306875 (num_hops = 1);
        Fri, 02 Mar 2012 01:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=CiUIt9JbpPhUktoHn041E5JiD8Z0mxdLR8ZGW7aOLmE=;
        b=glTeEyWcg2LhKCcSpjDaS85lg0yZrU/umOuhImpGlC6ZHoTzNPmaZ4rV/Bg1nDD9RX
         m/62szWgQsDgJfs0oU67tQSOnydgq4oGgTW6d3oBC3bF/0+LpamPFWISq/lHe77XC86b
         QuiuzD/tupvMQOI6s96vVXRzKUXFO9aQIG9eVwVZMtAA7rhAtPGStDGCrwLbzxCPSf/c
         fwJk8o0mLca0U/qWOCXw9hMsP/Hs81riw/qLanVxSOUduVRXqc19InMzsbSRrpksvEh9
         yAlCAzHzoSspZQdKQ3Gek0G6vWz2euNnJvDxkpWqaxMM0x0Sjxz9h11ohhEpTmn0J88z
         eLQw==
Received: by 10.204.133.220 with SMTP id g28mr3919919bkt.16.1330681306762;
        Fri, 02 Mar 2012 01:41:46 -0800 (PST)
Received: from [79.0.100.115] (host115-100-dynamic.0-79-r.retail.telecomitalia.it. [79.0.100.115])
        by mx.google.com with ESMTPS id d5sm8338093bkb.3.2012.03.02.01.41.44
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 01:41:45 -0800 (PST)
In-Reply-To: <87obsfcpnc.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192019>

On 03/02/2012 10:34 AM, Thomas Rast wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> +# FIXME: this is ugly, and which(1) is quite unportable.  Find a better
>> +# 	 way to obtain the same effect.
>> +MAKE := $(shell set $(MAKE); m1=$$1; shift; \
>> +                m2=`which $$m1 2>/dev/null` && test -n "$$m2" || m2=$$m1; \
>> +                echo "$$m2 $$*")
> 
> There's 'command -v make'.  'man 1p command' on my system (opensuse
> installs a bunch of POSIX reference material) says
> 
>        -v     (On  systems  supporting  the  User  Portability Utilities
>               option.) Write a string to standard output that  indicates
>               the pathname or command that will be used by the shell, in
>               the current shell execution environment (see Shell  Execu-
>               tion  Environment  ),  to  invoke command_name, but do not
>               invoke command_name.
> 
>                * Utilities, regular  built-in  utilities,  command_names
>                  including  a  slash  character, and any implementation-
>                  defined functions that are found using the  PATH  vari-
>                  able  (as  described in Command Search and Execution ),
>                  shall be written as absolute pathnames.
> 
> So perhaps enough systems including Solaris "support the User
> Portability Utilities option", and you can use this?
> 
Thanks, I had completely forgotten about this "trick".  It works correctly
with both /bin/sh and /bin/ksh on all of NetBSD 5.1, OpenBSD 5.0 and
Solaris 10, as well as with bash (4.1.5) and dash (0.5.5.1) on my Debian
unstable.  I will post an updated patch later today (or this evening).

Regards,
  Stefano
