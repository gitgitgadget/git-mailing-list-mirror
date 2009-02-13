From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 05:21:20 -0500
Message-ID: <76718490902130221q3114fbdbt89692e79158530ff@mail.gmail.com>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-5-git-send-email-jaysoffian@gmail.com>
	 <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 11:22:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXvC4-00061C-Kc
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 11:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266AbZBMKVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 05:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbZBMKVY
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 05:21:24 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:51283 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944AbZBMKVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 05:21:22 -0500
Received: by rv-out-0506.google.com with SMTP id g37so639193rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n9EuJLUBJ4clDsOor8I8TSuhH04QVrkGOpdXX+ShJJI=;
        b=xuW4BLd47lC7t6fSnZQSEaon2EITWu8Uq8U7Bmh450AWJKSZyO55ViRDOYxbQvXMgT
         67sozPw/1Udnpmv9x5G9s3Rkcg4QV5Jtv7Hx4YMwCSmjCbd/C9ehdx+Mj/bazxTgoPb5
         CgIF9fq4cHLAp9i1XfijlU1lcoDJSszfTycvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ayLsvccR+a3vBmgvJg09FuISwug15pJxmNrWEEio8Xy+k2SxfxWA2FqfeS8PvVvX9p
         SODk6uqfFhbG+oQmHQvUfGtmwMG+DFlz2G3611/0nc/pPBIN4CTHVVuA00DDzUobMut4
         DMlHhpPkG20vAz5mD7P4FnixkSlwTijhvHkT8=
Received: by 10.141.201.1 with SMTP id d1mr1077876rvq.157.1234520480910; Fri, 
	13 Feb 2009 02:21:20 -0800 (PST)
In-Reply-To: <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109737>

On Fri, Feb 13, 2009 at 5:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Calling the subcommand a "verb" is somewhat new, though.  Existing
> documentation for git commands that take multiple actions seem to call
> them subcommands, including "git-remote.txt" itself.

Okay.

> Hmph, what does "-a" stand for?  I would have expected to see "-u" that
> stands for "update" here.

--automatic -- as in figure out the name automatically from the other side.

> Also it may be better to be more explicit about both the syntax and the
> semantics of `<branch>`.

Okay.

> Do you expect "refs/remotes/<name>/master" or
> just "master" (I assume the latter)?

Yes, the latter.  If you did the wrong thing the error ought clue you in:

$ ./git remote set-head origin refs/remotes/origin/master
error: Not a valid ref: refs/remotes/origin/refs/remotes/origin/master

> Is it an error if the branch does
> not exist in the specified hierarchy?

Yes it is an error per-above. Well, at least on-top of next it is.

> Can you force to set to a branch
> that does not exist in your tracking side (yet) but you know exists on the
> remote side already?

No.

>> diff --git a/builtin-remote.c b/builtin-remote.c
>> index 465c87a..677e20e 100644
>> --- a/builtin-remote.c
>> +++ b/builtin-remote.c
>> @@ -658,7 +659,8 @@ static void free_remote_ref_states(struct ref_states *states)
>>       string_list_clear(&states->new, 0);
>>       string_list_clear(&states->stale, 0);
>>       string_list_clear(&states->tracked, 0);
>> -     free(states->head_name);
>> +     if (states->head_name)
>> +             free(states->head_name);
>>  }
>
> Regression?

Indeed.

> set_head()?

Yep.

> The code will scale better, especially for a young subcommand that may acquire
> new options, if the check is done by each codepath that deals with a
> specific option to do this kind of check.  That is, e.g.
>
>        if (opt_delete) {
>                error if the arg is not remote (alone)
>                do the "delete" thing
>        } else if (opt_update) {
>                error if the arg is not remote (alone)
>                do the "update" thing
>        } else {
>                error if the args are not (remote, branch)
>                do the "set" thing
>        }

Got it. I really am trying to match existing code, but it seems the
standards have gotten higher, so I need to do better than existing
code.

Thanks,

j.
