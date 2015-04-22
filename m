From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] stop putting argv[0] dirname at front of PATH
Date: Wed, 22 Apr 2015 12:23:17 -0700
Message-ID: <20150422192317.GI5467@google.com>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
 <xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
 <CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
 <20150416061732.GA5612@peff.net>
 <xmqq1tjcf432.fsf@gitster.dls.corp.google.com>
 <20150422181402.GB3535@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David =?iso-8859-1?Q?Rodr=EDguez?= <deivid.rodriguez@gmail.com>,
	Matthew Rothenberg <mroth@khanacademy.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:23:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0F4-0006uH-27
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbbDVTXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:23:21 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34036 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbbDVTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:23:20 -0400
Received: by iedfl3 with SMTP id fl3so50890536ied.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q+t9F6Y6xorTlbkfrYkfax1tIftJdSaUEzGZqPKxnG8=;
        b=mWaawn4VfCZvEc8gz4iyGhqocveDJTYqyGI9vZh0/Yu31nyZyGr5wniRCBf5/RND/W
         cN+373kqZEh/tgJCScMW3nfIjJwPgRcRxegrCBfJnzLoPwtaKjjO/tYFnopaBzu1UBeb
         JWvY69JiGKvsHCCF8h+Lc38QYAPHxE/esRLAA3J5gB/TdKWNT63K0npY/0h7hRMU8ZFi
         xqWOQpbFjHuRNcU1bcWoelH/WdE647dBXtPstuAZAPa33oRg+nBEOGGBC0qKLl1vWnZQ
         7InbrWU9qPsudoWN38qfD4MnItO1MRscrdcqQoT8ehNJazHII2BSskppoL54w5VRh8kK
         FePg==
X-Received: by 10.50.8.6 with SMTP id n6mr6839245iga.12.1429730599957;
        Wed, 22 Apr 2015 12:23:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b9fd:40db:80c1:a5bc])
        by mx.google.com with ESMTPSA id ys3sm3909929igb.4.2015.04.22.12.23.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Apr 2015 12:23:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150422181402.GB3535@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267616>

Hi,

Jeff King wrote:

>                                         This was added long
> ago by by 231af83 (Teach the "git" command to handle some
> commands internally, 2006-02-26), with the intent that
> things would just work if you did something like:
>
>   cd /opt
>   tar xzf premade-git-package.tar.gz
>   alias git=/opt/git/bin/git
>
> as we would then find all of the related external commands
> in /opt/git/bin. I.e., it made git runtime-relocatable,
> since at the time of 231af83, we installed all of the git
> commands into $(bindir).
[...]
>                                                          And
> not just for finding binaries; we want to find $(sharedir),
> etc, the same way.  The RUNTIME_PREFIX build knob does this
> the right way

Makes sense.  For the reason you say (templatedir, etc) I am surprised
to hear that that was the motivation, but I can't find any other.

[...]
> Signed-off-by: Jeff King <peff@peff.net>

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
>                                          But note that you can't just
> flip on RUNTIME_PREFIX on non-Windows systems, as some invocations will
> get the full path to the executable, and others see just "git". You'd
> need to convert that into an absolute path (either by searching the
> $PATH, or doing something system-specific like looking in /proc/$$/exe).

Yep --- /proc/self/exe should work okay if someone wants "portable
git" to work on Linux.

Thanks,
Jonathan
