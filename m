From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4.1 09/12] sequencer.c: teach append_signoff to avoid
 adding a duplicate newline
Date: Thu, 21 Feb 2013 13:27:16 -0800
Message-ID: <7vobfdtl1n.fsf@alter.siamese.dyndns.org>
References: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
 <1360665222-3166-1-git-send-email-drafnel@gmail.com>
 <7vip5lv6tv.fsf@alter.siamese.dyndns.org>
 <CA+sFfMcNWvPKuQpNWnacegbfgN0ZP=zfuDPDRkXs1G2FMrb+iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 22:27:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8dg9-0003Fx-QM
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 22:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766Ab3BUV1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 16:27:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753709Ab3BUV1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 16:27:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9583EB057;
	Thu, 21 Feb 2013 16:27:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sbbyJ4MOssyaOQy3/74l1ayqDBw=; b=MT8SPw
	SATuReU4p26PmxKzEt6KIEaqIZfjPX104ABNErS3pbXoj76EiuziPdCzw7vuOMkS
	m2YqL07mwJzw9uXAs1Q6pOmNjg+WXdeUTVAZMxUKizr9PEcSm/pqmR8duUCtmFUM
	knILjW9vcPSbFpZY+PhU9R9I0l5POl+Y+E8xI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hHiRNk6+GxeD99FFYDbl8XYoPDYVAfSk
	P2Ew9h5lBxsiK467Y4Avk6iKCP0W9ar8usbGWdw/NcIGFhDYhs0VJCVXYaOHNOdf
	s3MzIQQtiArGq3Y5qj3ihcq3CTR0mKeDgKZ0o8H5BSAlvUZ9xBa8uxiMKGqLMZdr
	Eb44RIumK1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 893ADB043;
	Thu, 21 Feb 2013 16:27:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E63B5B031; Thu, 21 Feb 2013
 16:27:17 -0500 (EST)
In-Reply-To: <CA+sFfMcNWvPKuQpNWnacegbfgN0ZP=zfuDPDRkXs1G2FMrb+iA@mail.gmail.com> (Brandon
 Casey's message of "Thu, 21 Feb 2013 12:26:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77E82926-7C6D-11E2-B8D8-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216799>

Brandon Casey <drafnel@gmail.com> writes:

> Yes.  The fix described by John Keeping restores the above behavior
> for 'commit -s'.  Or the fix I described which inserts two preceding
> newlines so it looks like this:
>
>    ----------------------------------------------------------------
>
>
>    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>    ----------------------------------------------------------------
>
> So then the cursor would be placed on the first line and a space would
> separate it from the sob which is arguably a better indication to the
> user that a blank line should separate the commit message body from
> the sob.

That sounds like an improvement to me.

> But, this does not fix the same problem for 'cherry-pick --edit -s'
> when used to cherry-pick a commit without a sob. ...
> Using 'cherry-pick --edit -s' to cherry-pick a commit with an empty
> commit message is going to be a pretty rare corner case....

We actively discourage an empty commit message by requiring users to
say "commit --allow-empty-message".  I think it is in line with the
philosophy for a Porcelain command "git cherry-pick -s" to punish
users by making them work harder to use a commit with an empty
message ;-).
