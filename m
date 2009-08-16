From: Frank Li <lznuaa@gmail.com>
Subject: Re: Using VC build git (new patch)
Date: Sun, 16 Aug 2009 12:07:57 +0800
Message-ID: <1976ea660908152107s8b8f3e5l3c2f043fb3e4d62@mail.gmail.com>
References: <1976ea660908150921n516178dbs2ce024ed729e2e02@mail.gmail.com>
	 <alpine.DEB.1.00.0908151851280.8306@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0908151908300.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 16 06:08:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McX2S-0003yQ-EP
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 06:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbZHPEH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2009 00:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbZHPEH5
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 00:07:57 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:63400 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbZHPEH4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 00:07:56 -0400
Received: by qyk34 with SMTP id 34so1742081qyk.33
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 21:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hVIhXpekK7GISIdLn3WhYPd81ZzHltyfooMDoxQdwoI=;
        b=HC+B2ObgRLGz3+5jGsWq+qdVJuuDPEFBjDjTYdLcgwcrbvBoJ5GxLLi62r258x6X2A
         wDn84EVTRCxn/7DrZ8ZyeD8ds3mIvSwQyfJpTo+Ne0QhifTqA1tdmHkgKbtQxAq4woiy
         OIV9ZHQz42nia9nbr/vdh1flBS/0LBBEIJcnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vaHpI2ZWoEE6Rpol2j82vKCiD5f/oInBWs4puINGMDgiE7xzTjdMg5STK6OaaivQ/R
         n+5C9E87acU716iKkBWyNnwrBdYL1m6+zOGfby7VvBGDQ/hFt4kzxRxCyvY3HaWIpNiI
         yidNm/MWd2tUoLHnWxmNwX5wlRMoyB/jAnXdU=
Received: by 10.224.30.195 with SMTP id v3mr3405599qac.359.1250395677222; Sat, 
	15 Aug 2009 21:07:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908151908300.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126049>

2009/8/16 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Sat, 15 Aug 2009, Johannes Schindelin wrote:
>
>> A single monster patch?
>>
>> Hmm.
>>
>> Please understand that I will not review that unless it is split up =
into
>> nice little and reviewable chunks.
>
> Well, I try to improve.
>
> So I had a look at your patch. =A0The changes fall naturally into one=
 of the
> following categories:
>
> =A0 =A0 =A0 =A0- decl-after-statement fixes
>
> =A0 =A0 =A0 =A0- missing #include "git-compat-util.h"
>
> =A0 =A0 =A0 =A0- converting a K&R style function definition to modern=
 C
>
> =A0 =A0 =A0 =A0- #undef's only needed for Microsoft Visual C++
          #undef ERROR is necessary.
          #undef in mingw.h is only for clean some warning.
>
> =A0 =A0 =A0 =A0- the addition of O_BINARY in the file modes
         Yes, default is text mode if no O_BINARY, _read _write will
do union code and cr\cf convert.

>
> =A0 =A0 =A0 =A0- disabling link() (why?)
         VC report stack error. I also don't know why.
         I have not deep debug this problem.
>
> =A0 =A0 =A0 =A0- double-#define'ing stat (which puzzles me greatly)
          old define is
          #define stat    stati64
          #define stati64 msys_stati64.

          stat is used for both struct and function name.
         In C code:
              struct stat a;
         stat -> stati64 -> msys_stati64,  so compiler report struct
msys_stati64 have not defined.

>
> =A0 =A0 =A0 =A0- dummy #define'ing of a few compiler attributes
>
> =A0 =A0 =A0 =A0- adding _MSVC to a conditional to avoid =A0#define'in=
g
> =A0 =A0 =A0 =A0 =A0SNPRINTF_SIZE_CORR yourself
>
> =A0 =A0 =A0 =A0- #define'ing several symbols without leading undersco=
re to the
> =A0 =A0 =A0 =A0 =A0MS-specific version with a leading underscore
>
> =A0 =A0 =A0 =A0- implementing strcasecmp() in a misnamed file
>
> =A0 =A0 =A0 =A0- "fixing" the return value of winansi_vfprintf for Mi=
crosoft
> =A0 =A0 =A0 =A0 =A0Visual C++ (I think this fix is wrong)
>
> =A0 =A0 =A0 =A0- correctly adding a Visual C++-specific conditional t=
o
> =A0 =A0 =A0 =A0 =A0git-compat-util.h, pager.c, run-command.c, run-com=
mand.h,
> =A0 =A0 =A0 =A0 =A0setup.c and help.c, although the latter five could=
 use some
> =A0 =A0 =A0 =A0 =A0refactoring into git-compat-util.h
           Do you means add
           #ifdef _MSC_VER
           #include git-compat-util.h
           #endif
>
> =A0 =A0 =A0 =A0 =A0Maybe there is also room to change the MinGW-condi=
tional into a
> =A0 =A0 =A0 =A0 =A0NO_TRUSTABLE_FILEMODE one
>
> =A0 =A0 =A0 =A0- adding several headers missing from Visual C++'s ins=
tallation
>
> =A0 =A0 =A0 =A0- adding _huge_ .vcproj files (can they not be smaller=
?)
           It is created by VS2008.  I think it is difficult to make sm=
aller.
>
> As you can see, there is a pretty natural way to split that huge patc=
h
> into chunks that most people on these lists can review easily, and th=
at
> would actually be a pleasure to look at.
>
> Even better, there are a few fixes (the first three, if you ask me), =
which
> are not even Windows-specific.
>
> Further, I would like to suggest adding a header file compat/msvc.h w=
hich
> contains all the #undef's and #define's necessary only for Visual C++=
, and
> which can be #include'd from git-compat-util.h, to better separate yo=
ur
> work from the other platforms (who do not want those changes). =A0Tha=
t
> should avoid those unwanted changes to mingw.c and mingw.h. =A0You ju=
st have
> to make sure that msvc.h is #include'd before mingw.h.

VC build will reuse msysgit work.
I will reduce change to mingw.c and mingw.h
But there are some problem at mingw.c and mingw.h

1. stat defination.  Because both struct and function use the same name=
 stat.
2. open need binary mode.
3. mingw.c use C99 style to break build at VC.
4. mingw.c use special DIR structure, So I need add open_dir in mingw.c=
=2E

If I don't change mingw.c, I need copy it to new file totally.
>
> With these comments, I look forward to your next iteration.
>
> Ciao,
> Dscho
>
>
>
>
