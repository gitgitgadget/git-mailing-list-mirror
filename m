From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not their referent
Date: Fri, 13 Feb 2015 11:12:10 -0800
Message-ID: <xmqqa90hocc5.fsf@gitster.dls.corp.google.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
	<54DCDA42.2060800@alum.mit.edu>
	<CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
	<54DE259C.4030001@alum.mit.edu>
	<xmqqoaoxoffe.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZpCjcGeifbLztpNUSq7-3Yy2_GEVPGEQsxrgoZfLFU+g@mail.gmail.com>
	<xmqqk2zloeg1.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYRi3KYcvNQbkhP0uLFgpJzD+h=P+smOLQy2Msv0C_1kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Carlos =?utf-8?Q?Mart?= =?utf-8?Q?=C3=ADn?= Nieto 
	<cmn@elego.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 20:12:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMLf0-0006bS-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 20:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbbBMTMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 14:12:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752772AbbBMTMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 14:12:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEE0923434;
	Fri, 13 Feb 2015 14:12:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hwYEd5qZSif4bWZjx997oYLLGpY=; b=eBWSK3
	ZuTIi7YsCP3ipQK8ZEv/jAZwjrgpzrKG5a/pPNWzhA45o49UxjJ77KqIXFKL6HTM
	aMkCrInWGsok8vJCjENAcaJyw+Bh5Eocck+E9TgDWJyy+d1O3cedgdiaQSJQ73oG
	1DzbHMBDbTHxywLmxfCKIjtG87q7XEOy3NGG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A5BdFUssNAoxV4ZbRdwkCiRiKOM9EjGj
	vRwJwv5sdTDceiCTMONcLr5ybham76mAMoOZqH3H2vM8GqJiX9k7fF/Ci7bXA7qc
	A9jrOivadqk87is8hWFda8I75yHI1yGIv3+MXTlA/Tijbavy6JLAWM/h30MFVoN7
	esPgMI2Rj3c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E510723433;
	Fri, 13 Feb 2015 14:12:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDEE823432;
	Fri, 13 Feb 2015 14:12:11 -0500 (EST)
In-Reply-To: <CAGZ79kYRi3KYcvNQbkhP0uLFgpJzD+h=P+smOLQy2Msv0C_1kw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 13 Feb 2015 10:32:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 369FBFE4-B3B4-11E4-A2F7-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263821>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Feb 13, 2015 at 10:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Fri, Feb 13, 2015 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> We convinced ourselves that not locking the symref is wrong, but
>>>> have we actually convinced us that not locking the underlying ref,
>>>> as long as we have a lock on the symref, is safe?
>>>>
>>>> To protect you, the holder of a lock on refs/remotes/origin/HEAD
>>>> that happens to point at refs/remotes/origin/next, from somebody who
>>>> is updating the underlying refs/remotes/origin/next directly without
>>>> going through the symbolic ref (e.g. receive-pack), wouldn't the
>>>> other party need to find any and all symbolic refs that point at the
>>>> underlying ref and take locks on them?
>>>
>>> As we're just modifying the ref log of HEAD in this case, we don't bother
>>> with where the HEAD points to. The other party may change
>>> refs/remotes/origin/next without us noticing, but we don't care here as
>>> all we do is rewriting the ref log for HEAD.
>>>
>>> If the other party were to modify HEAD (point it to some other branch, or
>>> forward the branch pointed to), they'd be expected to lock HEAD and
>>> would fail as we have the lock?
>>
>> I was not talking about HEAD in what you are responding to, though.
>> Don't we maintain a reflog on refs/remotes/origin/HEAD?  Is it OK to
>> allow its entries to become inconsistent with the underlying ref?
>
> Yes we do have a HEAD ref log, and that ref log would differ from
> the underlying ref log. I don't know if that is desired, but I
> would tend to not like it.

HEAD (or refs/remotes/origin/HEAD) reflog and reflog for
refs/heads/master (or refs/remotes/origin/next) would have to be
different as long as we allow symbolic refs to be repointed to
different refs.  If HEAD refers to 'next' today, and at the tip of
next sits commit X, the reflog for both of them would record the
fact that they were pointing at X.  If you repoint HEAD to point at
'master' (e.g. "git checkout master") whose tip is at commit Y, then
reflog for HEAD would record the fact that now HEAD points at Y, and
reflogs for 'master' or 'next' would not change merely because you
switched where HEAD points at.

And there is anything to like or not to like about it.

As we are trying to see a way to move forward to do the right thing
around reflog, I was wondering if locking only the symbolic ref is a
sensible endgame.  "The right thing" being:

   When a symbolic ref S points at underlying ref R, and if R's tip
   changes from X to Y, we would want to know from the reflog of S
   that S used to point at X and then changed to point at Y.

Replace S and R with either (HEAD, refs/heads/master) or
(refs/remotes/origin/HEAD, refs/remotes/origin/next) in the above
and we want both to be true.

How best to achieve that, and what is the set of right ref(s) to
take lock(s) on?  I am not very much interested in how incorrect
today's code might behave.  That is not the central point when
discussing what is the best way forward.

> So the other party updating the underlying ref would also need to lock
> HEAD then,

Yes, that is what I meant.  Your "also" can be read in two different
ways ("other party, too" or "HEAD, too"), though, and I think we
want both ;-).  That is why I hinted that it was iffy to state that
we only have to take the lock only on S and not on R, but only as a
workaround to keep older implementation out we take both---once they
get extinct we can get away with by taking a lock only on S.

When pushing to update 'master' and 'next' into a repository whose
'HEAD' points at 'master', we would want to take locks on 'next' (no
question), but is it sensible to take the lock on 'HEAD' and
deliberately leave 'master' unlocked?  Or is it more sensible to
take all locks on the underlying refs involved (i.e. 'next' and
'master') and in addition any symbolic refs that are pointing at
these refs involved (i.e. 'HEAD')?
