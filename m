From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Mon, 19 Mar 2012 09:51:22 -0700
Message-ID: <7vk42gbkl1.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
 <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:51:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9fnv-0006Aj-3B
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 17:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162242Ab2CSQvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 12:51:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162230Ab2CSQvY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 12:51:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09CB176BC;
	Mon, 19 Mar 2012 12:51:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h5C8+XtTewwtZC633JbmMb0Cn3E=; b=O/hczO
	xjiU/JWOSy70w5AINvgR9xWVpDPVB9LFVhYQlCf0yXL9EO+mQInoEC7I2XrZwEC+
	Jsou1P8FyDjpv8zUEGum15/05x36Z+qXYjxABiFPVe958b7syWBymhkjEuQCioED
	NnV8lMLeNHMEaDzYJ4jucw4C1lRqcIW19U8kM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sER4enfWG0EL6rMRpxoaQxsYZ3Pc+mYE
	lSgT3lfvNa1D/yn+1qgfp0l88ZzPbTr1HacHlOKOH6ywAsYd/cPEXgWQ83YveXBD
	VGUwOZFDmXJMBRczgj1CSAERnLTtxBEqO+6Ty0f2NSva3iyZHay5i3+Tv51cKKUZ
	KOv6uBVurtc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0A6F76BA;
	Mon, 19 Mar 2012 12:51:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76A1F76B7; Mon, 19 Mar 2012
 12:51:23 -0400 (EDT)
In-Reply-To: <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
 (Andrew Wong's message of "Sun, 18 Mar 2012 17:37:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2A573BE-71E3-11E1-85FD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193440>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> For example, the sequencer current doesn't clean up CHERRY_PICK_HEAD if
> 'commit' failed due to an empty commit. Letting 'rebase -i' deal with
> removing CHERRY_PICK_HEAD keeps the sequencer's logic a bit cleaner.

Hmmm.

Isn't the real solution *not* to create the CHERRY_PICK_HEAD in the
sequencer when it is not know if it is needed, instead of the current code
which seems to create first and then selectively try to unlink() it?
