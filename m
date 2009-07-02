From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/6] grep: move context hunk mark handling into show_line()
Date: Thu, 02 Jul 2009 05:15:33 +0200
Message-ID: <4A4C2655.9000000@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx> <4A4BDCFE.3050808@lsrfire.ath.cx> <7vzlbodne0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 05:15:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMCm2-0002qo-Bp
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 05:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbZGBDPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2009 23:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbZGBDPe
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 23:15:34 -0400
Received: from india601.server4you.de ([85.25.151.105]:36673 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbZGBDPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 23:15:34 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id D71022F8068;
	Thu,  2 Jul 2009 05:15:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <7vzlbodne0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122617>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Move last_shown into struct grep_opt, to make it available in
>> show_line(), and then make the function handle the printing of hunk
>> marks for context lines in a central place.
>=20
> Makes sense.  But now "are we showing from a separate block of text" =
check
> is in show_line() and relieves the caller of show_line() from doing s=
o,...
>=20
>>  		else if (last_hit &&
>>  			 lno <=3D last_hit + opt->post_context) {
>>  			/* If the last hit is within the post context,
>>  			 * we need to show this line.
>>  			 */
>> -			if (last_shown && lno !=3D last_shown + 1)
>> -				fputs(hunk_mark, stdout);
>>  			show_line(opt, bol, eol, name, lno, '-');
>> -			last_shown =3D lno;
>=20
> ... the comment in this context should go, no?

Hmm, I didn't read it to refer to the hunk_mark, but rather to the line
 (from bol to eol).  And it's still true that show_line needs to be
called because we're not more than post_context lines away from the
previous hit, i.e. this line is a post context line.
