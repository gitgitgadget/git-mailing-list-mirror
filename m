From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v3 24/39] i18n: bisect: enable l10n of bisect terms in
 messages
Date: Fri, 3 Jun 2016 12:32:20 +0000
Message-ID: <575178D4.5@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
 <1464799289-7639-25-git-send-email-vascomalmeida@sapo.pt>
 <xmqq4m9czu5u.fsf@gitster.mtv.corp.google.com> <574FF6A6.8030609@sapo.pt>
 <xmqqbn3jv6ka.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:58:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8ofw-0006JY-4a
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbcFCM6E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 08:58:04 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:38200 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932091AbcFCM6C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 08:58:02 -0400
Received: (qmail 24505 invoked from network); 3 Jun 2016 12:57:59 -0000
Received: (qmail 28375 invoked from network); 3 Jun 2016 12:57:59 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 3 Jun 2016 12:57:58 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqbn3jv6ka.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296329>

=C3=80s 17:33 de 02-06-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> =C3=80s 17:38 de 01-06-2016, Junio C Hamano escreveu:
>>> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>>>
>>>> @@ -739,7 +748,7 @@ static void handle_bad_merge_base(void)
>>>>  			fprintf(stderr, _("The merge base %s is %s.\n"
>>>>  				"This means the first '%s' commit is "
>>>>  				"between %s and [%s].\n"),
>>>> -				bad_hex, term_bad, term_good, bad_hex, good_hex);
>>>> +				bad_hex, _(term_bad), _(term_good), bad_hex, good_hex);
>=20
> But this translation still does not make much sense to me.
>=20
> If the user did not change term_bad and term_good from the default
> ones (i.e. the four words above), the flow of control would not come
> here; one of the above two !strcmp() lines you changed would trigger.
>=20
Hence, marking _(term_bad) and _(term_good) in this instance is both
futile and wrong. Because, at this point of flow, these term were likel=
y
defined by the user, therefore must not be translated.

> On the other hand, if the user did change term_bad and term_good by
> using --term-old=3Dvelho --term-new=3Dnovo earlier (which is stored i=
n
> BISECT_TERMS and read into these two variables), these are strings
> that Git encounters at runtime; you cannot expect _(term_bad) aka
> _("novo") to be translated by *.po files for the locale.
>=20
> And even if it were somehow translatable, you do not want to.
>=20
> Imagine a case where there is a Portuguese word the user used in
> place of 'novo' in the example above, and there is an English word
> with the same spelling with a totally different meaning.  And
> further imagine that English word is used elsewhere in Git and has
> translation to Portuguese in your *.po file.  _(term_bad) would
> become a translation of that English word into Portuguese, which
> would be a word totally unrelated to the word the user used
> originally when she did --term-old=3D<that word in portuguese>.
>=20
I thought about this after sending my last email about this topic. It i=
s
something that can happen indeed.

> So I do not think _(term_bad) and _(term_good) is a good idea in the
> last hunk quoted above (it is not just "not a good idea", but
> actually would be harmful), which would make term_names[] and "enum
> term" unnecessary.
>=20
I agree with you. I'm going to drop this patch in the next re-roll.
Leaving the previous patch, [PATCH v3 23/39] i18n: bisect: mark strings
for translation, unchanged which just masks the strings for translation
but not anything else.

> There is a case where one of the default four words could seep
> through to the last else clause.  Is that what you are trying to
> address?
>=20
No. I was trying to replace the English terms by their translation in
those messages. But we have arrive to conclusion it is a bad idea to pu=
rsue.

> That is, when term_bad is left as "bad" but term_good is customized
> to "super", neither "term_bad is 'bad' and term_good is 'good'" nor
> "term_bad is 'new' and term_good is 'old" is true, and we would say
>=20
> 	Merge base is BAD.  This means the first SUPER commit is ...
>=20
> With your change to mark _(term_bad) and _(term_good), the message
> would translate term_bad to whatever word it is in your language,
> and term_good that comes from the end user will be left as SUPER as
> the user typed.  I am not sure if it is a good thing to translate
> only BAD while leaving SUPER as-is in such a case.

I think this may be confusing for some users. I am positive it is a bad
thing.


If I had thought more about this, I hadn't proposed this patch. I'm
sorry for wasting your time with such nonsense. I'm going to drop it in
the next re-roll.
