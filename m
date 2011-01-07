From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] test: use test_utf8 and GIT_LC_UTF8 where an
 en_US.UTF-8 locale is required
Date: Fri, 07 Jan 2011 10:48:36 -0800
Message-ID: <7vpqs87dob.fsf@alter.siamese.dyndns.org>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
 <4BF2BABC.2010405@drmicha.warpmail.net> <1274202486.4228.22.camel@localhost>
 <1274720888.4838.13.camel@localhost> <cover.1294312018.git.yann@droneaud.fr>
 <97423472c08cd83373c769bf1cafdb9b85db37e3.1294312018.git.yann@droneaud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:49:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHN7-0001Xm-1q
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab1AGSsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:48:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab1AGSsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:48:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 098112E22;
	Fri,  7 Jan 2011 13:49:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ltylzJajVu8LpT4KHVdvMe6W99o=; b=M7dd5o
	mn8lAFbE6oa51fncbCtB6+aUKl+TISth5jSj5V1g1QpFA2bA7q9dDzHpWph0JXPO
	ieXOGhdunvKmJTrVgaehBV10uoJiI39F2n4tC8IdeseZLifzMCe5asgHlBpg2vDA
	8I7nBgVqyLz9nH2rgQATOWVcazeFjiMOl/jP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lFV4kRluQmrSXtktMS2Jlf4Yo+NITyWV
	mtOE1AG9FRHN48ZHHVZQpQUAvWG5+RkvzFW4+D0kS7emFcc2I8mm2s7jwx3Ecv3V
	eP3wbbkR5je8QSkUY1vy8A+uD4lIRXxaw1r+QFUXNq8g5pnWD4bKt0UvjDoLbv4O
	FAWSgGgZUck=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DADC52E20;
	Fri,  7 Jan 2011 13:49:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E7C4F2E1F; Fri,  7 Jan 2011
 13:49:16 -0500 (EST)
In-Reply-To: <97423472c08cd83373c769bf1cafdb9b85db37e3.1294312018.git.yann@droneaud.fr>
 (Yann Droneaud's message of "Thu\,  6 Jan 2011 15\:22\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5F7BDB2-1A8E-11E0-9D7A-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164738>

Yann Droneaud <yann@droneaud.fr> writes:

> Signed-off-by: Yann Droneaud <yann@droneaud.fr>
> ---
>  t/t9100-git-svn-basic.sh               |   25 ++++++++-----------------
>  t/t9129-git-svn-i18n-commitencoding.sh |   13 +++----------
>  2 files changed, 11 insertions(+), 27 deletions(-)

Both are nice changes; this patch shows the earlier abstraction in 2/4 is
the right direction to go.

>  compare_svn_head_with () {
>  	# extract just the log message and strip out committer info.
>  	# don't use --limit here since svn 1.1.x doesn't have it,
> -	LC_ALL="$a_utf8_locale" svn log `git svn info --url` | perl -w -e '
> +	LC_ALL=$GIT_LC_UTF8 svn log `git svn info --url` | \
> +	    LC_ALL=$GIT_LC_UTF8 perl -w -e '

Style.

	LC_ALL=... svn log ... |
        LC_ALL=... perl -w -e '
        	...
	'

When you end a line with '|', the shell knows that you haven't finished
talking to it, so there is no need for the trailing bs-lf there.  Indent
the downstream of the pipe to the same level as the upstream.
