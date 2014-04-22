From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v2 02/13] refs.c: use a single exit path from transaction
 commit and handle onerr
Date: Tue, 22 Apr 2014 15:46:41 -0700
Message-ID: <CAL=YDW=8tHEEZ5_gMhC6nEzJui-L=SKR9b+UQmD-EUDxyTGUdA@mail.gmail.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
	<1398120811-20284-3-git-send-email-sahlberg@google.com>
	<xmqqbnvt5ge2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcjSi-0003gt-2W
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbaDVWqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:46:43 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:53111 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaDVWqm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:46:42 -0400
Received: by mail-ve0-f171.google.com with SMTP id jy13so172913veb.2
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 15:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ifK8dBvBxZ33NHchwmZbOWAD6uvxswqERXFVKGjWjeM=;
        b=b22OTfxobytHtzyvzzaX9abayF84pb9JVsW2snYDs2wkJ/iZJrDqArFHyrZ6904p0r
         WT9lbEVR6kJtJ1uo0glelJcr9N9aFk6jHLcAP2T4M8gHAf/RZk+5ESTh8zaQO2jUITcY
         1mYVjgLEsgpUWTDxZF6mvkgZaMIWlXiEsc5bKWVVgCuGUcq4fkiiwjb4D92AmKE1h5Ju
         gt4zR651FkqXJqZtK1eJCCNReVZb5AERaJFa9sX7unRzikW/0EqqtUb0TZUwZfLR5pB5
         BO2ZcbPDyM34OqLBHpR4KpE0BzeeeBexhey/QtiJpLi7epMRrjkFOU4qkOeYYZzc5FP0
         sMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ifK8dBvBxZ33NHchwmZbOWAD6uvxswqERXFVKGjWjeM=;
        b=llx9vPahWRDZdNY6Koop4nV9l1BMCMMEq3tw4Gh7p34P5gQ9uIjr4eMIuFA+NCvqCx
         J7GiZ2dUhP4rrHuOIwdgKhipkhSdO99IYmjPxiNhl8Tg76rySSEUAidYH4Kqj0uDN5tx
         cBjCXZySJEws7+NJT6MmNw1jv0GTveYUXt+n9onw0YKvYCAbyhCYtdqJBexduf9c47f1
         E9azo8/V9NL3rY3DORV3Pr759yIUREjHUiStXQ6ixBXAbFMOpL9Hxn5LLvYmKMIcHrUv
         A8J0l2GhACKt53vdNySqJTveSMoDtSB4rYZDi/0aGlYU/Go0P3N78tzxpW2b7JTWxhAK
         fM+w==
X-Gm-Message-State: ALoCoQnuWL9hhtJnfSCV6SPJmRcqwYY0fwdtnATLT7vTeXSO+2CNxjKKyuqNqI3NMU0lWjE2MDAleNwlGqw2wFac2SbnvvK6xee3ilQZyTJVyVMypyH38wxylD9u84FZWz1KehSVf1vAl8dn07iNEfAanZcFCdcfxB7QmQWZ5EGGNRjtrNlXDctfFgYln0Lre3e6LpN1dawt
X-Received: by 10.220.133.197 with SMTP id g5mr11274441vct.20.1398206801574;
 Tue, 22 Apr 2014 15:46:41 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 22 Apr 2014 15:46:41 -0700 (PDT)
In-Reply-To: <xmqqbnvt5ge2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246800>

On Tue, Apr 22, 2014 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> diff --git a/refs.c b/refs.c
>> index 138ab70..9daf89e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3414,12 +3414,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>                          const char *msg, enum action_on_err onerr)
>> ...
>> +     if (ret) {
>> +             const char *str = "Cannot commit transaction.";
>> +             switch (onerr) {
>> +             case UPDATE_REFS_MSG_ON_ERR: error(str); break;
>> +             case UPDATE_REFS_DIE_ON_ERR: die(str); break;
>> +             case UPDATE_REFS_QUIET_ON_ERR: break;
>> +             }
>> +     }
>>       return ret;
>>  }
>
> I think this is a response to Michael's earlier review "do different
> callers want to give different error messages more suitable for the
> situation?".  I suspect that the ideal endgame may end up all
> callers passing QUIET_ON_ERR and doing the error message themselves,
> e.g. branch.c::craete_branch() may end something like this:
>
>     ...
>     if (!dont_change_ref)
>         if (ref_transaction_commit(..., UPDATE_REFS_QUIET_ON_ERR))
>                 die_errno(_("Failed to write branch '%s'"),
>                           skip_prefix(ref.buf, "refs/heads/));
>
> And in the meantime until the callers are converted, we may end up
> showing the fallback "Cannot commit transaction." but that would be
> OK during the development and polishing of this series.
>

That is a good idea.
I will try to address that in the next respin.
