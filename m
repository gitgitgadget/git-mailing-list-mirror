From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Thu, 12 Feb 2015 10:04:14 -0800
Message-ID: <CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
	<54DCDA42.2060800@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 19:04:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLy7g-0006zy-I4
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 19:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbbBLSEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 13:04:16 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33686 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbBLSEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 13:04:15 -0500
Received: by iecar1 with SMTP id ar1so13840732iec.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hj7x5W/YzhvBvlJ1tgohutu/pMxTxWcWzSIxrlpnS2Y=;
        b=ZEppVuL4N6It+k/Nj4yn302rO0E8ujsbvqIzcqjEVVswvrr+YAOhKbFf+H9doYoc71
         TBhhoXhgtsfpDPpkpQCsREjeIOUGFE9KnU1OrcYPq5gfTHT8V9udaiFD6pYY0lC946aW
         TuMkRGVfkyAAAr7X22vyaIXszgwmDFWtaDlfpaFW9OynrnDcrJyqoqRzQ7zrNQ+yg1mA
         Ad+LyRC7JHk9oWba9RuV3eLXftvBwq2HDS2ldGri8RIYC5azfkvIo047+5q0AiykTHDN
         uLunqvvXJxSjQ2cwAyiu34NPvTn3AMq5HdDR7Ty1sJdrigTV9BXTijaIxxJNYQBBb6+g
         iaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hj7x5W/YzhvBvlJ1tgohutu/pMxTxWcWzSIxrlpnS2Y=;
        b=Sh308cGU+kwnO7ZDDRabcUCX7pEV1xwoOEs/fgwx23GmhKMnA2MMG0oc5S5r9kUrSC
         xQ0IreFdfHOjq12ot0s8476nByKb0U6nf/iy6pUAZ9AFoH/TFjVYxqyOIIZHMyI6dGNg
         OCb1VtCLv8qbMCQy2kQAKiI/gArJWUBdbFZJ6Lx1MSWxiIcqh+qyFVGTphyXLf2GgpN2
         AqHHFypxJ8R/2/SZrWIFgGjYCHBw5tb2iJZ8SnfgDBFJZRnCvJjY/o1NOUiNy+gS6qk3
         qqUmX4GODwQl/NiG7oKCEhmluIS7fUxXzlGTaVE+kjJcJ580Hk8LWau7iIw33X9i8fT5
         DjHA==
X-Gm-Message-State: ALoCoQn9Z1QShDYKQL7h7XYpc5JEw91HBjBtf32iif4Os4Ye2aNEL8A+U8qxWOlhPkuod+rwHW19
X-Received: by 10.50.85.44 with SMTP id e12mr5499249igz.48.1423764254866; Thu,
 12 Feb 2015 10:04:14 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 12 Feb 2015 10:04:14 -0800 (PST)
In-Reply-To: <54DCDA42.2060800@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263746>

On Thu, Feb 12, 2015 at 8:52 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 02/12/2015 12:25 AM, Stefan Beller wrote:
>> On Wed, Feb 11, 2015 at 2:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>>> When processing the reflog of a symbolic ref, hold the lock on the
>>>>> symbolic reference itself, not on the reference that it points to.
>>>>
>>>> I am not sure if that makes sense.
>>>> So when expiring HEAD, you want to have a .git/HEAD.lock file
>>>> instead of a .git/refs/heads/master.lock file?
>>>>
>>>> What would happen if there is a concurrent modification
>>>> to the master branch?
>>>
>>> The HEAD may be pointing at 'master' and the other party that is
>>> trying to modify it would fail when it tries to update the reflog
>>> for HEAD thanks to HEAD.lock being held by us.  The HEAD may be
>>> pointing at 'next' and the other part that updates 'master' would
>>> not try to modify HEAD reflog and we do not conflict.
>>>
>>> At least, I think that is the rationale behind this change.
>>
>> That makes sense! Do we have documentation on symrefs?
>>
>> Originally I was wondering if this would make things
>> complicated for  symbolic branches which are not HEAD.
>> Then you could update the branch pointed to, because it
>> has no lock as the lock is on the symref. On the other hand
>> this seems to be an improvement, as you cannot move the
>> symref itself, as it has the lock and we don't really have other
>> symrefs?
>
> The convention is that holding lock $GIT_DIR/$refname.lock (where
> $refname might be, for example, "HEAD" or "refs/heads/master") protects
> two things:
>
> * The loose-reference file $GIT_DIR/$refname
> * The reflog file $GIT_DIR/logs/$refname
>
> And this makes sense:
>
> Suppose that HEAD is refs/heads/master. These two thing have independent
> reflogs, so there is no reason that one process can't be expiring the
> reflog of HEAD while another expires the reflog of refs/heads/master.
>
> The behavior before this patch was that the reflog for "HEAD" was
> modified while holding the reflog for "refs/heads/master". This is too
> strict and would make those two processes contend unnecessarily.
>
> I can't think of a reason that the current behavior is unsafe. But it's
> more restrictive than necessary, and more confusing than necessary. My
> guess is that it was unintended (i.e., a bug). It dates from
>
>     68db31cc28 (2007-05-09) git-update-ref: add --no-deref option for
> overwriting/detaching ref
>
> which initially added the REF_NODEREF constant and probably forgot that
> the new flag should be used in this invocation.
>
> However, another important question is whether other Git implementations
> have copied this unusual locking policy. If so, that would be a reason
> not to change it. I just pinged the libgit2 maintainer to find out their
> policy. Maybe you could find out about JGit?

I could not really find reflog expiration for jgit for a while, but
then I stumbled upon this:

    // TODO: implement reflog_expire(pm, repo);

so I think it's safe to change it in git.git for now.

Reviewed-by: Stefan Beller <sbeller@google.com>

>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
