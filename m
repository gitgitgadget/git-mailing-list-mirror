From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Add path-limiting to git-add--interactive
Date: Thu, 22 Nov 2007 12:14:43 +0100
Message-ID: <C11275B3-4E3A-4A3F-B782-BACE43953704@wincent.com>
References: <7vk5obb09a.fsf@gitster.siamese.dyndns.org> <1195695384-41329-1-git-send-email-win@wincent.com> <7vpry27id0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:15:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvA1k-0005UC-Dj
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXKVLPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 06:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXKVLPG
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:15:06 -0500
Received: from wincent.com ([72.3.236.74]:57297 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbXKVLPF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 06:15:05 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAMBEiOP011840;
	Thu, 22 Nov 2007 05:14:45 -0600
In-Reply-To: <7vpry27id0.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65790>

El 22/11/2007, a las 10:13, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> @@ -56,9 +56,14 @@ sub list_modified {
>> 	my ($only) =3D @_;
>> 	my (%data, @return);
>> 	my ($add, $del, $adddel, $file);
>> +	my @tracked =3D grep {
>> +		defined run_cmd_pipe(qw(git ls-files
>> +			                --exclude-standard --), $_)
>> +	} @ARGV;
>> +	return if $#tracked =3D=3D -1 && $#ARGV !=3D -1;
>
> Eek.  why?
>
> Did you mean to say:
>
>    my @tracked =3D run_cmd_pipe(gw(git ls-files --exclude-standard --=
) =20
> @ARGV);

Bah, indeed that will work. I mistakenly (stupidly?) thought I had to =20
check each path in @ARGV one at a time; didn't realize that I could =20
pass in all at once and that it would do the right thing.... I've =20
incorporated the suggested change.

> It would also make sense to use --error-unmatch and perhaps --with-=20
> tree=3DHEAD
> like git-commit.sh does.

My reading of the run_cmd_pipe function indicates that those options =20
won't have any effect at all because run_cmd_pipe doesn't check the =20
exit status of the command.

Cheers,
Wincent
