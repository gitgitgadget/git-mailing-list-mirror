From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] sha1_file: fix iterating loose alternate objects
Date: Mon, 02 Feb 2015 11:35:58 -0800
Message-ID: <xmqqoapct8bl.fsf@gitster.dls.corp.google.com>
References: <4727F1DC-2FC3-49BE-8C6D-0C4D7D8B107C@jonathonmah.com>
	<20150202185049.GA27399@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathon Mah <me@jonathonmah.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 20:36:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIMnH-00067k-5v
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 20:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbbBBTgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 14:36:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964815AbbBBTgB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 14:36:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D96E633635;
	Mon,  2 Feb 2015 14:35:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dM4ut7oebCIuKvCX2t+L5BWe/D8=; b=aVdFkn
	pfep9LvecD8YASk/LE7uN43FEaJzIT+8PmSRa4Zwfn4UQH0fQ6+kcdCTto9MDZLh
	9Kkj5QMjpQuz6XdLjNWQAIWyfJx+aQDHl2OM24s9YduPT7tFBstu/2bZ8Mam8hjy
	j0tJpvUBA6P3SlKyWRmhM2POMbu+5uoav3X0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NVe9A/ELGnBHOQmtgz7eeyUDA2xLrVHV
	C31dGJYZUQCgB67cJ0gDZ4+BH6rhIOjvCpXTJECo4RMnDiPBSiKYi7WPEXpJvUE/
	6zcPGnVhI1itWfgTq22JObLT9lEbVJztu2y3a/HQGn6SxblbXflW/WmiY6Jas5tv
	EehV1pUnNwM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD60233634;
	Mon,  2 Feb 2015 14:35:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2999933633;
	Mon,  2 Feb 2015 14:35:59 -0500 (EST)
In-Reply-To: <20150202185049.GA27399@peff.net> (Jeff King's message of "Mon, 2
	Feb 2015 13:50:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B6C48164-AB12-11E4-B2AD-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263279>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 02, 2015 at 10:48:12AM -0800, Jonathon Mah wrote:
>
>> The string in 'base' contains a path suffix to a specific object; when
>> its value is used, the suffix must either be filled (as in
>> stat_sha1_file, open_sha1_file, check_and_freshen_nonlocal) or cleared
>> (as in prepare_packed_git) to avoid junk at the end.  loose_from_alt_odb
>> (introduced in 660c889e46d185dc98ba78963528826728b0a55d) did neither and
>> treated 'base' as a complete path to the "base" object directory,
>> instead of a pointer to the "base" of the full path string.
>> 
>> The trailing path after 'base' is still initialized to NUL, hiding the
>> bug in some common cases.  Additionally the descendent
>> for_each_file_in_obj_subdir function swallows ENOENT, so an error only
>> shows if the alternate's path was last filled with a valid object
>> (where statting /path/to/existing/00/0bjectfile/00 fails).
>> 
>> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
>> ---
>> Squashed test and fix.
>
> Thanks, this version looks good to me.

Thanks, both of you.

The analysis, the fix and the test all look reasonable.
