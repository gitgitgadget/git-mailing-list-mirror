From: Rei Thiessen <rei.thiessen@gmail.com>
Subject: Re: [PATCH] cygwin: set write permission before unlink
Date: Wed, 29 Jun 2011 12:48:40 -0600
Message-ID: <BANLkTincfBvDBYYLGJe-m5hknvCVdmMUww@mail.gmail.com>
References: <1309331898-32247-1-git-send-email-rei.thiessen@gmail.com>
	<09c0b1900a67bd1f701c0b23954a34ab.squirrel@mail.localhost.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Christof_Kr=FCger?= <git@christof-krueger.de>
X-From: git-owner@vger.kernel.org Wed Jun 29 20:48:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbzoc-0000Hh-Vk
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 20:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019Ab1F2Ssn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jun 2011 14:48:43 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54641 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab1F2Ssl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2011 14:48:41 -0400
Received: by iyb12 with SMTP id 12so1269417iyb.19
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JbWz9j8R8PaZ9FpW4lYHwZpWVfxkoH4XE7XuaO7pO5s=;
        b=k7ooRUkjaOdwK1+DakJjiGRXK+15uE3xROk2nIbBAEe1lFxzXjzTpFJ00ekeMZzSpZ
         x7Mhm5Nmv7xQEsWEffqGEvD42DyI6lm3fEWi8Z5B/XlWbXmZGlD9JQOBaI3qahkuU5I9
         ghUAULt6UC0LFne6KoGS5ol0QS+n+X8y05EHA=
Received: by 10.43.44.1 with SMTP id ue1mr1217385icb.314.1309373320633; Wed,
 29 Jun 2011 11:48:40 -0700 (PDT)
Received: by 10.42.189.199 with HTTP; Wed, 29 Jun 2011 11:48:40 -0700 (PDT)
In-Reply-To: <09c0b1900a67bd1f701c0b23954a34ab.squirrel@mail.localhost.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176456>

Another point of concern is that the user might have specifically set
the read-only flag only certain files
to protect them from changes/deletion, but after the patch, git can
delete them with impunity.
But then, a file's permission isn't supposed to matter to unlink() anyw=
ays.
Interestingly, Cygwin's packaged unlink command-line utility will
delete read-only files,
so Cygwin's attempt to fake permissions through the read-only flag
when a filesystem is mounted with "noacl"
seems to be inconsistent.

I'll leave this issue up to Cygwin's package maintainer for git.

Regards,
Rei


2011/6/29 Christof Kr=FCger <git@christof-krueger.de>:
>> +#undef unlink
>> +int cygwin_unlink(const char *pathname)
>> +{
>> + =A0 =A0 /* "read-only" files can't be unlinked */
>> + =A0 =A0 chmod(pathname, 0666);
>> + =A0 =A0 return unlink(pathname);
>> +}
>
> I've no idea on how cygwin maps file permissions to the underlying
> filesystem, but the above raised my attention. Doesn't chmodding the =
file
> to 0666 open a small windows where "group" and "other" users have rea=
d
> access to the file? This might be unwanted by the user and could be
> exploited by some attacker listening for changes on that file.
> Or am I too paranoid?
>
> Regards,
> =A0Chris
>
>
