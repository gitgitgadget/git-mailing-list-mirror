From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Sun, 20 Oct 2013 19:57:28 +0200
Message-ID: <CALWbr2z1RmLLNa3Cj+n6g=zu5FB4VZSmRTU1qYb86pXLfYGJGg@mail.gmail.com>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
	<1382179954-5169-1-git-send-email-apelisse@gmail.com>
	<52636E5A.1080909@web.de>
	<CACsJy8AXV=KJtTWxp6dpfa_Pr81h3YwW5EK=c_dV=F7tr7ChWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	Git Mailing List <git@vger.kernel.org>, Wataru Noguchi <wnoguchi.0727@gmail.com>, 
	Erik Faye-Lund <kusmabite@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBD3NZH6HQMJBBCFTSCJQKGQETMPRELA@googlegroups.com Sun Oct 20 19:57:29 2013
Return-path: <msysgit+bncBD3NZH6HQMJBBCFTSCJQKGQETMPRELA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f55.google.com ([74.125.83.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD3NZH6HQMJBBCFTSCJQKGQETMPRELA@googlegroups.com>)
	id 1VXxFp-0003dK-G7
	for gcvm-msysgit@m.gmane.org; Sun, 20 Oct 2013 19:57:29 +0200
Received: by mail-ee0-f55.google.com with SMTP id b45sf402726eek.20
        for <gcvm-msysgit@m.gmane.org>; Sun, 20 Oct 2013 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=Cl2ThjrvocBLn0e3L11ESgrdRSSkei94DrNbCSf0oSE=;
        b=ogZFAFd23E3pQiGJHTwDWpcxILCmXrOsGT5LKGhrATvZzSdXBIz5MjSvPh8PiMKR8T
         +ZpbdcTahXRo4Txy6gPJPqx/rc0Ch8ujnlv1uRu5ihso+YSDg3byRq5ceDzRvCfpkUVH
         NT+3mokoFRWbkc5HC4xdrZhgWXrwsmg0K3WC8Uj5Sw2mn7SYd9tY3xHpDIn2P8hGzgc0
         nAesPUqFLoO83gSUwGrEdJbYhcxYCW9Vua8GVcqvFvsB5DR8yWGyQOLlQnQOgFT1DDZV
         oK8xIPSaDGtpj//Y+j4EvwIhTK1T0MV4soXc025tqBjcKWoQ6tL0neEZEgp5uxWurhxj
         Xtgg==
X-Received: by 10.152.120.129 with SMTP id lc1mr34748lab.7.1382291849229;
        Sun, 20 Oct 2013 10:57:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.5.2 with SMTP id o2ls395056lao.29.gmail; Sun, 20 Oct 2013
 10:57:28 -0700 (PDT)
X-Received: by 10.112.171.230 with SMTP id ax6mr581720lbc.20.1382291848571;
        Sun, 20 Oct 2013 10:57:28 -0700 (PDT)
Received: from mail-lb0-x22d.google.com (mail-lb0-x22d.google.com [2a00:1450:4010:c04::22d])
        by gmr-mx.google.com with ESMTPS id qy6si917498bkb.3.2013.10.20.10.57.28
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Oct 2013 10:57:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of apelisse@gmail.com designates 2a00:1450:4010:c04::22d as permitted sender) client-ip=2a00:1450:4010:c04::22d;
Received: by mail-lb0-f173.google.com with SMTP id w7so707944lbi.18
        for <msysgit@googlegroups.com>; Sun, 20 Oct 2013 10:57:28 -0700 (PDT)
X-Received: by 10.112.132.70 with SMTP id os6mr805331lbb.38.1382291848224;
 Sun, 20 Oct 2013 10:57:28 -0700 (PDT)
Received: by 10.112.50.240 with HTTP; Sun, 20 Oct 2013 10:57:28 -0700 (PDT)
In-Reply-To: <CACsJy8AXV=KJtTWxp6dpfa_Pr81h3YwW5EK=c_dV=F7tr7ChWQ@mail.gmail.com>
X-Original-Sender: apelisse@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of apelisse@gmail.com designates 2a00:1450:4010:c04::22d
 as permitted sender) smtp.mail=apelisse@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236420>

My main motive was to not *stop* the process when a long path is met.
Because somebody created a repository on Linux with a long file-name
doesn't mean you should not be able to clone it *at all* on Windows.

On Sun, Oct 20, 2013 at 12:33 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 20, 2013 at 12:47 PM, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>> I'm not sure how to handle overlong path in general, there are several w=
ays:
>> a) Silently overwrite memory (with help of memcpy() and/or strcpy()

This one stop the process, as the application crashes :-)

>> b) Silently shorten the path using strlcpy() instead of strcpy()

I was expecting this solution to fail later in a non-blocking way
(e.g. "Can't checkout file $truncated_path, continuing with other
files"). Maybe it would be better to look at each specific call site
and see if there is a way to report a problem ('return error("Can't
checkout %s: path too long")')

>> c) Avoid the overwriting and call die().

This one also stops the process, with an error (of course that's
better than point a)

>> d) Prepare a longer buffer using xmalloc()
> d+) Use strbuf

This of course looks like the best solution, but I believe PATH_MAX
exists for a reason, and maybe we can't simply ignore that value ?

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
