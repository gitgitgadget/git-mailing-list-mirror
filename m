From: Wataru Noguchi <wnoguchi.0727@gmail.com>
Subject: Re: [PATCH] mingw-multibyte: fix memory acces violation and
 path length limits.
Date: Tue, 01 Oct 2013 22:37:39 +0900
Message-ID: <524AD023.4040804@gmail.com>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com> <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info> <524796DC.5020302@gmail.com> <5248088F.2060902@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Stefan Beller <stefanbeller@googlemail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDD7TRGTWYIBBKFAVOJAKGQEP24UANA@googlegroups.com Tue Oct 01 15:37:46 2013
Return-path: <msysgit+bncBDD7TRGTWYIBBKFAVOJAKGQEP24UANA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f58.google.com ([209.85.219.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDD7TRGTWYIBBKFAVOJAKGQEP24UANA@googlegroups.com>)
	id 1VR093-0002GM-Jh
	for gcvm-msysgit@m.gmane.org; Tue, 01 Oct 2013 15:37:45 +0200
Received: by mail-oa0-f58.google.com with SMTP id l10sf1494783oag.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Oct 2013 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=B2HYCDkWo7sqIhzo4Hz6b1M7RrGyIE2XFKT0GKXF9N0=;
        b=fifK7LAuHvBpQGo/X81jMT4B/Eyz/D1MzOtxtjywG0xiYtthW4/0W2QHI6DeaI+5Qm
         L06KAJwZvSfUB9c2BfT21jnESmZOPZ0AKiIU4JHtNir5Bo5sXzt52nWs79agoWt647hm
         +GJLZBT/6KdXx1HAe8oBD9Co7yCdLsF1D6rYC5jhTwjFlTgmGgLxjYlJpM4UcSy5LCAv
         5VwroMmZramyGJ96WPPluhhpl4+Sek7Y4YJXK/gTo227wMufpzEvtN/LVKbU3mPpqBcw
         paHUx2huBOU/ZoDF4gN6MdXImUl9/9S5VAns38UHSiXSojyxOAsypCnJi86l9uGEt2Y+
         As9g==
X-Received: by 10.50.80.78 with SMTP id p14mr652173igx.6.1380634664582;
        Tue, 01 Oct 2013 06:37:44 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.131.163 with SMTP id on3ls131318igb.19.gmail; Tue, 01 Oct
 2013 06:37:44 -0700 (PDT)
X-Received: by 10.66.172.79 with SMTP id ba15mr29259102pac.26.1380634663958;
        Tue, 01 Oct 2013 06:37:43 -0700 (PDT)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com [2607:f8b0:400e:c03::231])
        by gmr-mx.google.com with ESMTPS id dk16si947888pac.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 06:37:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c03::231 as permitted sender) client-ip=2607:f8b0:400e:c03::231;
Received: by mail-pa0-x231.google.com with SMTP id ld10so7451361pab.36
        for <msysgit@googlegroups.com>; Tue, 01 Oct 2013 06:37:43 -0700 (PDT)
X-Received: by 10.66.234.131 with SMTP id ue3mr33211803pac.35.1380634663890;
        Tue, 01 Oct 2013 06:37:43 -0700 (PDT)
Received: from [192.168.1.4] (p4168-ipbf905akatuka.ibaraki.ocn.ne.jp. [219.114.17.168])
        by mx.google.com with ESMTPSA id ye1sm8339918pab.19.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 06:37:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <5248088F.2060902@googlemail.com>
X-Original-Sender: wnoguchi.0727@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c03::231
 as permitted sender) smtp.mail=wnoguchi.0727@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235660>

Hi,

Thanks for your advice.

I see. I'll try following tool for optimization affection.

Thanks.

(2013/09/29 20:01), Stefan Beller wrote:
> On 09/29/2013 04:56 AM, Wataru Noguchi wrote:
>>
>> - gcc optimization level is O2.(fail)
>> - gcc O0, O1 works fine.
>
> Maybe you could try to compile with
> STACK found at http://css.csail.mit.edu/stack/
> That tool is designed to find
> Optimization-unstable code.
>
>
>

-- 
=========================================
   Wataru Noguchi
   wnoguchi.0727@gmail.com
   http://wnoguchi.github.io/
=========================================

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
