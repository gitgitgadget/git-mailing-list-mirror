From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 17:46:08 +0200
Message-ID: <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com>
References: <433B3B10.5050407@zytor.com>
	 <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
	 <434299DB.7020805@zytor.com>
	 <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13954_6876396.1128527168258"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 17:49:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENBTF-0006zG-7c
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 17:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVJEPqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 11:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbVJEPqN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 11:46:13 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:59918 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030185AbVJEPqM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 11:46:12 -0400
Received: by nproxy.gmail.com with SMTP id n15so82565nfc
        for <git@vger.kernel.org>; Wed, 05 Oct 2005 08:46:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=YQXbBIbwNbRSsRcRl/t9b3SoaYcxrmYP+Y+OrZGVQIfd41LhBtkAggiKknpsyf+VtaAFxif7MHCWKjQsozBsFlkAiMJar+Za6YSgnM6idDSgBuqO4c1Ku9Ht9JRzyCpOFRILHFuHOSix3LodhXfIBdlhmfr8QhZHMB7BiDiMagU=
Received: by 10.48.235.7 with SMTP id i7mr55340nfh;
        Wed, 05 Oct 2005 08:46:08 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Wed, 5 Oct 2005 08:46:08 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9712>

------=_Part_13954_6876396.1128527168258
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/5/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 10/4/05, H. Peter Anvin <hpa@zytor.com> wrote:
> > > I noticed that rename(2) in my copy of cygwin (1.5.18-1) does not rem=
ove the
> > > target and returns an error (probably EPERM, but I have reasons not t=
o trust
> > > strerror on that thing).
> > > The repository was on FAT.
> > > Taking "rename(2)" from cygwin's libiberty solved this (they unlink i=
f link(2)
> > > returns EEXIST).
> > >
> > > PS: Does broken rename(2) qualify a system "not worthy to support"?
> >
> > I just tried this with Cygwin 1.5.18-1 and didn't have any such
> > problems.  I tried it on NTFS, FAT and Samba, using WinXP.
>
> It's on Win2k, there was multiple cygwin installations in path, the other=
 one
> supposedly is 1.5.5 (it's from QNX Momentics installation).
> I had that old "cygwin1.dll" renamed into "cygwin1.dll-disabled" long
> ago, though...
> I can't reproduce this out of GIT context, and the error is not
> reproducable after
> I removed the other cygwin installation out of PATH.
> Anyway, sorry, I should have tried this before posting.

Still does not work for me. I cannot isolate the problem out of git,
but at the moment the only way for me to make commit_index_file to work
is to put unlink(indexfile) before rename(cf->lockfile, indexfile).

For everyone interested, I attach cygwin's strace output here.

------=_Part_13954_6876396.1128527168258
Content-Type: application/octet-stream; name=log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="log"

**********************************************
Program name: d:\download\git-mine\git-update-index.exe (pid 1476, ppid 1)
App version:  1005.18, api: 0.132
DLL version:  1005.18, api: 0.132
DLL build:    2005-07-02 20:30
OS version:   Windows NT-5.0
Heap size:    536870912
Date/Time:    2005-10-05 17:27:37
**********************************************
   55     474 [main] git-update-index 1476 set_myself: myself->dwProcessId 1476
   57     531 [main] git-update-index 1476 time: 1128526057 = time (0)
  404     935 [main] git-update-index 1476 environ_init: 0x10020238: !F:=F:\
  100    1035 [main] git-update-index 1476 environ_init: 0x10020248: !H:=H:\
  100    1135 [main] git-update-index 1476 environ_init: 0x10020258: !I:=I:\
  100    1235 [main] git-update-index 1476 environ_init: 0x10020268: !J:=J:\
   99    1334 [main] git-update-index 1476 environ_init: 0x10020278: !N:=N:\
   99    1433 [main] git-update-index 1476 environ_init: 0x10020288: !X:=X:\
  100    1533 [main] git-update-index 1476 environ_init: 0x10020298: !Y:=Y:\
   99    1632 [main] git-update-index 1476 environ_init: 0x100202A8: !Z:=Z:\
  100    1732 [main] git-update-index 1476 environ_init: 0x100202B8: ALLUSERSPROFILE=C:\Documents and Settings\All Users
  100    1832 [main] git-update-index 1476 environ_init: 0x100202F0: APPDATA=C:\Documents and Settings\ARiesen\Application Data
  100    1932 [main] git-update-index 1476 environ_init: 0x10020330: APR_ICONV_PATH=d:\Programs\Subversion\iconv
  100    2032 [main] git-update-index 1476 environ_init: 0x10020360: CLASSPATH="C:\WINNT\system32\QTJava.zip"
  101    2133 [main] git-update-index 1476 environ_init: 0x10020390: COMMONPROGRAMFILES=C:\Program Files\Common Files
  100    2233 [main] git-update-index 1476 environ_init: 0x100203C8: COMPUTERNAME=OEKAP852
  100    2333 [main] git-update-index 1476 environ_init: 0x100203E8: COMSPEC=C:\WINNT\system32\cmd.exe
   99    2432 [main] git-update-index 1476 environ_init: 0x10020410: CVS_RSH=/bin/ssh
  100    2532 [main] git-update-index 1476 environ_init: 0x10020428: CYGWIN_BASH_HOSTNAME=oekap852
  100    2632 [main] git-update-index 1476 environ_init: 0x10020450: EDITOR=gvim -f
  100    2732 [main] git-update-index 1476 environ_init: 0x10020468: EXSERVER=OEKAEX01
   99    2831 [main] git-update-index 1476 environ_init: 0x10020480: GREP_OPTIONS=--exclude=*.svn-base
  104    2935 [main] git-update-index 1476 environ_init: 0x100204A8: HB_TOOLS_DIR=D:/p4scm/SCM/Release/BuildProcess/tools
  101    3036 [main] git-update-index 1476 environ_init: 0x100204E8: HGEDITOR=ee
  100    3136 [main] git-update-index 1476 environ_init: 0x100204F8: HGMERGE=ee -d
  100    3236 [main] git-update-index 1476 environ_init: 0x10020510: HGUSER=ariesen@harmanbecker.com
  100    3336 [main] git-update-index 1476 environ_init: 0x10020538: HISTFILESIZE=20000
  100    3436 [main] git-update-index 1476 environ_init: 0x10020550: HISTSIZE=1000
  100    3536 [main] git-update-index 1476 getwinenv: can't set native for HOME= since no environ yet
  106    3642 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (h:, no-keep-rel, no-add-slash)
   59    3701 [main] git-update-index 1476 normalize_win32_path: h: = normalize_win32_path (h:)
   62    3763 [main] git-update-index 1476 mount_info::conv_to_posix_path: /cygdrive/h = conv_to_posix_path (h:)
  150    3913 [main] git-update-index 1476 win_env::add_cache: posix /cygdrive/h
   51    3964 [main] git-update-index 1476 win_env::add_cache: native HOME=h:
   51    4015 [main] git-update-index 1476 posify: env var converted to HOME=/cygdrive/h
   99    4114 [main] git-update-index 1476 environ_init: 0x10020578: HOME=/cygdrive/h
  139    4253 [main] git-update-index 1476 environ_init: 0x100206A8: HOMEDRIVE=C:
  101    4354 [main] git-update-index 1476 environ_init: 0x10020568: HOMEPATH=\
  101    4455 [main] git-update-index 1476 environ_init: 0x100206C0: HOSTNAME=oekap852
  100    4555 [main] git-update-index 1476 environ_init: 0x100206D8: INCLUDE=C:\Program Files\Microsoft Visual Studio\VC98\atl\include;C:\Program Files\Microsoft Visual Studio\VC98\mfc\include;C:\Program Files\Microsoft Visual Studio\VC98\include
  107    4662 [main] git-update-index 1476 environ_init: 0x10020790: INFOPATH=/usr/local/info:/usr/info:/usr/share/info:/usr/autotool/devel/info:/usr/autotool/stable/info:
  102    4764 [main] git-update-index 1476 environ_init: 0x10020800: LANG=en_US
  100    4864 [main] git-update-index 1476 environ_init: 0x10020810: LIB=C:\Program Files\Microsoft Visual Studio\VC98\mfc\lib;C:\Program Files\Microsoft Visual Studio\VC98\lib
  101    4965 [main] git-update-index 1476 environ_init: 0x10020880: LM_LICENSE_FILE=7192@oekaw2do01
  101    5066 [main] git-update-index 1476 environ_init: 0x100208A8: LOGIN_CONTEXT=PDE-SW.Karlsbad
  100    5166 [main] git-update-index 1476 environ_init: 0x100208D0: LOGNAME=%USERNAME.PDE-SW.Karlsbad
  100    5266 [main] git-update-index 1476 environ_init: 0x100208F8: LOGONSERVER=\\OEKAW2DC03
  100    5366 [main] git-update-index 1476 environ_init: 0x10020918: MAKEFLAGS=-Id:/QNX630/target/qnx6/usr/include
  167    5533 [main] git-update-index 1476 environ_init: 0x10020950: MAKE_MODE=unix
  101    5634 [main] git-update-index 1476 environ_init: 0x10020968: MANPATH=/usr/local/man:/usr/man:/usr/share/man:/usr/autotool/devel/man:
  128    5762 [main] git-update-index 1476 environ_init: 0x100209B8: MSDEVDIR=C:\Program Files\Microsoft Visual Studio\Common\MSDev98
  102    5864 [main] git-update-index 1476 environ_init: 0x10020A00: NAME=Riesen, Alexander
  100    5964 [main] git-update-index 1476 environ_init: 0x10020A20: NUMBER_OF_PROCESSORS=1
  100    6064 [main] git-update-index 1476 environ_init: 0x10020A40: NWLANGUAGE=ENGLISH
   99    6163 [main] git-update-index 1476 environ_init: 0x10020A58: NWUSERNAME=ARiesen
  100    6263 [main] git-update-index 1476 environ_init: 0x10020A70: OLDPWD=/d/download/git-cygwin
  100    6363 [main] git-update-index 1476 environ_init: 0x10020A98: OS2LIBPATH=C:\WINNT\system32\os2\dll;
   99    6462 [main] git-update-index 1476 environ_init: 0x10020AC8: OS=WINNT
  100    6562 [main] git-update-index 1476 environ_init: 0x10020AD8: OS_VERSION=V5.00
  100    6662 [main] git-update-index 1476 environ_init: 0x10020AF0: P4_QNX_OS_ROOT=D:/p4qnx/qnx/release/os
  101    6763 [main] git-update-index 1476 getwinenv: can't set native for PATH= since no environ yet
   60    6823 [main] git-update-index 1476 normalize_posix_path: src .
   54    6877 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (d:\download\git-mine, no-keep-rel, no-add-slash)
   52    6929 [main] git-update-index 1476 normalize_win32_path: d:\download\git-mine = normalize_win32_path (d:\download\git-mine)
   53    6982 [main] git-update-index 1476 mount_info::conv_to_posix_path: /d/download/git-mine = conv_to_posix_path (d:\download\git-mine)
   52    7034 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   51    7085 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22EBC0, 260, 1, 0), errno 0
   52    7137 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/ = normalize_posix_path (.)
   52    7189 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine)
   57    7246 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   52    7298 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine, dst d:\download\git-mine, flags 0xA, rc 0
   98    7396 [main] git-update-index 1476 symlink_info::check: not a symlink
   53    7449 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine, 0x22E880) (0xA)
  441    7890 [main] git-update-index 1476 set_privilege: 1 = set_privilege ((token 330) SeChangeNotifyPrivilege, 1)
  149    8039 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine), has_acls(0)
  117    8156 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (d:\scripts\git, keep-rel, no-add-slash)
   58    8214 [main] git-update-index 1476 normalize_win32_path: d:\scripts\git = normalize_win32_path (d:\scripts\git)
   53    8267 [main] git-update-index 1476 mount_info::conv_to_posix_path: /d/scripts/git = conv_to_posix_path (d:\scripts\git)
   52    8319 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (D:\Programs\cygwin\usr\local\bin, keep-rel, no-add-slash)
   52    8371 [main] git-update-index 1476 normalize_win32_path: D:\Programs\cygwin\usr\local\bin = normalize_win32_path (D:\Programs\cygwin\usr\local\bin)
   52    8423 [main] git-update-index 1476 mount_info::conv_to_posix_path: /usr/local/bin = conv_to_posix_path (D:\Programs\cygwin\usr\local\bin)
   53    8476 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (D:\Programs\cygwin\bin, keep-rel, no-add-slash)
   51    8527 [main] git-update-index 1476 normalize_win32_path: D:\Programs\cygwin\bin = normalize_win32_path (D:\Programs\cygwin\bin)
   52    8579 [main] git-update-index 1476 mount_info::conv_to_posix_path: /usr/bin = conv_to_posix_path (D:\Programs\cygwin\bin)
   52    8631 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (D:\Programs\cygwin\bin, keep-rel, no-add-slash)
   51    8682 [main] git-update-index 1476 normalize_win32_path: D:\Programs\cygwin\bin = normalize_win32_path (D:\Programs\cygwin\bin)
   52    8734 [main] git-update-index 1476 mount_info::conv_to_posix_path: /usr/bin = conv_to_posix_path (D:\Programs\cygwin\bin)
   52    8786 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (D:\Programs\cygwin\usr\X11R6\bin, keep-rel, no-add-slash)
   52    8838 [main] git-update-index 1476 normalize_win32_path: D:\Programs\cygwin\usr\X11R6\bin = normalize_win32_path (D:\Programs\cygwin\usr\X11R6\bin)
   52    8890 [main] git-update-index 1476 mount_info::conv_to_posix_path: /usr/X11R6/bin = conv_to_posix_path (D:\Programs\cygwin\usr\X11R6\bin)
   52    8942 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (c:\WINNT\system32, keep-rel, no-add-slash)
   51    8993 [main] git-update-index 1476 normalize_win32_path: c:\WINNT\system32 = normalize_win32_path (c:\WINNT\system32)
   52    9045 [main] git-update-index 1476 mount_info::conv_to_posix_path: /c/WINNT/system32 = conv_to_posix_path (c:\WINNT\system32)
   52    9097 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (c:\WINNT, keep-rel, no-add-slash)
   51    9148 [main] git-update-index 1476 normalize_win32_path: c:\WINNT = normalize_win32_path (c:\WINNT)
   52    9200 [main] git-update-index 1476 mount_info::conv_to_posix_path: /c/WINNT = conv_to_posix_path (c:\WINNT)
   52    9252 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (c:\WINNT\System32\Wbem, keep-rel, no-add-slash)
   51    9303 [main] git-update-index 1476 normalize_win32_path: c:\WINNT\System32\Wbem = normalize_win32_path (c:\WINNT\System32\Wbem)
   52    9355 [main] git-update-index 1476 mount_info::conv_to_posix_path: /c/WINNT/System32/Wbem = conv_to_posix_path (c:\WINNT\System32\Wbem)
   52    9407 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (c:\WINNT\system32\nls, keep-rel, no-add-slash)
   52    9459 [main] git-update-index 1476 normalize_win32_path: c:\WINNT\system32\nls = normalize_win32_path (c:\WINNT\system32\nls)
   51    9510 [main] git-update-index 1476 mount_info::conv_to_posix_path: /c/WINNT/system32/nls = conv_to_posix_path (c:\WINNT\system32\nls)
   52    9562 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (c:\WINNT\system32\nls\ENGLISH, keep-rel, no-add-slash)
   52    9614 [main] git-update-index 1476 normalize_win32_path: c:\WINNT\system32\nls\ENGLISH = normalize_win32_path (c:\WINNT\system32\nls\ENGLISH)
   52    9666 [main] git-update-index 1476 mount_info::conv_to_posix_path: /c/WINNT/system32/nls/ENGLISH = conv_to_posix_path (c:\WINNT\system32\nls\ENGLISH)
   52    9718 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (c:\Program Files\Perforce, keep-rel, no-add-slash)
   55    9773 [main] git-update-index 1476 normalize_win32_path: c:\Program Files\Perforce = normalize_win32_path (c:\Program Files\Perforce)
   51    9824 [main] git-update-index 1476 mount_info::conv_to_posix_path: /c/Program Files/Perforce = conv_to_posix_path (c:\Program Files\Perforce)
   53    9877 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (c:\Program Files\QNX Software Systems\bin, keep-rel, no-add-slash)
   52    9929 [main] git-update-index 1476 normalize_win32_path: c:\Program Files\QNX Software Systems\bin = normalize_win32_path (c:\Program Files\QNX Software Systems\bin)
   52    9981 [main] git-update-index 1476 mount_info::conv_to_posix_path: /c/Program Files/QNX Software Systems/bin = conv_to_posix_path (c:\Program Files\QNX Software Systems\bin)
   53   10034 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (D:\Programs\cygwin\bin, keep-rel, no-add-slash)
   51   10085 [main] git-update-index 1476 normalize_win32_path: D:\Programs\cygwin\bin = normalize_win32_path (D:\Programs\cygwin\bin)
   52   10137 [main] git-update-index 1476 mount_info::conv_to_posix_path: /usr/bin = conv_to_posix_path (D:\Programs\cygwin\bin)
   52   10189 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (c:\Program Files\doxygen\bin, keep-rel, no-add-slash)
   51   10240 [main] git-update-index 1476 normalize_win32_path: c:\Program Files\doxygen\bin = normalize_win32_path (c:\Program Files\doxygen\bin)
   52   10292 [main] git-update-index 1476 mount_info::conv_to_posix_path: /c/Program Files/doxygen/bin = conv_to_posix_path (c:\Program Files\doxygen\bin)
   53   10345 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (d:\Programs\Perl\bin, keep-rel, no-add-slash)
   51   10396 [main] git-update-index 1476 normalize_win32_path: d:\Programs\Perl\bin = normalize_win32_path (d:\Programs\Perl\bin)
   51   10447 [main] git-update-index 1476 mount_info::conv_to_posix_path: /d/Programs/Perl/bin = conv_to_posix_path (d:\Programs\Perl\bin)
   53   10500 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (d:\Programs\Vim\vim63, keep-rel, no-add-slash)
   51   10551 [main] git-update-index 1476 normalize_win32_path: d:\Programs\Vim\vim63 = normalize_win32_path (d:\Programs\Vim\vim63)
  100   10651 [main] git-update-index 1476 mount_info::conv_to_posix_path: /d/Programs/Vim/vim63 = conv_to_posix_path (d:\Programs\Vim\vim63)
   53   10704 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (d:\scripts, keep-rel, no-add-slash)
   88   10792 [main] git-update-index 1476 normalize_win32_path: d:\scripts = normalize_win32_path (d:\scripts)
   52   10844 [main] git-update-index 1476 mount_info::conv_to_posix_path: /d/scripts = conv_to_posix_path (d:\scripts)
   52   10896 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (d:\Programs\Subversion\bin, keep-rel, no-add-slash)
   52   10948 [main] git-update-index 1476 normalize_win32_path: d:\Programs\Subversion\bin = normalize_win32_path (d:\Programs\Subversion\bin)
   53   11001 [main] git-update-index 1476 mount_info::conv_to_posix_path: /d/Programs/Subversion/bin = conv_to_posix_path (d:\Programs\Subversion\bin)
   52   11053 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (X, keep-rel, no-add-slash)
   51   11104 [main] git-update-index 1476 mount_info::conv_to_posix_path: X = conv_to_posix_path (X)
   52   11156 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (.\, keep-rel, add-slash)
   51   11207 [main] git-update-index 1476 mount_info::conv_to_posix_path: ./ = conv_to_posix_path (.\)
   51   11258 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (Y, keep-rel, no-add-slash)
   52   11310 [main] git-update-index 1476 mount_info::conv_to_posix_path: Y = conv_to_posix_path (Y)
   55   11365 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (.\, keep-rel, add-slash)
   51   11416 [main] git-update-index 1476 mount_info::conv_to_posix_path: ./ = conv_to_posix_path (.\)
   52   11468 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (.\, keep-rel, add-slash)
   51   11519 [main] git-update-index 1476 mount_info::conv_to_posix_path: ./ = conv_to_posix_path (.\)
  168   11687 [main] git-update-index 1476 win_env::add_cache: posix /d/scripts/git:/usr/local/bin:/usr/bin:/usr/bin:/usr/X11R6/bin:/c/WINNT/system32:/c/WINNT:/c/WINNT/System32/Wbem:/c/WINNT/system32/nls:/c/WINNT/system32/nls/ENGLISH:/c/Program Files/Perforce:/c/Program Files/QNX Software Systems/bin:/usr/bin:/c/Program Files/doxygen/bin:/d/Programs/Perl/bin:/d/Programs/Vim/vim63:/d/scripts:/d/Programs/Subversion/bin:X:./:Y:./:./
   56   11743 [main] git-update-index 1476 win_env::add_cache: native PATH=d:\scripts\git;D:\Programs\cygwin\usr\local\bin;D:\Programs\cygwin\bin;D:\Programs\cygwin\bin;D:\Programs\cygwin\usr\X11R6\bin;c:\WINNT\system32;c:\WINNT;c:\WINNT\System32\Wbem;c:\WINNT\system32\nls;c:\WINNT\system32\nls\ENGLISH;c:\Program Files\Perforce;c:\Program Files\QNX Software Systems\bin;D:\Programs\cygwin\bin;c:\Program Files\doxygen\bin;d:\Programs\Perl\bin;d:\Programs\Vim\vim63;d:\scripts;d:\Programs\Subversion\bin;X;.\;Y;.\;.\
   60   11803 [main] git-update-index 1476 posify: env var converted to PATH=/d/scripts/git:/usr/local/bin:/usr/bin:/usr/bin:/usr/X11R6/bin:/c/WINNT/system32:/c/WINNT:/c/WINNT/System32/Wbem:/c/WINNT/system32/nls:/c/WINNT/system32/nls/ENGLISH:/c/Program Files/Perforce:/c/Program Files/QNX Software Systems/bin:/usr/bin:/c/Program Files/doxygen/bin:/d/Programs/Perl/bin:/d/Programs/Vim/vim63:/d/scripts:/d/Programs/Subversion/bin:X:./:Y:./:./
  103   11906 [main] git-update-index 1476 environ_init: 0x10020CE8: PATH=/d/scripts/git:/usr/local/bin:/usr/bin:/usr/bin:/usr/X11R6/bin:/c/WINNT/system32:/c/WINNT:/c/WINNT/System32/Wbem:/c/WINNT/system32/nls:/c/WINNT/system32/nls/ENGLISH:/c/Program Files/Perforce:/c/Program Files/QNX Software Systems/bin:/usr/bin:/c/Program Files/doxygen/bin:/d/Programs/Perl/bin:/d/Programs/Vim/vim63:/d/scripts:/d/Programs/Subversion/bin:X:./:Y:./:./
  108   12014 [main] git-update-index 1476 environ_init: 0x10020B20: PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH
  100   12114 [main] git-update-index 1476 environ_init: 0x10020B60: PLATFORM=WNT
  100   12214 [main] git-update-index 1476 environ_init: 0x10020B78: PRINTER=
  100   12314 [main] git-update-index 1476 environ_init: 0x10020B88: PROCESSOR_ARCHITECTURE=x86
  100   12414 [main] git-update-index 1476 environ_init: 0x10020BA8: PROCESSOR_IDENTIFIER=x86 Family 15 Model 3 Stepping 4, GenuineIntel
  100   12514 [main] git-update-index 1476 environ_init: 0x10020BF0: PROCESSOR_LEVEL=15
  101   12615 [main] git-update-index 1476 environ_init: 0x10020C08: PROCESSOR_REVISION=0304
   99   12714 [main] git-update-index 1476 environ_init: 0x10020C28: PROGRAMFILES=C:\Program Files
  100   12814 [main] git-update-index 1476 environ_init: 0x10020C50: PWD=/d/download/git-mine
  100   12914 [main] git-update-index 1476 environ_init: 0x10020C70: PYTHONPATH=/d/scripts/lib/python
  100   13014 [main] git-update-index 1476 environ_init: 0x10020C98: QNX_CONFIGURATION=C:\Program Files\QNX Software Systems
  100   13114 [main] git-update-index 1476 environ_init: 0x10021520: QNX_HOST=d:/QNX630/host/win32/x86
  100   13214 [main] git-update-index 1476 environ_init: 0x10021548: QNX_TARGET=d:/QNX630/target/qnx6
  100   13314 [main] git-update-index 1476 environ_init: 0x10021570: QTJAVA="C:\WINNT\system32\QTJava.zip"
   99   13413 [main] git-update-index 1476 environ_init: 0x100215A0: ROOTDIR=Z:\SYS
  100   13513 [main] git-update-index 1476 environ_init: 0x10020CD8: SHLVL=1
   99   13612 [main] git-update-index 1476 environ_init: 0x100215B8: SYSTEMDRIVE=C:
  100   13712 [main] git-update-index 1476 environ_init: 0x100215D0: SYSTEMROOT=C:\WINNT
  104   13816 [main] git-update-index 1476 getwinenv: can't set native for TEMP= since no environ yet
   99   13915 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (d:\tmp, no-keep-rel, no-add-slash)
   51   13966 [main] git-update-index 1476 normalize_win32_path: d:\tmp = normalize_win32_path (d:\tmp)
   52   14018 [main] git-update-index 1476 mount_info::conv_to_posix_path: /tmp = conv_to_posix_path (d:\tmp)
  148   14166 [main] git-update-index 1476 win_env::add_cache: posix /tmp
   50   14216 [main] git-update-index 1476 win_env::add_cache: native TEMP=d:\tmp
   51   14267 [main] git-update-index 1476 posify: env var converted to TEMP=/tmp
   98   14365 [main] git-update-index 1476 environ_init: 0x100215F8: TEMP=/tmp
  100   14465 [main] git-update-index 1476 environ_init: 0x100215E8: TERM=cygwin
  100   14565 [main] git-update-index 1476 getwinenv: can't set native for TMP= since no environ yet
  100   14665 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (d:\tmp, no-keep-rel, no-add-slash)
   51   14716 [main] git-update-index 1476 normalize_win32_path: d:\tmp = normalize_win32_path (d:\tmp)
   52   14768 [main] git-update-index 1476 mount_info::conv_to_posix_path: /tmp = conv_to_posix_path (d:\tmp)
  147   14915 [main] git-update-index 1476 win_env::add_cache: posix /tmp
   50   14965 [main] git-update-index 1476 win_env::add_cache: native TMP=d:\tmp
   51   15016 [main] git-update-index 1476 posify: env var converted to TMP=/tmp
   98   15114 [main] git-update-index 1476 environ_init: 0x10021738: TMP=/tmp
  100   15214 [main] git-update-index 1476 getwinenv: can't set native for TMPDIR= since no environ yet
  100   15314 [main] git-update-index 1476 mount_info::conv_to_posix_path: conv_to_posix_path (d:\tmp, no-keep-rel, no-add-slash)
   51   15365 [main] git-update-index 1476 normalize_win32_path: d:\tmp = normalize_win32_path (d:\tmp)
   51   15416 [main] git-update-index 1476 mount_info::conv_to_posix_path: /tmp = conv_to_posix_path (d:\tmp)
  148   15564 [main] git-update-index 1476 win_env::add_cache: posix /tmp
   51   15615 [main] git-update-index 1476 win_env::add_cache: native TMPDIR=d:\tmp
   50   15665 [main] git-update-index 1476 posify: env var converted to TMPDIR=/tmp
   98   15763 [main] git-update-index 1476 environ_init: 0x10021880: TMPDIR=/tmp
  100   15863 [main] git-update-index 1476 environ_init: 0x10021868: USER=ARiesen
   99   15962 [main] git-update-index 1476 environ_init: 0x100219A8: USERDOMAIN=HBI
  100   16062 [main] git-update-index 1476 environ_init: 0x100219C0: USERNAME=ARiesen
  100   16162 [main] git-update-index 1476 environ_init: 0x100219D8: USERPROFILE=C:\Documents and Settings\ARiesen
  100   16262 [main] git-update-index 1476 environ_init: 0x10021A10: WINDIR=C:\WINNT
   99   16361 [main] git-update-index 1476 environ_init: 0x10021A28: WINDOWS_LOGIN=0
  100   16461 [main] git-update-index 1476 environ_init: 0x10021A40: WINVER=5.0.2195  Service Pack 4
  100   16561 [main] git-update-index 1476 environ_init: 0x10021A68: X11=/usr/X11R6
   99   16660 [main] git-update-index 1476 environ_init: 0x10021A80: _=/usr/bin/strace
   58   16718 [main] git-update-index 1476 pinfo_init: Set nice to 0
   51   16769 [main] git-update-index 1476 pinfo_init: pid 1476, pgid 1476
  398   17167 [main] git-update-index 1476 set_privilege: 0 = set_privilege ((token 35C) SeRestorePrivilege, 1)
   64   17231 [main] git-update-index 1476 set_privilege: 1 = set_privilege ((token 35C) SeChangeNotifyPrivilege, 1)
   87   17318 [main] git-update-index 1476 dtable::extend: size 32, fds 0x611556B0
   63   17381 [main] git-update-index 1476 normalize_posix_path: src /etc/passwd
   51   17432 [main] git-update-index 1476 normalize_posix_path: /etc/passwd = normalize_posix_path (/etc/passwd)
   52   17484 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/etc/passwd)
   53   17537 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   51   17588 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /etc/passwd, dst D:\Programs\cygwin\etc\passwd, flags 0xA, rc 0
   98   17686 [main] git-update-index 1476 symlink_info::check: not a symlink
   53   17739 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (D:\Programs\cygwin\etc\passwd, 0x22E830) (0xA)
   54   17793 [main] git-update-index 1476 path_conv::check: this->path(D:\Programs\cygwin\etc\passwd), has_acls(0)
  107   17900 [main] git-update-index 1476 etc::test_file_change: FindFirstFile succeeded
  356   18256 [main] git-update-index 1476 pwdgrp::load: /etc/passwd curr_lines 5
   52   18308 [main] git-update-index 1476 pwdgrp::load: /etc/passwd load succeeded
   66   18374 [main] git-update-index 1476 normalize_posix_path: src /etc/group
   52   18426 [main] git-update-index 1476 normalize_posix_path: /etc/group = normalize_posix_path (/etc/group)
   51   18477 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/etc/group)
   52   18529 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   51   18580 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /etc/group, dst D:\Programs\cygwin\etc\group, flags 0xA, rc 0
   78   18658 [main] git-update-index 1476 symlink_info::check: not a symlink
   52   18710 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (D:\Programs\cygwin\etc\group, 0x22E7F0) (0xA)
   53   18763 [main] git-update-index 1476 path_conv::check: this->path(D:\Programs\cygwin\etc\group), has_acls(0)
   94   18857 [main] git-update-index 1476 etc::test_file_change: FindFirstFile succeeded
  343   19200 [main] git-update-index 1476 pwdgrp::load: /etc/group curr_lines 8
   52   19252 [main] git-update-index 1476 pwdgrp::load: /etc/group load succeeded
  184   19436 [main] git-update-index 1476 pwdgrp::read_group: Completing /etc/group: mkgroup:S-1-5-21-484763869-1275210071-682003330-513:10513:ARiesen
  108   19544 [main] git-update-index 1476 cygheap_user::ontherange: what 2, pw 0x10021CE8
   54   19598 [main] git-update-index 1476 cygheap_user::ontherange: HOME is already in the environment /cygdrive/h
  205   19803 [main] git-update-index 1476 sigproc_init: process/signal handling enabled(1)
  313   20116 [sig] git-update-index 1476 wait_sig: myself->dwProcessId 1476
   61   20177 [sig] git-update-index 1476 wait_sig: entering ReadFile loop, readsig 0x328, myself->sendsig 0x324
  154   20331 [main] git-update-index 1476 build_argv: argv[0] = 'git-update-index'
   54   20385 [main] git-update-index 1476 build_argv: argv[1] = 'index.c'
   56   20441 [main] git-update-index 1476 build_argv: argc 2
  116   20557 [main] git-update-index 1476 build_fh_pc: fh 0x611557E8
   72   20629 [main] git-update-index 1476 open_shared: name (null), shared 0x60020000 (wanted 0x60020000), h 0x318
   61   20690 [main] git-update-index 1476 _pinfo::set_ctty: checking if /dev/tty-1 changed
   53   20743 [main] git-update-index 1476 _pinfo::set_ctty: attached tty1073741824 sid 1476, pid 1476, tty->pgid 1476, tty->sid 1476
 3244   23987 [main] git-update-index 1476 fhandler_base::set_flags: flags 0x10002, supplied_bin 0x0
   74   24061 [main] git-update-index 1476 fhandler_base::set_flags: O_TEXT/O_BINARY set in flags 0x10000
   55   24116 [main] git-update-index 1476 fhandler_base::set_flags: filemode set to binary
  106   24222 [main] git-update-index 1476 fhandler_console::open: incremented open_fhs, now 1
   54   24276 [main] git-update-index 1476 fhandler_console::open: opened conin$ 0x2B, conout$ 0x2F
   68   24344 [main] git-update-index 1476 fhandler_console::output_tcsetattr: 0 = tcsetattr (,60020018) (ENABLE FLAGS 3) (lflag 107 oflag 9)
  137   24481 [main] git-update-index 1476 build_fh_pc: fh 0x611559F0
   54   24535 [main] git-update-index 1476 fhandler_base::set_flags: flags 0x10002, supplied_bin 0x0
   54   24589 [main] git-update-index 1476 fhandler_base::set_flags: O_TEXT/O_BINARY set in flags 0x10000
   53   24642 [main] git-update-index 1476 fhandler_base::set_flags: filemode set to binary
   95   24737 [main] git-update-index 1476 fhandler_console::open: incremented open_fhs, now 2
   56   24793 [main] git-update-index 1476 fhandler_console::open: opened conin$ 0xB, conout$ 0x33
   66   24859 [main] git-update-index 1476 fhandler_console::output_tcsetattr: 0 = tcsetattr (,60020018) (ENABLE FLAGS 3) (lflag 107 oflag 9)
  126   24985 [main] git-update-index 1476 build_fh_pc: fh 0x61155BF8
   53   25038 [main] git-update-index 1476 fhandler_base::set_flags: flags 0x10002, supplied_bin 0x0
   53   25091 [main] git-update-index 1476 fhandler_base::set_flags: O_TEXT/O_BINARY set in flags 0x10000
   53   25144 [main] git-update-index 1476 fhandler_base::set_flags: filemode set to binary
   88   25232 [main] git-update-index 1476 fhandler_console::open: incremented open_fhs, now 3
   53   25285 [main] git-update-index 1476 fhandler_console::open: opened conin$ 0x13, conout$ 0x37
   66   25351 [main] git-update-index 1476 fhandler_console::output_tcsetattr: 0 = tcsetattr (,60020018) (ENABLE FLAGS 3) (lflag 107 oflag 9)
  128   25479 [main] git-update-index 1476 dll_crt0_1: user_data->main 0x401580
   54   25533 [main] git-update-index 1476 __set_errno: void dll_crt0_1(char*):880 val 0
   53   25586 [main] git-update-index 1476 wait_for_sigthread: wait_sig_inited 0x320
  169   25755 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   53   25808 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x40C450, 261, 1, 1), errno 0
   60   25868 [main] git-update-index 1476 normalize_posix_path: src .git/refs/
   53   25921 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   52   25973 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22EAA0, 260, 1, 0), errno 0
   54   26027 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/refs/ = normalize_posix_path (.git/refs/)
   54   26081 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/refs)
   55   26136 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   26189 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/refs, dst d:\download\git-mine\.git\refs, flags 0xA, rc 0
  104   26293 [main] git-update-index 1476 symlink_info::check: not a symlink
   55   26348 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\refs, 0x22E760) (0xA)
   55   26403 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\refs), has_acls(0)
   55   26458 [main] git-update-index 1476 build_fh_pc: fh 0x61155E00
  231   26689 [main] git-update-index 1476 get_file_attribute: file: d:\download\git-mine\.git\refs
   60   26749 [main] git-update-index 1476 fhandler_base::fstat_helper: 0 = fstat (, 0x22ECF0) st_atime=4341A9E0 st_size=0, st_mode=0x41ED, st_ino=318799352, sizeof=96
   56   26805 [main] git-update-index 1476 fhandler_base::fhaccess: returning 0
   53   26858 [main] git-update-index 1476 access: returning 0
   55   26913 [main] git-update-index 1476 normalize_posix_path: src .git/objects/
   52   26965 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   53   27018 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22EAA0, 260, 1, 0), errno 0
   54   27072 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/objects/ = normalize_posix_path (.git/objects/)
   53   27125 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/objects)
   54   27179 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   27232 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/objects, dst d:\download\git-mine\.git\objects, flags 0xA, rc 0
   82   27314 [main] git-update-index 1476 symlink_info::check: not a symlink
   53   27367 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\objects, 0x22E760) (0xA)
  173   27540 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\objects), has_acls(0)
   57   27597 [main] git-update-index 1476 build_fh_pc: fh 0x61155E00
  400   27997 [main] git-update-index 1476 get_file_attribute: file: d:\download\git-mine\.git\objects
   57   28054 [main] git-update-index 1476 fhandler_base::fstat_helper: 0 = fstat (, 0x22ECF0) st_atime=4341A9E0 st_size=0, st_mode=0x41ED, st_ino=67615292, sizeof=96
   55   28109 [main] git-update-index 1476 fhandler_base::fhaccess: returning 0
   53   28162 [main] git-update-index 1476 access: returning 0
   53   28215 [main] git-update-index 1476 lstat64: entering
   53   28268 [main] git-update-index 1476 normalize_posix_path: src .git/HEAD
   52   28320 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   53   28373 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E8F0, 260, 1, 0), errno 0
   54   28427 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/HEAD = normalize_posix_path (.git/HEAD)
   53   28480 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/HEAD)
   55   28535 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   52   28587 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/HEAD, dst d:\download\git-mine\.git\HEAD, flags 0xA, rc 0
   81   28668 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\HEAD) failed
   55   28723 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
   81   28804 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\HEAD.exe) failed
   54   28858 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
   76   28934 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\HEAD.exe.lnk) failed
   54   28988 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
  129   29117 [main] git-update-index 1476 symlink_info::check: 17 = symlink.check (d:\download\git-mine\.git\HEAD.lnk, 0x22E5B0) (0x1000001)
   59   29176 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\HEAD.lnk), has_acls(0)
   56   29232 [main] git-update-index 1476 build_fh_pc: fh 0x61155E00
   53   29285 [main] git-update-index 1476 stat_worker: (.git/HEAD, 0x22ED20, 1, 0x61155E00), file_attributes 1
   99   29384 [main] git-update-index 1476 get_file_attribute: file: d:\download\git-mine\.git\HEAD.lnk
   55   29439 [main] git-update-index 1476 fhandler_base::fstat_helper: 0 = fstat (, 0x22ED20) st_atime=4342FB60 st_size=17, st_mode=0xA1FF, st_ino=332219763, sizeof=96
   56   29495 [main] git-update-index 1476 stat_worker: 0 = (.git/HEAD, 0x22ED20)
   54   29549 [main] git-update-index 1476 normalize_posix_path: src .git/HEAD
   53   29602 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   52   29654 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E940, 260, 1, 0), errno 0
   54   29708 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/HEAD = normalize_posix_path (.git/HEAD)
   53   29761 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/HEAD)
   54   29815 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   29868 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/HEAD, dst d:\download\git-mine\.git\HEAD, flags 0xA, rc 0
   78   29946 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\HEAD) failed
   55   30001 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
   75   30076 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\HEAD.exe) failed
   59   30135 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
   75   30210 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\HEAD.exe.lnk) failed
   55   30265 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
  110   30375 [main] git-update-index 1476 symlink_info::check: 17 = symlink.check (d:\download\git-mine\.git\HEAD.lnk, 0x22E600) (0x1000001)
   58   30433 [main] git-update-index 1476 fs_info::update: Cannot get root component of path refs/heads/master
  786   31219 [main] git-update-index 1476 open: open (.git/index.lock, 0xA02)
   54   31273 [main] git-update-index 1476 normalize_posix_path: src .git/index.lock
   53   31326 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   52   31378 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22EA70, 260, 1, 0), errno 0
   55   31433 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/index.lock = normalize_posix_path (.git/index.lock)
   53   31486 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/index.lock)
   54   31540 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   31593 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/index.lock, dst d:\download\git-mine\.git\index.lock, flags 0xA, rc 0
   80   31673 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\index.lock) failed
   55   31728 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
   75   31803 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\index.lock.lnk) failed
   55   31858 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
   53   31911 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\index.lock, 0x22E730) (0xA)
   54   31965 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git)
   54   32019 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   32072 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git, dst d:\download\git-mine\.git, flags 0xA, rc 0
   78   32150 [main] git-update-index 1476 symlink_info::check: not a symlink
   54   32204 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git, 0x22E730) (0xA)
   54   32258 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\index.lock), has_acls(0)
   56   32314 [main] git-update-index 1476 build_fh_pc: fh 0x61155E00
   95   32409 [main] git-update-index 1476 fhandler_base::open: (d:\download\git-mine\.git\index.lock, 0x100A02)
   98   32507 [main] git-update-index 1476 fhandler_base::set_flags: flags 0x100A02, supplied_bin 0x10000
   56   32563 [main] git-update-index 1476 fhandler_base::set_flags: filemode set to binary
   53   32616 [main] git-update-index 1476 fhandler_base::open: 0 = NtCreateFile (0x320, C0100000, d:\download\git-mine\.git\index.lock, io, NULL, 80, 7, 2, 20, NULL, 0)
   54   32670 [main] git-update-index 1476 fhandler_base::open: 1 = fhandler_base::open (d:\download\git-mine\.git\index.lock, 0x100A02)
   54   32724 [main] git-update-index 1476 fhandler_base::open_fs: 1 = fhandler_disk_file::open (d:\download\git-mine\.git\index.lock, 0xA02)
   55   32779 [main] git-update-index 1476 open: 3 = open (.git/index.lock, 0xA02)
   56   32835 [main] git-update-index 1476 void: 0x0 = signal (2, 0x402E20)
  157   32992 [main] git-update-index 1476 open: open (.git/index, 0x0)
   53   33045 [main] git-update-index 1476 normalize_posix_path: src .git/index
   53   33098 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   57   33155 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E960, 260, 1, 0), errno 2
   55   33210 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/index = normalize_posix_path (.git/index)
   53   33263 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/index)
   53   33316 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   33369 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/index, dst d:\download\git-mine\.git\index, flags 0xA, rc 0
   84   33453 [main] git-update-index 1476 symlink_info::check: not a symlink
   54   33507 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\index, 0x22E620) (0xA)
   54   33561 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\index), has_acls(0)
   77   33638 [main] git-update-index 1476 build_fh_pc: fh 0x61156008
   55   33693 [main] git-update-index 1476 fhandler_base::open: (d:\download\git-mine\.git\index, 0x100000)
   66   33759 [main] git-update-index 1476 fhandler_base::set_flags: flags 0x100000, supplied_bin 0x10000
   54   33813 [main] git-update-index 1476 fhandler_base::set_flags: filemode set to binary
   53   33866 [main] git-update-index 1476 fhandler_base::open: 0 = NtCreateFile (0x2FC, 80100000, d:\download\git-mine\.git\index, io, NULL, 0, 7, 1, 20, NULL, 0)
   54   33920 [main] git-update-index 1476 fhandler_base::open: 1 = fhandler_base::open (d:\download\git-mine\.git\index, 0x100000)
   54   33974 [main] git-update-index 1476 fhandler_base::open_fs: 1 = fhandler_disk_file::open (d:\download\git-mine\.git\index, 0x0)
   53   34027 [main] git-update-index 1476 open: 4 = open (.git/index, 0x0)
   75   34102 [main] git-update-index 1476 get_file_attribute: file: d:\download\git-mine\.git\index
   79   34181 [main] git-update-index 1476 fhandler_base::fstat_helper: 0 = fstat (, 0x22ED40) st_atime=4342FB60 st_size=32616, st_mode=0x81A4, st_ino=1769659834, sizeof=96
   57   34238 [main] git-update-index 1476 fstat64: 0 = fstat (4, 0x22ED40)
  101   34339 [main] git-update-index 1476 mmap64: addr 0, len 32616, prot 3, flags 2, fd 4, off 0
   78   34417 [main] git-update-index 1476 fhandler_disk_file::mmap: 307C0000 = MapViewOfFileEx (h:2F8, access:1, 0, off:0, len:32616, addr:0)
   60   34477 [main] git-update-index 1476 mmap64: 307C0000 = mmap() succeeded
   54   34531 [main] git-update-index 1476 close: close (4)
   56   34587 [main] git-update-index 1476 fhandler_base::close: closing '/d/download/git-mine/.git/index' handle 0x2FC
   60   34647 [main] git-update-index 1476 close: 0 = close (4)
  244   34891 [main] git-update-index 1476 lstat64: entering
   53   34944 [main] git-update-index 1476 normalize_posix_path: src index.c
   52   34996 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   53   35049 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E9A0, 260, 1, 0), errno 22
   54   35103 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/index.c = normalize_posix_path (index.c)
   53   35156 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/index.c)
   54   35210 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   35263 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/index.c, dst d:\download\git-mine\index.c, flags 0xA, rc 0
   86   35349 [main] git-update-index 1476 symlink_info::check: not a symlink
   54   35403 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\index.c, 0x22E660) (0xA)
   55   35458 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\index.c), has_acls(0)
   56   35514 [main] git-update-index 1476 build_fh_pc: fh 0x61156008
   52   35566 [main] git-update-index 1476 stat_worker: (index.c, 0x22ED40, 1, 0x61156008), file_attributes 32
   61   35627 [main] git-update-index 1476 fhandler_base::open: (d:\download\git-mine\index.c, 0x110000)
   65   35692 [main] git-update-index 1476 fhandler_base::set_flags: flags 0x110000, supplied_bin 0x10000
   54   35746 [main] git-update-index 1476 fhandler_base::set_flags: O_TEXT/O_BINARY set in flags 0x10000
   53   35799 [main] git-update-index 1476 fhandler_base::set_flags: filemode set to binary
   52   35851 [main] git-update-index 1476 fhandler_base::open: 0 = NtCreateFile (0x2FC, 80100000, d:\download\git-mine\index.c, io, NULL, 0, 7, 1, 20, NULL, 0)
   55   35906 [main] git-update-index 1476 fhandler_base::open: 1 = fhandler_base::open (d:\download\git-mine\index.c, 0x110000)
   53   35959 [main] git-update-index 1476 fhandler_base::open_fs: 1 = fhandler_disk_file::open (d:\download\git-mine\index.c, 0x10000)
   67   36026 [main] git-update-index 1476 get_file_attribute: file: d:\download\git-mine\index.c
   77   36103 [main] git-update-index 1476 fhandler_base::fstat_helper: 0 = fstat (, 0x22ED40) st_atime=4342FB60 st_size=1301, st_mode=0x81A4, st_ino=-792472185, sizeof=96
   57   36160 [main] git-update-index 1476 fhandler_base::close: closing '/d/download/git-mine/index.c' handle 0x2FC
   59   36219 [main] git-update-index 1476 stat_worker: 0 = (index.c, 0x22ED40)
  120   36339 [main] git-update-index 1476 open: open (index.c, 0x0)
   53   36392 [main] git-update-index 1476 normalize_posix_path: src index.c
   52   36444 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   53   36497 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E990, 260, 1, 0), errno 22
   54   36551 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/index.c = normalize_posix_path (index.c)
   53   36604 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/index.c)
   54   36658 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   63   36721 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/index.c, dst d:\download\git-mine\index.c, flags 0xA, rc 0
   80   36801 [main] git-update-index 1476 symlink_info::check: not a symlink
   55   36856 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\index.c, 0x22E650) (0xA)
   54   36910 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\index.c), has_acls(0)
   55   36965 [main] git-update-index 1476 build_fh_pc: fh 0x61156008
   54   37019 [main] git-update-index 1476 fhandler_base::open: (d:\download\git-mine\index.c, 0x100000)
   64   37083 [main] git-update-index 1476 fhandler_base::set_flags: flags 0x100000, supplied_bin 0x10000
   54   37137 [main] git-update-index 1476 fhandler_base::set_flags: filemode set to binary
   53   37190 [main] git-update-index 1476 fhandler_base::open: 0 = NtCreateFile (0x2FC, 80100000, d:\download\git-mine\index.c, io, NULL, 0, 7, 1, 20, NULL, 0)
   54   37244 [main] git-update-index 1476 fhandler_base::open: 1 = fhandler_base::open (d:\download\git-mine\index.c, 0x100000)
   54   37298 [main] git-update-index 1476 fhandler_base::open_fs: 1 = fhandler_disk_file::open (d:\download\git-mine\index.c, 0x0)
   53   37351 [main] git-update-index 1476 open: 4 = open (index.c, 0x0)
   53   37404 [main] git-update-index 1476 mmap64: addr 0, len 1301, prot 1, flags 2, fd 4, off 0
  256   37660 [main] git-update-index 1476 fhandler_disk_file::mmap: 307D0000 = MapViewOfFileEx (h:2F4, access:1, 0, off:0, len:1301, addr:0)
   64   37724 [main] git-update-index 1476 mmap64: 307D0000 = mmap() succeeded
   54   37778 [main] git-update-index 1476 close: close (4)
   53   37831 [main] git-update-index 1476 fhandler_base::close: closing '/d/download/git-mine/index.c' handle 0x2FC
   64   37895 [main] git-update-index 1476 close: 0 = close (4)
  329   38224 [main] git-update-index 1476 normalize_posix_path: src .git/objects/pack
   58   38282 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   53   38335 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E630, 260, 1, 0), errno 22
   54   38389 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/objects/pack = normalize_posix_path (.git/objects/pack)
   54   38443 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/objects/pack)
   54   38497 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   38550 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/objects/pack, dst d:\download\git-mine\.git\objects\pack, flags 0xA, rc 0
   92   38642 [main] git-update-index 1476 symlink_info::check: not a symlink
   54   38696 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\objects\pack, 0x22E2F0) (0xA)
   55   38751 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\objects\pack), has_acls(0)
   56   38807 [main] git-update-index 1476 build_fh_pc: fh 0x61156008
  349   39156 [main] git-update-index 1476 get_file_attribute: file: d:\download\git-mine\.git\objects\pack
   59   39215 [main] git-update-index 1476 fhandler_base::fstat_helper: 0 = fstat (, 0x22E820) st_atime=4341A9E0 st_size=0, st_mode=0x41ED, st_ino=165413209, sizeof=96
   56   39271 [main] git-update-index 1476 fhandler_base::fhaccess: returning 0
   54   39325 [main] git-update-index 1476 fhandler_disk_file::opendir: 0x100229B8 = opendir (/d/download/git-mine/.git/objects/pack)
  105   39430 [main] git-update-index 1476 fhandler_disk_file::readdir: 0x100229BC = readdir (0x100229B8) (.)
   69   39499 [main] git-update-index 1476 fhandler_disk_file::readdir: 0x100229BC = readdir (0x100229B8) (..)
   81   39580 [main] git-update-index 1476 fhandler_disk_file::readdir: 0x0 = readdir (0x100229B8)
   55   39635 [main] git-update-index 1476 fhandler_disk_file::closedir: 0 = closedir (0x100229B8)
  207   39842 [main] git-update-index 1476 closedir: 0 = closedir (0x22E8D0)
  159   40001 [main] git-update-index 1476 open: open (.git/objects/info/alternates, 0x0)
   53   40054 [main] git-update-index 1476 normalize_posix_path: src .git/objects/info/alternates
   53   40107 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   52   40159 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E5B0, 260, 1, 0), errno 22
   55   40214 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/objects/info/alternates = normalize_posix_path (.git/objects/info/alternates)
   53   40267 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/objects/info/alternates)
   54   40321 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   40374 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/objects/info/alternates, dst d:\download\git-mine\.git\objects\info\alternates, flags 0xA, rc 0
  108   40482 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\objects\info\alternates) failed
   57   40539 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
  100   40639 [main] git-update-index 1476 symlink_info::check: GetFileAttributes (d:\download\git-mine\.git\objects\info\alternates.lnk) failed
   56   40695 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
   54   40749 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\objects\info\alternates, 0x22E270) (0xA)
   54   40803 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/objects/info)
   54   40857 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   52   40909 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/objects/info, dst d:\download\git-mine\.git\objects\info, flags 0xA, rc 0
   85   40994 [main] git-update-index 1476 symlink_info::check: not a symlink
   54   41048 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\objects\info, 0x22E270) (0xA)
   55   41103 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\objects\info\alternates), has_acls(0)
   56   41159 [main] git-update-index 1476 build_fh_pc: fh 0x61156008
   55   41214 [main] git-update-index 1476 fhandler_base::open: (d:\download\git-mine\.git\objects\info\alternates, 0x100000)
   95   41309 [main] git-update-index 1476 seterrno_from_win_error: /netrel/src/cygwin-1.5.18-1/winsup/cygwin/fhandler.cc:666 windows error 2
   56   41365 [main] git-update-index 1476 geterrno_from_win_error: windows error 2 == errno 2
   53   41418 [main] git-update-index 1476 __set_errno: void seterrno_from_win_error(const char*, int, DWORD):307 val 2
   53   41471 [main] git-update-index 1476 fhandler_base::open: C0000034 = NtCreateFile (0x0, 80100000, d:\download\git-mine\.git\objects\info\alternates, io, NULL, 0, 7, 1, 20, NULL, 0)
   55   41526 [main] git-update-index 1476 fhandler_base::open: 0 = fhandler_base::open (d:\download\git-mine\.git\objects\info\alternates, 0x100000)
   54   41580 [main] git-update-index 1476 fhandler_base::open_fs: 0 = fhandler_disk_file::open (d:\download\git-mine\.git\objects\info\alternates, 0x0)
   54   41634 [main] git-update-index 1476 open: -1 = open (.git/objects/info/alternates, 0x0)
   54   41688 [main] git-update-index 1476 stat64: entering
   53   41741 [main] git-update-index 1476 normalize_posix_path: src .git/objects/44/279b2481951e474e959a395d085327082700b0
   53   41794 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   52   41846 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E770, 260, 1, 0), errno 2
   54   41900 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/objects/44/279b2481951e474e959a395d085327082700b0 = normalize_posix_path (.git/objects/44/279b2481951e474e959a395d085327082700b0)
   55   41955 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/objects/44/279b2481951e474e959a395d085327082700b0)
   54   42009 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   42062 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/objects/44/279b2481951e474e959a395d085327082700b0, dst d:\download\git-mine\.git\objects\44\279b2481951e474e959a395d085327082700b0, flags 0xA, rc 0
   87   42149 [main] git-update-index 1476 symlink_info::check: not a symlink
   54   42203 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\objects\44\279b2481951e474e959a395d085327082700b0, 0x22E430) (0xA)
   56   42259 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\objects\44\279b2481951e474e959a395d085327082700b0), has_acls(0)
   56   42315 [main] git-update-index 1476 build_fh_pc: fh 0x61156008
   53   42368 [main] git-update-index 1476 stat_worker: (.git/objects/44/279b2481951e474e959a395d085327082700b0, 0x22EAD0, 0, 0x61156008), file_attributes 33
   56   42424 [main] git-update-index 1476 fhandler_base::open: (d:\download\git-mine\.git\objects\44\279b2481951e474e959a395d085327082700b0, 0x110000)
   66   42490 [main] git-update-index 1476 fhandler_base::set_flags: flags 0x110000, supplied_bin 0x10000
   55   42545 [main] git-update-index 1476 fhandler_base::set_flags: O_TEXT/O_BINARY set in flags 0x10000
   97   42642 [main] git-update-index 1476 fhandler_base::set_flags: filemode set to binary
   53   42695 [main] git-update-index 1476 fhandler_base::open: 0 = NtCreateFile (0x2FC, 80100000, d:\download\git-mine\.git\objects\44\279b2481951e474e959a395d085327082700b0, io, NULL, 0, 7, 1, 20, NULL, 0)
   55   42750 [main] git-update-index 1476 fhandler_base::open: 1 = fhandler_base::open (d:\download\git-mine\.git\objects\44\279b2481951e474e959a395d085327082700b0, 0x110000)
   59   42809 [main] git-update-index 1476 fhandler_base::open_fs: 1 = fhandler_disk_file::open (d:\download\git-mine\.git\objects\44\279b2481951e474e959a395d085327082700b0, 0x10000)
   69   42878 [main] git-update-index 1476 get_file_attribute: file: d:\download\git-mine\.git\objects\44\279b2481951e474e959a395d085327082700b0
   78   42956 [main] git-update-index 1476 fhandler_base::fstat_helper: 0 = fstat (, 0x22EAD0) st_atime=4342FB60 st_size=562, st_mode=0x8124, st_ino=-1400112376, sizeof=96
   57   43013 [main] git-update-index 1476 fhandler_base::close: closing '/d/download/git-mine/.git/objects/44/279b2481951e474e959a395d085327082700b0' handle 0x2FC
   61   43074 [main] git-update-index 1476 stat_worker: 0 = (.git/objects/44/279b2481951e474e959a395d085327082700b0, 0x22EAD0)
   56   43130 [main] git-update-index 1476 munmap: munmap (addr 307D0000, len 1301)
   66   43196 [main] git-update-index 1476 build_fh_pc: fh 0x61156008
   61   43257 [main] git-update-index 1476 munmap: 0 = munmap(): 307D0000
  101   43358 [main] git-update-index 1476 writev: writev (3, 0x22ECE0, 1)
   53   43411 [main] git-update-index 1476 fhandler_base::write: binary write
   88   43499 [main] git-update-index 1476 writev: 8192 = write (3, 0x22ECE0, 1), errno 2
   87   43586 [main] git-update-index 1476 writev: writev (3, 0x22ECE0, 1)
   53   43639 [main] git-update-index 1476 fhandler_base::write: binary write
   59   43698 [main] git-update-index 1476 writev: 8192 = write (3, 0x22ECE0, 1), errno 2
   86   43784 [main] git-update-index 1476 writev: writev (3, 0x22ECE0, 1)
   53   43837 [main] git-update-index 1476 fhandler_base::write: binary write
   59   43896 [main] git-update-index 1476 writev: 8192 = write (3, 0x22ECE0, 1), errno 2
   86   43982 [main] git-update-index 1476 writev: writev (3, 0x22ED10, 1)
   53   44035 [main] git-update-index 1476 fhandler_base::write: binary write
   59   44094 [main] git-update-index 1476 writev: 8040 = write (3, 0x22ED10, 1), errno 2
  354   44448 [main] git-update-index 1476 fhandler_console::write: 22D140, 36
   52   44500 [main] git-update-index 1476 fhandler_console::write: at 114(r) state is 0
  189   44689 [main] git-update-index 1476 fhandler_console::write: 36 = write_console (,..36)
  160   44849 [main] git-update-index 1476 normalize_posix_path: src .git/index.lock
   54   44903 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   52   44955 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E730, 260, 1, 0), errno 2
   54   45009 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/index.lock = normalize_posix_path (.git/index.lock)
   54   45063 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/index.lock)
   55   45118 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   45171 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/index.lock, dst d:\download\git-mine\.git\index.lock, flags 0xA, rc 0
   94   45265 [main] git-update-index 1476 symlink_info::check: not a symlink
   54   45319 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\index.lock, 0x22E3F0) (0xA)
   55   45374 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\index.lock), has_acls(0)
   54   45428 [main] git-update-index 1476 normalize_posix_path: src .git/index
   52   45480 [main] git-update-index 1476 cwdstuff::get: posix /d/download/git-mine
   53   45533 [main] git-update-index 1476 cwdstuff::get: (/d/download/git-mine) = cwdstuff::get (0x22E730, 260, 1, 0), errno 2
   54   45587 [main] git-update-index 1476 normalize_posix_path: /d/download/git-mine/.git/index = normalize_posix_path (.git/index)
   53   45640 [main] git-update-index 1476 mount_info::conv_to_win32_path: conv_to_win32_path (/d/download/git-mine/.git/index)
   58   45698 [main] git-update-index 1476 set_flags: flags: binary (0x2)
   53   45751 [main] git-update-index 1476 mount_info::conv_to_win32_path: src_path /d/download/git-mine/.git/index, dst d:\download\git-mine\.git\index, flags 0xA, rc 0
   80   45831 [main] git-update-index 1476 symlink_info::check: not a symlink
   54   45885 [main] git-update-index 1476 symlink_info::check: 0 = symlink.check (d:\download\git-mine\.git\index, 0x22E3F0) (0xA)
   54   45939 [main] git-update-index 1476 path_conv::check: this->path(d:\download\git-mine\.git\index), has_acls(0)
  275   46214 [main] git-update-index 1476 seterrno_from_win_error: /netrel/src/cygwin-1.5.18-1/winsup/cygwin/syscalls.cc:1262 windows error 5
   60   46274 [main] git-update-index 1476 geterrno_from_win_error: windows error 5 == errno 13
   53   46327 [main] git-update-index 1476 __set_errno: void seterrno_from_win_error(const char*, int, DWORD):307 val 13
   54   46381 [main] git-update-index 1476 rename: -1 = rename (d:\download\git-mine\.git\index.lock, d:\download\git-mine\.git\index)
  352   46733 [main] git-update-index 1476 fhandler_console::write: 22D140, 26
   52   46785 [main] git-update-index 1476 fhandler_console::write: at 114(r) state is 0
  142   46927 [main] git-update-index 1476 fhandler_console::write: 26 = write_console (,..26)
  451   47378 [main] git-update-index 1476 fhandler_console::write: 22D280, 38
   53   47431 [main] git-update-index 1476 fhandler_console::write: at 117(u) state is 0
   83   47514 [main] git-update-index 1476 fhandler_console::write: 38 = write_console (,..38)
  253   47767 [main] git-update-index 1476 fhandler_console::write: 409AEB, 7
   53   47820 [main] git-update-index 1476 fhandler_console::write: at 102(f) state is 0
   76   47896 [main] git-update-index 1476 fhandler_console::write: 7 = write_console (,..7)
  448   48344 [main] git-update-index 1476 fhandler_console::write: 22D270, 29
   52   48396 [main] git-update-index 1476 fhandler_console::write: at 85(U) state is 0
   78   48474 [main] git-update-index 1476 fhandler_console::write: 29 = write_console (,..29)
  359   48833 [main] git-update-index 1476 fhandler_console::write: 610E30E7, 1
   53   48886 [main] git-update-index 1476 fhandler_console::write: at 10(0x20) state is 0
   98   48984 [main] git-update-index 1476 fhandler_console::write: 1 = write_console (,..1)
  448   49432 [main] git-update-index 1476 close: close (0)
   68   49500 [main] git-update-index 1476 fhandler_console::close: decremented open_fhs, now 2
   54   49554 [main] git-update-index 1476 close: 0 = close (0)
  442   49996 [main] git-update-index 1476 close: close (1)
   65   50061 [main] git-update-index 1476 fhandler_console::close: decremented open_fhs, now 1
   53   50114 [main] git-update-index 1476 close: 0 = close (1)
  441   50555 [main] git-update-index 1476 close: close (2)
   66   50621 [main] git-update-index 1476 fhandler_console::close: decremented open_fhs, now 0
   53   50674 [main] git-update-index 1476 close: 0 = close (2)
  247   50921 [main] git-update-index 1476 do_exit: do_exit (32768), exit_state 0
   54   50975 [main] git-update-index 1476 void: 0x0 = signal (20, 0x1)
   52   51027 [main] git-update-index 1476 void: 0x0 = signal (1, 0x1)
   53   51080 [main] git-update-index 1476 void: 0x402E20 = signal (2, 0x1)
   53   51133 [main] git-update-index 1476 void: 0x0 = signal (3, 0x1)
   53   51186 [main] git-update-index 1476 fhandler_base::close: closing '/d/download/git-mine/.git/index.lock' handle 0x320
   69   51255 [main] git-update-index 1476 sigproc_terminate: entering
   67   51322 [sig] git-update-index 1476 wait_sig: done
   70   51392 [sig] git-update-index 1476 _cygtls::remove: wait 0x0
  133   51525 [main] git-update-index 1476 proc_terminate: nprocs 0
   52   51577 [main] git-update-index 1476 proc_terminate: leaving
  101   51678 [main] git-update-index 1476 sigproc_terminate: sigproc handling not active
   50   51728 [main] git-update-index 1476 proc_terminate: nprocs 0
   58   51786 [main] git-update-index 1476 proc_terminate: leaving
   55   51841 [main] git-update-index 1476 __to_clock_t: dwHighDateTime 0, dwLowDateTime 0
   50   51891 [main] git-update-index 1476 __to_clock_t: total 00000000 00000000
   51   51942 [main] git-update-index 1476 __to_clock_t: dwHighDateTime 0, dwLowDateTime 468750
   50   51992 [main] git-update-index 1476 __to_clock_t: total 00000000 0000002E
  540   52532 [main] git-update-index 1476 pinfo::maybe_set_exit_code_from_windows: pid 1476, exit value - old 0x80008000, windows 0xDEADBEEF, cygwin 0x80008000

------=_Part_13954_6876396.1128527168258--
