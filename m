From: Wataru Noguchi <wnoguchi.0727@gmail.com>
Subject: Re: [PATCH] mingw-multibyte: fix memory acces violation and
 path length limits.
Date: Sun, 29 Sep 2013 11:56:28 +0900
Message-ID: <524796DC.5020302@gmail.com>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com> <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDD7TRGTWYIBBYFNT2JAKGQE3HZB5ZI@googlegroups.com Sun Sep 29 04:56:36 2013
Return-path: <msysgit+bncBDD7TRGTWYIBBYFNT2JAKGQE3HZB5ZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f183.google.com ([209.85.216.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDD7TRGTWYIBBYFNT2JAKGQE3HZB5ZI@googlegroups.com>)
	id 1VQ7BS-0005ut-33
	for gcvm-msysgit@m.gmane.org; Sun, 29 Sep 2013 04:56:34 +0200
Received: by mail-qc0-f183.google.com with SMTP id s13sf890391qcv.10
        for <gcvm-msysgit@m.gmane.org>; Sat, 28 Sep 2013 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=L9lCG4tqZ1iU054j/jaby88HjC1ZU9/8JOg/UvulyCc=;
        b=GTBE1OQc+G/Ae+7hKuK6WDhRp7yOKE5ZQTE3Un2YP/JuOalDf1tTFloG5jrwVbyB5V
         ND46IXSaeuGEwMBj+i8PfkT+l4WZPkNJDKK49B3DuTfV1L2AiSl2a3aqzFMKSnRzrqTn
         MZeoDZGY2Fsm5TXppkj3ZG2yPMRCcEF9oTwg3iKXee7kzOuez9l+d8aTceR1W0F2wUGL
         8RNrgcG/iPXWdGaCMzsd4Bdsfe/v0CA+5AgHibfe87PYC9wXQrYVfjtizOEh/xb5C/PK
         hyxBomEG1lAAV1BXo4oCqcZpurbTnJqfZ4ILgY6CLoYp/i+0D1gkFR7YrAL9bxcvI4jW
         UNJw==
X-Received: by 10.50.66.101 with SMTP id e5mr302820igt.12.1380423393265;
        Sat, 28 Sep 2013 19:56:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.130.34 with SMTP id ob2ls1148798igb.39.gmail; Sat, 28 Sep
 2013 19:56:32 -0700 (PDT)
X-Received: by 10.68.218.163 with SMTP id ph3mr13202183pbc.5.1380423392641;
        Sat, 28 Sep 2013 19:56:32 -0700 (PDT)
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com [2607:f8b0:400e:c01::231])
        by gmr-mx.google.com with ESMTPS id zg4si2157153pbc.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 19:56:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c01::231 as permitted sender) client-ip=2607:f8b0:400e:c01::231;
Received: by mail-pb0-f49.google.com with SMTP id xb4so4105710pbc.36
        for <msysgit@googlegroups.com>; Sat, 28 Sep 2013 19:56:32 -0700 (PDT)
X-Received: by 10.68.252.33 with SMTP id zp1mr16082382pbc.95.1380423392514;
        Sat, 28 Sep 2013 19:56:32 -0700 (PDT)
Received: from [192.168.1.4] (p4168-ipbf905akatuka.ibaraki.ocn.ne.jp. [219.114.17.168])
        by mx.google.com with ESMTPSA id ry4sm23042435pab.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 19:56:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info>
X-Original-Sender: wnoguchi.0727@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c01::231
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235574>

Hi,

Thanks for comments.

My currently working repository is

https://github.com/wnoguchi/git/tree/hotfix/mingw-multibyte-path-checkout-failure

I have revert commits to 1f10da3.
I'll try failure step.

- gcc optimization level is O2.(fail)
- gcc O0, O1 works fine.


$ gdb git-clone
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-pc-mingw32"...
(gdb) r https://github.com/wnoguchi/mingw-checkout-crash.git
Starting program: C:\msysgit\git/git-clone.exe https://github.com/wnoguchi/mingw
-checkout-crash.git
[New thread 800.0xa10]
Error: dll starting at 0x779f0000 not found.
Error: dll starting at 0x75900000 not found.
Error: dll starting at 0x779f0000 not found.
Error: dll starting at 0x778f0000 not found.
[New thread 800.0x92c]
Cloning into 'mingw-checkout-crash'...
Error: dll starting at 0x29f0000 not found.
remote: Counting objects: 8, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 8 (delta 0), reused 8 (delta 0)
Unpacking objects: 100% (8/8), done.
Checking connectivity... done
[New thread 800.0xea0]

Program received signal SIGSEGV, Segmentation fault.
0x004d5200 in git_check_attr (
     path=0xacc6a0 ""..., num=5, check=0x572440) at attr.c:754
754                     const char *value = check_all_attr[check[i].attr->attr_n
r].value;
(gdb) list
749             int i;
750
751             collect_all_attrs(path);
752
753             for (i = 0; i < num; i++) {
754                     const char *value = check_all_attr[check[i].attr->attr_n
r].value;
755                     if (value == ATTR__UNKNOWN)
756                             value = ATTR__UNSET;
757                     check[i].value = value;
758             }
(gdb) up
#1  0x004a796b in convert_attrs (ca=0x28f950,
     path=0xacc6a0 ""...) at convert.c:740
740             if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
(gdb) list
735                             ccheck[i].attr = git_attr(conv_attr_name[i]);
736                     user_convert_tail = &user_convert;
737                     git_config(read_convert_config, NULL);
738             }
739
740             if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
741                     ca->crlf_action = git_path_check_crlf(path, ccheck + 4);

742                     if (ca->crlf_action == CRLF_GUESS)
743                             ca->crlf_action = git_path_check_crlf(path, cche
ck + 0);
744                     ca->ident = git_path_check_ident(path, ccheck + 1);
(gdb) list -
725             int i;
726             static struct git_attr_check ccheck[NUM_CONV_ATTRS];
727
728     //      if (NUM_CONV_ATTRS != 0) {
729     //              ccheck[0].attr = NULL;
730     //              ccheck[0].value = NULL;
731     //      }
732
733             if (!ccheck[0].attr) {
734                     for (i = 0; i < NUM_CONV_ATTRS; i++)
(gdb) p ccheck[0].attr
$1 = (struct git_attr *) 0xa081e38f


Next, change PATH_MAX value to 4096 if MinGW environment.(6cae216)
Works fine.
Is this failure caused by PATH_MAX length too short? or my repository directory depth too deep?
But when optimization disabled(O0) in Makefile , works fine...(bf0acff)
Do you know what's happen?


Thanks.


(2013/09/29 8:18), Johannes Schindelin wrote:
> Hi,
>
> On Sun, 29 Sep 2013, Wataru Noguchi wrote:
>
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -724,6 +724,11 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>>   {
>>   	int i;
>>   	static struct git_attr_check ccheck[NUM_CONV_ATTRS];
>> +	
>> +	if (NUM_CONV_ATTRS != 0) {
>> +		ccheck[0].attr = NULL;
>> +		ccheck[0].value = NULL;
>> +	}
>
> I wonder whether it would make more sense to use
>
> 	memset(ccheck, 0, sizeof(ccheck))
>
> ? But then, ccheck is static and *should* be initialized to all 0
> according to the C standard. And re-initializing it to NULL would
> invalidate the values that were set earlier.
>
> Also, if NUM_CONV_ATTRS == 0, I would expect
>
>>   	if (!ccheck[0].attr) {
>
> to access an invalid location...
>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index a31127f..ba02c69 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -237,6 +237,16 @@ extern char *gitbasename(char *);
>>   #ifndef PATH_MAX
>>   #define PATH_MAX 4096
>>   #endif
>> +#ifdef GIT_WINDOWS_NATIVE
>> +/* Git for Windows checkout PATH_MAX is reduce to 260.
>> + * but if checkout relative long path name, its length too short.
>> + * thus, expand length.
>> + */
>> +#ifdef PATH_MAX
>> +#undef PATH_MAX
>> +#endif
>> +#define PATH_MAX 4096
>> +#endif
>
> This looks fine, but I am wary... did you not say that a crash was caused
> by this? In that case, we would have a user that accesses the respective
> buffer without checking the size and we would still have to fix that bug..
>
> Ciao,
> Dscho
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
