From: Haitao Li <lihaitao@gmail.com>
Subject: Re: [PATCH v2] date.c: Support iso8601 timezone formats
Date: Thu, 8 Sep 2011 10:53:59 +0800
Message-ID: <CABk5KLhXyQOFLegdpNcHzfwxX4LwjcG_eE3TVW1eDgTP=4kYGQ@mail.gmail.com>
References: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
 <1315374407-30828-1-git-send-email-lihaitao@gmail.com> <7vaaag4794.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 04:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Ul0-00013Q-8Z
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 04:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab1IHCyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 22:54:20 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:51049 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab1IHCyU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 22:54:20 -0400
Received: by vws10 with SMTP id 10so495109vws.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 19:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3HGj8AyyO0m2NUQ3ECh6k0OTuNVTrQlheXHlb+Aps28=;
        b=iH2wmk8nqFuYZTHEGjH9tUYGwSWMmv5//W0m6xulW0XBiMD8LiuYgHwjf+9nrM5dQv
         KhPb3/W8NQLIcV9fhPN6N0eNKGIc9BsG2YmAosKtf1WL+xq460hryE28aM0ySkoRDWYR
         u8L1HaLpnGEPwu5EkEHZ+tSp1JH6PdhAKFMEg=
Received: by 10.52.108.164 with SMTP id hl4mr123119vdb.357.1315450459280; Wed,
 07 Sep 2011 19:54:19 -0700 (PDT)
Received: by 10.52.159.129 with HTTP; Wed, 7 Sep 2011 19:53:59 -0700 (PDT)
In-Reply-To: <7vaaag4794.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180934>

>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Only hours specified =
*/
>
> That comment belongs to inside the following if() {...}.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n =3D=3D 1 || n =3D=3D=
 2) {
>
> ... i.e. here.
>
Good catch!

>> - =C2=A0 =C2=A0 if (min < 60 && n > 2) {
>> + =C2=A0 =C2=A0 if (n > 0 && min < 60 && hour < 25) {
>
> What is this "hour < 25" about? Aren't we talking about the UTC offse=
t
> value that come after the [-+] sign?
>
> I do not mind adding a new check, but I do mind if it adds a check wi=
th
> not much value. =C2=A0Even at Pacific/Kiritimati, the offset is 14; t=
he new
> check seems a bit too lenient.
>

I think it's not "too" lenient. UTC+14 was "invented" in 1995 [1].
Maybe UTC+15 would be added someday for some reason? How about
changing to "hour < 24", this is how ICU checks offset validity [2].

1. http://en.wikipedia.org/wiki/UTC%2B14#History
2. http://bugs.icu-project.org/trac/browser/icu/tags/release-4-8-1/sour=
ce/i18n/timezone.cpp#L1482
