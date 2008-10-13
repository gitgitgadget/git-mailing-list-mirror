From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Tue, 14 Oct 2008 00:29:48 +0200
Message-ID: <4ac8254d0810131529l37d67b61q3589f15700d38261@mail.gmail.com>
References: <1223934148-13942-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7vzll887ps.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 00:31:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpVwQ-0006QD-Un
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 00:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758422AbYJMW3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 18:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757681AbYJMW3v
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 18:29:51 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:59612 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758422AbYJMW3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 18:29:50 -0400
Received: by yx-out-2324.google.com with SMTP id 8so455270yxm.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=g7kK7sDAj9B5W3av4eUi9DGRQzGAd4f5fSyeWWHE9I0=;
        b=qqBj/asSMtL23vHCm1Zo3J7fLCW1fAAmj0l1gpymc3uvN2JYAW3M5ZGQIWOHNQ1Ugq
         R0mseuRMkDRS4i8QrziNrqajhLcR7NRmh74IDLuvvUZ8uFA6fLPRrUCz/2JWaFQ23xFK
         76qErttZnGIe6UqU9x6xExmqLu9E8mEAl24qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IW07t1Zv/7NuDHDYkWOJ0QDqfF1aE/2c5FnpXff+iraVohmTo0z3jVlQf9BSMQ6ylX
         btaJD2yV59b5ztwnjAT8m28iwcoRT0rgeTbHxSZSIZ69WbGBYCAbkE64fSPWyUgMf1iu
         lNpWK+lq+obRSP3td9scdjKHpmU+XDyx6rulY=
Received: by 10.65.116.9 with SMTP id t9mr11619883qbm.95.1223936988332;
        Mon, 13 Oct 2008 15:29:48 -0700 (PDT)
Received: by 10.64.142.13 with HTTP; Mon, 13 Oct 2008 15:29:48 -0700 (PDT)
In-Reply-To: <7vzll887ps.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98161>

On Tue, Oct 14, 2008 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> tuncer.ayaz@gmail.com writes:
>
>> From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
>>
>> Updated patch to current Junio master.
>
> That's not a commit log message, is it?

Sorry, I was referring to my previous post and
this was my first post via send-email.

Is it ok for me to include the log message here?

-->
After fixing clone -q I noticed that pull -q does not do what
it's supposed to do and implemented --quiet/--verbose by
adding it to builtin-merge and fixing two places in builtin-fetch.

I have not touched/adjusted contrib/completion/git-completion.bash
but can take a look if wanted. I think it already needs one or two
adjustments caused by recent --OPTIONS changes in master.

I've tested the following invocations with the below changes applied:
$ git pull
$ git pull -q
$ git pull -v
<--

is that good enough or did I miss something?

>> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
>> ---
>>  Documentation/merge-options.txt |    8 ++++++++
>>  builtin-fetch.c                 |    5 +++--
>>  builtin-merge.c                 |   22 +++++++++++++++-------
>>  git-pull.sh                     |   10 ++++++++--
>>  4 files changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
>> index 007909a..427cdef 100644
>> --- a/Documentation/merge-options.txt
>> +++ b/Documentation/merge-options.txt
>> @@ -1,3 +1,11 @@
>> +-q::
>> +--quiet::
>> +     Operate quietly.
>> +
>> +-v::
>> +--verbose::
>> +     Be verbose.
>> +
>>  --stat::
>>       Show a diffstat at the end of the merge. The diffstat is also
>>       controlled by the configuration option merge.stat.
>> diff --git a/builtin-fetch.c b/builtin-fetch.c
>> index ee93d3a..287ce33 100644
>> --- a/builtin-fetch.c
>> +++ b/builtin-fetch.c
>> @@ -372,12 +372,13 @@ static int store_updated_refs(const char *url, const char *remote_name,
>>                               SUMMARY_WIDTH, *kind ? kind : "branch",
>>                                REFCOL_WIDTH, *what ? what : "HEAD");
>>               if (*note) {
>> -                     if (!shown_url) {
>> +                     if ((verbose || !quiet) && !shown_url) {
>
> A pair of external verbosity flag -q and -v may be acceptable, but is it
> sane to have a pair of variables in code always used like this?  In other
> words, this makes me wonder if a single "verbosity level" variable that
> can be set to quiet, normal and verbose would make it more readable.  For
> example, this one would say:
>
>        if (verbosity >= VERBOSITY_NORMAL && !shown_url) {
>                ...
>        }

what I would actually prefer to implement are separate
printf functions for verbose, info and error messages
and display them according to:
info: sent to ouput if verbose is set or quiet is not set
error: always sent to ouput
verbose: only sent to output if verbose is set

you could get that with your "verbosity level" solution.
to keep it simple I would avoid adding any more
levels or topics to logging and if someone really wants
to either declare trace_printf to be debug_printf
or rename it :).

if that make sense I would like to teach this to
git as a general option as far as possible and get
rid of all the if clauses in front of printf calls.

> Also what does your command line parsing code do when the user gives -q
> and -v at the same time?  Does the last one on the command line win?
> Shouldn't you instead get an error message (which of course would mean you
> would need to fix the caller in git-pull.sh)?

I thought about that also and at least in this patch
tried to handle it by ignoring quiet if verbose is set.
this may not be the logic everyone wants to have
and exclusively allowing either -q or -v makes
more sense.

>> +                     if (verbose || !quiet)
>> +                             fprintf(stderr, " %s\n", note);
>
> Ditto.
>
>> +     if (verbose || !quiet)
>> +             printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
>
> Ditto.
>
>> +             if (verbose || !quiet)
>> +                     printf("%s\n", msg);
>> +             if ((verbose || !quiet) && !merge_msg.len)
>
> Ditto.
>
>> +     if (!verbose && quiet)
>> +             show_diffstat = 0;
>
> Hmph, ah, that's (!(verbose || !quiet)).  See the readability issue?

your version is more readable. the human mind seems to
have a problem with double or triple negations :).

>> +             if (verbose || !quiet)
>> +                     printf("Updating %s..%s\n",
>> +                             hex,
>> +                             find_unique_abbrev(remoteheads->item->object.sha1,
>> +                             DEFAULT_ABBREV));
>
> Ditto.
>
