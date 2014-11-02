From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 01/19] dir.c: optionally compute sha-1 of a .gitignore file
Date: Sun, 2 Nov 2014 08:25:12 +0700
Message-ID: <CACsJy8COjFxFUoUn7YY-0ciGmmRnih+ijPoF7PAd=89ejAUfiA@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1414411846-4450-2-git-send-email-pclouds@gmail.com> <544FD44D.4000101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 02 02:25:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkjvP-0004LL-Rq
	for gcvg-git-2@plane.gmane.org; Sun, 02 Nov 2014 02:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbaKBBZo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Nov 2014 21:25:44 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64846 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaKBBZn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Nov 2014 21:25:43 -0400
Received: by mail-ie0-f180.google.com with SMTP id y20so3510195ier.11
        for <git@vger.kernel.org>; Sat, 01 Nov 2014 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AXwLC6kmkudM5i3tS2JxahS+hJ38mMrByRjpDvyRZsg=;
        b=LfGsK5hiVwuntSon3YeKNDXe+FS8ARQa+T6GPB2P+MGYD/86MOsBpIcFejm+s306E5
         k/ddUu1/ji8N6jFhji9Jrl9tUlm//cKQ2xX0axAOYhrPsLQEZ8AchQAT6VuyZSSLrAJZ
         nb2bDa3sim5AlM10QMOyWbfzJgeDTGDuvZJrAc16LV1BtFIgjNtvn5ZLDYJ1AiHGxDXK
         U3wgyayTxnVctfHf+sEVhc4Yqr1+6Mbi7L/pUbXcsn6GbbATJYFV7RETAimI7O2AJOv8
         6iGSA06Tx3eSFcv2tKhdFLdFnS28yod0tYsj1mLyUNTytAX3wXuKbq2u7JKxR9MD/1No
         uJ1A==
X-Received: by 10.42.24.10 with SMTP id u10mr71247icb.58.1414891542479; Sat,
 01 Nov 2014 18:25:42 -0700 (PDT)
Received: by 10.107.176.8 with HTTP; Sat, 1 Nov 2014 18:25:12 -0700 (PDT)
In-Reply-To: <544FD44D.4000101@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 29, 2014 at 12:37 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
>
> On 2014-10-27 13.10, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> []
> Nice serious, I can imagine to test & benchmark it (so I assume there=
 is a branch
> on github or so ?)

It's on 'pu' now. There's a branch on my github repo, but it has some
extra debugging on top, so 'pu' is probably the best option.

> Another thing:
> Can we switch the feature off?
>
> It could be nice to benchmark with and without the cache on the comma=
nd line,
> and besides that we may want to switch it on or off, depending on the=
 file system.
> I think this can be easily done when reading and writing the index fi=
le.
> (But may cost a config variable, core.dirmtime ??)

You can permanently switch it off with "git update-index
--no-untracked-cache". An option to temporarily disable it is not
available. I'll add an environment variable for that.

=46or a normal case, "update-index --untracked-cache" would test if the
OS/FS supports this before enabling it. If the repo is moved to
another fs, or being used by a different OS, then the user has to
manually disable it first. I don't know what we can do here, maybe
record uname and filesystem in the index as well..

>> diff --git a/dir.c b/dir.c
>> +static int add_excludes(const char *fname, const char *base, int ba=
selen,
>> +                     struct exclude_list *el, int check_index,
>> +                     struct sha1_stat *ss, int ss_valid)
> Cosmetic question: does it make sense to write
>
> struct sha1_stat *sha1_stat
> or
> struct sha1_stat *s_stat

Noted.


--=20
Duy
