From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/1] Support updating working trees when pushing into non-bare repos
Date: Thu, 13 Nov 2014 11:11:41 -0800
Message-ID: <xmqqd28q29w2.fsf@gitster.dls.corp.google.com>
References: <cover.1415629053.git.johannes.schindelin@gmx.de>
	<cover.1415876330.git.johannes.schindelin@gmx.de>
	<xmqqbnob2ds7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 20:12:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XozoG-0005kN-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 20:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbaKMTL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 14:11:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754035AbaKMTL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 14:11:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E0411D1A9;
	Thu, 13 Nov 2014 14:11:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nkpRoN8bYR36K7F58zEe8LyLxH0=; b=niGt0d
	pfPESFJEEE92g7PVDyAtzboyI0see8j9acD7tw8EeHRJJumSlN8ZVSWGMG/mNWqg
	J58SLvjGkm9YlVol3Fe1pnqyszPJZwN9KYMxcADwHH0STBxVij5DHVB/AnJ1iwPh
	92me9dex/NjVfIfkfAant0b7Y3tHBGnxC4izQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TyZ//AA4KDRpxQuXMkgaSAy1MZT27J4n
	TsfDXrnMfmbncq9vUGnJmoiKGjSifUgtFQdAopPtLIAhDSC2wVGG2jB68+SMTKbJ
	dGH20ZFUu1DLCS0p1F0Y1kbtseBBWlaW37xftzucRinYSzjNfcdfuru4i5KyS5Kq
	J+4OLnoesM4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F41D21D1A8;
	Thu, 13 Nov 2014 14:11:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C6521D19B;
	Thu, 13 Nov 2014 14:11:42 -0500 (EST)
In-Reply-To: <xmqqbnob2ds7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 13 Nov 2014 09:47:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E6DC283C-6B68-11E4-B7C5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -static const char *merge_worktree(unsigned char *sha1)
>> +static const char *update_worktree(unsigned char *sha1)
>>  {
>>  	const char *update_refresh[] = {
>>  		"update-index", "--ignore-submodules", "--refresh", NULL
>>  	};
>> +	const char *diff_index[] = {
>> +		"diff-index", "--quiet", "--cached", "--ignore-submodules",
>> +		"HEAD", "--", NULL
>> +	};
>>  	const char *read_tree[] = {
>>  		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
>>  	};
>
> OK.
>
> "update-index --refresh && diff-files && diff-index --cached" is how
> we traditionally ensure the working tree is absolutely clean (see
> require_clean_work_tree in git-sh-setup.sh), but I do not think of a
> reason why diff-files step is not redundant.  As a totally separate
> topic outside this series, we may want to visit that shell function.

Ahh, scratch that.  Over there we use 'update-index -q --refresh',
so the difference between the index and the working tree is not
noticed and we do need diff-files.  Here, the code runs update-index
without -q, so we do catch such a difference without diff-files.

Sorry for the noise ;-)
