From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/3] config --global --edit: create a template file if needed
Date: Fri, 25 Jul 2014 10:59:43 -0700
Message-ID: <xmqqegx9720g.fsf@gitster.dls.corp.google.com>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAPig+cSyLtUmkxAcO+iatKSS2t2T5byXRrJYq=MSuBoZ3m=hcw@mail.gmail.com>
	<vpqtx65ctqm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:00:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjmm-0005k6-9U
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 20:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760749AbaGYSAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 14:00:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59376 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbaGYR77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:59:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F37E2970C;
	Fri, 25 Jul 2014 13:59:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g8LX7xlHNR36lKDeboxBUctf6jY=; b=gkesQw
	IWcR+uvu895AriUmgCXat+cdn9/AFDRBPSqpazsMgfUcuGdm0So0Gij5cVkDEmu2
	k9m/E5xfAqYNrXPBTObisLyVKOgZZtK13teLNyVx8gDghxDvvfCv2RthN7qyVlx7
	8T0Bd8INPf0AJQUF9+1mfXjoLZku0uXPisoA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aIGFmd9944DSQ8vPE2FywJ4K126dHQpV
	/OUpH7vwxThZY8VFRau21HHepppb7rT2dldeEkGljZ/RsSyx2EvuJlYZ7XRS1HT1
	9dgTHSGogdKInRrMQV4bMyc7B3qqJQ/qa1pgDjXOMEHzF6vNwXFFPfHeo9NPMhHQ
	h21LWpRbsQw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 944582970A;
	Fri, 25 Jul 2014 13:59:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 469EF296E8;
	Fri, 25 Jul 2014 13:59:45 -0400 (EDT)
In-Reply-To: <vpqtx65ctqm.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	25 Jul 2014 18:01:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 75F0DB44-1425-11E4-8CA2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254250>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +static char *default_user_config()
>>> +{
>>> +       struct strbuf buf = STRBUF_INIT;
>>> +       strbuf_addf(&buf,
>>> +                   _("# This is Git's user-wide configuration file.\n"
>>> +                     "[core]\n"
>>> +                     "# Please, adapt and uncomment the following lines:\n"
>>> +                     "#        user = %s\n"
>>> +                     "#        email = %s\n"),
>>
>> "[core]", "user =", "email =" should not be translated. Would it make
>> sense to keep these outside of _()?
>
> I would say no, as the code and the string to translate would be much
> less readable without core, user and email inline.
>
> Were you suggesting stg like
>
> _("# This is Git's user-wide configuration file.\n"
>   "[%s]\n"
>   "# Please, adapt and uncomment the following lines:\n"
>   "#        %s = %s\n"
>   "#        %s = %s\n"),
>   "core", "name", ..., "email", ...
>
> ?

;-) That is a clever way to say what my first reaction to Eric's
comment was, which was to have this as multiple strbuf_addf().

Technically speaking, the '#' at the beginning of lines must not be
translated, either, and if that goes without saying, i.e. if the
translators know well enough not to change them, then I can be
persuaded that we can expect that translators know well enough not
to touch the three substrings Eric pointed out.

So, the original message may be fine as-is.

>>> +                       if (fd) {
>>> +                               char *content = default_user_config();
>>> +                               write_str_in_full(fd, content);
>>
>> close(fd);
>
> Indeed.
>
>>> +                               free(content);
>>> +                       }
>>> +                       else if (errno != EEXIST)
>>> +                               die_errno(_("Cannot create configuration file %s"), config_file);
>>
>> Other error messages in this file (including those just above this
>> block) begin with a lowercase letter.
>
> Applied.
>
> Thanks,
