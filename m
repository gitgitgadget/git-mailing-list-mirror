From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/5] Refactor pretty_print_commit arguments into a
 struct
Date: Sun, 18 Oct 2009 15:47:44 -0700
Message-ID: <7vaazonwtr.fsf@alter.siamese.dyndns.org>
References: <cover.1255701207.git.trast@student.ethz.ch>
 <9d3d0f0a6126afc86689138adf58ac7a12c43858.1255701207.git.trast@student.ethz.ch> <7vljja7xy8.fsf@alter.siamese.dyndns.org> <200910182051.20461.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 19 00:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzeXt-00081n-IL
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 00:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbZJRWr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 18:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755431AbZJRWr5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 18:47:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbZJRWr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 18:47:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 573097C9D4;
	Sun, 18 Oct 2009 18:48:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=E3PuQ3RVh4GVnFlr/daMnUW38ds=; b=ij7lQUvewBGJjmRaaT9Xg2l
	OP+oCkTbDBeRYEcAa/lRY2iYCPhoWp6ryNZ1ngS2GmxZlYqOR6dHy+I5JuPeS+DX
	YcriNADiEtYGR/jGbp1v8s9DNVj3un+eVPZgcLngheVWoErJH1QK24R85zmBQ0ED
	4dB9SYbFdLCwrsGU1ogI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=P+a6gNJuvEYEWbNJaxvnKm+4ull4jFXehTwb/UfZMxbl+wsbU
	o5Axh3+/dh/0R7uW8Vo8te4UHGlkPCxwbHqNQABGGg5ZN/MPFMj6APOXdiQE548j
	wdpNh6BwNIHwnja4rbmbq1BFm2kHyANOi49JEPUpZgzbIk+QxFlYgO9KX4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 103EF7C9D3;
	Sun, 18 Oct 2009 18:47:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D1D6E7C9D2; Sun, 18 Oct 2009
 18:47:45 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 46D4B76C-BC38-11DE-A6EA-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130617>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> The existing calls to format_commit_message() often take DATE_NORMAL to
>> its "enum date_mode dmode" argument, and you replaced it with a pointer to
>> a struct.  DATE_NORMAL happens to be "0" and the compiler does not catch
>> calls you forgot to convert in this patch.
>
> Hmph, that's embarrassing.  Apparently I was way too focused on
> pretty_print_commit...

This is nothing to be embarrassed about.  I did not notice it when I
queued the series either, and I noticed it only when I tried to look at
interactions with js/diff-verbose-submodule topic(the other series does
not hardcode the style to be DATE_NORMAL).

One solution to help the compiler catch this kind of semantic crash upon
merging or applying code based on the old format_commit_message() would
have been to change its function signature (or even the name), so that it
would not go unnoticed that DATE_NORMAL that happens to be "0" is silently
interpreted as (void *)0 == NULL.
