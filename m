From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] mingw-multibyte: fix memory acces violation and
 path length limits.
Date: Thu, 3 Oct 2013 19:36:48 +0200
Message-ID: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com>
 <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info>
 <524796DC.5020302@gmail.com> <5249AE2A.3050302@web.de> <524ACFAE.4040701@gmail.com>
 <524C9D8F.2090107@gmail.com> <CALWbr2zDi6XjMCRimUHu2=1qrA_=3ATq+50KBa1aNoBf4X_L9g@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wataru Noguchi <wnoguchi.0727@gmail.com>, =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, git <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRBWOWW2JAKGQESFUVOPY@googlegroups.com Thu Oct 03 19:37:33 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBWOWW2JAKGQESFUVOPY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gg0-f191.google.com ([209.85.161.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBWOWW2JAKGQESFUVOPY@googlegroups.com>)
	id 1VRmqB-0007SQ-GD
	for gcvm-msysgit@m.gmane.org; Thu, 03 Oct 2013 19:37:31 +0200
Received: by mail-gg0-f191.google.com with SMTP id y1sf349544ggc.18
        for <gcvm-msysgit@m.gmane.org>; Thu, 03 Oct 2013 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=EyULI9nO5xWhatxE7II/64LMIbu0v+ZeyPCRA3dfUDI=;
        b=m74iU2du1dxFaUvIZeW8gLLodWZ93mmVIHBloo8E5g/rxOdq11gEv7cIs7eZuVj4KX
         5w41DwuljaV2YVbn/baXjJCslRzO+R/SdSbkKHLPX0ES2FCw05yAVhG0ZNLPQpUSah9/
         P3VolXW0uJsQYzkIxQfePJzK9Mg2+m6euAUR1AlCfL4FmQovPfFsPk1JnDeUwP51p5VZ
         2KBiFZABanRU04SAdoHPUqvdKsF8Su4bmxpG0T8TwyAxMm3WBzYtRSGM7gWVB0kKw1PK
         ldqZf8q8FTO3qIr5rg03KwHDVITLQQJPewPB1EIbiJ5mHkkIr7JylD0io2+hRwSNkYVB
         toZw==
X-Received: by 10.50.61.162 with SMTP id q2mr180643igr.10.1380821850436;
        Thu, 03 Oct 2013 10:37:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.12.2 with SMTP id u2ls615102igb.11.canary; Thu, 03 Oct 2013
 10:37:29 -0700 (PDT)
X-Received: by 10.43.154.8 with SMTP id lc8mr4659659icc.16.1380821849382;
        Thu, 03 Oct 2013 10:37:29 -0700 (PDT)
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com [2607:f8b0:4001:c03::22f])
        by gmr-mx.google.com with ESMTPS id l7si125660igt.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 10:37:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22f as permitted sender) client-ip=2607:f8b0:4001:c03::22f;
Received: by mail-ie0-f175.google.com with SMTP id e14so6177915iej.20
        for <msysgit@googlegroups.com>; Thu, 03 Oct 2013 10:37:28 -0700 (PDT)
X-Received: by 10.43.154.18 with SMTP id lc18mr5780835icc.41.1380821848469;
 Thu, 03 Oct 2013 10:37:28 -0700 (PDT)
Received: by 10.64.249.33 with HTTP; Thu, 3 Oct 2013 10:36:48 -0700 (PDT)
In-Reply-To: <CALWbr2zDi6XjMCRimUHu2=1qrA_=3ATq+50KBa1aNoBf4X_L9g@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22f
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235686>

On Thu, Oct 3, 2013 at 7:25 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> I've not followed the thread so much but, in that
> entry.c::checkout_entry,() we do:
>
> memcpy(path, state->base_dir, len);
> strcpy(path + len, ce->name);
>
> which can of course result in memory violation if PATH is not long enough.
>

...aaand you're spot on. The following patch illustrates it:

$ /git/git-clone.exe mingw-checkout-crash.git
Cloning into 'mingw-checkout-crash'...
done.
fatal: argh, this won't work!
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry the checkout with 'git checkout -f HEAD'

---

diff --git a/entry.c b/entry.c
index acc892f..505638e 100644
--- a/entry.c
+++ b/entry.c
@@ -244,6 +244,9 @@ int checkout_entry(struct cache_entry *ce,
  if (topath)
  return write_entry(ce, topath, state, 1);

+ if (len > PATH_MAX || len + strlen(ce->name) > PATH_MAX)
+ die("argh, this won't work!");
+
  memcpy(path, state->base_dir, len);
  strcpy(path + len, ce->name);
  len += ce_namelen(ce);


> On Thu, Oct 3, 2013 at 12:26 AM, Wataru Noguchi <wnoguchi.0727@gmail.com> wrote:
>> Hi,
>>
>> At last, I foundfollowing Makefile optimization suppression works fine in my
>> case.
>>
>> CFLAGS = -g -O2 -fno-inline-small-functions -Wall
>>
>> Following optimization option cause crash,
>>
>> -finline-small-functions
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

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
