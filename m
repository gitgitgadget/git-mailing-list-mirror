From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH 1/3] config --global --edit: create a template file if needed
Date: Fri, 25 Jul 2014 13:51:54 -0400
Message-ID: <CAPig+cRpcA15_FQj1Cs6M8MFUhvh0UGd2RtAf9aXLQus-mLp6g@mail.gmail.com>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAPig+cSyLtUmkxAcO+iatKSS2t2T5byXRrJYq=MSuBoZ3m=hcw@mail.gmail.com>
	<vpqtx65ctqm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjey-0007Vx-34
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbaGYRv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:51:56 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:43148 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbaGYRvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:51:55 -0400
Received: by mail-yk0-f179.google.com with SMTP id 142so3013590ykq.38
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=U8xBo/jYWa73EL0SOa9NfpdQ/HonGcD2GBs57X80Prk=;
        b=BfYeC5UQRd6Ou0P/ZY5OLvx/BHoRRdQjH/gIR27mITb8DeX9OR+UPeXy7T8iljF0uq
         Db+KjLmmVFiUbFJkGEfdw6CxIhYU7lkFDrc6vtV6p5FJs3fEMBkHgkqAtcbq96jEM6Nt
         0o6NfaEDE9SCZBdLQTL4YJW6ywOiEJsqWMiTXpg5oz7iepb5fJgRX2w0kZuXDrZZK6kE
         4T/sa6NFPJPLIVEkteuFJYWTbIo0tBJcPXwKpteCtMOhSQZDN9/1ifWVipWMu+BcCuUR
         saZQgYd91WvmPH142N7Ld2BTeGegXdsBAEy5b3EZlXXYGyk5SdCJWM0KwqvGSTHKDmUN
         mZQg==
X-Received: by 10.236.150.70 with SMTP id y46mr25321310yhj.52.1406310714855;
 Fri, 25 Jul 2014 10:51:54 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Fri, 25 Jul 2014 10:51:54 -0700 (PDT)
In-Reply-To: <vpqtx65ctqm.fsf@anie.imag.fr>
X-Google-Sender-Auth: yJrZL1WMMmfIJ0ooMSQlXbjlplg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254242>

On Fri, Jul 25, 2014 at 12:01 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
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

That or some equivalent variation. I'm not a translator, but the above
seems to convey sufficient context for a translator to understand what
needs to be said, while preventing accidental translations of those
strings which should not be translated.

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
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
