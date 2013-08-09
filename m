From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 09 Aug 2013 16:39:03 -0700
Message-ID: <7vmwoq304o.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	<CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
	<7v7gfu4ikb.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Ky2AkEt-XS_nAo=_RrPXSVAL=8cGiMuJabw0=BRU0Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 01:39:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7wH4-0001Md-7d
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 01:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031637Ab3HIXjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 19:39:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031614Ab3HIXjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 19:39:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4499D37627;
	Fri,  9 Aug 2013 23:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=data0aLRy6El2lSAwNAJvVq+8CQ=; b=TlPHsm
	8PuzAxySBD5u8avyBneRjIAXfX9aIksTgmn+VSrURVUgMVXujlRcReffwS66Tzk8
	NiO8Hmtcpst8zk75jqorKD3ilPGQgJVmtToH5PArUQqv8kb1rmwekoTuXVySbDaZ
	dttPHhBxjXJoQwtVa4BDRUhYoH62nzNhWnwv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CXLQiGB1ybt1exXslsFS1A0ucOm0yJdA
	O++x9jiSXN4O2hpEZVRH++eAzSyKG34po58hgRBS2dgA8nb6nSHPDyBaIw+Rpx4M
	BJ4ESJX40RaILWiQwG/dUgshk6ptC1n4TYlBmdxXEyfngu8KN1ZKnzU3p62mp5sw
	3BsD/q6FbsU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AD5E37626;
	Fri,  9 Aug 2013 23:39:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8174537625;
	Fri,  9 Aug 2013 23:39:04 +0000 (UTC)
In-Reply-To: <CAMP44s1Ky2AkEt-XS_nAo=_RrPXSVAL=8cGiMuJabw0=BRU0Dw@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 9 Aug 2013 17:28:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0699BE2-014C-11E3-913B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232055>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Aug 9, 2013 at 5:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> OK, I think I see why you are puzzled.
>>>>
>>>> Cloning works fine because we "fix the path" *after* the clone is done
>>>> successfully, for the following reason:
>>>
>>> So if we didn't store a different path, it would work. So instead of
>>> expanding '~' ourselves, it would be better to don't expand anything,
>>> and leave it as it is, but how to detect that in fix_path()?
>>
>> I think that the patch relies on that os.path.expanduser(), if
>> url.path is such a path that begins with "~" (or "~whom"), returns
>> an absolute path.  When given an absolute path, or "~whom/path",
>> fix_path returns without running 'git config' on remote.<alias>.url
>> configuration.
>
> I think ~whom/path would run 'git config'.

Hmph, do you mean the third example of this?

        $ python
        >>> import os
        >>> os.path.expanduser("~/repo")
        '/home/junio/repo'
        >>> os.path.expanduser("~junio/repo")
        '/home/junio/repo'
        >>> os.path.expanduser("~felipe/repo")
        '~felipe/repo'

which will give "~felipe/repo" that is _not_ an absolute repository
because no such user exists on this box?

It is true that in that case fix_path() will not return early and
will throw a bogus path at "git config", but if the "~whom" does not
resolve to an existing home directory of a user, I am not sure what
we can do better than what Antoine's patch does.
