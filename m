From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 33/41] refs.c: pass the ref log message to
 _create/delete/update instead of _commit
Date: Tue, 3 Jun 2014 10:01:48 -0700
Message-ID: <CAL=YDWkjWJxx-ZYNO1GjzsfiecH=vmj5e0bgJeYH1ccMa4zjKQ@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-34-git-send-email-sahlberg@google.com>
	<20140530173831.GH12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 19:01:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrs5x-0006MW-VY
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 19:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269AbaFCRBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 13:01:49 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:44486 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbaFCRBt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 13:01:49 -0400
Received: by mail-vc0-f179.google.com with SMTP id ij19so2655631vcb.24
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b25JicbqfX+YUxHFk00JsEfShpJOpuT+ElThTOshj4I=;
        b=MsfV19YuQX3r23weBYW7+pGjkXp6AZuYvgtl373+XomsqqsE4eWt96jqm6pkJj77IW
         2LOFJ0K1nERcU9v4R1bmPqAJN6aOPJwXTuxV7alF+zAQuqkTlbDXkeJL30jcpEWfyb2m
         4SFQp/T26rDUyN3IRoIouMzFY/l8kE1T8N7kBxLsGH5SgHCXruFyIr15x/RN/6fPBT3A
         f3JxD+NO7javxYIJG6TnZOcTGtXFsNYzwNcTnhnUh26rODe+DPuS1aFc2tuwqJh4NrQW
         9XxUbVm8Ebi+iY2rzkU93hcTjiMHSbMKElAG78+hsRB27Lrnqx96AEM5TJB9z710jSUV
         k8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=b25JicbqfX+YUxHFk00JsEfShpJOpuT+ElThTOshj4I=;
        b=ibILSVFTK9qzwJQdqB8dU7F6t7vVNZ9jrCo8GUm+NkrkEA2AIE+YTBX5OMKVCxWzRS
         Bpem8piIuIimiiCjOnaRkw6mdOA8UhJFcVYcPoAil2L8FNhRKvGqmYeBaMt/VE6CDDN0
         oc8tUpexP2sAv071cYDZsM61xFor6DLU80mAVO5XHPXXWJByUk5HKMibhUjRHlDhYrYf
         Vhguiilo9zlpHNzBzEByzBs6lAxruE7yI7ReYN6AgI1CHWSS2jQWiOXBtpHPHGBhSpML
         4X7iy+avRuxgJ+190MtbogOqY4wSUBuD81v7KHLJIo0RFmKaZ24Ran/b8qvDV2K7el67
         77QQ==
X-Gm-Message-State: ALoCoQnIIf1z/sg5wXgcXRJQWHRI4d51wp3KbEGk7LmjQ4iobXpUef/JjnXTakWm68OGA+SHzFZF
X-Received: by 10.220.123.201 with SMTP id q9mr2213043vcr.77.1401814908368;
 Tue, 03 Jun 2014 10:01:48 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 3 Jun 2014 10:01:48 -0700 (PDT)
In-Reply-To: <20140530173831.GH12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250631>

On Fri, May 30, 2014 at 10:38 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Change the reference transactions so that we pass the reflog message
>> through to the create/delete/update function instead of the commit message.
>> This allows for individual messages for each change in a multi ref
>> transaction.
>
> Nice.
>
> That reminds me: in the future, do we want to have some way to figure
> out what ref updates happened together?  E.g., cvsnt introduced commit
> identifiers to answer a similar kind of question in CVS per-file
> history.  If some backend wants to support that, the API this patch
> introduces would handle it fine --- good.
>
> [...]
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -673,10 +673,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>>                       }
>>               }
>>       }
>> -
>>       if (rc & STORE_REF_ERROR_DF_CONFLICT)
>>               error(_("some local refs could not be updated; try running\n"
>> -                   " 'git remote prune %s' to remove any old, conflicting "
>> +                   "'git remote prune %s' to remove any old, conflicting "
>>                     "branches"), remote_name);
>
> Unrelated change snuck in?

Yeah, there shouldn't be a space there.

>
> The rest of the patch is
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks!

>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index faa1233..55f457c 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -673,9 +673,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>                         }
>                 }
>         }
> +
>         if (rc & STORE_REF_ERROR_DF_CONFLICT)
>                 error(_("some local refs could not be updated; try running\n"
> -                     "'git remote prune %s' to remove any old, conflicting "
> +                     " 'git remote prune %s' to remove any old, conflicting "
>                       "branches"), remote_name);
>
>   abort:
