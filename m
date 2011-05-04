From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] diff: introduce --stat-lines to limit the stat
 lines
Date: Tue, 03 May 2011 21:37:04 -0700
Message-ID: <7vvcxrf5e7.fsf@alter.siamese.dyndns.org>
References: <7vmxj6s22r.fsf@alter.siamese.dyndns.org>
 <102e117f7a9f7fd6e652f23d5630db973e8e52b8.1304419588.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 04 06:37:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHTpy-00080a-26
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 06:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364Ab1EDEhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 00:37:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab1EDEhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 00:37:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2DEB5D31;
	Wed,  4 May 2011 00:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fv6R+6w1ztrmOd0FfMjAySKfqjc=; b=Zd8Rf1
	uOYT/rYpuEBbQdEb/RFaqGLs+o3QcdnVk/54SbFyeuiq//0V/yd8PwajIiN9kvuC
	D3Usl727Zx+sDhxN0G3MIwkTb5IUIJXTslvTO72qmM7L46x0/Ut8+c00GmakPMjY
	ZHHOY0a2wdKyYq8yDkNw2RP9Pxp5JUKjqQcKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jsSlJOPMs8KkgCg4ap112CSNoxA9R9TA
	a2sU4UdpmaquS4B6s6+WOkGSPKW6AsHJ1K4LZBCTlWf54oIXLiVXt5ueE6TLrvFs
	rHiVPGKwjC1Zznp7PB22jOSmRBeg44sub82mGF6L8IMTzTq3UAeI6IYzpLIti9nB
	c1jsfU6z9q4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D20F5D30;
	Wed,  4 May 2011 00:39:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A790B5D2E; Wed,  4 May 2011
 00:39:10 -0400 (EDT)
In-Reply-To: <102e117f7a9f7fd6e652f23d5630db973e8e52b8.1304419588.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 3 May 2011 12:46:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76212E8E-7608-11E0-9FD0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172714>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> @@ -1302,7 +1304,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	else
>  		width = max_change;
>  
> -	for (i = 0; i < data->nr; i++) {
> +	for (i = 0; i < count; i++) {
>  		const char *prefix = "";
>  		char *name = data->files[i]->print_name;
>  		uintmax_t added = data->files[i]->added;

This first loop can omit a "struct diffstat_file" that is not a rename and
does not add nor delete any lines (look for "total_files--"), but you do
not seem to compensate for it. If you have such a record in the earlier
part of the result for whatever reason, you would end up showing fewer
entries than what "count" indicates in this loop.
