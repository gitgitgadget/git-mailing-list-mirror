From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] blame: handle broken commit headers gracefully
Date: Wed, 17 Apr 2013 23:22:41 +0200
Message-ID: <516F12A1.9050106@lsrfire.ath.cx>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com> <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org> <516DBE2E.4060201@lsrfire.ath.cx> <7vzjwyi0ba.fsf@alter.siamese.dyndns.org> <7vli8hhgmn.fsf@alter.siamese.dyndns.org> <20130417063942.GA27703@sigill.intra.peff.net> <516EE300.7020200@lsrfire.ath.cx> <516EEB12.5050209@lsrfire.ath.cx> <20130417210713.GB635@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ivan Lyapunov <dront78@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 17 23:22:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USZoZ-0002HO-EU
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 23:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966507Ab3DQVWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 17:22:47 -0400
Received: from india601.server4you.de ([85.25.151.105]:48226 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965818Ab3DQVWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 17:22:45 -0400
Received: from [192.168.2.105] (p4FFD858B.dip.t-dialin.net [79.253.133.139])
	by india601.server4you.de (Postfix) with ESMTPSA id A6D571F1;
	Wed, 17 Apr 2013 23:22:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130417210713.GB635@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221574>

Am 17.04.2013 23:07, schrieb Jeff King:
> On Wed, Apr 17, 2013 at 08:33:54PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Minimal patch, test case missing.  It's a bit sad that the old commi=
t
>> parser of blame handled Ivan's specific corruption (extra "-<>" afte=
r
>> email) gracefully because it used the spaces as cutting points inste=
ad
>> of "<" and ">".
>
> That may mean there is room for improvement in split_ident_line to
> be more resilient in removing cruft. With something like:
>
>    Name <email@host>-<> 123456789 -0000
>
> it would obviously be nice to find the date timestamp there, but I
> wonder what the "email" field should return? The full broken string, =
or
> just "email@host"? One way is convenient for overlooking problems in
> broken commits, but I would worry about code paths that are using
> split_ident_line to verify the quality of the string (like
> determine_author_info). It's possible we would need a strict and a
> forgiving mode.

You can have both; the necessary data is in the struct ident_split: Jus=
t=20
check that *mail_end =3D=3D '>' and mail_end + 1 =3D=3D date_begin etc.

Ren=C3=A9
