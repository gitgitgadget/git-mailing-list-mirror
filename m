From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 12/13] tag.c: implement '--format' option
Date: Thu, 20 Aug 2015 21:20:40 +0530
Message-ID: <CAOLa=ZQfEeJofxe0ei_h7efrhMVnXMQ=K+5PzZ1fRWU0us7KBA@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
 <1439923052-7373-13-git-send-email-Karthik.188@gmail.com> <vpq614b49dk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 20 17:54:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSSAD-0000vn-4j
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 17:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbbHTPxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 11:53:52 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36559 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbbHTPxv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 11:53:51 -0400
Received: by iodv127 with SMTP id v127so50852458iod.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KXs6Mf/Ot2bkvSIC07GB/8NngqVtl7sZyp399arShG0=;
        b=Ce6Q2E8A9Z+xoj87woOuRPBdasy84RgXQNIDvv+MVRttDipypX/FhydODxAO/ZeHlt
         kJ8dRg7fCaqrDHM0U2fj7NZIlcINVnc7ekwGpk7FMoXj/+lFVMFMzFLMdtW4LsUHviKu
         VzpwfJqqlprDBLHZ0d5U7Ydoa/AW27mGC2HX/wDQ4HT+mpcC9zkiYARfH59WNhj/vQ0O
         YshiNsd8wBlMiJ4lPZ1tDnUpTfYPuoVauPZHQ3OQ2X9/fCtgQCT6qOHULa3vWl7PCVuc
         KSyOCn3lPXOOCcjhVTPr43sLTmJ8/1gC42C9bEC60g6mwEhdIp3qiyXO89L6XeRK/XyH
         3hFQ==
X-Received: by 10.107.10.214 with SMTP id 83mr3147780iok.120.1440086030609;
 Thu, 20 Aug 2015 08:53:50 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 20 Aug 2015 08:50:40 -0700 (PDT)
In-Reply-To: <vpq614b49dk.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276248>

On Wed, Aug 19, 2015 at 8:23 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -158,6 +159,18 @@ This option is only applicable when listing tags without annotation lines.
>>       The object that the new tag will refer to, usually a commit.
>>       Defaults to HEAD.
>>
>> +<format>::
>> +     A string that interpolates `%(fieldname)` from the object
>> +     pointed at by a ref being shown.  If `fieldname` is prefixed
>> +     with an asterisk (`*`) and the ref points at a tag object, the
>> +     value for the field in the object tag refers is used.  When
>> +     unspecified, defaults to `%(refname:short)`.  It also
>> +     interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
>> +     interpolates to character with hex code `xx`; for example
>> +     `%00` interpolates to `\0` (NUL), `%09` to `\t` (TAB) and
>> +     `%0a` to `\n` (LF).  The fields are same as those in `git
>> +     for-each-ref`.
>> +
>
> This documentation should probably be shortened to stg like
>
>         A string that interpolates `%(fieldname)` from the object
>         pointed at by a ref being shown. The format is the same as the
>         one of linkgit:git-for-each-ref[1]. When unspecified, defaults
>         to `%(refname:short)`
>

I guess this makes sense with what you're saying below, the --format option
for tag.c is more of an extra add-on, and such a discrioption may not be needed.
Will change this.

> Alternatively, you can extract the "FIELD NAMES" section of
> git-for-each-ref.txt to a separate file and include it in the doc for
> each command having this --format option (this is how it's done for "git
> log --format" IIRC). But taking that much space to describe hexadecimal
> escapes that very few people would use and not documenting the %(atoms)
> is counter-productive IMHO.
>

I guess, It'll be better to write a document on the whole of
ref-filter. I'll probably do that
at the end of this.

> I would favor the first option (keep it short, include a pointer) with
> Junio's remark in mind: "git tag" and "git branch" are meant to be
> simple commands, and the scary swiss-army-knife should remain "git
> for-each-ref".
>
> I am still (slightly) in favor of adding --format to tag and branch, as
> long as it does not make the commands too scary.
>

Will change this, thanks for the suggestions.


-- 
Regards,
Karthik Nayak
