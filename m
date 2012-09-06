From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: poll() emulation in git
Date: Thu, 06 Sep 2012 17:15:02 +0200
Message-ID: <5048BDF6.2000602@gnu.org>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <50474001.5030407@gnu.org> <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de> <50476EFD.2000500@gnu.org> <010301cd8c38$4256bb90$c70432b0$@schmitz-digital.de> <5048B3D0.2070809@gnu.org> <010a01cd8c3e$25609500$7021bf00$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>,
	'Erik Faye-Lund' <kusmabite@gmail.com>, bug-gnulib@gnu.org,
	rsbecker@nexbridge.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:15:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9dnc-0005UO-Jq
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 17:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab2IFPPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 11:15:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47355 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab2IFPPK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 11:15:10 -0400
Received: by pbbrr13 with SMTP id rr13so2639335pbb.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KXPF7MocrZ7xZnQfGo9BE2NU3tF2h7keD3m7bTweYi8=;
        b=ylpJyEt4ZL5y9MlFMMkbdmCE+DufkYc9Qzn3dY+W0oIGuE5dEoEhk8xw+HqT5pWonB
         1hCaPNUrUcVkmDJzQBzwsrAz8LtUWf94/L+Rf2j1bTwXk4PJHgMnqit25M5A2vdTRZGb
         KAus9qWzYHL3b/LQwCCCu7ZoNy+upWJK88HbKAz9XWThRffJjO9O6u6SFIhMfU2HvRFT
         JT9rskaAAIzWEsTarkmzFW1QcvVCGO9phkMyEyNbIudZ5KtMKCCh9HunbHcIHneQRPop
         0/Siju/UFDTeMRiJOq7k54SnKo92fmgpdRADZS4zw2+7F5bGzWa8J98CDVDTVHtnknv4
         9Iuw==
Received: by 10.66.80.202 with SMTP id t10mr3756536pax.70.1346944509651;
        Thu, 06 Sep 2012 08:15:09 -0700 (PDT)
Received: from yakj.usersys.redhat.com (93-34-169-1.ip50.fastwebnet.it. [93.34.169.1])
        by mx.google.com with ESMTPS id uh7sm1488226pbc.35.2012.09.06.08.15.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 08:15:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <010a01cd8c3e$25609500$7021bf00$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204897>

Il 06/09/2012 16:44, Joachim Schmitz ha scritto:
>> > Yes, it's an usleep(autocorrect * 100000) basically (poll takes
>> > milliseconds, not micro).
> OK, it is _supposed_ to do this usleep(), but is does not, as poll() returns early with EFAULT in this case:
>   /* EFAULT is not necessary to implement, but let's do it in the
>      simplest case. */
>   if (!pfd)
>     {
>       errno = EFAULT;
>       return -1;
>     }
> 
> poll() is doing this before calling select(), so won't sleep.
> So there's a bug in {gnulib|git}'s poll(), right?
> 

Yes, it should be "if (!pfd && nfd)".

Paolo
