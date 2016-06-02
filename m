From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH v3 28/39] i18n: config: unfold error messages marked for
 translation
Date: Thu, 2 Jun 2016 09:28:41 +0000
Message-ID: <574FFC49.9040409@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
 <1464799289-7639-29-git-send-email-vascomalmeida@sapo.pt>
 <xmqqzir4yfcq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 16:40:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Tml-00081V-Nb
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 16:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161283AbcFBOjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 10:39:35 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:41316 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161273AbcFBOjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 10:39:31 -0400
Received: (qmail 16540 invoked from network); 2 Jun 2016 14:39:27 -0000
Received: (qmail 4497 invoked from network); 2 Jun 2016 14:39:27 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <sunshine@sunshineco.com>; 2 Jun 2016 14:39:25 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqzir4yfcq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296202>

=C0s 17:43 de 01-06-2016, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>=20
>> Introduced in 473166b ("config: add 'origin_type' to config_source
>> struct", 2016-02-19), Git can inform the user about the origin of a
>> config error, but the implementation does not allow translators to
>> translate the keywords 'file', 'blob, 'standard input', and
>> 'submodule-blob'. Moreover, for the second message, a reason for the
>> error is appended to the message, not allowing translators to transl=
ate
>> that reason either.
>=20
> Good intentions.
>=20
>> @@ -417,6 +417,7 @@ static int git_parse_source(config_fn_t fn, void=
 *data)
>>  	int comment =3D 0;
>>  	int baselen =3D 0;
>>  	struct strbuf *var =3D &cf->var;
>> +	char error_msg[128];
>> =20
>>  	/* U+FEFF Byte Order Mark in UTF8 */
>>  	const char *bomptr =3D utf8_bom;
>> @@ -471,10 +472,38 @@ static int git_parse_source(config_fn_t fn, vo=
id *data)
>>  		if (get_value(fn, data, var) < 0)
>>  			break;
>>  	}
>> +
>> +	switch (cf->origin_type) {
>> +	case CFG_BLOB:
>> +		xsnprintf(error_msg, sizeof(error_msg),
>> +			  _("bad config line %d in blob %s"),
>> +			  cf->linenr, cf->name);
>=20
> Use xstrfmt() intead, perhaps?  That would be cleaner.
>=20
Wouldn't that create a memory leak?
Because, in this patch, error_msg is used in the following way

        if (cf->die_on_error)
                die(error_msg);
        else
                return error(error_msg);
