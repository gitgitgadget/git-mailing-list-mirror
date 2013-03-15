From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Fri, 15 Mar 2013 11:08:17 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info> <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com> <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info> <7vk3p9wqh5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, kusmabite@gmail.com,
        git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCS5LIPSQMEBBGXGROFAKGQEWB3Y4II@googlegroups.com Fri Mar 15 11:08:51 2013
Return-path: <msysgit+bncBCS5LIPSQMEBBGXGROFAKGQEWB3Y4II@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f55.google.com ([209.85.161.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCS5LIPSQMEBBGXGROFAKGQEWB3Y4II@googlegroups.com>)
	id 1UGRZB-0005D4-7V
	for gcvm-msysgit@m.gmane.org; Fri, 15 Mar 2013 11:08:49 +0100
Received: by mail-fa0-f55.google.com with SMTP id t1sf981276fae.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Mar 2013 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf
         :x-authentication-warning:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:x-fromdanielhimself
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=GfLJFs8vZiL70huNq0zpE6oD75i9nA6dfNbA3kKE0Qo=;
        b=brWnuhk0rIfMhg3PyynX+71VPJQwHND3V5ojWtBaGH34fLWUFnPRqck/Gz1jajLLm/
         w7+F5Iu4fGKRgO0amjTss0Dgt+jZJvrefkJZ4oeajK3GJwe4+TZhVCyGEnuHcb3wqh7X
         8EZuNAA7FEhZaSE+oHkB08ryELWdKMbBRXFC5LSRvICyjFUboYPQ8q7wjBfLL7+DDhnW
         TpCCJflo9yMsODEi5Hi1bQNAIGgkAKR60cAF2Hi3bgSF20waN5sAToiPs3tL6rXl 
X-Received: by 10.180.72.232 with SMTP id g8mr84917wiv.15.1363342106586;
        Fri, 15 Mar 2013 03:08:26 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.109.47 with SMTP id hp15ls2154224wib.33.canary; Fri, 15
 Mar 2013 03:08:26 -0700 (PDT)
X-Received: by 10.204.150.5 with SMTP id w5mr676180bkv.0.1363342106050;
        Fri, 15 Mar 2013 03:08:26 -0700 (PDT)
Received: from giant.haxx.se (www.haxx.se. [2a00:1a28:1200:9::2])
        by gmr-mx.google.com with ESMTPS id s1si514034bkt.3.2013.03.15.03.08.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 03:08:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of daniel@haxx.se designates 2a00:1a28:1200:9::2 as permitted sender) client-ip=2a00:1a28:1200:9::2;
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r2FA8I0T021262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 15 Mar 2013 11:08:18 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r2FA8HNa021256;
	Fri, 15 Mar 2013 11:08:18 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <7vk3p9wqh5.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218235>

On Thu, 14 Mar 2013, Junio C Hamano wrote:

> As to ALL vs DEFAULT, given that its manual page is riddled with a scary 
> warning:
>
>    This function must be called at least once within a program (a
>    program is all the code that shares a memory space) before the
>    program calls any other function in libcurl. The environment it sets
>    up is constant for the life of the program and is the same for every
>    program, so multiple calls have the same effect as one call.  ... In
>    normal operation, you must specify CURL_GLOBAL_ALL. Don't use any
>    other value unless you are familiar with it and mean to control
>    internal operations of libcurl.

(speaking from a libcurl perspective)

The "warning" is just there to scare people into actually consider what they 
want and understand that removing bits will change behavior. I would say 
that's exactly what you've done and I don't think people here need to be 
scared anymore! :-)

As for how ALL vs DEFAULT will act or differ in the future, I suspect that we 
will end up having them being the same (even when we add bits) as we've 
encouraged "ALL" in the documentation like this for quite some time.

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
