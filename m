From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] status: display "doing what" information in git
 status
Date: Thu, 05 May 2011 16:37:00 -0700
Message-ID: <7vbozg67oj.fsf@alter.siamese.dyndns.org>
References: <1304632126-16733-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 06 01:37:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI86h-0006iQ-Vg
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 01:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab1EEXhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 19:37:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab1EEXhK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 19:37:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3706941F4;
	Thu,  5 May 2011 19:39:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7ByX4E0XhVZbSQuEVLBBn1CLptg=; b=VmCgeA
	sojMEGq/wNA32MPaMc0AGjybmSVmBIxJlN+/EomWAQp86NLPIenC+idw7fL4V9mO
	hjwbkxS6M/r+N+yxmFZKUkomTpXctkx/XYqodKHlRd+KfsCIDwNIpeNCAF3mChkt
	15w2CmX8AleMPWl9ItmmzC6ipOIkD5Nq3lsgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BdBPrEKQIPLHwrBXnsk64QRhAewMrsIQ
	YJbXF8FkvdzZajvThQ4MbYenpurm+zug+DjqAt7K7KOwLynkFaGYC1NVIAG6p+fa
	C6pBI+J3Ig4Cg9gNi7pUfNSrhqmzbzEHS8ap3bY0AsZBetrWtsOm5DHYjnKzk6tK
	8hAMxRceCko=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 145F741F0;
	Thu,  5 May 2011 19:39:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E9E9441E5; Thu,  5 May 2011
 19:39:05 -0400 (EDT)
In-Reply-To: <1304632126-16733-1-git-send-email-madcoder@debian.org> (Pierre
 Habouzit's message of "Thu, 5 May 2011 23:48:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E009AF9C-7770-11E0-82E1-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172925>

Pierre Habouzit <madcoder@debian.org> writes:

> @@ -732,6 +805,7 @@ void wt_status_print(struct wt_status *s)
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
>  	}
>  
> +	wt_status_print_doingwhat(s);
>  	wt_status_print_updated(s);
>  	wt_status_print_unmerged(s);
>  	wt_status_print_changed(s);

I am very surprised that a new call to this function is added here.

As the "You are in middle of" information is useful mostly when you are on
detached head, I would have expected that the call would be inside the
if/elif chain near the top of wt_status_print() where we say "On branch"
vs "Not currently on...", to replace that information that comes from that
on_what variable.
