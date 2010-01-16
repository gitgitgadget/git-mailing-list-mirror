From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 11:44:55 +0100
Message-ID: <201001161144.55263.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <201001160908.33996.j6t@kdbg.org> <40aa078e1001160114k5ce0414et7cd645724973609b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com,
 git@vger.kernel.org
To: kusmabite@gmail.com
X-From: 34phRSwMIBxg7UH81z4.CF4AGMG46H4CC4924FCIDG.0CA@listserv.bounces.google.com Sat Jan 16 11:46:13 2010
Return-path: <34phRSwMIBxg7UH81z4.CF4AGMG46H4CC4924FCIDG.0CA@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f141.google.com ([209.85.210.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW6AX-0003sT-0w
	for gcvm-msysgit@m.gmane.org; Sat, 16 Jan 2010 11:46:13 +0100
Received: by yxe5 with SMTP id 5sf305178yxe.24
        for <gcvm-msysgit@m.gmane.org>; Sat, 16 Jan 2010 02:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding:content-disposition;
        bh=3x70yZGC7tvsbtQvUS1DVxH1Zz2EkEP593PggJGsu0k=;
        b=Zi7CV6s0z+EVdEKQ9UbpTpD9TQuelAN3qI0pJRivCJDBDP1MoqtaDoYj2wXUCB6sF+
         9OP4OaIu/RF9mOuQYZCPcxB8KtzEBA3WtD0CoEJQCgkATwth/FU6NdtFDajqJ89+dZ04
         R+Z393hLpvGDqv24j1JhQZry6Yj8YaD0k69gU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding:content-disposition;
        b=1K/8wzRW5aCMgswUwKZQPrbKn5KmA1zjo8pfXHlSsQB99vpbmQFXC/Zu6hT4suY7hi
         QE+fnhCgXgD1bMxiFh2qETZQJoetwjowaKnzGp5HW4z8WaqoPRC5dNPTIuOyKBh2DhRo
         OEnJo9VcnOhCGoBHzghRjJjiZIPez1pRcUMWY=
Received: by 10.101.179.34 with SMTP id g34mr263872anp.22.1263638754893;
        Sat, 16 Jan 2010 02:45:54 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.16.66 with SMTP id n2ls363233bka.1.p; Sat, 16 Jan 2010 
	02:45:53 -0800 (PST)
Received: by 10.204.13.70 with SMTP id b6mr113061bka.17.1263638753784;
        Sat, 16 Jan 2010 02:45:53 -0800 (PST)
Received: by 10.204.13.70 with SMTP id b6mr113060bka.17.1263638753759;
        Sat, 16 Jan 2010 02:45:53 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 17si252104bwz.8.2010.01.16.02.45.53;
        Sat, 16 Jan 2010 02:45:53 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7FE3310017;
	Sat, 16 Jan 2010 11:45:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5ACEA19F6CB;
	Sat, 16 Jan 2010 11:44:55 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1001160114k5ce0414et7cd645724973609b@mail.gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/5542c3956e082229
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137218>

On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
> On Sat, Jan 16, 2010 at 9:08 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> > Wouldn't it be possible to call getsockopt(), and if it returns ENOTSOCK
> > (WSAENOTSOCK), then it is a pipe?
>
> I read reports that this didn't work in Wine. Not that I care that
> much about Wine.

What does it mean that "it does not work"? Is it that it does not return 
ENOTSOCK, so that we mistake pipes as sockets?

-- Hannes
