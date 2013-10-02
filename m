From: Wataru Noguchi <wnoguchi.0727@gmail.com>
Subject: Re: [PATCH] mingw-multibyte: fix memory acces violation and
 path length limits.
Date: Thu, 03 Oct 2013 07:26:23 +0900
Message-ID: <524C9D8F.2090107@gmail.com>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com> <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info> <524796DC.5020302@gmail.com> <5249AE2A.3050302@web.de> <524ACFAE.4040701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 git@vger.kernel.org, msysgit@googlegroups.com
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
X-From: msysgit+bncBDD7TRGTWYIBBE53WKJAKGQEUR6ORKI@googlegroups.com Thu Oct 03 00:26:29 2013
Return-path: <msysgit+bncBDD7TRGTWYIBBE53WKJAKGQEUR6ORKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f189.google.com ([209.85.216.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDD7TRGTWYIBBE53WKJAKGQEUR6ORKI@googlegroups.com>)
	id 1VRUsH-0006gu-BU
	for gcvm-msysgit@m.gmane.org; Thu, 03 Oct 2013 00:26:29 +0200
Received: by mail-qc0-f189.google.com with SMTP id l13sf314382qcy.26
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Oct 2013 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=t8xC3pZLB47Nij3Px4/TnCxToMucRwon76kGEskXOiM=;
        b=JPk3rXAUv49aRJx1qpn3OazDdkwRddZ/ccUpqJYld65o6nTsQtI24wmkt/cAJkG6S4
         ERiWsAT87XhNr2yQqACnf/7iZrQNZKuUEIRf46qP2W0qkOpbGZyvpIiJtMWpw5+taWNJ
         CIGo/pxQ2Hl0BvIGrk8AEH0IpW2tcenoVmt1DYAtC3Bj5846/28ZeIs5OpZDvTCh3rjm
         d6UzLkujK9DQAut4YJSbj4vcb04a1she/06vu4W8Aff2V3u7MFR9R3HrHab3gO20nZoT
         Kh81RifJEzKM+CWCztXQ5k9RwIpTRF+EehwCvmB9sbvjk1Ajq2W7ede4reRTpuwGkvqS
         SUVg==
X-Received: by 10.50.109.170 with SMTP id ht10mr265839igb.14.1380752788521;
        Wed, 02 Oct 2013 15:26:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.16.72 with SMTP id e8ls1315210igd.1.gmail; Wed, 02 Oct 2013
 15:26:27 -0700 (PDT)
X-Received: by 10.66.168.198 with SMTP id zy6mr800206pab.46.1380752787657;
        Wed, 02 Oct 2013 15:26:27 -0700 (PDT)
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com [2607:f8b0:400e:c03::233])
        by gmr-mx.google.com with ESMTPS id od1si569491pbb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Oct 2013 15:26:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c03::233 as permitted sender) client-ip=2607:f8b0:400e:c03::233;
Received: by mail-pa0-f51.google.com with SMTP id kp14so1705703pab.38
        for <msysgit@googlegroups.com>; Wed, 02 Oct 2013 15:26:27 -0700 (PDT)
X-Received: by 10.66.27.43 with SMTP id q11mr5473529pag.97.1380752787518;
        Wed, 02 Oct 2013 15:26:27 -0700 (PDT)
Received: from [192.168.1.139] (p4168-ipbf905akatuka.ibaraki.ocn.ne.jp. [219.114.17.168])
        by mx.google.com with ESMTPSA id im8sm4082569pbc.24.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Oct 2013 15:26:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524ACFAE.4040701@gmail.com>
X-Original-Sender: wnoguchi.0727@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c03::233
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235676>

Hi,

At last, I foundfollowing Makefile optimization suppression works fine in m=
y case.

CFLAGS =3D -g -O2 -fno-inline-small-functions -Wall

Following optimization option cause crash,

-finline-small-functions


// entry.c:237

int checkout_entry(struct cache_entry *ce,
		   const struct checkout *state, char *topath)
{
//------------------------------------------------------------------
// crash!
	static char path[PATH_MAX + 1];
//------------------------------------------------------------------
// works fine. but bad practice.
	static char path[4096 + 1];
//------------------------------------------------------------------
	struct stat st;
	int len =3D state->base_dir_len;

	if (topath)
		return write_entry(ce, topath, state, 1);


Thanks.


(2013/10/01 22:35), Wataru Noguchi wrote:
> Hi,
>
> Thanks for your patch.
>
> Unfortunately, in my case still crash...
>
> But PATH_MAX length kinds issues interesting.
>
> I'll try investigate a little more.
>
> - PATH_MAX and O2
>
> Thanks.
>
> (2013/10/01 2:00), Ren=E9 Scharfe wrote:
>> Am 29.09.2013 04:56, schrieb Wataru Noguchi:
>>> Hi,
>>>
>>> Thanks for comments.
>>>
>>> My currently working repository is
>>>
>>> https://github.com/wnoguchi/git/tree/hotfix/mingw-multibyte-path-checko=
ut-failure
>>>
>>> I have revert commits to 1f10da3.
>>> I'll try failure step.
>>>
>>> - gcc optimization level is O2.(fail)
>>> - gcc O0, O1 works fine.
>>>
>>>
>>> $ gdb git-clone
>>> GNU gdb 6.8
>>> Copyright (C) 2008 Free Software Foundation, Inc.
>>> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl=
.html>
>>> This is free software: you are free to change and redistribute it.
>>> There is NO WARRANTY, to the extent permitted by law.  Type "show copyi=
ng"
>>> and "show warranty" for details.
>>> This GDB was configured as "i686-pc-mingw32"...
>>> (gdb) r https://github.com/wnoguchi/mingw-checkout-crash.git
>>> Starting program: C:\msysgit\git/git-clone.exe https://github.com/wnogu=
chi/mingw
>>> -checkout-crash.git
>>> [New thread 800.0xa10]
>>> Error: dll starting at 0x779f0000 not found.
>>> Error: dll starting at 0x75900000 not found.
>>> Error: dll starting at 0x779f0000 not found.
>>> Error: dll starting at 0x778f0000 not found.
>>> [New thread 800.0x92c]
>>> Cloning into 'mingw-checkout-crash'...
>>> Error: dll starting at 0x29f0000 not found.
>>> remote: Counting objects: 8, done.
>>> remote: Compressing objects: 100% (7/7), done.
>>> remote: Total 8 (delta 0), reused 8 (delta 0)
>>> Unpacking objects: 100% (8/8), done.
>>> Checking connectivity... done
>>> [New thread 800.0xea0]
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x004d5200 in git_check_attr (
>>>        path=3D0xacc6a0 ""..., num=3D5, check=3D0x572440) at attr.c:754
>>> 754                     const char *value =3D check_all_attr[check[i].a=
ttr->attr_n
>>> r].value;
>>> (gdb) list
>>> 749             int i;
>>> 750
>>> 751             collect_all_attrs(path);
>>> 752
>>> 753             for (i =3D 0; i < num; i++) {
>>> 754                     const char *value =3D check_all_attr[check[i].a=
ttr->attr_n
>>> r].value;
>>> 755                     if (value =3D=3D ATTR__UNKNOWN)
>>> 756                             value =3D ATTR__UNSET;
>>> 757                     check[i].value =3D value;
>>> 758             }
>>
>> I get a different crash on Linux if I set PATH_MAX to 260.  The followin=
g
>> hackish patch prevents it.  Does it help in your case as well?  If it do=
es
>> then I'll send a nicer (but longer) one.
>>
>> Thanks,
>> Ren=E9
>>
>>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 1a61e6f..9bd7dcb 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -961,7 +961,7 @@ static int clear_ce_flags(struct cache_entry **cache=
, int nr,
>>                   int select_mask, int clear_mask,
>>                   struct exclude_list *el)
>>   {
>> -    char prefix[PATH_MAX];
>> +    char prefix[4096];
>>       return clear_ce_flags_1(cache, nr,
>>                   prefix, 0,
>>                   select_mask, clear_mask,
>>
>>
>


--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
   Wataru Noguchi
   wnoguchi.0727@gmail.com
   http://wnoguchi.github.io/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

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
