From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 05:14:18 -0500
Message-ID: <CAMP44s33WLE6xJ_bFJBX2z0hdkALqCKpq7Ve+8hZw2URWUPz_w@mail.gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
	<20130418101133.GW2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 18 12:14:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USlrI-0006YF-SK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967993Ab3DRKOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:14:22 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:35834 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967948Ab3DRKOU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:14:20 -0400
Received: by mail-la0-f43.google.com with SMTP id eg20so2365772lab.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=74C5VdIw+osqpuAXP7PNteV/G6ZYy7l8MYKpi7qC9xg=;
        b=xpXsyzbx9cz6ufqGX/GJxJtjfUGVTptgP73PCq+ybnqIIONGe+cTiSTgFiJ+BSIw7W
         jf8ERRJOlbrqx8SHwK6yckDc+wt0bKVyE+NNj7HorzsOQcSHlvIvtteTVg4rTb1kXzg0
         7mzbm8MkEsMIojI2WRsB0Wi4ItqcpgbJuB+yZsSIWRYGeymqIFIDnQleT8WtbvK81AtH
         DeM7eRLi/NQj6Ab75fT7Dqff26FgssXcX1dwrUPYkJMOxxCubBMcf8UPthBZmQoCghIK
         1A7ajpKa0KYn5FpQbTSBHtI6CebC7a5nFvhvQRVmz/a24PswAaiZ4TJwnM6OzknJ8uWz
         lCtQ==
X-Received: by 10.152.6.162 with SMTP id c2mr5240636laa.20.1366280058557; Thu,
 18 Apr 2013 03:14:18 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 03:14:18 -0700 (PDT)
In-Reply-To: <20130418101133.GW2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221641>

On Thu, Apr 18, 2013 at 5:11 AM, John Keeping <john@keeping.me.uk> wrote:
> On Wed, Apr 17, 2013 at 11:14:30PM -0500, Felipe Contreras wrote:
>> This has never worked, since it's inception the code simply skips all
>> the refs, essentially telling fast-export to do nothing.
>>
>> Let's at least tell the user what's going on.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  Documentation/gitremote-helpers.txt | 4 ++--
>>  t/t5801-remote-helpers.sh           | 6 +++---
>>  transport-helper.c                  | 5 +++--
>>  3 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
>> index ba7240c..4d26e37 100644
>> --- a/Documentation/gitremote-helpers.txt
>> +++ b/Documentation/gitremote-helpers.txt
>> @@ -162,8 +162,8 @@ Miscellaneous capabilities
>>       For remote helpers that implement 'import' or 'export', this capability
>>       allows the refs to be constrained to a private namespace, instead of
>>       writing to refs/heads or refs/remotes directly.
>> -     It is recommended that all importers providing the 'import' or 'export'
>> -     capabilities use this.
>> +     It is recommended that all importers providing the 'import'
>> +     capability use this. It's mandatory for 'export'.
>
> s/It's/It is/

What's the difference?

>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -785,6 +785,9 @@ static int push_refs_with_export(struct transport *transport,
>>       struct string_list revlist_args = STRING_LIST_INIT_NODUP;
>>       struct strbuf buf = STRBUF_INIT;
>>
>> +     if (!data->refspecs)
>> +             die("remote-helper doesn't support push; refspec needed");
>
> I think the "refspec needed" text is likely to be confusing if an
> end-user ever sees this message.  I'm not sure how we can provide useful
> feedback for both remote helper authors and end-users though.

It doesn't have to be. They'll google it, or they'll post a bug report
with this warning verbatim, or they'll just ignore it. I don't think
there's much more we can do to help in either of these cases.

-- 
Felipe Contreras
