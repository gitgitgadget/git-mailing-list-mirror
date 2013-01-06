From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 21:51:17 +0100
Message-ID: <50E9E3C5.4070104@web.de>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 21:52:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrxCW-000544-GK
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 21:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab3AFUvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 15:51:47 -0500
Received: from mout.web.de ([212.227.17.12]:63408 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab3AFUvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 15:51:46 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MAvCS-1TkDxa3oA8-00Ai3E; Sun, 06 Jan 2013 21:51:19 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:00w6t8TVpqLHm8rhkHt7O/DEzfQe6uxEVak9nwjAkta
 OHUhMgEzDclsfokQewBmDy6bHTxHZqZWZnG8uPZ3xDz2ZjiMVU
 yQZH6Aot/x37k1AuOtRqR+kQ9Arb/au3Cz2kuTwR/Ga6Fle8dj
 AFlehWA2rjdrv4EXRI2OthmXj3DkiE7g+5Sxgald72MgtVOJCd
 bv/QuuHnsElAa2XdtwiXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212839>

On 06.01.13 20:54, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> Mark Levedahl wrote:
>>
>>>                                                          However, the newer
>>> win32api is provided only for the current cygwin release series, which can
>>> be reliably identified by having dll version 1.7.x, while the older frozen
>>> releases (dll versions 1.6.x from redhat, 1.5.x open source) still have the
>>> older api as no updates are being made for the legacy version(s).
>>
>> Ah.  That makes sense, thanks.
>>
>> (For the future, if we wanted to diagnose an out-of-date win32api and
>> print a helpful message, I guess cygcheck would be the command to use.)
> 
> Hmph, so we might see somebody who cares about Cygwin to come up
> with a solution based on cygcheck (not on uname) to update this
> part, perhaps on top of Peff's "split default settings based on
> uname into separate file" patch?
> 
> If I understood what Mark and Torsten wrote correctly, you will have
> the new win32api if you install 1.7.17 (or newer) from scratch, but
> if you are on older 1.7.x then you can update the win32api part as a
> package update (as opposed to the whole-system upgrade).  A test
> based on "uname -r" cannot notice that an older 1.7.x (say 1.7.14)
> installation has a newer win32api because the user updated it from
> the package (hence the user should not define CYGWIN_V15_WIN32API).
> 
> Am I on the same page as you guys, or am I still behind?
> 
> In the meantime, perhaps we would need something like this?
> 
> 
> diff --git a/Makefile b/Makefile
> index 8e225ca..b45b06d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -281,6 +281,9 @@ all::
>  #
>  # Define NO_REGEX if you have no or inferior regex support in your C library.
>  #
> +# Define CYGWIN_V15_WIN32API if your Cygwin uses win32api dll older than
> +# 1.7.x (this typically is true on Cygwin older than 1.7.17)
> +#
>  # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
>  # user.
>  #

Hm, I haven't understood the connection between the dll (cygwin1.dll ?)
which is used in runtime, and the header files which are used when compiling.

Are they updated at the same time when updating from 1.7.16 to 1.7.17 ?

Until I updated my cygwin 1.7 (following Marks recommendation) this did the trick for me:

+ifeq ($(shell grep mingw /usr/include/w32api/winsock2.h />/dev/null 2>/dev/null && echo y),y)
+	CYGWIN_V15_WIN32API=YesPlease
+endif


As an alternative, would this be easier to read?
> +# Define CYGWIN_V15_WIN32API for Cygwin versions up to 1.7.16
