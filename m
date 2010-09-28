From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] pathspec: add tree_recursive_diff parameter
Date: Mon, 27 Sep 2010 22:28:25 -0700
Message-ID: <7vk4m6v3ly.fsf@alter.siamese.dyndns.org>
References: <1284939000-16907-1-git-send-email-pclouds@gmail.com>
 <1284939000-16907-3-git-send-email-pclouds@gmail.com>
 <7vocbivnfs.fsf@alter.siamese.dyndns.org>
 <AANLkTinZt8kish9L2F-ad_boXByZTUj-BnYTp-vtePk0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 07:28:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Sk8-0005Rr-3Y
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 07:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab0I1F2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 01:28:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170Ab0I1F2i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 01:28:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 527A1D9B12;
	Tue, 28 Sep 2010 01:28:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6jDR7CWy46de
	GKa0AOOOz55YBiA=; b=yKMgfDeqwSsEw1cuJ/inUGNIXtjWk3qR63y2t18BAKVQ
	5dyM2IE8tizI5xlXBSFr06DL3SmjdWTNHBqjx9JXZZjItNPNgD6gHRNmgICEZulH
	4G6w+lv93OeLt3EKZEmHsxKiIc2OtxFSyScGPxcPHaZcpxjC8z8TdSz/pXU1two=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=t+vLaB
	vTEazKfQanY++RSoljNqJV2NoZu/AndqeAZyTSbBM6YVt0TgDegNkic6JMxGalXD
	qUp8OFIFBx7vKlcWBJRi1DvyzKV8gAetVLu2JFH0mjbydX9NhcJALRZdIOiZ/G13
	brShWkP/q3+jom/j33BvrrFy9pTJkMRaNFs0o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FD51D9B11;
	Tue, 28 Sep 2010 01:28:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7946FD9B10; Tue, 28 Sep
 2010 01:28:32 -0400 (EDT)
In-Reply-To: <AANLkTinZt8kish9L2F-ad_boXByZTUj-BnYTp-vtePk0@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 28 Sep 2010 12\:38\:55 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D60D092-CAC1-11DF-88F1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157387>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2010/9/28 Junio C Hamano <gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>> ...
>>>  - If it's recursive diff, directories are just an intermediate ste=
p.
>>>    All path must end with a file name. Thus, directories will be
>>>    unconditionally matched.
>>
>> Hmm, I am not sure what you mean by this.  If the pathspec says a/b*=
/c,
>> you are in "a" and are deciding if you should descend to its subdire=
ctory,
>> then you would surely want to be able to say:
>>
>>  (1) Ah, the subdirectory I am looking at is "bar" and it does match=
 "b*".
>>      It might contain "c"; I should descend into it.
>>
>>  (2) Nope, the subdirectory I am looking at is "frotz" and it can ne=
ver
>>      match "b*", so there is no point recursing into it.
>
> I did not go that far, trying to analyse the pattern. When I wrote
> "immediate step" I was thinking of "*foo" pattern, which effectively
> means descending to any reachable directories because '*' matches
> slashes too. I think that's the worst case.
>
> Anyway I did not know that I could borrow some optimizations from
> pathspec_matches() in builtin/grep.c.

As you noticed, over time we have polished our re-implementations of th=
e
pathspec logic to avoid needlessly descending into subdirectories, and =
the
one in the grep may be the latest incarnation of it.  The logic that us=
es
the path_simplify structure in dir.c may also offer you some inspiratio=
ns.

Note that the worst case will fall out as a natural consequence of doin=
g
the fallback in the dumb and simple way, so you do not have to worry to=
o
much about it ;-)  I would prefer to see the new, consolidated logic to=
 at
least know the easy optimizations we already have.

Thanks.
