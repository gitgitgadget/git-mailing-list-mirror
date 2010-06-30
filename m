From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 02/12] parse-options: add two helper functions
Date: Wed, 30 Jun 2010 22:35:47 +0800
Message-ID: <AANLkTikKo3yr0eY9Lmv98TtFfTWjYG7HG6GPfwmoB6Aa@mail.gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
	<1277558857-23103-3-git-send-email-struggleyb.nku@gmail.com>
	<7vaaqggwsh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 16:37:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTyPl-0007DU-J9
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 16:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420Ab0F3OhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 10:37:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44941 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab0F3OhN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 10:37:13 -0400
Received: by qwi4 with SMTP id 4so298407qwi.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KWM6kpIo77WlH4ix0IKOdlhNkqC9cDXv+Ixu+Gchbps=;
        b=CC+SRSwubyLmzcXm5paKzuEWXmqY5pr5DRBx+eSTOARtucTg4P4tzuDBgQBp+AZaXQ
         71a5knbtgjnRLI2yCbE8m2p/furW06lDp/XmGI0nqZWyXf5sNB1Oy+fEd/MWeegksuES
         DKmnymx2CrIKEOBZfTg5N3UUJ4XdL3sInJy7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dFHvhZq7oaz/PkAyApqmj3Vbmtsn/J8Jr3pK94JaQd29JS9QtdOTIchbusRRSs6pC9
         sNXpghd4LLhBdJz7/XxNv0gw77ifZFKXRdbhUOpZtWlNGBnps6Ez5mvdts+YVbwzbqK9
         pzunBJPD+APJHIERnnWrx0BwsNS6NbEy1xe8A=
Received: by 10.224.28.139 with SMTP id m11mr4738929qac.130.1277908548029; 
	Wed, 30 Jun 2010 07:35:48 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Wed, 30 Jun 2010 07:35:47 -0700 (PDT)
In-Reply-To: <7vaaqggwsh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149960>

Hi Junio,

On Mon, Jun 28, 2010 at 2:22 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> diff --git a/parse-options.c b/parse-options.c
>> index cbb49d3..013dbdb 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -439,6 +439,27 @@ unknown:
>> =A0 =A0 =A0 return PARSE_OPT_DONE;
>> =A0}
>>
>> +const char *parse_options_current(struct parse_opt_ctx_t *ctx)
>> +{
>> + =A0 =A0 return ctx->argv[0];
>> +}
>> +
>> +int parse_options_next(struct parse_opt_ctx_t *ctx, int retain)
>> +{
>> + =A0 =A0 if (ctx->argc <=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> +
>> + =A0 =A0 if (retain =3D=3D 1)
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ctx->out[ctx->cpidx++] =3D ctx->argv[0];
>> + =A0 =A0 }
>
> Style. =A0Either drop the unnecessary curly pair, or open the curly a=
t the
> end of the line that has the closing parenthesis of "if" condition.
>
> These two functions makes sense. =A0You could then use parse-options-=
step to
> let the machinery mostly be driven by the usual table lookup, and whe=
n
> (and only when) the machinery says "I don't know what this is", you c=
an
> check "current" to see what it is (e.g. it may be "-L"), handle it
> yourself, and if you need to do something different (e.g. eat the <pa=
th>
> that immedately follows "-L"), you can use "next" to skip it without =
ever
> showing that to the table based parseopt machinery.
>
> I however wonder why you would need two passes if you have these two =
APIs
> into parse-options machinery, though...
>

Hmm, yes, I have rewrite the the parsing code as a one pass one. It is
3 or 4 weeks since this parsing code written, so I can't remember
clearly why it adopt this two pass way. :-)

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
