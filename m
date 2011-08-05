From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Fri, 5 Aug 2011 19:58:18 +0200
Message-ID: <CABPQNSb96xdiL=POyrM-vR1f_KN6s+0UwnZ4E3pZ8NoTfSixzw@mail.gmail.com>
References: <1312560614-20772-1-git-send-email-pascal@obry.net>
 <1312560614-20772-3-git-send-email-pascal@obry.net> <7vipqb3g1w.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, git@vger.kernel.org,
	Theo Niessink <theo@taletn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 19:59:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpOfo-0003mZ-76
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 19:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876Ab1HER7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 13:59:00 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33170 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab1HER66 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2011 13:58:58 -0400
Received: by pzk37 with SMTP id 37so4249264pzk.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=deZ/t2uYiMD/vdzvyHCdYzkcNyUjB5hra+2lHreFjQE=;
        b=po+m+i9RGRWa46mjAO6SRvF+LpIkSZQd/bWQz8kBZx4NQXhhp5i+ibMTkb9PUTYmHa
         HArzXP2a5kvqOhfehf1c1x8tOiCAyp8F3EDZU2vN3muN0szRGcgaPxjoz3Wnm/sNLC5l
         5TnePFEDZgJe2Zmu9Z6DbPl17QUmGOSGEMqAE=
Received: by 10.142.60.16 with SMTP id i16mr2256223wfa.343.1312567138180; Fri,
 05 Aug 2011 10:58:58 -0700 (PDT)
Received: by 10.68.56.65 with HTTP; Fri, 5 Aug 2011 10:58:18 -0700 (PDT)
In-Reply-To: <7vipqb3g1w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178811>

On Fri, Aug 5, 2011 at 7:48 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Pascal Obry <pascal@obry.net> writes:
>
>> In fact Cygwin supports both, so make Git agree with this.
>> The failing case is when a file is committed in a sub-dir of the
>> repository using a log message from a file specified with a DOS
>> style path-name. To reproduce:
>>
>> =A0 =A0$ cd src
>> =A0 =A0$ git commit -F c:\tmp\log.txt file.c
>> =A0 =A0fatal: could not read log file 'src/c:\tmp\log.txt': No such =
file \
>> =A0 =A0or directory.
>>
>> Signed-off-by: Pascal Obry <pascal@obry.net>
>> ---
>> =A0compat/cygwin.h | =A0 =A03 +++
>> =A01 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/compat/cygwin.h b/compat/cygwin.h
>> index a3229f5..de9737c 100644
>> --- a/compat/cygwin.h
>> +++ b/compat/cygwin.h
>> @@ -7,3 +7,6 @@ extern stat_fn_t cygwin_lstat_fn;
>>
>> =A0#define stat(path, buf) (*cygwin_stat_fn)(path, buf)
>> =A0#define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
>> +
>> +#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] =3D=
=3D ':')
>> +#define is_dir_sep(c) ((c) =3D=3D '/' || (c) =3D=3D '\\')
>
> I wonder if these two that are the same as mingw should further be
> consolidated into one implementation, something like below.
>
> Note that I am just wondering, not suggesting, without knowing which =
is
> better.

IMO this becomes a bit hard to read as you have to ping-pong between
sources to understand exactly what that flag does. We have
compat/win32.h, perhaps we should move the macros there and include it
from both compat/mingw.h and compat/cygwin.h instead (given that we're
going to do this, of course)?
