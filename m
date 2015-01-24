From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/6] refs.c: remove unlock_ref and commit_ref from write_ref_sha1
Date: Fri, 23 Jan 2015 17:29:31 -0800
Message-ID: <xmqqiofxneys.fsf@gitster.dls.corp.google.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-6-git-send-email-sbeller@google.com>
	<xmqq61bxoxs8.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYPCFBNNkYV0C_XeCEaqfz=Mh3Zy=L-vAWsmZBFgebqNQ@mail.gmail.com>
	<xmqqppa5nhab.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ0EBRgSuc4Wupaa9t85xcF79SizvGbjD9OC3+Jq=XbFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 02:29:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEpXf-0006sa-6Y
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 02:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbbAXB3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 20:29:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750836AbbAXB3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 20:29:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9813732575;
	Fri, 23 Jan 2015 20:29:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PHg0Cm/g2fmV1iR+hQ2V0wPlEo4=; b=ibQNGw
	lkFlCkqLt86elmIygY1Pl2mPP+4GEGX4wj6Eg/ctfIiEQH1Ok/0DtNS2COJ9yPqa
	fWbnVM2x7OvA2NO8Lvd1RR7wDskW5mWs+miEBY+iqhp9OyGzEQpbcZ4qHrlaW/Pc
	3895RacVHo13mq3qMaQrrjSm9Xa5Oyl7OaCL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jw2bEAFtEheqAYLqdvUXLo2llRfmVYSu
	jLlOve+3vX7SnWbOFOrZNatJuFFy8Y2HG+dUF1n6RToOjIbXbao1KRjyoD1kgXAu
	w8Nyo7Rj1fz28Oh2uy7cViq2USUEn+qGvIb4z24rd4TV9lTgJevizIa+jv8ctpEo
	hKtY/Vgiie8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E3F132574;
	Fri, 23 Jan 2015 20:29:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1165132573;
	Fri, 23 Jan 2015 20:29:32 -0500 (EST)
In-Reply-To: <CAGZ79kZ0EBRgSuc4Wupaa9t85xcF79SizvGbjD9OC3+Jq=XbFA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 23 Jan 2015 17:04:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73180744-A368-11E4-A332-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262984>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jan 23, 2015 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Fri, Jan 23, 2015 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Stefan Beller <sbeller@google.com> writes:
>>>>
>>>>> -static int commit_ref(struct ref_lock *lock)
>>>>> +static int commit_ref(struct ref_lock *lock, const unsigned char *sha1)
>>>>>  {
>>>>> +     if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
>>>>> +             return 0;
>>>>>       if (commit_lock_file(lock->lk))
>>>>>               return -1;
>>>>>       return 0;
>>>>> @@ -2879,10 +2882,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>>>>>       }
>>>>>       lock->force_write = 1;
>>>>>       hashcpy(lock->old_sha1, orig_sha1);
>>>>> -     if (write_ref_sha1(lock, orig_sha1, logmsg)) {
>>>>> +     if (write_ref_sha1(lock, orig_sha1, logmsg)
>>>>> +         || commit_ref(lock, orig_sha1)) {
>>>>> +             unlock_ref(lock);
>>>>
>>>> This is not a new problem, but the two lines in pre-context of this
>>>> patch look strange.
>>>
>>> Which (not new) problem are you talking about here? Do you have
>>> a reference?
>>
>> These two lines in pre-context of the hunk:
>>
>>>>>       lock->force_write = 1;
>>>>>       hashcpy(lock->old_sha1, orig_sha1);
>>
>
> So these 2 lines (specially the force_write=1 line) is just there to trigger
> the valid early exit path as you sent in the other mail :
>
>> if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
>>             return 0;
>
> when we have the same sha1?
> and you're saying that's a problem because hard to understand?

What is the point of that hashcmp() in the first place?  My
understanding is that 

 (1) lock->old_sha1 is to hold the original SHA-1 in the ref we took
     the lock on.

 (2) when not forcing, and when the two SHA-1 are the same, we
     bypass and return early because overwriting the ref with the
     same value is no-op.

Now, in that codepath, when the code is renaming into some ref, the
ref either would have no original SHA-1 (i.e. we are renaming to a
non-existing name) or have unrelated SHA-1 (i.e. we are overwriting
an existing one).  For some (unknown to me) reason, however, the
code pretends that lock->old_sha1 has the new SHA-1 already before
we start to do the write or commit.

And because both write and commit tries to pretend to be no-op when
the caller tries to update a ref with the same SHA-1, but in this
codepath it does want the write to happen, it needs to set the
force_write bit set, which look like an unnecessary workaround.

Let me rephrase.

A natural way to write that caller, I think, would be more like
this:

	... lock is given by the caller, probably with ->old_sha1
	... filled in; it is not likely to be orig_sha1, as it is
        ... either null (if locking to create a new ref) or some
        ... unrelated value read from the ref being overwritten by
        ... this rename_ref() operation.

	write_ref_sha1(lock, orig_sha1, logmsg);
	# which may do the "don't write the same value" optmization
        # if we are renaming another ref that happens to have the
        # same value, in which case it is OK. Otherwise this will
        # overwrite without being forced.

	... *IF* and only if there is some reason lock->old_sha1
        ... needs to match what is in the filesystem ref right now,
        ... then do
	hashcpy(lock->old_sha1, orig_sha1);
	... but probably there is no reason to do so.

The two lines hashcpy() and ->force_write = 1 that appear before the
write_ref_sha1() do not conceptually make sense.  The former does
not make sense because ->old_sha1 is supposed to be the original
value that is already stored in the ref, to allow us optimize "write
the same value" case, and you are breaking that invariant by doing
hashcpy() before write_ref_sha1().  The lock->old_sha1 value does
not have anything to do with the (original) value of the ref we took
the lock on.

And ->force_write = 1 becomes necessary only because the effect of
this nonsensical hashcpy() is to make the !hashcmp() used by the
short-cut logic trigger.  Since the code needs to override that
logic, you need to say "force" before calling write_ref_sha1().  If
you didn't do the hashcpy(), you wouldn't have to say "force", no?
