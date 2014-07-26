From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] refs.c: move ref parsing code out of resolve_ref()
Date: Sat, 26 Jul 2014 08:50:44 +0700
Message-ID: <CACsJy8DWEuiyyj0HhnGttnbyQ2+tTWDAW5H67uBXeV4ESM6seg@mail.gmail.com>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
 <1406285039-22469-4-git-send-email-pclouds@gmail.com> <CAL=YDWnWAoCrJn28vGKb=xrKKO=fCN=Uz+nM+eh+dYbHCFYpgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 03:51:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAr8u-0006XJ-8J
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 03:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbaGZBvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 21:51:16 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:57239 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbaGZBvP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 21:51:15 -0400
Received: by mail-qg0-f44.google.com with SMTP id e89so6086537qgf.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oItr5xQ/cqvymT91K9SXx7Z3gLVWw56Gq83/uPHABzA=;
        b=X3nbPbHBJkubdK+4p4Bb7DUZdU3ye57XivJooYn+27Vd3riPGCO0WAe+3mFSuZD1I6
         /x4j/eeBShHmzQyzYYwBfBF7G6tbjr6huGXTyxxOpbRZfRBYutdZDLymKPyV7lHzGteE
         FyAQyJHQ1HEZzKforY6E5yF3gMuiBl/1+mqoaFYftmu5N8ZKG2vR52zQoDlTm3wmrEox
         ++kVZ5XIOe7mM+Y1oJp4xQ01ZFsQnFWm/Va9DwJlGuk+jYHkLlwYKq8a8NwKFe3luOWR
         HOntNe9Ja1LkfZ3p4YDxomTUxUqMty/ZUzO8InajsyP3dkOkWl6G84M6WN4vGMwnSQ92
         vB6g==
X-Received: by 10.224.5.193 with SMTP id 1mr33067710qaw.89.1406339474540; Fri,
 25 Jul 2014 18:51:14 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Fri, 25 Jul 2014 18:50:44 -0700 (PDT)
In-Reply-To: <CAL=YDWnWAoCrJn28vGKb=xrKKO=fCN=Uz+nM+eh+dYbHCFYpgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254274>

On Fri, Jul 25, 2014 at 11:12 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> diff --git a/refs.c b/refs.c
>> index bec2bb1..2769f20 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1533,6 +1533,105 @@ static int handle_missing_loose_ref(const char *refname,
>>         }
>>  }
>>
>> +int parse_ref(const char *path, struct strbuf *ref,
>> +             unsigned char *sha1, int *flag)
>
> Can you make this function static?
> It is not used by anything outside of this series and thus making it
> static avoids growing the public refs api.

It's to be used by builtin/checkout.c in nd/multiple-work-trees. I
could mark it static now and unmark it later, but I'd need to add the
static prototype back in refs.c because in the next patch
resolve_gitlink_ref() uses this function and resolve_gitlink_ref() is
before parse_ref().
-- 
Duy
