From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 04:27:57 -0500
Message-ID: <CAMP44s0cJwHSJrWKkWAwKSv8OE=OqVRdKEtBNdAvQ7YAE5-JKw@mail.gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-2-git-send-email-felipe.contreras@gmail.com>
	<20130418082441.GR2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 18 11:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USl8X-0007hW-1w
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 11:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966551Ab3DRJ2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 05:28:01 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:63836 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967142Ab3DRJ17 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 05:27:59 -0400
Received: by mail-lb0-f180.google.com with SMTP id t11so2475810lbi.39
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=NWRIVJSUQSrAPTqcwVtl+AbelTWBA3XENpX8A49kw3Q=;
        b=fNl27gE3DPNENkEpvJXhIKmMvjzx2hvSP3vrShLnJnzaSk8H62QYKHBBOuqcWpsBDy
         I+OHD3mA2dK3o3vq3BB8LO0WgROT9r/0mO2Fh/9dCDtKDV2Nf47b+S7IdU3/hqpZvP09
         bvPwnw9v3wvbSTBKDTTOumW41fhApRs7fQ7bErTQEHdXFICSs7JOqOpWe4epT1wHV7Zr
         Hyjz+bmHYhnh/BjAKttDsO6CgHBthbv/04VFZ9pwj3g3hRbBHU9eBJtJ39M40zf0ozy2
         0qz0DrIN6d49dYovWaxbCRcnH4b1nP5D0O/vjGKYNlM1n/pJme4eXkl4YIKnXdTgBWLE
         OwKQ==
X-Received: by 10.112.22.198 with SMTP id g6mr1418988lbf.135.1366277277735;
 Thu, 18 Apr 2013 02:27:57 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 02:27:57 -0700 (PDT)
In-Reply-To: <20130418082441.GR2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221631>

On Thu, Apr 18, 2013 at 3:24 AM, John Keeping <john@keeping.me.uk> wrote:
> On Wed, Apr 17, 2013 at 11:14:28PM -0500, Felipe Contreras wrote:
>> The *:* refspec doesn't work, and never has, clarify the code and
>> documentation to reflect that. This in effect reverts commit 9e7673e
>> (gitremote-helpers(1): clarify refspec behaviour).
>
> In what way doesn't it work?  If I specify that refspec then I do get
> output that appears sensible.

% git checkout origin/master
% make -C t t5801-remote-helpers.sh

not ok 15 - pushing with straight refspec # TODO known breakage

It fails for me here.


>>  Documentation/gitremote-helpers.txt |  4 ++--
>>  t/t5801-remote-helpers.sh           | 15 ---------------
>>  transport-helper.c                  |  2 +-
>>  3 files changed, 3 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
>> index f506031..0c91aba 100644
>> --- a/Documentation/gitremote-helpers.txt
>> +++ b/Documentation/gitremote-helpers.txt
>> @@ -174,8 +174,8 @@ ref.
>>  This capability can be advertised multiple times.  The first
>>  applicable refspec takes precedence.  The left-hand of refspecs
>>  advertised with this capability must cover all refs reported by
>> -the list command.  If a helper does not need a specific 'refspec'
>> -capability then it should advertise `refspec *:*`.
>> +the list command.  If no 'refspec' capability is advertised,
>> +there is an implied `refspec *:*`.
>
> This is wrong.

It has been like that since v1.7.0.

> As your later patch makes clearer, there is no implied
> refspec for push - it only works for fetch.  I found the wording you've
> reverted to extremely misleading.  How about something like this:
>
>     For historical reasons, 'import' treats the absence of a 'refspec'
>     line as equivalent to `refspec *:*`; remote helpers should always
>     specify an explicit refspec.

Maybe my version was "misleading" because it didn't mention it was for
historical reasons, but yours is plain wrong; remote helpers might not
be using 'import' or 'export' at all, so not all remote helpers should
always specify an explicit refspec. And if the previous text "It is
recommended that all importers providing the 'import' capability use
this. It's mandatory for 'export'." does not convey the idea these
remote helpers should always specify an explicit refspec, I don't know
what it does.

-- 
Felipe Contreras
