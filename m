From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: poll() emulation in git
Date: Wed, 05 Sep 2012 17:25:49 +0200
Message-ID: <50476EFD.2000500@gnu.org>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <50474001.5030407@gnu.org> <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
	'Erik Faye-Lund' <kusmabite@gmail.com>, bug-gnulib@gnu.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Sep 05 17:26:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9HUW-0005jl-8W
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 17:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab2IEPZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 11:25:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48817 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab2IEPZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 11:25:58 -0400
Received: by pbbrr13 with SMTP id rr13so1101324pbb.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pQjPgsKrsBhaYBGk0OQPxgzuzQ408JrVtHnyqZQpc+A=;
        b=OhxwqaVFo5yMS2U4lqCrVUyZyfOunirV10UcMDcB2iet9hT905pbK1M3sQFUowZvHF
         zm2WUXYNzf8GzGS8/0w6y2olsP+xRF0NyAwcZeEKwYslNyRJyVVzS5zFKnZJV/cGp+7m
         /Wrs5u2wuRSOXRB3X7NDWGyuEHuLSdMHxMr1fGlZyQilnIUMbaLX0pSsvOdUkUWBG0P3
         bh6N3/yvLl6M/tBbIa5klsO5utHiw9d6FRHksDUiQC5pzUrE4Ku/1bUk1makL3IkHxN/
         u+1v24BLeRu0ytsiSHJMOnX3J74KwJSXB4uVm1fmReoYe1k31bbvUYQX05PrVvbMhlfQ
         V3IA==
Received: by 10.66.87.138 with SMTP id ay10mr49526242pab.38.1346858758132;
        Wed, 05 Sep 2012 08:25:58 -0700 (PDT)
Received: from yakj.usersys.redhat.com (93-34-169-1.ip50.fastwebnet.it. [93.34.169.1])
        by mx.google.com with ESMTPS id qx8sm1620813pbc.63.2012.09.05.08.25.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 08:25:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204831>

Il 05/09/2012 15:36, Joachim Schmitz ha scritto:
>>> > > Does your system have a working FIONREAD ioctl for pipes?
>> > 
>> > It does have FIONREAD ioctl. Whether it works properly is to be determined...
>> > I'll test if you could show me how?
> Oh, now I see what you aimed at, but no, that Mac OS X method doesn't work for me, I tried (at least I think I did).
> 
> And <sys/ioctl.h> has
> /*
>  * Normal IOCTL's supported by the socket interface
>  */
> #define FIONREAD        _IOR(0, 8, _ioctl_int)       /* Num of bytes to read */
> #define FIONBIO         _IOW(0, 9, _ioctl_int)       /* Non-blocking I/O     */
> 
> So these seem to be supported on sockets only, I guess.
> And indeed the man pages for ioctl confirms:
> 
>           Valid values for the request parameter for AF_INET or
>           AF_INET6 sockets are:
> 
> 
>           FIONREAD  Gets the number of bytes available for reading and
>                     stores it at the int pointed at by arg.
> 
> 
> So not even AF_UNIX sockets, not to mention pipes...

So there's no way you can support POLLHUP.  Your system is quite
crippled. :(

Paolo
