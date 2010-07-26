From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug with `export-subst' attribute
Date: Sun, 25 Jul 2010 23:01:57 -0700
Message-ID: <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100725221539.GA21813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 08:02:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdGlY-0000z3-T5
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 08:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab0GZGCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 02:02:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab0GZGCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 02:02:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D774AC7256;
	Mon, 26 Jul 2010 02:02:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fplpMAUFxjl+9Imii2QgpvyHedc=; b=a+rwfQ
	JWpgPE2dO4uL9vEEeUqM1UMAv80M+dfAgCNHPnRsrgdqXYs2Y822ERN8o7eV/d+n
	ilvVHIr50/M7wldpzYPJ5+e4w4T3hs38AADddvvDtGj3TpiS+UIBDix2DWjCCgJT
	8UHa1ebhQ0fGDaWpJZoDF/NPXMqH3PFCukKp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bdEb5gBTVBFazbCoxFSgGSLUFuIvmHf9
	NVXGxrZnNQHA5jCFyoABwsGUEEBhoSfVn4BwDxkC2eT7lpGA1CvCaWSz7L1aWaYH
	qqkB9eVPS+LBsjoNaWlNWRADe79TRjx48Lzlz1KSM7BP7tw+eg0bZaifyB/GikYA
	Os3Ur7VULIU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C1E9C7252;
	Mon, 26 Jul 2010 02:02:05 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 521E7C724B; Mon, 26 Jul
 2010 02:01:59 -0400 (EDT)
In-Reply-To: <20100725221539.GA21813@burratino> (Jonathan Nieder's message of
 "Sun\, 25 Jul 2010 17\:15\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 512D1CAC-987B-11DF-BC01-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151809>

Jonathan Nieder <jrnieder@gmail.com> writes:

> My bad.  Would something like this fix it?
>
> -- 8< --
> Subject: archive, commit: use --abbrev by default again
>
> v1.7.1.1~17^2~3 (pretty: Respect --abbrev option, 2010-05-03) taught
> git log --format=%h to respect the --abbrev option instead of
> always abbreviating, with the side-effect that we have to pay
> attention to the abbrev setting now.
>
> For example, the "git archive" export-subst feature and the
> informational line printed by "git commit" are using unabbreviated
> object names now, the former because full object names are the low-level
> default, the latter because it was first written to imitate plumbing.
>
> Fix them.  While at it, remove a similar confusing assignment of 0 to
> rev.abbrev in "git checkout" which had no effect.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

The ones to archive and checkout I understand, but what effect does the
one to commit.c::print_summary() have?

> diff --git i/builtin/commit.c w/builtin/commit.c
> index a78dbd8..ae4831e 100644
> --- i/builtin/commit.c
> +++ w/builtin/commit.c
> @@ -1163,7 +1163,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
>  	init_revisions(&rev, prefix);
>  	setup_revisions(0, NULL, &rev, NULL);
>  
> -	rev.abbrev = 0;
> +	rev.abbrev = DEFAULT_ABBREV;
>  	rev.diff = 1;
>  	rev.diffopt.output_format =
>  		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_SUMMARY;
