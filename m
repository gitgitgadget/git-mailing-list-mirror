From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [BUG?] blame: Odd -L 1,+0 behavior
Date: Fri, 16 Jul 2010 21:25:58 +0000
Message-ID: <AANLkTinSO3S4hjuvzSOfEBwBEL8_amk7uM2-_LKMtE8k@mail.gmail.com>
References: <AANLkTin-6nck9aVKPTwOy_PmrGUs1iS8ruqzIORbf8jb@mail.gmail.com>
	<7vy6dbqghl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 23:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZsQ2-0007gp-PU
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 23:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966207Ab0GPV0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 17:26:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53385 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759270Ab0GPVZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 17:25:59 -0400
Received: by iwn7 with SMTP id 7so2549718iwn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BYV6SE4y027+IjHMgs53RJitvTNOdSnygDXPiGxAM5c=;
        b=egmM1igb5Q9/pcIWbD0gRL6z+i4K1d2juZ3yOyHGVvgFPZgiu6+78hwbE6+W1YA6Yj
         gYeNs4XuNSYrJBlEY+cDmGXb1s7M+5YpNgM2OEwejiRiXp3KgCtS5WfqVMyZUzeb8pYl
         4yReq0ieFWWXd/AZ1j7uVABdIBHPU4x9e98aM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G1k2XprfnKCbPTV8KJVglt8ezZV1UaSHWA1i4LL9rc3jG5SneNu6T7FphC+jLOnYlF
         ijwDY4tF5h4TfrXsQuokjc749Q7qjxr3XWP5wXwP3Ag9TPxJ4R+XiIK/5L9a8nzNlaIx
         05vndKkEo7ShTs3oOMeX0c7L/yFhgjFGkNS5w=
Received: by 10.231.146.134 with SMTP id h6mr1505505ibv.170.1279315558550; 
	Fri, 16 Jul 2010 14:25:58 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 16 Jul 2010 14:25:58 -0700 (PDT)
In-Reply-To: <7vy6dbqghl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151175>

On Fri, Jul 16, 2010 at 21:11, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> ok, +/- are zero-indexed:
>>
>> =C2=A0 =C2=A0 $ git blame -L 1,+2 cow
>
> I don't know what "zero-indexed" means, but +2 means "starting from t=
he
> line I told you earlier, give me two lines". =C2=A0Likewise -2 means =
"ending at
> the line I told you earlier, give me two lines".

=46rom just using it I parsed 1,+1 as "give me line #1 plus $n-1
lines". At first I thought 1,+1 would print two lines (line 1 *plus*
one). But it makes sense when you explain it.

> As a side effect of the internal implementation of this logic -L 5,3
> means the same thing as -L 3,5 but that is not an intended nor
> documented behaviour.

How should L 5,3 and 3,5 work? Should the former give an error?

>> Shouldn't this either print nothing, er be an error:
> (multiple)
>
> The parsing code is lax in the sense that rejecting nonsensical input=
 like
> "-L 10,-100" and "-L 2,+0" as an error was not considered a primary g=
oal.
> The only error checking it does is to make sure it does not parse num=
bers
> that it cannot use (i.e. start from line 30 in a file that does not h=
ave
> that many lines).

Do you want a patch to make it less lax?
