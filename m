From: Anthony Ramine <n.oxyde@gmail.com>
Subject: Re: [PATCH] wildmatch: properly fold case everywhere
Date: Tue, 28 May 2013 15:01:51 +0200
Message-ID: <5A688100-5F54-4945-85BB-643B69C05F85@gmail.com>
References: <1369744361-44918-1-git-send-email-n.oxyde@gmail.com> <CACsJy8Bu2XvapGHjcKZJuATqB90MXSCoNHkke9CBeiwSvzpH8A@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 15:02:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJXP-0006dr-IB
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933976Ab3E1NB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 May 2013 09:01:59 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:60551 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933919Ab3E1NB6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 May 2013 09:01:58 -0400
Received: by mail-we0-f179.google.com with SMTP id m46so5369550wev.10
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=2HszG7VIbVBgYoOkj6hSTGK53ohiHe78RJo56FQ+o2c=;
        b=nhhC9WdW8xyerEGozqglCrY4wwiT3wHysdfv6Dz+xTqZrPph1lk5E8cn1E9Z2+fn4Z
         HT+VL65WO5CmLyQ/Eeet/qM68gnE/vZZoylhp75waaZCSKSfIe4RbxpAp8Bs89yMHzVI
         7UEtRbXwlVPIIJeREys3S9W9oSBmu9BKrz7uqMfB74gYr1wPH/dWLXEpziZ+M2A9+md2
         Clzskq3lnycIPuj2jvwdl+G/Ua5re6FFXE1GBiBPWz5MhRDWtok/ytcU1gvNGdc35e3j
         CR5SfKHWl1sP8ZdIFBOSou/mwt5QmWIvYDAq1zUY4Rw5XWKqD0HxvFEYIQzxZaj8R3aM
         MXUQ==
X-Received: by 10.180.211.197 with SMTP id ne5mr11795215wic.54.1369746117405;
        Tue, 28 May 2013 06:01:57 -0700 (PDT)
Received: from [192.168.118.71] (33-43.83-90.static-ip.oleane.fr. [90.83.43.33])
        by mx.google.com with ESMTPSA id cw8sm24165714wib.7.2013.05.28.06.01.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:01:56 -0700 (PDT)
In-Reply-To: <CACsJy8Bu2XvapGHjcKZJuATqB90MXSCoNHkke9CBeiwSvzpH8A@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225644>

You're right, I will amend my patch. How do I make git-send-email reply=
 to that thread?

--=20
Anthony Ramine

Le 28 mai 2013 =E0 14:53, Duy Nguyen a =E9crit :

> On Tue, May 28, 2013 at 7:32 PM, Anthony Ramine <n.oxyde@gmail.com> w=
rote:
>> @@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar *=
text, unsigned int flags)
>>                                        }
>>                                        if (t_ch <=3D p_ch && t_ch >=3D=
 prev_ch)
>>                                                matched =3D 1;
>> +                                       else if ((flags & WM_CASEFOL=
D) && ISLOWER(t_ch)) {
>> +                                               t_ch =3D toupper(t_c=
h);
>=20
> This happens in a while loop where t_ch may be used again. Should we
> make a local copy of toupper(t_ch) and leave t_ch untouched?
>=20
>> +                                               if (t_ch <=3D p_ch &=
& t_ch >=3D prev_ch)
>> +                                                       matched =3D =
1;
>> +                                       }
>>                                        p_ch =3D 0; /* This makes "pr=
ev_ch" get set to 0. */
>>                                } else if (p_ch =3D=3D '[' && p[1] =3D=
=3D ':') {
>>                                        const uchar *s;
> --
> Duy
