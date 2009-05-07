From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] daemon.c: replace inet_ntop with getnameinfo
Date: Thu, 07 May 2009 06:34:10 -0700 (PDT)
Message-ID: <m3tz3xm3zt.fsf@localhost.localdomain>
References: <4A02D288.6040804@googlemail.com> <4A02D70B.6090305@op5.se>
	<EC96A79E-4D4E-467A-A10F-D905FE02E508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, jdl@jdl.com
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 07 15:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M23jy-0001HL-Jv
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 15:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbZEGNeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 09:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbZEGNeN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 09:34:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:48843 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbZEGNeL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 09:34:11 -0400
Received: by rv-out-0506.google.com with SMTP id f6so3324319rvb.5
        for <git@vger.kernel.org>; Thu, 07 May 2009 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=bITJ65YDfI6fnO/AnUnErAmtmU3hJYRCBIDpgPXO+NY=;
        b=Mvfid/ximvbRzxljktekbiScdk0FJNHkL3QNS/Q38dHrUasUkQReD14Irp/NVMxmfx
         1N8BJ+ZDBhBeUct7uNZv5Sx5ExNpOwc+b591dhkI4EeXtZ7TePrR6Q2kjyhK60n5cbFt
         cOd5xTbljSA0L0nWu2m033OumuiBdZsCSr/Q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BamFoc2KBR2aYLiDXwDM/PWoTOMAWofkW4HRrZFTqF5F6mnjbXE7AkWer2PICID+U4
         JBtqpB8lwUdyyRZ9Ns0kroE4RfxJ3jCw2jqIQtsc4abq64BgaIHrdwKOBtJ8n4SR9t2D
         r0V1HJb/ZIDkqKPZfh2nuNA1YCEaRUlq0oGdo=
Received: by 10.114.127.1 with SMTP id z1mr2293496wac.3.1241703251738;
        Thu, 07 May 2009 06:34:11 -0700 (PDT)
Received: from localhost.localdomain (abwr140.neoplus.adsl.tpnet.pl [83.8.241.140])
        by mx.google.com with ESMTPS id m27sm311466pof.16.2009.05.07.06.34.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 06:34:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n47DY5kk003588;
	Thu, 7 May 2009 15:34:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n47DXxiR003584;
	Thu, 7 May 2009 15:33:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <EC96A79E-4D4E-467A-A10F-D905FE02E508@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118476>

Benjamin Kramer <benny.kra@googlemail.com> writes:

> Andreas Ericsson wrote:
> 
> > What per-IP directories are you talking about?
> 
> git daemon has a feature called interpolated paths
> 
> If git daemon is started like this:
>      git daemon --interpolated-path=%IP/%D
> (the machine has two IPs: 123.123.123.123 (v4) and 2001:db8::1 (v6))
> and someone clones a repository:
>      git clone git://123.123.123.123/frotz
> git daemon will look for the repository in the directory
> `123.123.123.123/frotz'
> 
> But if git daemon listens on the IPv6 interface and someone clones a
> repository:
>      git clone git://2001:db8::1/frotz
> Then git daemon will look for the repository in `0.0.0.0/frotz'
> 
> My patch makes it converting IPv6 addresses properly and if you the
> clone in my previous example it'll now look in `2001:db8::1/frotz'
> (with colons in the directory name)

BTW. this is not only MS Windows that have problems with ':' in paths
(because of it being drive letter separator), but also IIRC MacOS X,
where ':' and not '/' is directory separator.

The fact that ':' is separator of paths in $PATH environmental variable
is a bit complication, but you can always escape ':' in $PATH.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
