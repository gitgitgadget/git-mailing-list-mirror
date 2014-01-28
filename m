From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] diff: turn skip_stat_unmatch on selectively
Date: Tue, 28 Jan 2014 14:51:45 -0800
Message-ID: <xmqq7g9jlny6.fsf@gitster.dls.corp.google.com>
References: <1390632411-3596-3-git-send-email-pclouds@gmail.com>
	<1390863568-22656-1-git-send-email-pclouds@gmail.com>
	<xmqqd2jdm1jj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 23:51:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8HVd-0007wU-3M
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 23:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbaA1Wvw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jan 2014 17:51:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755835AbaA1Wvu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jan 2014 17:51:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C18267B1D;
	Tue, 28 Jan 2014 17:51:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aRqusIRWbyfq
	JBve379nWXVyFIg=; b=Dj4SKnisWMyDFtesxPXLNBF4zw3ZElNTA7+ffrmsHn1j
	yDn+dUg5l8xEFXgCk2Ii+7E1s1SIKCihhqIhq/JYmSsLp5BiXulYt3zeonTundpf
	uB/W09Yb8IzOyUKQGwDeWM1Xtu4BMYByBOQiw+AfCEQmm62XQZ0oSu44VV2sz8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MV0Th5
	NM+N804HspSztuivnN4V7f9uvsEgrlHETvPO+vERnev6/FoS2tgqLQDdhZpw8m/+
	aznLVZzuJpsK6DyVu6LofsWDK7hhO5Rz4koi+TTmajd8qVDAqWpExEiC9d0f1pxM
	QtYJu8dBL6dY++InBhVUVHCW9QIGH4VUHSts8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8721767B1C;
	Tue, 28 Jan 2014 17:51:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D68B867B1B;
	Tue, 28 Jan 2014 17:51:47 -0500 (EST)
In-Reply-To: <xmqqd2jdm1jj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Jan 2014 15:45:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C4AFCC7E-886E-11E3-A1F5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241198>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> skip_stat_unmatch flag is added in fb13227 (git-diff: squelch "empty=
"
>> diffs - 2007-08-03) to ignore empty diffs caused by stat-only
>> dirtiness. In some diff case, stat is not involved at all. While
>> the code is written in a way that no expensive I/O is done, we still
>> need to move all file pairs from the old queue to the new queue in
>> diffcore_skip_stat_unmatch().
>>
>> Only enable it when worktree is involved: "diff" and "diff <rev>".
>> This should help track down how skip_stat_unmatch is actually used
>> when bugs occur.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  This replaces 'diff: turn off skip_stat_unmatch on "diff --cached"'
>>  The previous patch obviously leaves skip_stat_unmatch on in "diff
>>  <rev> <rev>" and maybe other cases.
>
> Oops, I lost track.  Sorry.

Together with {1,2}/3 applied on maint-1.8.4, this sems to break
t3417 (there may be others, but I didn't have time to check).
