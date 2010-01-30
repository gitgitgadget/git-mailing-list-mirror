From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Implement pthread_cond_broadcast on Windows
Date: Sat, 30 Jan 2010 10:30:36 +0100
Message-ID: <201001301030.36395.j6t@kdbg.org>
References: <4B62CEAB.5050608@viscovery.net> <201001300054.05610.j6t@kdbg.org> <alpine.DEB.1.00.1001300328070.3749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
 =?iso-8859-1?q?Zolt=E1n_F=FCzesi?= <zfuzesi@eaglet.hu>,
 git@vger.kernel.org,
 msysGit Mailinglist <msysgit@googlegroups.com>,
 Dmitry Potapov <dpotapov@gmail.com>,
 "Andrzej K. Haczewski" <ahaczewski@gmail.com>,
 "Erik Faye-Lund" <kusmabite@googlemail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: 3iPxjSwMIBzQZwjaTRW.ehWcioiWYjWeeWbUWhekfi.Sec@groups.bounces.google.com Sat Jan 30 10:32:13 2010
Return-path: <3iPxjSwMIBzQZwjaTRW.ehWcioiWYjWeeWbUWhekfi.Sec@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f144.google.com ([209.85.211.144])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3iPxjSwMIBzQZwjaTRW.ehWcioiWYjWeeWbUWhekfi.Sec@groups.bounces.google.com>)
	id 1Nb9ga-0000Hf-6s
	for gcvm-msysgit@m.gmane.org; Sat, 30 Jan 2010 10:32:12 +0100
Received: by ywh8 with SMTP id 8sf5815798ywh.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 30 Jan 2010 01:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding:content-disposition;
        bh=B0XYXa0u02WHdOJH/7YDKtyspQyL/15flG9ZIjx4FEE=;
        b=vZlFCUXGqS+2hgD19u7Kg1lGpFemrsIB/emXXl6duqnX6J8awmDGYuEGWT+48X9HHl
         mI7jAh3Ykff8OGOgdqp33TwVmL6tOmAFgfL4q881e5L3JcDebRjzH09l+sSVwMJOFU8w
         USQzEz9SLc6AAmBTX9tFpw5YHeKXLbQG91rBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding:content-disposition;
        b=6dajANjVWngGHWbFnzRgKTCCnx2crbOSjoxdsF5XWpacQ76XhJ5tlszpvyqQTWyVaY
         Iofz0kN6WsfpcN163Ku//nqY0PLXckDB3dI2Ju1YA9hpsv4BkOvA/D9tYwUgkxShdwXE
         amKDdP+xpN5keVIKAQNXmiEQdLlAzIZA2oFy4=
Received: by 10.101.139.7 with SMTP id r7mr124321ann.41.1264843912950;
        Sat, 30 Jan 2010 01:31:52 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.26.205 with SMTP id f13ls752698bkc.0.p; Sat, 30 Jan 2010 
	01:31:51 -0800 (PST)
Received: by 10.204.135.211 with SMTP id o19mr72095bkt.0.1264843911208;
        Sat, 30 Jan 2010 01:31:51 -0800 (PST)
Received: by 10.204.135.211 with SMTP id o19mr72094bkt.0.1264843911179;
        Sat, 30 Jan 2010 01:31:51 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 18si280938bwz.5.2010.01.30.01.31.51;
        Sat, 30 Jan 2010 01:31:51 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2AF462C400D;
	Sat, 30 Jan 2010 10:31:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E014519F5EC;
	Sat, 30 Jan 2010 10:30:36 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.1001300328070.3749@intel-tinevez-2-302>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/fbe15dd7865ea1e5
X-Message-Url: http://groups.google.com/group/msysgit/msg/e74d8b7335b56e43
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138471>

On Samstag, 30. Januar 2010, Johannes Schindelin wrote:
> Hi,
>
> On Sat, 30 Jan 2010, Johannes Sixt wrote:
> > See http://www.cse.wustl.edu/~schmidt/win32-cv-1.html, section "The
> > SignalObjectAndWait solution". But note that this implementation does not
> > use SignalObjectAndWait (which is needed to achieve fairness, but we do
> > not need fairness).
> >
> > Note that our implementations of pthread_cond_broadcast and
> > pthread_cond_signal require that they are invoked with the mutex held
> > that is used in the pthread_cond_wait calls.
> >
> > Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> > ---
> >  Junio,
> >
> >  please queue this patch for 1.7.0-rc1 even though it has not undergone
> >  a lot of review - the result is better than a git that does not even
> >  build on Windows.
>
> As you Cc:ed the msysGit list, do you want this in 4msysgit.git, too?

I hope some clever people on the msysgit list can say aye or nay to this 
patch. If you intend to release an msysgit that contains 5b594f4 (Threaded 
grep), then you need *something*, otherwise the build fails. Whether you get 
that something via upstream or apply it directly is of course secondary, but 
I prefer the former. ;)

-- Hannes
