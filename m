From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Sun, 30 Nov 2014 22:40:53 -0500
Message-ID: <CAEvUa7=R7Bm7e=HCuw7QnMPwhunjJ4LUYv4LzMHMugh-iUkt8A@mail.gmail.com>
References: <87vblxl8ah.fsf@gmail.com>
	<547B7B27.90204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 04:41:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvHrB-0004o6-7n
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 04:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbaLADky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 22:40:54 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:54705 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbaLADky convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Nov 2014 22:40:54 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so10204432pab.4
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 19:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1W37ZlIZ5nMi2W6kaOMLxQOr44yEjcldwGIkrbGLTmE=;
        b=qKnWBkYPDmv5VviFwV3PUQOhFf+j6m9NFqQDdBQQRpKdm6zj9haNoy4B3x7XjIZxTC
         joFXKsvCJdnz3guQd0wDMorISTlyjnypK3n0PWjzPwPzKTk4dTqQTKLqkPzz7gQJAru7
         degLMWEZ88edoQ9epQlvLZA3ZOWx/BW3wMmthm/1RDyNt3oAWYP3FUAg4K/taIpLPDkE
         v00DK8hpkdTn8VbJ3PBXKw3tgVmo7qCCpAxrlqYIYdHbUqE4gWuDbZ6ZdADUpCLX9yMW
         A8E4GjRq7SH7vRj1ups49tmRVdoOQ/3My1KKUIq4Rhh4WjWvCNKN/i9YTaUvk6tbV5Dl
         F1hA==
X-Received: by 10.66.232.168 with SMTP id tp8mr95441396pac.132.1417405253524;
 Sun, 30 Nov 2014 19:40:53 -0800 (PST)
Received: by 10.70.55.36 with HTTP; Sun, 30 Nov 2014 19:40:53 -0800 (PST)
In-Reply-To: <547B7B27.90204@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260467>

On Sun, Nov 30, 2014 at 3:16 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
[snip]
> Could the code be more human-readable ?
> static inline mode_t mode_native_to_git(mode_t native_mode)
> {
>         int perm_bits =3D native_mode & 07777;
>         if (S_ISREG(native_mode))
>                 return 0100000 | perm_bits;
>         if (S_ISDIR(native_mode))
>                 return 0040000 | perm_bits;
>         if (S_ISLNK(native_mode))
>                 return 0120000 | perm_bits;
>         if (S_ISBLK(native_mode))
>                 return 0060000 | perm_bits;
>         if (S_ISCHR(native_mode))
>                 return 0020000 | perm_bits;
>         if (S_ISFIFO(native_mode))
>                 return 0010000 | perm_bits;
>         /* Non-standard type bits were given. */
>         /* Shouldn't we die() here ?? */
>                 return perm_bits;
> }

Sure, I can send an updated patch with the new variable and without the=
 "else"s.

Regarding the question in the last comment:  I was assuming if this
case was ever reached, Git would handle the returned mode the same way
as if it encountered an unknown/non-standard file type on a normal
operating system, which could die() if needed in the function that
called stat().

Should I send an updated patch that die()s there?

David
