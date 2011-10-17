From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] gitweb: change format_diff_line() to remove
 leading SP from $diff_class
Date: Mon, 17 Oct 2011 12:02:20 -0700
Message-ID: <7v62jnmog3.fsf@alter.siamese.dyndns.org>
References: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 21:02:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFsSC-0006nd-1v
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 21:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787Ab1JQTCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 15:02:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab1JQTCX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 15:02:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C5875C09;
	Mon, 17 Oct 2011 15:02:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UIPkWJ3QjPo75pt6gBlAU6UlVHY=; b=Rqm9tY
	eesWHbBEzJoa3t1aP4Wf4GgTBB29Tgzs0G5rYf1rfSUxrrgatUh1jjtpq4XMEYBu
	OVER/eDwYPdrw+WORCBlU9RBc5qINow/5kJHV52DrdTV7vw4iHlSlyienE161shY
	CH4WfI2uKAaz0r8W3FcZLhn+901nJp8MXlYcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fAzbqGjcI4JH/lCAzIAj10SlecIOMSi8
	5EqUH8NdsxcbVeYxuSHeVO2QgkKn97RFb5S2wqOOrqBKznlbVjIZNvLvtZr9FyWJ
	WyX4lpozMh6E+Kc6PBqtHuoUkYSY4n9MFpBr2lCyEk2x0ahzKfqAjav+QmDarsm1
	gE6hiNCtoE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 534595C07;
	Mon, 17 Oct 2011 15:02:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E9565C06; Mon, 17 Oct 2011
 15:02:21 -0400 (EDT)
In-Reply-To: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com> (Kato
 Kazuyoshi's message of "Mon, 17 Oct 2011 15:59:55 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ADC959E-F8F2-11E0-B64E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183808>

Kato Kazuyoshi <kato.kazuyoshi@gmail.com> writes:

> The format_diff_line() will return $diff_class and HTML in upcoming changes.

An auxiliary piece of information like this is fine at the end of the
commit log message, but the patch itself wants to be justified
standalone.  Perhaps this should be sufficient:

	The $diff_class variable to classify the kind of line in the diff
	output was prefixed with a SP, only so that the code to synthesize
	value for "class" attribute can blindly concatenate it with
	another value "diff". This made the code unnecessarily ugly.

	Instead, add SP that separates the value of $diff_class from
	another class value "diff" where <div class="..."> string is
	created and drop the leading SP from the value of $diff_class.
	
Explained this way, it does not even have to mention that the return value
will be changed in a different patch.

We all know that the hidden motivation of this change is that the caller
of this function, after it starts using the returned value of $diff_class,
does not want to worry about the ugly SP prefix in that variable. Saying
only "This function will return this variable in the future" still does
not fully explain that hidden motivation unless you say "and the caller
shouldn't have to worry about the leading SP", so let's not even mention
it in the log message of this change.

> ---

Sign-off?

>  gitweb/gitweb.perl |   24 +++++++++++++-----------
>  1 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 85d64b2..095adda 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2235,28 +2235,30 @@ sub format_diff_line {
> ...
> +
> +	my $div_open = '<div class="' . (join ' ', ('diff', $diff_class)) . '">';

I think using a separate helper variable like this is a good change.  You
do not have to worry about the issue in three different places.

But doesn't join(" ", ("frotz", "")) still give you "frotz "?  It is OK to
punt and say

	my $div_open = '<div class="diff $diff_class">';

which would be far easier to read. It may sacrifice a bit of tidiness in
the resulting HTML but the tidiness of the source outweighs it.

Of course, if you have tons of classes, it may be worth doing something
like

	join(" ", grep { defined $_ && $_ ne ""}  @diff_classes);

but I do not think it is worth it in this particular case.

Thanks.
