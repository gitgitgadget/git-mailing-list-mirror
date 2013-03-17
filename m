From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Sun, 17 Mar 2013 23:11:28 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1303172305230.21738@tvnag.unkk.fr>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info> <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com> <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info> <7vk3p9wqh5.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr> <7v4ngcwt4w.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1303151719170.32216@tvnag.unkk.fr>
 <20130316120300.GA2626@sigill.intra.peff.net> <alpine.DEB.2.00.1303162355120.21738@tvnag.unkk.fr> <CALWbr2wQNM=7vUcoragNmKGpSeXkOCsmsM5y1AMhj95i15A4bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, kusmabite@gmail.com,
        git <git@vger.kernel.org>, msysgit@googlegroups.com
To: Antoine Pelisse <apelisse@gmail.com>
X-From: msysgit+bncBCS5LIPSQMEBBG77TCFAKGQEDZ75LDI@googlegroups.com Sun Mar 17 23:12:04 2013
Return-path: <msysgit+bncBCS5LIPSQMEBBG77TCFAKGQEDZ75LDI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCS5LIPSQMEBBG77TCFAKGQEDZ75LDI@googlegroups.com>)
	id 1UHLoB-0005F0-GS
	for gcvm-msysgit@m.gmane.org; Sun, 17 Mar 2013 23:12:03 +0100
Received: by mail-lb0-f185.google.com with SMTP id n1sf1561522lba.12
        for <gcvm-msysgit@m.gmane.org>; Sun, 17 Mar 2013 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf
         :x-authentication-warning:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:x-fromdanielhimself
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=vibHkmQQdoE3Wb5ri9unO9C0vrKYXNHx8o9V5xy1/7M=;
        b=jPZD4yrwtan8S7EKg5NmiD6t3HtEd+ne4MT7vZaqo8souOPhMNhjCGVOWNYXA2KDxj
         FOcHIVMqiZIg2RMAKkeKy1omzx7SqXzfKyr58ciRXsSA6/bV49pau9bZlDOqRASCdvrl
         cX4kZC08aPHxQlxOye52Vs+UCU/VjIdqj88aCe04EbZ44EPOLIF2sWgG9wgW/lh+0MMq
         VSxa7ApptkQAr87acmOkVY5VsoIsmygPMP2FQ/TIpkpHfsmSlVt59mrfVzUCsPl5 
X-Received: by 10.180.75.174 with SMTP id d14mr763167wiw.17.1363558300427;
        Sun, 17 Mar 2013 15:11:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.198.112 with SMTP id jb16ls407412wic.2.canary; Sun, 17 Mar
 2013 15:11:39 -0700 (PDT)
X-Received: by 10.205.24.134 with SMTP id re6mr1143517bkb.7.1363558299418;
        Sun, 17 Mar 2013 15:11:39 -0700 (PDT)
Received: from giant.haxx.se (www.haxx.se. [2a00:1a28:1200:9::2])
        by gmr-mx.google.com with ESMTPS id u1si1170849bkv.1.2013.03.17.15.11.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Mar 2013 15:11:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of daniel@haxx.se designates 2a00:1a28:1200:9::2 as permitted sender) client-ip=2a00:1a28:1200:9::2;
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r2HMBTRO021949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 17 Mar 2013 23:11:29 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r2HMBS1r021941;
	Sun, 17 Mar 2013 23:11:28 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <CALWbr2wQNM=7vUcoragNmKGpSeXkOCsmsM5y1AMhj95i15A4bw@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Original-Sender: daniel@haxx.se
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of daniel@haxx.se designates 2a00:1a28:1200:9::2 as
 permitted sender) smtp.mail=daniel@haxx.se
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218377>

On Sun, 17 Mar 2013, Antoine Pelisse wrote:

>> With redirects taken into account, I can't think of any really good way
>> around avoiding this init...
>
> Is there any way for curl to initialize SSL on-demand ?

Yes, but not without drawbacks.

If you don't call curl_global_init() at all, libcurl will notice that on first 
use and then libcurl will call global_init by itself with a default bitmask.

That automatic call of course will prevent the application from being able to 
set its own bitmask choice, and also the global_init function is not 
(necessarily) thread safe while all other libcurl functions are so the 
internal call to global_init from an otherwise thread-safe function is 
unfortunate.

-- 

  / daniel.haxx.se

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
