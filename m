From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] mingw-multibyte: fix memory acces violation and
 path length limits.
Date: Mon, 30 Sep 2013 23:02:05 +0200
Message-ID: <CABPQNSbsySuqyb-KucGMgnUVG1zSttkgUxsXPYzp=68YdGV7cA@mail.gmail.com>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com>
 <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info>
 <524796DC.5020302@gmail.com> <5249AE2A.3050302@web.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Wataru Noguchi <wnoguchi.0727@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, GIT Mailing-list <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
X-From: msysgit+bncBDR53PPJ7YHRB5WNU6JAKGQEF44WXVY@googlegroups.com Mon Sep 30 23:02:51 2013
Return-path: <msysgit+bncBDR53PPJ7YHRB5WNU6JAKGQEF44WXVY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f58.google.com ([209.85.219.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB5WNU6JAKGQEF44WXVY@googlegroups.com>)
	id 1VQkcB-00079q-IU
	for gcvm-msysgit@m.gmane.org; Mon, 30 Sep 2013 23:02:47 +0200
Received: by mail-oa0-f58.google.com with SMTP id l10sf1253550oag.13
        for <gcvm-msysgit@m.gmane.org>; Mon, 30 Sep 2013 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=YQamylA2LIf/8+Cl5wmtN2KCGEyrtVzqzed648rJqdw=;
        b=Be2cH60u1KqYrS+rh2jqhZo+19LR3hkDGPcXXjnf52MdEuH5Bv9Lt//bmzF5OlBsee
         ndMomOfknv2JGaHTwtRtbbDcMOBO9B4cAUVVcCLFSfD++gG+wFvpp91+Dv1iOHrZUAy+
         TZFI4xQNtLtLhv+DprDIy1IyE9gEU2cxSsTdS9LNmYwxdam6rs6rfXlPMRqHxOY2DQtF
         k3pYM6c0KnEyTChXtuyzfXWJdqkpCSgNXUGxEXPNcv4JtBFzCSoGbBmxcZ2JUFi0X+Kr
         CKo3YCJG6cgifOxMienU+2tJNMiCY4RU1cBDfsmwRLcjMmZirFFgyQFpR53DQHsCx9v0
         llKQ==
X-Received: by 10.50.66.101 with SMTP id e5mr549083igt.12.1380574966601;
        Mon, 30 Sep 2013 14:02:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.148.69 with SMTP id tq5ls2037712igb.12.gmail; Mon, 30 Sep
 2013 14:02:45 -0700 (PDT)
X-Received: by 10.42.210.68 with SMTP id gj4mr15141332icb.1.1380574965903;
        Mon, 30 Sep 2013 14:02:45 -0700 (PDT)
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com [2607:f8b0:4001:c03::232])
        by gmr-mx.google.com with ESMTPS id 8si1990922igl.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 14:02:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::232 as permitted sender) client-ip=2607:f8b0:4001:c03::232;
Received: by mail-ie0-x232.google.com with SMTP id to1so11346790ieb.23
        for <msysgit@googlegroups.com>; Mon, 30 Sep 2013 14:02:45 -0700 (PDT)
X-Received: by 10.43.106.198 with SMTP id dv6mr2767775icc.51.1380574965712;
 Mon, 30 Sep 2013 14:02:45 -0700 (PDT)
Received: by 10.64.249.33 with HTTP; Mon, 30 Sep 2013 14:02:05 -0700 (PDT)
In-Reply-To: <5249AE2A.3050302@web.de>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::232
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235626>

On Mon, Sep 30, 2013 at 7:00 PM, Ren=E9 Scharfe <l.s.r@web.de> wrote:
> Am 29.09.2013 04:56, schrieb Wataru Noguchi:
>> Hi,
>>
>> Thanks for comments.
>>
>> My currently working repository is
>>
>> https://github.com/wnoguchi/git/tree/hotfix/mingw-multibyte-path-checkou=
t-failure
>>
>> I have revert commits to 1f10da3.
>> I'll try failure step.
>>
>> - gcc optimization level is O2.(fail)
>> - gcc O0, O1 works fine.
>>
>>
>> $ gdb git-clone
>> GNU gdb 6.8
>> Copyright (C) 2008 Free Software Foundation, Inc.
>> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.=
html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law.  Type "show copyin=
g"
>> and "show warranty" for details.
>> This GDB was configured as "i686-pc-mingw32"...
>> (gdb) r https://github.com/wnoguchi/mingw-checkout-crash.git
>> Starting program: C:\msysgit\git/git-clone.exe https://github.com/wnoguc=
hi/mingw
>> -checkout-crash.git
>> [New thread 800.0xa10]
>> Error: dll starting at 0x779f0000 not found.
>> Error: dll starting at 0x75900000 not found.
>> Error: dll starting at 0x779f0000 not found.
>> Error: dll starting at 0x778f0000 not found.
>> [New thread 800.0x92c]
>> Cloning into 'mingw-checkout-crash'...
>> Error: dll starting at 0x29f0000 not found.
>> remote: Counting objects: 8, done.
>> remote: Compressing objects: 100% (7/7), done.
>> remote: Total 8 (delta 0), reused 8 (delta 0)
>> Unpacking objects: 100% (8/8), done.
>> Checking connectivity... done
>> [New thread 800.0xea0]
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x004d5200 in git_check_attr (
>>       path=3D0xacc6a0 ""..., num=3D5, check=3D0x572440) at attr.c:754
>> 754                     const char *value =3D check_all_attr[check[i].at=
tr->attr_n
>> r].value;
>> (gdb) list
>> 749             int i;
>> 750
>> 751             collect_all_attrs(path);
>> 752
>> 753             for (i =3D 0; i < num; i++) {
>> 754                     const char *value =3D check_all_attr[check[i].at=
tr->attr_n
>> r].value;
>> 755                     if (value =3D=3D ATTR__UNKNOWN)
>> 756                             value =3D ATTR__UNSET;
>> 757                     check[i].value =3D value;
>> 758             }
>
> I get a different crash on Linux if I set PATH_MAX to 260.  The following
> hackish patch prevents it.

Interesting. It does not seem to help here. Multiple issues in the
same code-path?

>  Does it help in your case as well?  If it does
> then I'll send a nicer (but longer) one.

Sounds like something that's still worth investigating, even if it
does not help.

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
