From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Wed, 15 Jan 2014 09:49:05 -0800
Message-ID: <xmqqr4892l0u.fsf@gitster.dls.corp.google.com>
References: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
	<CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com>
	<201401141236.44393.mfick@codeaurora.org>
	<CACPiFCLxiCOqv=wLeq9LxisWn5T62hk8xDYwXmeFRNT05HY0iQ@mail.gmail.com>
	<20140115091220.GB14335@sigill.intra.peff.net>
	<CACPiFCKeOYHUb22d_Ea0PcbU-uAn=fVAn0QP1qbLAiNh1KEoqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 18:49:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Uab-0000YL-0R
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 18:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbaAORtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 12:49:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbaAORtM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 12:49:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 142386487C;
	Wed, 15 Jan 2014 12:49:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gqEqIa6OWVLwuvKzelkh8Bb4Keg=; b=pdP9rx
	C2QsDn1yOztJxfywd7LKicA0eZNRzmGZEBEGb2bciJCiTp9SYNVwnKhHVYJ4qGUF
	55WDDBE0rRIWYry5M11D/F9Pb5J62rFzGmkfcWxiYtmZnSwco+2DbkxQl+1Wtfmm
	HmHVbkNbBijgZYNUlYfIwdekj+UYvJ9eAs1jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ejAG4lUz3fWKouVq0W/6FdbWYluIqPU1
	aqz8REeASbEFdWhvbTJNxYPpn+FjlyteFy2oWn6fsE4BhNPevRelsIOeTIPNRmhz
	Gqq5osL+lrqwHRmZjdLcdwrI030uu6S8MfAnkH3P+1DJE9Y1WAwmFVW2P6Y1/Yn/
	n7ksynA08/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CB746487A;
	Wed, 15 Jan 2014 12:49:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3A0E64876;
	Wed, 15 Jan 2014 12:49:08 -0500 (EST)
In-Reply-To: <CACPiFCKeOYHUb22d_Ea0PcbU-uAn=fVAn0QP1qbLAiNh1KEoqQ@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 15 Jan 2014 08:42:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 55AA12FA-7E0D-11E3-A432-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240473>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Wed, Jan 15, 2014 at 4:12 AM, Jeff King <peff@peff.net> wrote:
>> We see these occasionally at GitHub, too. I haven't yet figured out a
>> definite cause, though whatever it is, it's relatively rare.
>
> Do you have a cleanup script to safely get rid of stale .keep and
> .lock files? I wonder what other stale bits merit a cleanup...

As long as we can reliably determine that it is safe to do so
without risking races, automatically cleaning .lock files is a good
thing to do.

Cleaning .keep files needs the same care and a bit more, though.
You of course have to be sure that no other concurrent process is in
the middle of doing something, but you also need to be sure that the
".keep" file is not a marker created by the end user to say "keep
this pack, do not subject its contents to repacking" after a careful
repacking of the stable part of the history.
