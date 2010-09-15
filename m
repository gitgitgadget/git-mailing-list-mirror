From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 19:19:28 -0400
Message-ID: <AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com> <7v62y661pl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:20:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow1Go-0001Dw-0O
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab0IOXT7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 19:19:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38501 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab0IOXT6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 19:19:58 -0400
Received: by iwn5 with SMTP id 5so490352iwn.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1yvFWBfx22EOKGHZi68f5IEiyFVrF3/KWEzcdC6BOmQ=;
        b=gPX99P4CGCF2jW+N+rYJcgtdRPGHAq1W+UmJJ2PPSL+h1QeK7iLM//l9PL6iRe0Lo0
         gQVBNhSeGZdgQA8c8L8Dm10Y9q2+TCmFMl4bF8pgMD4P15UCjmgzgA7Xz9M6OBSiLbaM
         z2UINIDklu8NaZTn9dgjbuRZal6aR5ME5g4iI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xidzgmE1hqSmYEejlk6yp5AmYTGnTOSX4SGTGld8zQpudeXpPf04ykL2t0OB5yQ3hq
         usIzObbb+2QIrz7A0ST+f9uMWXLQxd4lT3qoM51XPNBgsYqiKMwORQWm4y7+m4nD7rPk
         ajqMWjxtgTnCv24P2o+3q7q1Dr3OAt1WVaRDw=
Received: by 10.231.60.4 with SMTP id n4mr2523419ibh.18.1284592798114; Wed, 15
 Sep 2010 16:19:58 -0700 (PDT)
Received: by 10.231.11.11 with HTTP; Wed, 15 Sep 2010 16:19:28 -0700 (PDT)
In-Reply-To: <7v62y661pl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156272>

On Wed, Sep 15, 2010 at 7:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Am I missing something really obvious here?
>>
>> kore:~/Repos/git (master)$ git ls-files | wc -l
>> =C2=A0 =C2=A0 2009
>
> You asked it to show the cached paths (default). =C2=A0Your project c=
urrently
> tracks 2009 paths in the index.

Correct.

>> kore:~/Repos/git (master)$ git ls-files -x \* | wc -l
>> =C2=A0 =C2=A0 2009
>
> You told that '*' is the exclude pattern for carrying out some operat=
ion,
> but you didn't tell what operation you want. =C2=A0You are shown the =
cached
> paths (default).

I want cached paths, minus the exclude pattern. Using -c -x \* gives
the same result.

There is no indication in the man page that -x doesn't apply to -c.

>> kore:~/Repos/git (master)$ git ls-files -i -x \* | wc -l
>> =C2=A0 =C2=A0 2009
>
> You told that '*' is the exclude pattern, you want only paths that ma=
tch
> the exclude pattern, and chose to show files in the index (which agai=
n is
> the default) by not saying -o.
>
> I've never found -i useful myself (actually I don't find many options=
 the
> command has very useful anymore), but the above is how I read the ls-=
files
> manual page.

I don't care about -i myself, and maybe I should have been clearer.
AFAICT, [-c] -x is broken:

$ git ls-files -c -x \* |wc -l
    2009

       -c, --cached
           Show cached files in the output (default)

       -x <pattern>, --exclude=3D<pattern>
           Skips files matching pattern. Note that pattern is a shell
wildcard pattern.

Oh, geez, here it is lower down in the man page:

  git ls-files can use a list of "exclude patterns" when traversing
the directory tree and finding files to show when the flags --others
or --ignored are specified. gitignore(5) specifies the format of
exclude patterns.

Bah, what use is that? Minimally ls-files shouldn't accept -x unless
given either --ignored or --others if that's all it applies to. I
guess this is my itch to scratch.

j.
