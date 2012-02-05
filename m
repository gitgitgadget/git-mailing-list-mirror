From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 5 Feb 2012 23:11:20 +0200
Message-ID: <CAMP44s0xmvjxsE6AYrA5qTZuDfWq8vPDPOo69hiRS+xWbsbS7g@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<20120202084859.GC3823@burratino>
	<7v8vklvxwh.fsf@alter.siamese.dyndns.org>
	<CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
	<7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
	<7vehuboe5g.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
	<20120204182611.GA31091@sigill.intra.peff.net>
	<CAMP44s2r-fcnfpdT4u5U7TwF1z6Abp+J1U7oqfsSrYMuD6weOQ@mail.gmail.com>
	<20120204232015.GB1170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:11:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9Mt-00011M-2h
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab2BEVLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 16:11:22 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:48475 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751654Ab2BEVLW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 16:11:22 -0500
Received: by lbom4 with SMTP id m4so873469lbo.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 13:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qolou3Cc+qzDsbnWG8CZu25aAEjlzeaRpVGQQcNBNhk=;
        b=GRzGstK3R4Tslh1fShs8Bxpa88W9ZU6q/0ZuuZPShgftQevmn9r/L+WlJSoebayRQh
         2hO20YPiXl9HHjVE027rnv0rbs9gXpiTlSkF3GR7DnUJXQ2BsQW6HUpO5cmcSO5S+nzB
         O+IRcNHiC14FhjIemEU0+uvoOfiw36x0+lR+4=
Received: by 10.112.101.34 with SMTP id fd2mr4024448lbb.16.1328476280681; Sun,
 05 Feb 2012 13:11:20 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sun, 5 Feb 2012 13:11:20 -0800 (PST)
In-Reply-To: <20120204232015.GB1170@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189962>

On Sun, Feb 5, 2012 at 1:20 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 04, 2012 at 09:30:42PM +0200, Felipe Contreras wrote:
>
>> > but it feels like the fix should go into map_user. =C2=A0I tried a=
 few things,
>> > like "git log -1 --format=3D%aE", and couldn't find other code pat=
hs with
>> > this problem. So presumably they are all feeding email addresses w=
ithout
>> > the closing ">" (so one option is to just say "map_user needs to g=
et
>> > NUL-terminated strings).
>>
>> Perhaps, but I though the idea was to make it efficient. I think the
>> above fix should be ok.
>
> Because of the calling convention of map_user, the buffer with the in=
put
> must also be writable (since it holds the result). So there should be=
 no
> loss of efficiency to convert the ">" into a "\0" (and in fact, the
> simplest fix is probably to just have map_user "tie off" any ">" it
> detects).

Yes, but then the caller (git blame) would need to _always_ do that
conversion before (">" -> "\0"), and after ("\0" -> ">"), as opposed
to now, that it does the conversion only when map_user succeeds (or
checks if it has to do it).

--=20
=46elipe Contreras
