From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 03/10] transport-helper: add 'force' to 'export' helpers
Date: Thu, 31 Oct 2013 12:55:06 -0600
Message-ID: <CAMP44s39H8tASO_OvK+C+XSG-2pm09RJY6Xeg4AqDZBAU7GPaw@mail.gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-7-git-send-email-felipe.contreras@gmail.com>
	<xmqqa9hp714d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:55:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbxOm-0006zC-5C
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab3JaSzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:55:09 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:42367 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701Ab3JaSzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:55:08 -0400
Received: by mail-la0-f45.google.com with SMTP id hp15so2638262lab.18
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B74ehpUL7+3nHexJ5oGZyoln6n9NJ33L+RFGzPgeDtc=;
        b=AEBuINr1HsXr4dTylXX+i8F2mlPpW2vGt+kYcDGys53xzYyF5gzxsarXhaEPYuXO8z
         f41H73rB2dbYsNlBrhcdlisSzNJVglQFFgkl+zGFQ6vS0fY/2pzvsGwOJLLjp3Y+u2OX
         yIGTvew3aOuBKC45IBq7JSlL+HP6B5Ja41gKoUl52O128S0fG2JofNH/EU13se7LEEfN
         5q5FNOc/9kep+G7fxdCNbamt9wSd3QRCzYT5eEIdcbjVi86kgCKR3VVEGVJDKmHPVvXw
         uAk33H9+Xe94uIcdhn6Qfs4YguyIg2xLa1mwk5v17jEAOrC/8wyyQ5OeHdcZiEhMPRkR
         pGFg==
X-Received: by 10.152.120.228 with SMTP id lf4mr2167038lab.44.1383245706914;
 Thu, 31 Oct 2013 11:55:06 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 11:55:06 -0700 (PDT)
In-Reply-To: <xmqqa9hp714d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237156>

On Thu, Oct 31, 2013 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Otherwise they cannot know when to force the push or not (other than
>> hacks).
>> ...
>> diff --git a/transport-helper.c b/transport-helper.c
>> index d05fc7c..ed238e5 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -854,6 +854,11 @@ static int push_refs_with_export(struct transport *transport,
>>                       die("helper %s does not support dry-run", data->name);
>>       }
>>
>> +     if (flags & TRANSPORT_PUSH_FORCE) {
>> +             if (set_helper_option(transport, "force", "true") != 0)
>> +                     die("helper %s does not support 'force'", data->name);
>> +     }
>> +
>
> Does this cause a "git push --force $there A:B" to fail when $there
> is a destination that goes via an existing helper does not suport
> "force" option?

Yes.

> Should it fail even when the current value of B is an ancestor of A
> (i.e. when an unforced push would succeed)?

It might make sense to fail only when the push is non-fast-forward,
but it's not so straight-forward to implement.

-- 
Felipe Contreras
