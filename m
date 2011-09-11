From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] Signed push
Date: Sat, 10 Sep 2011 18:42:58 -0700
Message-ID: <7v4o0jq2fx.fsf@alter.siamese.dyndns.org>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
 <7vipp1otyp.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hWVPCEeJKKccp4Wc-j+XMSFXqRf6VYd7ngLER8RhODRQ@mail.gmail.com>
 <7vehzopdga.fsf@alter.siamese.dyndns.org> <20110910192225.GA5397@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 11 03:43:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2Z4o-0001EG-RB
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 03:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758532Ab1IKBnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 21:43:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756361Ab1IKBnC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 21:43:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6DE350F1;
	Sat, 10 Sep 2011 21:43:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ts1Ff7NLHK8CFYX0F2w6M3yqKM=; b=O0kPVM
	BrsnclS11G13XplvL8BogCuicKG0EevP3Fo0pMFDUuPY3Ic3hk1s+wE+9uae65JF
	RwgdA4YUp+3IcS4GbzUsf24BgkCQkPO9jaHRG/kglnp4Q+wYjIBwK4gWPa33PmBn
	aab+LDH2J81UR8ZiCRD1kc3d6piedW4A2+/gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bxyrp/iBd1vO2dEyL8UfeV96RmBYkY9L
	jwgbtqXrR6WMufeNaNUHxMoIJVaRtG1djKGKJKMomGPge3aZV5xl3fTGTS7ixIFv
	J1hXaWlJ1oevyTYaPf89GXYavMEwTHdrlUAdoUu6vz7B0LmoNPXXlU8jGMlXwSRn
	Qlu0bWSQ+30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D52D50EF;
	Sat, 10 Sep 2011 21:43:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14C5250EE; Sat, 10 Sep 2011
 21:42:59 -0400 (EDT)
In-Reply-To: <20110910192225.GA5397@thunk.org> (Ted Ts'o's message of "Sat,
 10 Sep 2011 15:22:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 619A2B9E-DC17-11E0-9990-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181164>

Ted Ts'o <tytso@mit.edu> writes:

> I guess I'm confused about what the problem is with this?

Yeah, I have to agree.

> If I do something like this:
>
> git tag -s -m for_linus-20110910 for_linus-20110910
> git push github
> git push --tags github
>
> I'm "forcing" the sending side to keep the signed tag, no?

No, you are not forced to _keep_ it. After pushing you can delete it
locally.

The reason your "tag" example is fundamentally different is because a tag
like for_linus_20110910 is a one-shot thing and you can choose to remove
it from your local namespace once you are done pushing. It does not affect
your ability to make another signed tag for_linus_20110911 before pushing
tomorrow.

The point in this round of "signed push" topic is to allow people not tag
every time before they push, making it easier to sign their pushes to
encourage it, so that other people can have a way to verify the commits
near the tip of branches that are not still tagged in between releases.
Instead of contaminating refs/tags/ namespace with daily tags, the idea
was to keep a single "signed-push" notes tree on the receiving end (which
is the distribution point for consumers) that contain the signed record of
pushes.

The original "signed push" (what I called v2) design was for the sender to
prepare the record that goes into the notes tree, but record the notes
tree at the receiving end (this does _not_ prevent the sender from
fetching it back to keep his local copy, but the sender is _not_ required
to do so). It needs updates to both sending and receiving end.

An alternative idea (which I implemented as v3) that came up during the
discussion was to instead have the sender add this record locally to the
signed-push notes tree, and push it out along with the branches. For this
push not to lose _existing_ records of pushes at the receiving end, the
pusher is required to have an up-to-date copy of signed-push notes tree,
and add the new record to it before pushing it out. One upside is that
this does not need updates to receiving end.

I do not know if you read the message Sverre was responding to, but the
"you have to have local copy" requirement has another and potentially
bigger downside (which Sverre did not quote) for people who push out to
multiple places.

Perhaps we shouldn't worry about tag namespace contamination to make
things easier and simpler and stop using notes tree?
