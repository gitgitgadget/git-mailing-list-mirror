From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Avoid the need of "--" when wildcard pathspec is used
Date: Wed, 1 Jul 2015 06:07:27 +0700
Message-ID: <CACsJy8C0Pz8ZjzW+n=3kT3c+x+CBONUuk27SNMiMsYwCapnVjA@mail.gmail.com>
References: <1435668007-31231-1-git-send-email-pclouds@gmail.com> <xmqqk2ulcbj3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 01:08:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA4dI-0001VH-CB
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 01:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbbF3XH7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 19:07:59 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33852 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbF3XH6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2015 19:07:58 -0400
Received: by igcsj18 with SMTP id sj18so120018391igc.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9EDWG2uQ1OIDk7pxEJetCb4LL7xi+QEKJcvXaTrle4U=;
        b=cnVcMf7fgZ34U6gKrkK5CJiIyXdaElSW5C2GNQxtb9S82zdS0Fe8+So+4lURoV4gWV
         XdvOjo6ikr3SbnCLgPnSDz/C7Pp9raXsK/wdfcNy/f+cqK37htttt74hEgZgratzm029
         sqPHkwSEYBCvD0rKX7X5pBYQzO3tbJrJfUJQWjvBpjscdgoBt9qc3yYhKMxLwXuNiMAS
         530Y5TIBYTna7GHUNhlXkZWihNdgWHBdgdSxfnFVs1myhrO6kPiG6WmkGoAQQS1oAszf
         /+lFgD671J0aApdiB7rmY6e8j6hLj8PdDY/oFXOQ2juixBU8f693yEL1hO2FWDTdiJmn
         iWnA==
X-Received: by 10.50.132.70 with SMTP id os6mr209334igb.27.1435705677185; Tue,
 30 Jun 2015 16:07:57 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Tue, 30 Jun 2015 16:07:27 -0700 (PDT)
In-Reply-To: <xmqqk2ulcbj3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273112>

On Wed, Jul 1, 2015 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> When "--" is lacking from the command line and a command can take bo=
th
>> revs and paths, the idea is if an argument can be seen as both an
>> extended SHA-1 and a path, then "--" is required or git refuses to
>> continue. It's currently implemented as:
>> ...
>
> Hmph, how does this relate to 28fcc0b7 (pathspec: avoid the need of
> "--" when wildcard is used, 2015-05-02)?  A follow-up?  "Oops, I did
> it wrong"?  something else?

Arghhh! I vaguely recalled I sent something but I couldn't find it and.=
=2E

>
>> diff --git a/setup.c b/setup.c
>> index 82c0cc2..f7cb93b 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -143,6 +143,8 @@ int check_filename(const char *prefix, const cha=
r *arg)
>>               name =3D arg + 2;
>>       } else if (!no_wildcard(arg))
>>               return 1;

=2E. if I looked at the context lines, I should have noticed the change
was already here!

>> +     else if (!no_wildcard(arg))
>> +             return 1;

 Seems strange (or expected?) that git cherry-pick just adds this
chunk on top anyway..

> Puzzling.  You already checked if arg has an wildcard and returned
> with 1 if there is none.  The added check looks like a no-op to me.

Yeah sorry for the noise. The only value this patch adds is tests (and
maybe better commit message, the last one still mentions magic
pathspec even though it's not about it). I think we can just drop
this.
--=20
Duy
