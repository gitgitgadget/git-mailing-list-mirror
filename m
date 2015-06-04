From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP 1/8] wrapper: implement xopen()
Date: Thu, 4 Jun 2015 20:05:22 +0800
Message-ID: <CACRoPnRn5ynmt1UXct6BzXpr_aioAtLpXfwjZKMBUs4-sGP63A@mail.gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-2-git-send-email-pyokagan@gmail.com>
	<55661513.8000306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 04 14:05:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Tu0-0004gX-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 14:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbbFDMFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2015 08:05:35 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33068 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbbFDMFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 08:05:23 -0400
Received: by lbcue7 with SMTP id ue7so25832750lbc.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 05:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oHo7fNFbteNlRsaM/CSGbDLrjsR9KL0wFoW8hE1F8SI=;
        b=s7Zr+JQKuuAw+IzEGiEwUZwJ2YDzzc5ZaqZFd67VwAylSZndWtpgMkNr7cHFPGa1BE
         v3cv8fezfLkPPbWmyPZ6B1tHyUe1rI878mkMR2sFwinFSXovwF96Dcg+t/gLz1eY4hMX
         8dbs6ta9KdtFOWnLT50J3kvEPIfIdZVBY/bJSXkamFbbFuqpBb8Wj7eXe1JEV5OvLDR6
         d1P6pVSuT5dHr8xox8/IiAzLLW+9xcU3Ee1XNnBdrzg+uRLQOIFE60Z4o/Hj9P/h6jYg
         OGNAy3SckjRQFbp4VLqpmfn9tf72bbLFamH85D1zQxJrr0hlDu1RIlbnUdSUz+Ft+Kpl
         X4Rw==
X-Received: by 10.112.182.4 with SMTP id ea4mr32248036lbc.35.1433419522132;
 Thu, 04 Jun 2015 05:05:22 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 4 Jun 2015 05:05:22 -0700 (PDT)
In-Reply-To: <55661513.8000306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270769>

On Thu, May 28, 2015 at 3:03 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2015-05-27 15.33, Paul Tan wrote:
>> +/**
>> + * xopen() is the same as open(), but it die()s if the open() fails=
=2E
>> + */
>> +int xopen(const char *path, int flags, mode_t mode)
>> +{
>> +     int fd;
>> +
>> +     assert(path);
>> +     fd =3D open(path, flags, mode);
>> +     if (fd < 0) {
>> +             if ((flags & O_WRONLY) || (flags & O_RDWR))
>> +                     die_errno(_("could not open '%s' for writing")=
, path);
> This is only partly true:
> it could be either "writing" or "read write".

Ah right, I see now that the POSIX spec allows for, and encourages
O_RDONLY | O_WRONLY =3D=3D O_RDWR.

> I don't know if the info "for reading" or "for writing" is needed/hel=
pful at all,
> or if a simple "could not open" would be enough.

Yeah, I agree that it may not be helpful, but I noticed that most
error messages in git are of the form "unable to open X for writing",
"unable to open X for reading", "could not create X" etc. Or rather I
thought I noticed, but it now seems to me that there are quite a lot
of uses of "could not open X" as well.

I guess I will remove the distinction.

Thanks,
Paul
