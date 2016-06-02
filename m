From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v3 24/39] i18n: bisect: enable l10n of bisect terms in
 messages
Date: Thu, 2 Jun 2016 09:04:38 +0000
Message-ID: <574FF6A6.8030609@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
 <1464799289-7639-25-git-send-email-vascomalmeida@sapo.pt>
 <xmqq4m9czu5u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 16:39:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8TmZ-0007so-1Y
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 16:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbcFBOj3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 10:39:29 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:49461 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932978AbcFBOj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 10:39:27 -0400
Received: (qmail 31568 invoked from network); 2 Jun 2016 14:39:24 -0000
Received: (qmail 3182 invoked from network); 2 Jun 2016 14:39:24 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 2 Jun 2016 14:39:19 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqq4m9czu5u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296201>

=C0s 17:38 de 01-06-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> +enum term { BAD, GOOD, OLD, NEW };
>> +static const char *term_names[] =3D {
>> +/* TRANSLATORS: in bisect.c source code file, the following terms a=
re
>> +   used to describe a "bad commit", "good commit", "new revision", =
etc.
>> +   Please, if you can, check the source when you are not sure if a =
%s
>> +   would be replaced by one of the following terms. */
>> +	N_("bad"), N_("good"), N_("old"), N_("new"),  NULL
>> +};
>> +
>>  /* Remember to update object flag allocation in object.h */
>>  #define COUNTED		(1u<<16)
>> =20
>> @@ -725,12 +734,12 @@ static void handle_bad_merge_base(void)
>>  	if (is_expected_rev(current_bad_oid)) {
>>  		char *bad_hex =3D oid_to_hex(current_bad_oid);
>>  		char *good_hex =3D join_sha1_array_hex(&good_revs, ' ');
>> -		if (!strcmp(term_bad, "bad") && !strcmp(term_good, "good")) {
>> +		if (!strcmp(term_bad, term_names[BAD]) && !strcmp(term_good, term=
_names[GOOD])) {
>>  			fprintf(stderr, _("The merge base %s is bad.\n"
>>  				"This means the bug has been fixed "
>>  				"between %s and [%s].\n"),
>>  				bad_hex, bad_hex, good_hex);
>> -		} else if (!strcmp(term_bad, "new") && !strcmp(term_good, "old"))=
 {
>> +		} else if (!strcmp(term_bad, term_names[NEW]) && !strcmp(term_goo=
d, term_names[OLD])) {
>>  			fprintf(stderr, _("The merge base %s is new.\n"
>>  				"The property has changed "
>>  				"between %s and [%s].\n"),
>> @@ -739,7 +748,7 @@ static void handle_bad_merge_base(void)
>>  			fprintf(stderr, _("The merge base %s is %s.\n"
>>  				"This means the first '%s' commit is "
>>  				"between %s and [%s].\n"),
>> -				bad_hex, term_bad, term_good, bad_hex, good_hex);
>> +				bad_hex, _(term_bad), _(term_good), bad_hex, good_hex);
>=20
> These "bad" and "good" that are compared with term_bad and term_good
> are the literal tokens the end user gives from the "git bisect"
> command line.  I do not think you would want to catch them with
>=20
>     $ git bisect novo <rev>
>     $ git bisect velho <rev>
>=20
> unless the user has done
>=20
>     $ git bisect --term-old=3Dvelho --term-new=3Dnovo
>=20
> previously.

I may be misunderstanding you, but we do not "catch" those terms with
this patch, although I'm not sure what you mean by "catch them". I thin=
k
you forget that no-operation N_("good"), does not affect in any way the
string "good", it only enables xgettext to extract it to .pot file, doe=
s
not trigger translation.
Overall, I don't understand what are you trying to tell me here.

>=20
> And that "custom bisect terms" case is covered by the last "else"
> clause in this if/elseif cascade (outside the context we can see in
> your message).
>=20
> The only thing you need to do around here is to mark the string as
> translatable.  I do not think we need "enum term", or term_names[].

This patch tries to make bisect output those term translated within the
also translated message. To enable this, it is handy to have
term_names[] in order to mark each term, although I could have mark the=
m
anywhere they appeared in the source. It was only for that I chose to
have term_names[].
>=20
>> @@ -747,7 +756,7 @@ static void handle_bad_merge_base(void)
>>  	fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
>>  		"git bisect cannot work properly in this case.\n"
>>  		"Maybe you mistook %s and %s revs?\n"),
>> -		term_good, term_bad, term_good, term_bad);
>> +		_(term_good), _(term_bad), _(term_good), _(term_bad));
>=20
> Likewise for all _(term_good), _(term_bad) and use of term_names[]
> we see in this patch.
>=20

Indeed this was more of a PATCH/RFC to see what people would think of
it. If nobody contest and there is no value in it, I'll happily drop
this patch in the next re-roll.

My motivation for this patch was that a user could feel embarrassment
reading a message in her language with those terms untranslated.
Although I do believe that no translating them is also a possibility.
