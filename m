From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: make "git describe" output clickable, too
Date: Mon, 12 Dec 2011 11:48:55 -0800
Message-ID: <7v62hl4llk.fsf@alter.siamese.dyndns.org>
References: <87mxb0foqe.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jim Meyering <jim@meyering.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 12 20:49:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaBs3-0000gu-4Q
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 20:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968Ab1LLTtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:49:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37799 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab1LLTs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:48:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DC195E40;
	Mon, 12 Dec 2011 14:48:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yTXriV+3iWPstnkxx5h6pTJrtbg=; b=n83/Gc
	Kt8fbcviGVwYksRIWD7kisX8dZWYntXstkSdtO8jgHuX4sbuzVvwbG0/R+Qh4KWL
	6LYc3efquGpynSZVIjHFAskGtvt/ZpWvTaD9DlMc/XbgVSPLW4T5WPOhF4aVArpo
	f5vf23ARnDo41xauivySTmS+nRta/WBGWKBfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UskRkw/rX7rrekSsjv4W3UUk7J8WAD5o
	rdNJywjAw8b+XPgGabbGSfQgTmwzn6uzg4ecK2WWLYxXqcUIpqxpsUoh14thgmmM
	j0uKCYFsOMRMohJkEsw1mGutyprky9pIFINeOR4p5/q1KoveVmY8oHGZBx+F3Nf4
	oVC8BosJ/p0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 754515E3F;
	Mon, 12 Dec 2011 14:48:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDAA85E3C; Mon, 12 Dec 2011
 14:48:56 -0500 (EST)
In-Reply-To: <87mxb0foqe.fsf@rho.meyering.net> (Jim Meyering's message of
 "Sat, 10 Dec 2011 16:08:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5412D01C-24FA-11E1-9A69-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186938>

Jim Meyering <jim@meyering.net> writes:

> I noticed that automake's contribution guidelines suggest using
> "git describe" output in commit logs to reference previous commits.
> By contrast, in coreutils, I had acquired the habit of using a bare SHA1
> prefix (8 hex digits), since gitk creates clickable links for that, and
> not for "git describe" output.
>
> I prefer the readability of the full "git describe" output, yet want to
> retain the gitk links, so wrote the following that renders as clickable
> not just SHA1-like strings, but also an SHA1-like string that is
> prefixed by "-g".
>
> Signed-off-by: Jim Meyering <meyering@redhat.com>
> ---
> This is relative to master.
> Think of this as mere proof-of-concept:

Paul, I think this makes tons of sense. Comments?

> Ideally, the string preceding the -g would be used to disambiguate
> the SHA1 prefix, but that would require more code.
>
> I confess that I haven't looked to see if documentation needs
> to be updated or if this would merit test suite additions.
>
>  gitk-git/gitk |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 4cde0c4..f8eb613 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -6688,7 +6688,7 @@ proc appendwithlinks {text tags} {
>
>      set start [$ctext index "end - 1c"]
>      $ctext insert end $text $tags
> -    set links [regexp -indices -all -inline {\m[0-9a-f]{6,40}\M} $text]
> +    set links [regexp -indices -all -inline {(?:\m|-g)[0-9a-f]{6,40}\M} $text]
>      foreach l $links {
>  	set s [lindex $l 0]
>  	set e [lindex $l 1]
> @@ -6704,6 +6704,10 @@ proc appendwithlinks {text tags} {
>  proc setlink {id lk} {
>      global curview ctext pendinglinks
>
> +    if {[string range $id 0 1] eq "-g"} {
> +      set id [string range $id 2 end]
> +    }
> +
>      set known 0
>      if {[string length $id] < 40} {
>  	set matches [longid $id]
> --
> 1.7.8.163.g9859a
