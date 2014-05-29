From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 25/41] fast-import.c: use a ref transaction when
 dumping tags
Date: Thu, 29 May 2014 09:10:41 -0700
Message-ID: <CAL=YDW=WmNObkTO_uybTToeMKGGQf5NC0oFvy_pMrsg+ehpzog@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-26-git-send-email-sahlberg@google.com>
	<20140528194746.GX12314@google.com>
	<CAL=YDWkUhdoJkdg_zaq+p=XRu7H9fqNXDz89uPhbr4equTyVLQ@mail.gmail.com>
	<20140528221720.GB12314@google.com>
	<CAL=YDW=ruMzd=twadncjgFTh3yv=796cN72amJ4ep8a41tgmrA@mail.gmail.com>
	<20140528233940.GC12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 18:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2uk-0000wX-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247AbaE2QKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:10:43 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:38700 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207AbaE2QKm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:10:42 -0400
Received: by mail-vc0-f182.google.com with SMTP id id10so638789vcb.13
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z/DPYOxpkX7xxFWOuC2G+s1yOIGEDRl7M10T4ja9+pc=;
        b=bZ/X6xJ3YFJJK7fIoeP4ZU2HjCxVwATUWNofVKR/zwXyejKeB0mp/8zAe2zxQu/H/Y
         uMcrbajLt4vpED/1wpw3YPDBLl1XHstjPxC9RpiEmfhZp07Caf60p+tgaCZ7GznvG274
         wTc4CHurE8y2eQskVmKTMXqEnSh0kOQxB+wztzEB/sVwpKY/lzOd9v2zAtDlOPT+CezM
         8m9hLYcBupFHKlebPxfCP4DEmAlTeTDI5gZcZIRi3dyTroqPZ3eF211FPmB1E5DN0XhS
         8/4hKNnEvKvNtLjGFtSFR5+FfMC9dlZcTm+MI1K0Pja9RPV8qGpA6BbQlF+ehyZLB/3Y
         RbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Z/DPYOxpkX7xxFWOuC2G+s1yOIGEDRl7M10T4ja9+pc=;
        b=LnEL3e9vp0BMvNlBEQK8qWKT4YxW1Tem923vrBgJy6SV+YCf7Zdw2DUlnRDhcEQWFI
         PYm05KQU4nqEyGUikJygjb/miMIAYtsUQVnqoLHqIlG0tlOAMw7fsjtSJ1rLHesN1R7k
         3wmaTzPlqeYd6r48f6OsjOIyHDX9HgpS2ugqSPhUG8sd1+JzdxtCR3ABNyoK/rzNqRCD
         jykum9xRkz/0Iv3JHvMg084GCS2SLAXZ1Hz6NOKv95kJ797oZirHQEflwNUfHnrXlWn4
         EDgPZPLHcYJwrU0opyoFIQ4fDggelvZNsMRtCloylUWdwzjMAtTM5CN/eVJmO93yUfSb
         VDQg==
X-Gm-Message-State: ALoCoQmv9+wu616speSl456PDvXXxqYMP6QK9S8I4epT9dOS3aR/yHnoAArvzfMwsR0wegm668Mv
X-Received: by 10.221.20.199 with SMTP id qp7mr7790669vcb.24.1401379841396;
 Thu, 29 May 2014 09:10:41 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 29 May 2014 09:10:41 -0700 (PDT)
In-Reply-To: <20140528233940.GC12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250390>

On Wed, May 28, 2014 at 4:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> I rely on the fact that if the transaction has failed then it is safe
>> to call ref_transaction_commit since it is guaranteed to return an
>> error too.
>
> Yes, I am saying that behavior for ref_transaction_commit is weird.
>
> Usually when ref_transaction_commit is called I can do
>
>         struct strbuf err = STRBUF_INIT;
>         if (ref_transaction_commit(..., &err))
>                 die("%s", err.buf);
>
> and I know that since ref_transaction_commit has returned a nonzero
> result, err.buf is populated with a sensible message that will
> describe what went wrong.
>
> That's true even if there's a bug elsewhere in code I didn't write
> (e.g., someone forgot to check the return value from
> ref_transaction_update).
>
> But the guarantee you are describing removes that property.  It
> creates a case where ref_transaction_commit can return nonzero without
> updating err.  So I get the following message:
>
>         fatal:
>
> I don't think that's a good outcome.

In this case "fatal:" can not happen.
This is no more subtle than most of the git core.


I have changed this function to explicitly abort on _update failing
but I think this is making the api too restrictive.


>
> Sure, if I am well acquainted with the API, I can make sure to use the
> same strbuf for all transaction API calls.  But that would result in
> strange behavior, too: if multiple _update calls fail, then I get
> concatenated messages.
>
> Okay, I can make sure to do at most one failing _update, before
> calling _commit and printing the error.  But at that point, what is
> the advantage over normal exception handling, where the error gets
> handled at the _update call site?
>
> Jonathan
