From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP 1/8] wrapper: implement xopen()
Date: Wed, 3 Jun 2015 16:16:57 +0800
Message-ID: <CACRoPnSk7vgFwTazEz3yytsdBC0CT+Yjs3JZ_oX_kuR2yyZhRA@mail.gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-2-git-send-email-pyokagan@gmail.com>
	<55661513.8000306@web.de>
	<20150527215307.GC23259@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 10:17:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z03rF-0000FY-OJ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 10:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbbFCIRB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 04:17:01 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35436 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbFCIQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 04:16:58 -0400
Received: by lbbuc2 with SMTP id uc2so1802625lbb.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Fdi8J0ATN80Z7JuoXSQ25dTsp9XcXsaeajAFh+xGic0=;
        b=EU9oEB9DpaV3TdLxbEfVlS+wYvE2ZjoUNtdcMTUcVyOkeS+xMPKYDhUOrjv3dtRzlW
         ERI3vGo0h1uuXZa5FxPgYOymcHYdXmuzOmoJCqgzInyqOQhBaQonxDjVAkLKQOmOsMys
         y5GfsRmXNwSbHQnbXpfpD+MpELt1aibCvB9YPGalDTXkBO+vJERIP1gpii/OKRSrZ0Pp
         ITAn2Wi8J2eXkO11pItzVS6qRSCoaXidY3SUmGhhlXZOqOFJxaiF02yrwBxyCOKXO6Hp
         zz8cyrkMWByXQ8vPRXORMzBQSbpRxX6I6yclMGDPkRjTBf+a1/zC1G1Nfo+3S+ZOFUnJ
         h3IA==
X-Received: by 10.152.164.193 with SMTP id ys1mr1410257lab.65.1433319417153;
 Wed, 03 Jun 2015 01:16:57 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 3 Jun 2015 01:16:57 -0700 (PDT)
In-Reply-To: <20150527215307.GC23259@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270664>

On Thu, May 28, 2015 at 5:53 AM, Jeff King <peff@peff.net> wrote:
> On Wed, May 27, 2015 at 09:03:47PM +0200, Torsten B=C3=B6gershausen w=
rote:
>
>> The original open can take 2 or 3 parameters, how about this:
>> int xopen(const char *path, int oflag, ... )
>> {
>>         va_list params;
>>         int mode;
>>         int fd;
>>
>>         va_start(params, oflag);
>>         mode =3D va_arg(params, int);
>>         va_end(params);
>>
>>         fd =3D open(path, oflag, mode);
>
> Don't you need a conditional on pulling the mode arg off the stack
> (i.e., if O_CREAT is in the flags)?

Yeah, we do, as va_arg()'s behavior is undefined if we do not have the
next argument.

The POSIX spec[1] only mentions O_CREAT as requiring the extra
argument, so I guess we'll only need to check for that.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/open.html

Thanks,
Paul
