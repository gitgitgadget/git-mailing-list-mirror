From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Fix %config_path_settings handling
Date: Fri, 14 Oct 2011 12:26:43 -0700
Message-ID: <7vbotjz85o.fsf@alter.siamese.dyndns.org>
References: <4E982B27.8050807@drmicha.warpmail.net>
 <201110141838.19118.jnareb@gmail.com>
 <7vwrc7zbk2.fsf@alter.siamese.dyndns.org>
 <201110142049.32734.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Cord Seele <cowose@gmail.com>,
	Cord Seele <cowose@googlemail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 21:26:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REnP9-0003HJ-5a
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 21:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab1JNT0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 15:26:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731Ab1JNT0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 15:26:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2ACF6387;
	Fri, 14 Oct 2011 15:26:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y8NG+6yBN2f/6Rpk48+AdLxAWkg=; b=ocFcho
	C667VDgqv3KP4GU5eqa4MPGiql4gjHHJH67g48rh53oq6GJ8/pm2HzdD0yHcdolM
	SlBv1MC2nNHvcsK7aeT+JxID4QiQwjMHingFEh7VrvkjC2b4Bo+1cTqQBDJiBQrg
	YePYdg/zqbEB2/jAEq+7y+oCyCer9ADhAI9xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XwVkYeK2xCeKRaWzUz0d18yer04rM5Og
	lwYCJVoZ2dC1WmLE/bPEs3by/VWAAdSwRQHduTXizUF2ECLktCaLM44gLjauKDrU
	9NyMXshN0HhEgOdLA6lpfkycRAdOvYF/944gOC6hQsnpM3RY8DspY4r0dpDL8KWt
	gtucxOATp1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA5BE6386;
	Fri, 14 Oct 2011 15:26:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 361A16385; Fri, 14 Oct 2011
 15:26:45 -0400 (EDT)
In-Reply-To: <201110142049.32734.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 14 Oct 2011 20:49:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73FFCED6-F69A-11E0-B95A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183603>

Jakub Narebski <jnareb@gmail.com> writes:

> From: Cord Seele <cowose@gmail.com>
>    value... which admittedly is a bit cryptic.  More readable if more
>    verbose option would be to use hash reference, e.g.:
>
>         my %config_bool_settings = (
>             "thread" => { variable => \$thread, default => 1},
>             [...]
>
>    Or something like that.

Do you really want to leave this "Or something like that" here?

> 3. 994d6c6 (send-email: address expansion for common mailers, 2006-05-14)
>    didn't add test for alias expansion to t9001-send-email.sh

I was hoping that an updated patch to have a new test or two here...

> Signed-off-by: Cord Seele <cowose@gmail.com>
> Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Is this the version tested by Michael?

> +		my $target = $config_path_settings{$setting};
> +		if (ref($target) eq "ARRAY" && !@$target) {
> +			# multi-valued and not set
> +			my @values = Git::config_path(@repo, "$prefix.$setting");
> +			@$target = @values if (@values && defined $values[0]);
> +		} elsif (!defined $$target) {
> +			# multi-valued and not set
> +			$$target = Git::config_path(@repo, "$prefix.$setting");
> +		}

If the target is an array ref and for whatever reason the array is already
populated, wouldn't you check "if (!defined $$target)" with this change?
