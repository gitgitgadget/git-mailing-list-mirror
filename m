From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] Teach --dirstat to not completely ignore
 rearranged lines within a file
Date: Mon, 11 Apr 2011 14:38:59 -0700
Message-ID: <7vtye4tqmk.fsf@alter.siamese.dyndns.org>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <1302475732-741-1-git-send-email-johan@herland.net>
 <1302475732-741-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:39:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9OpI-0007ae-PY
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942Ab1DKVjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 17:39:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1DKVjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 17:39:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 072C34BE5;
	Mon, 11 Apr 2011 17:41:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=EderR70UWlD9cRiuCDNhVCpf1iE=; b=Mr4PTrzp1xnPyVwh3oeS
	zAyFMbyrRkBJY2yqv7HTD9ILnbXOPWqXIQbD6kw468tSrU5nAsYexqKV0Q5fSnJq
	umdEf4A9Q5VWIKTH5k3K6nch1NDxQwJbPCX0ZyNr6ooh5V9+N0hPYorNqOH5qD8G
	3FZSuzxEuzk352gNFfc9oNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=I1Uf9RLNmFwkNHtwT0hXLya9IZfLu6lZeVqEyQL1PmYkUO
	ja5Czp6t/nEUx/ZQWS7hEhObfK818p4EVHKnogDJ2/9B/B4Hm+TmcgjKx5O/JFUl
	DOQx6M3WgU/r7rFNeZ5Q0almtMu0UCEqyFyD9AV6w1PKtvhdBQjaHhWpIvGPo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A19EE4BE0;
	Mon, 11 Apr 2011 17:41:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 25B034BDC; Mon, 11 Apr 2011
 17:40:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 664B9D9A-6484-11E0-B259-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171360>

Johan Herland <johan@herland.net> writes:

> Currently, the --dirstat analysis fails to detect when lines within a
> file are rearranged, because the "damage" calculated by show_dirstat()
> is 0. However, if the SHA1 sum has changed, we already now that there
> should be at least some minimum amount of damage.

This logic is sensible, modulo that "fails to detect" is actually "ignores
mere line movements on purpose".

In any case, if the object names are different, we already know that there
is _some_ damage, and it is very unintiutive to claim that there is _no_
damage.

> This patch teaches show_dirstat() to assign a minimum amount of damage
> (== 1) to entries for which the analysis otherwise yields zero damage.

So it is perfectly in line with the above logic to give a minimum here.
Zero was simply just unintuitive, and this is a good fix to the problem.

> Obviously this is not a complete fix, but it's at least better to

I however do not understand what "a complete fix" means in this context.
You've fixed the unintuitiveness, and as far as the description in the
introductory paragraph of the problem goes, I think this already is a
complete fix.
