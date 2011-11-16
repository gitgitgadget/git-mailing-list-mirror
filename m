From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Wed, 16 Nov 2011 15:37:34 +0700
Message-ID: <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com> <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org> <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net> <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com> <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 09:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQb0X-0002Ib-IR
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 09:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab1KPIiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 03:38:08 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52298 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab1KPIiG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 03:38:06 -0500
Received: by bke11 with SMTP id 11so256822bke.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 00:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=w7+crM/Yg2oQQzS5WS40BXgu5WQ13Xl95RhNYkwCVB8=;
        b=iKAuyRvTalqC6O9ImQup3awvarYChXayo8S71B0BTsq0vuXT5llwRWy2t5dnwD/iKn
         5/D+TuqsCqADhUTRY+VwSBVC+hfF7wMWYP+yuKWJ0okSjF160P5zrvLS0pyQ4DtyaSrz
         1vlVP4wVMh5W+f8q+y2nVHJi32+0QKsrvlmv4=
Received: by 10.204.130.208 with SMTP id u16mr27475699bks.47.1321432685164;
 Wed, 16 Nov 2011 00:38:05 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 16 Nov 2011 00:37:34 -0800 (PST)
In-Reply-To: <20111116075955.GB13706@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185526>

2011/11/16 Jonathan Nieder <jrnieder@gmail.com>:
> Ramkumar Ramachandra wrote:
>> Junio C Hamano wrote:
>
>>> Or perhaps http://thread.gmane.org/gmane.comp.version-control.git/1=
84963/focus=3D185436
>>
>> I noticed that sha1_to_hex() also operates like this. =C2=A0The
>> resolve_ref() function is really important, but using the same
>> technique for these tiny functions is probably an overkill
>
> I don't follow. =C2=A0Do you mean that not being confusing is overkil=
l,
> because the function is small that no one will bother to look up the
> right semantics? =C2=A0Wait, that sentence didn't come out the way I
> wanted. ;-)
>
> Jokes aside, here's a rough series to do the git_path ->
> git_path_unsafe renaming. =C2=A0While writing it, I noticed a couple =
of
> bugs, hence the two patches before the last one. =C2=A0Patch 2 is the=
 more
> interesting one.

Or perhaps
 - kill git_path(const char *fmt, ...) in favor of git_pathdup() compan=
ion
 - git_path(const char *path) maintains a small hash table to keep
track of all returned strings based with "path" as key.

Out of 142 git_path() calls in my tree, 97 of them are in form
git_path("some static string"). git_path() could learn to keep track
of all generated strings while keep it convenient to use. I suspect
with some macro magic, we can keep track of generated strings without
a hash table.
--=20
Duy
