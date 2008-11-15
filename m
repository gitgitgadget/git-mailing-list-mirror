From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: make sure correct error is propagated
Date: Fri, 14 Nov 2008 21:44:02 -0800
Message-ID: <7vr65d7dct.fsf@gitster.siamese.dyndns.org>
References: <1226647174-15844-1-git-send-email-sam@vilain.net>
 <1226655681.17731.4.camel@maia.lan>
 <7vfxlu9lhs.fsf@gitster.siamese.dyndns.org>
 <200811142009.51803.fg@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, Francis Galiegue <fge@one2team.com>,
	git@vger.kernel.org
To: Francis Galiegue <fg@one2team.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 06:49:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1E2c-0001vu-Kl
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 06:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbYKOFos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Nov 2008 00:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbYKOFor
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 00:44:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbYKOFor convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2008 00:44:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 482A67D2BB;
	Sat, 15 Nov 2008 00:44:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1FE0C7D2AF; Sat,
 15 Nov 2008 00:44:09 -0500 (EST)
In-Reply-To: <200811142009.51803.fg@one2team.com> (Francis Galiegue's message
 of "Fri, 14 Nov 2008 20:09:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 80B239C4-B2D8-11DD-8671-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101048>

=46rancis Galiegue <fg@one2team.com> writes:

> Le Friday 14 November 2008 20:05:19 Junio C Hamano, vous avez =C3=A9c=
rit=C2=A0:
> [...]
>> >  	fd =3D mkstemp(buffer);
>> > -	if (fd < 0 && dirlen && (errno !=3D EPERM)) {
>> > +	if (fd < 0 && dirlen && (errno !=3D EACCESS)) {
>>
>> Is this accepting the two as equivalents???
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Well, looking at mkdir(2), it says:
>
>        EPERM  The file system containing pathname does not support th=
e=20
> creation of directories.
>
> Hmm, err... git would fail at an earlier point anyway, wouldn't it? E=
ven git=20
> init would fail there.

Actually, POSIX does not even talk about EPERM for mkdir(2), but that w=
as
not my point.  The code does something different from what the proposed
commit log message talks about.  That was what bothered me.
