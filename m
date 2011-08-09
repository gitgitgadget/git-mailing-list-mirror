From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Tue, 09 Aug 2011 22:38:11 +0200
Organization: Home - http://www.obry.net
Message-ID: <4E419AB3.7090405@obry.net>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net> <4E416D4A.40602@ramsay1.demon.co.uk>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 09 22:44:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqtAL-00057a-Rq
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 22:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab1HIUok convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 16:44:40 -0400
Received: from mail-ww0-f47.google.com ([74.125.82.47]:39544 "EHLO
	mail-ww0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1HIUoj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 16:44:39 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Aug 2011 16:44:39 EDT
Received: by wwf4 with SMTP id 4so385133wwf.4
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 13:44:38 -0700 (PDT)
Received: by 10.216.0.66 with SMTP id 44mr5882786wea.63.1312922309198;
        Tue, 09 Aug 2011 13:38:29 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-8-151.w82-124.abo.wanadoo.fr [82.124.70.151])
        by mx.google.com with ESMTPS id n6sm185402wed.16.2011.08.09.13.38.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Aug 2011 13:38:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <4E416D4A.40602@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179047>

Le 09/08/2011 19:24, Ramsay Jones a =E9crit :
> Pascal Obry wrote:
>> In fact Cygwin supports both, so make Git agree with this.
>> The failing case is when a file is committed in a sub-dir of the
>> repository using a log message from a file specified with a DOS
>> style path-name. To reproduce:
>>
>>     $ cd src
>>     $ git commit -F c:\tmp\log.txt file.c
>>     fatal: could not read log file 'src/c:\tmp\log.txt': No such fil=
e \
>>     or directory.
>
> Hmm, are you using bash or cmd.exe? Using bash I get the following:

bash.

>
>      $ cd src
>      $ git commut -F c:\tmp\log.txt file.c
>      fatal: could not read file 'src/c:tmplog.txt': No such file or d=
irectory
>      $
>
> Which is what I would expect of (any) posix shell, viz:
>
>      $ ls c:\
>      >  ^C
>      $ ls c:\\
>      AUTOEXEC.BAT*            NTDETECT.COM*               WATCOM/    =
   msysgit/
>      CMPNENTS/                Program Files/              WINDOWS/   =
   msysgit-old/
>      CONFIG.SYS*              RECYCLER/                   boot.ini*  =
   ntldr*
>      Documents and Settings/  SUPPORT/                    cygwin/    =
   pagefile.sys
>      I386/                    SWSTAMP.TXT*                cygwintemp/=
   ssl/
>      IO.SYS*                  System Volume Information/  dm/        =
   uname/
>      MSDOS.SYS*               TOOLSCD/                    dm840/     =
   zlib/
>      MSOCache/                VALUEADD/                   hiberfil.sy=
s

Exactly, \\ this is what I have used and this is the bug. Cygwin=20
supports ls c:\\ so should Cygwin/Git. My quoted example was missing th=
e=20
escape \.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
