From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Mon, 07 Dec 2009 23:28:01 -0800
Message-ID: <7v3a3lorge.fsf@alter.siamese.dyndns.org>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
 <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
 <20091208054724.GA21347@coredump.intra.peff.net>
 <20091208060109.GB9951@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	James Vega <vega.james@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:28:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHuUe-0006tC-PD
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 08:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbZLHH2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 02:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbZLHH2H
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 02:28:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZLHH2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 02:28:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 561EDA4CF0;
	Tue,  8 Dec 2009 02:28:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4x4B7WteUJywnpysVrB11oMpkiE=; b=MqDMe7
	GTqC9patf81BYpYU/fu1MlkNNaWhBbJkZETDoljQUVIaeu1ROk3Dvpj9kukhctUe
	vrWhgKM4vcvnWUQz2PfFB1GmlkTu7S/5Z6pMcykoyJkOLBWB6oBllznpBP1Knusw
	oQeaFzQ07ZQbJsdB/EqULU4808DZ0sy6TvmAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uDcS2iVA32NnAc2YYxciDEqQ2StKNbAB
	0E5nh9fs5AS+qTgSkLozTsYSVrMc67S4AQqKTcUBvSlJVJM2nSUqg2x4ZqTudnlv
	BK7v3SUFixkCHSBh0IQTUkxU+uFDY9VizYXxxHRh7T/8BsBlxR7W3ac16Rsx+i61
	6C0uOiUIDL4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2394EA4CEF;
	Tue,  8 Dec 2009 02:28:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 56610A4CEE; Tue,  8 Dec 2009
 02:28:03 -0500 (EST)
In-Reply-To: <20091208060109.GB9951@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 8 Dec 2009 01\:01\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BE836A2-E3CB-11DE-AD5E-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134829>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 08, 2009 at 12:47:24AM -0500, Jeff King wrote:
>
>> There is a slightly different approach we could take, too: keep the
>> "deletion" hunk as a first-class hunk, and just meld the content hunk's
>> output into it. Then both cases would get the "Stage deletion" question
>> instead of the "Stage this hunk" you get now for non-empty files (which
>> just happens to trigger a deletion due to the headers).
>
> BTW, the code for this is the much smaller change below. If you prefer
> that, I can squash in the test and write up an appropriate commit
> message.

Doubly interesting, as I recall reading "That would take some refactoring,
though, as pulling the deletion hunk"

    ... goes and looks ...

Ah, Ok, the "refactoring" refers to the "header reordering weirdness".

That might be something we may want to fix someday, when we find ourselves
needing to add a feature to turn deletion into non-deletion or vice versa
during "add -p" [e]dit, as I suspect that the "hunk editing" codepath does
not keep track of what the user's patch is doing, to the point that it
does not even know how many lines there are supposed to be in the
resulting hunk that it asks "git apply" to recount.  There is no way to
add/delete "deleted file" line if the logic does not know what the patch
is doing.

But someday is not today.  I think this six-liner is preferable.

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 35f4ef1..02e97b9 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1217,7 +1217,11 @@ sub patch_update_file {
>  	if (@{$mode->{TEXT}}) {
>  		unshift @hunk, $mode;
>  	}
> -	if (@{$deletion->{TEXT}} && !@hunk) {
> +	if (@{$deletion->{TEXT}}) {
> +		foreach my $hunk (@hunk) {
> +			push @{$deletion->{TEXT}}, @{$hunk->{TEXT}};
> +			push @{$deletion->{DISPLAY}}, @{$hunk->{DISPLAY}};
> +		}
>  		@hunk = ($deletion);
>  	}
>  
