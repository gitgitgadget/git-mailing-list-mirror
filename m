From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 4/5] pretty: Use mailmap to display username and email
Date: Wed, 12 Dec 2012 14:27:24 +0100
Message-ID: <CALWbr2w65iAnegu-VSLWo1Ckh9q8291aVVjchcXaz1A24bLcEA@mail.gmail.com>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
	<1355264493-8298-5-git-send-email-apelisse@gmail.com>
	<7vehiw6wc1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Rich Midwinter <rich.midwinter@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 14:27:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TimLf-0004kT-JV
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 14:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab2LLN11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 08:27:27 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:56437 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2LLN10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 08:27:26 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so228249eaa.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SlIQT5J+vQiDYDg3mYkjwgEzOgQs9rgjZ89UrjKWZhw=;
        b=ZEPzb5lSU9xLvd1fBE1Y1dgq/ptKFmGmSsi+7aPEa0jjHmjLWKlj2Ou9SSo8ayD2Jr
         hlJx1j54kZfiIanhaKGLJT0IA/s1+OolywDZxSlOlHCLeq0aEIQyPmDoY585txBNHlaf
         7Fp6l1wiJ0BQ/yB+aewlgvZTls5R4rS4sOtSbqEixxfYL9HzTmzh7WeoYjA6bsYniaxd
         Ex/gLdw0o4vFJ3R1CcSGVaOTCAmWBDzHauEkGa7xV9ScPbNnAoI7XZahDIFmLd7NddMZ
         SlncDaMb0cbAnZIkXG4YC65xqq7TXG122nwwG0lb0IBfnSJB5L+iPKjNlNMeaJGLBTV1
         mp6A==
Received: by 10.14.208.137 with SMTP id q9mr2837612eeo.28.1355318845172; Wed,
 12 Dec 2012 05:27:25 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 12 Dec 2012 05:27:24 -0800 (PST)
In-Reply-To: <7vehiw6wc1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211353>

> Or it might be better to make those two strbufs output-only
> parameter, e.g.
>
>         map_user(struct string_list *mailmap,
>                 const char *name, size_t namelen,
>                 const char *mail, size_t maillen,
>                 struct strbuf *name_out, struct strbuf *mail_out);
>
> then after split_ident_line(), this caller could feed two pointers
> into the original "line" as name and mail parameter, without making
> any copies (the callee has to make a copy but it has to be done
> anyway when the name/mail is mapped).  I suspect it would make this
> caller simpler, but I do not know how invasive such changes are for
> other callers of map_user().

It makes a lot of sense.
blame.c::get_commit_info() hard code the length
shortlog.c::insert_one_record() hard code the length
pretty.c::format_person_part() hard code the length

I don't think it will be invasive.

> Such an update can be left outside of this series, of course.

I will try to make it at the beginning of the series. It will avoid unnecessary
conflicts.

>> +             strbuf_addch(sb, ' ');
>> +             strbuf_addch(sb, '<');
>> +             strbuf_add(sb, person_mail, strlen(person_mail));
>> +             strbuf_addch(sb, '>');
>>               strbuf_addch(sb, '\n');
>
> Is that strbuf_addf(sb, " <%s>\n", person_mail)?

Of couse ;) Fixed.
