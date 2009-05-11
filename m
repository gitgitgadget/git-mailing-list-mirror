From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] mktree --missing: allow missing objects
Date: Sun, 10 May 2009 17:29:59 -0700
Message-ID: <7vocu0traw.fsf@alter.siamese.dyndns.org>
References: <1241981391-19639-1-git-send-email-gitster@pobox.com>
	<1241981391-19639-2-git-send-email-gitster@pobox.com>
	<1241981391-19639-3-git-send-email-gitster@pobox.com>
	<1241981391-19639-4-git-send-email-gitster@pobox.com>
	<1241981391-19639-5-git-send-email-gitster@pobox.com>
	<1241981391-19639-6-git-send-email-gitster@pobox.com>
	<1241981391-19639-7-git-send-email-gitster@pobox.com>
	<4A075195.5020508@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon May 11 02:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3JPO-0006Xs-Ug
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 02:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756390AbZEKAaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2009 20:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbZEKAaA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 20:30:00 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52589 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbZEKA37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 20:29:59 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090511003000.EBVS20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Sun, 10 May 2009 20:30:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id q0Vz1b00L4aMwMQ040VzZ8; Sun, 10 May 2009 20:30:00 -0400
X-Authority-Analysis: v=1.0 c=1 a=e_bBD2ouMa8A:10 a=iLCZyVqmBykA:10
 a=v71NlBQNzAa1MED6jDIA:9 a=G8iKTUwE9MwDFYp9l-IA:7
 a=2tJYBRfrB-6chb1J5V1EYy6qEKgA:4
X-CM-Score: 0.00
In-Reply-To: <4A075195.5020508@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon\, 11 May 2009 00\:13\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118761>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> -static void mktree_line(char *buf, size_t len, int line_termination=
)
>> +static void mktree_line(char *buf, size_t len, int line_termination=
, int allow_missing)
>>  {
>>  	char *ptr, *ntr;
>>  	unsigned mode;
>> @@ -92,9 +92,12 @@ static void mktree_line(char *buf, size_t len, in=
t line_termination)
>> =20
>>  	/* It is perfectly normal if we do not have a commit from a submod=
ule */
>>  	if (!S_ISGITLINK(mode))
>> +		allow_missing =3D 1;
>> +
>> +	if (!allow_missing)
>>  		type =3D sha1_object_info(sha1, NULL);
>>  	else
>> -		type =3D OBJ_COMMIT;
>> +		type =3D object_type(mode);
>> =20
>>  	if (type < 0)
>>  		die("object %s unavailable", sha1_to_hex(sha1));
>
> Don't you need this, above?
>
> -  	if (!S_ISGITLINK(mode))
> +	if (S_ISGITLINK(mode))

Agh; you are of course right.
