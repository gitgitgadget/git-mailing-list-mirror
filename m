From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv10 08/11] Notes API: get_note(): Return the note
 annotating the given object
Date: Mon, 07 Dec 2009 12:52:18 -0800
Message-ID: <7vk4wy1p8d.fsf@alter.siamese.dyndns.org>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
 <1260185254-1523-9-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHkZT-0002rn-NN
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935268AbZLGUwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbZLGUwX
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:52:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbZLGUwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:52:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41F5E86AB4;
	Mon,  7 Dec 2009 15:52:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y2dfzXrWzgHQP9KUWp/iq5e5uV8=; b=Tx5jju
	LeDHkJOIpSB2wCQMOSC5Kxh52D2ngnM/KSRml7eSMGS4AfqxZtJE0/JXkci+6/Ih
	3HBmegIVcdNelWXkM1XEb5AJmCeHcthJMmnTpJ23mqT2NxvdgH99vn05S0n8wyjp
	cdDng2XzYLdh2GPDUAAJykPnlCYLu7JIwl8M4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D6D05Am5XextOYiGluMIXWUzRXRaa+Zk
	aiOpSEcZS9henJeVcTmtdkBnQGZywhpkl/dKG4/vQW9yWfVrH0Y81VV6z5b+ZjF5
	EbPre4i/yeKLPzbllS/hnYMdfh8Y8O+rxGbwtd90vamepX9e43DQ/jVGWF8Px3tU
	Cx0usw6E5vE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C0386AB3;
	Mon,  7 Dec 2009 15:52:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 166CD86AB2; Mon,  7 Dec
 2009 15:52:19 -0500 (EST)
In-Reply-To: <1260185254-1523-9-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon\, 07 Dec 2009 12\:27\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B93B768-E372-11DE-A8B6-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134783>

Johan Herland <johan@herland.net> writes:

> Created by a simple cleanup and rename of lookup_notes().
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  notes.c |   15 ++++++++-------
>  notes.h |    3 +++
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/notes.c b/notes.c
> index 79bfa24..110404a 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -379,12 +379,13 @@ void add_note(const unsigned char *object_sha1, const unsigned char *note_sha1)
>  	note_tree_insert(&root_node, 0, l, PTR_TYPE_NOTE);
>  }
>  
> -static unsigned char *lookup_notes(const unsigned char *object_sha1)
> +const unsigned char *get_note(const unsigned char *object_sha1)

Is there a need to find "note for this commit in the set of notes 3 days
ago"?  IOW, reading note for the given commit not from the tip of the
history of the refs/notes/commits but from say refs/notes/commits~4?
Similarly, is there a need to ask for a history of notes for a given
commit, something like "git log refs/notes/commit/$this_commit" in a world
without any fanout?

Obviously, "there is no need because..." is the best answer I'd be happy
with.  "There may be in the future but we haven't identified a good use
case and we don't implement what we do not need now." is also perfectly
acceptable.

IOW, I am not suggesting to change it---I just want to know how much
thought went in before deciding to implement the interface this way.
