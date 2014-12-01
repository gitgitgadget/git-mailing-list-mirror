From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] introduce git root
Date: Sun, 30 Nov 2014 19:04:04 -0800
Message-ID: <xmqqd284rryz.fsf@gitster.dls.corp.google.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 01 04:04:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvHHc-0008Dk-B3
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 04:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbaLADEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 22:04:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752227AbaLADEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 22:04:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3272423C2B;
	Sun, 30 Nov 2014 22:04:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SmhNULv05XZi14GwVyFNECjU9wg=; b=ZUJIuP
	oohQ4snR3LhOgZ4vQPC+1kinqziAmsZyIbixEXc7ld2s/+GV48+fIQ+37KVmbXo+
	jTj/7KyJYYN2Woj8OrGy7tabvUfsF3WaKl1SHYgR/tN8APERQtDAXGGmweagVgVV
	fY2nD1yGe7jHXwJEoHntu+ZebcVBcG/a2inYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pHWQRLRhF/99bbmwewvHpvBIkCfuTBrm
	ZQKxS25287NBrDuqpdG28NVsuBiKQqFTQVRYUnmm6mFKTl83n/gZDS1uuNFXCVR+
	7K2UHyl4E5zkMCxOnGVUY/4Y0/ZU2n+i0t94+0xyudCLOSYpo5Me9YBdt7DjkoWh
	VkyXGkRxphg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 295EC23C2A;
	Sun, 30 Nov 2014 22:04:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9ABD823C27;
	Sun, 30 Nov 2014 22:04:05 -0500 (EST)
In-Reply-To: <vpqoaro99xd.fsf@anie.imag.fr> (Matthieu Moy's message of "Sun,
	30 Nov 2014 12:58:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5E5802E-7906-11E4-8C43-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260464>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> ... git rev-parse --show-toplevel is not just long,
> it's just not the place where people would look for (it's neither about
> revision nor about parsing, so clearly, "rev-parse" is not a good place
> to host the feature in the UI).

For the record, "rev-parse" is not about revisions in the first
place.  It started purely as a helper to implement "git log" in
terms of "git rev-list" piped to "git diff-tree --stdin", which
requires you to sift a command line argument list given to such
a scripted "git log" into those to be passed to "rev-list" (i.e.
primarily revision ranges) and those to be passed to "diff-tree"
(i.e. primarily diff options and pathspecs).

Various subcommands "rev-parse" takes such as --show-git-dir were
added only because there wasn't any single best "kitchen sink"
command to tuck such a small feature that do not deserve a
standalone command (e.g. "git root", which makes it sound as if the
top-level of the working tree is the most important thing in the
world, and adding other useful things such as --show-prefix to it,
while it would make sense to have them there from the implementation
point of view, would be hard to justify against the connotation the
word "root" gives us), and we happened to pick "rev-parse" as a
"kitchen sink" place, which is not better or worse as anything else.

If I were redoing this today, I would probably nominate the "git"
potty as such a "kitchen synk" command.  We have "--man-path" that
shows the location of the manual pages, "--exec-path[=path]" that
either shows or allows us to override the path to the subcommands,
and "--show-prefix", "--show-toplevel", and friends may feel quite
at home there.
