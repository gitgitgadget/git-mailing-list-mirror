From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update SVN.pm
Date: Thu, 17 Apr 2014 11:01:09 -0700
Message-ID: <xmqqoazzesyi.fsf@gitster.dls.corp.google.com>
References: <20140416141605.GA9692@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 17 20:02:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Waqe0-00074U-L1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 20:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbaDQSBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 14:01:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbaDQSBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 14:01:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B89F7A772;
	Thu, 17 Apr 2014 14:01:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HQQyQZc6BMWeVthdRV6EBMTOd/M=; b=TZhAhM
	/L9eNnbxK8+wR4MJaqgM278ep7yu/bbEESqI35sjucR650srDxBGZwekA63WCCJ7
	P9oizZoPyRyLWyaXMyr2yZSfGLgV27QuLRG3axTjfuAuWt8iLg4ucqhKTsUjcS/m
	z5t0k8POUXzPaLLyszcTJtGmzfZyRNg6PGExw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=isrgIiGmDEVoIZQ/iXjAaRiZYIVd2ap2
	IfsVh1Uhg9TIP+BEWfVSLeKRSVm1S9eSVlsVmkXWVKjfAJpFmcEbgHNzTcHebHrO
	ZMdp8GlH/E6vzVuENVfas3itY1mo0ANd1c1+5lg7hJ2EiGXA4pItPgBUS5fRDKTw
	c5/62OfVeNo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23AF17A771;
	Thu, 17 Apr 2014 14:01:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3270F7A76C;
	Thu, 17 Apr 2014 14:01:11 -0400 (EDT)
In-Reply-To: <20140416141605.GA9692@camelia.ucw.cz> (Stepan Kasal's message of
	"Wed, 16 Apr 2014 16:16:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42455630-C65A-11E3-9BBB-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246430>

Stepan Kasal <kasal@ucw.cz> writes:

> From: RomanBelinsky <belinsky.roman@gmail.com>
> Date: Tue, 11 Feb 2014 18:23:02 +0200
>
> fix parsing error for dates like:
> 2014-01-07T5:58:36.048176Z
> previous regex can parse only:
> 2014-01-07T05:58:36.048176Z
> reproduced in my svn repository during conversion.
>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---

Two niggles.

 - The "Subject" line is not descriptive enough to let readers of "git
   shortlog" know what this change is about.

 - Can we have the patch signed-off by the author?


For the first point, I'd suggest rewriting the proposed commit
message like this (this is what I came up with after reading that
msysgit discussion page you referred to in the other message):

------------------------------------------------------
SVN.pm::parse_svn_date: allow timestamps with a single-digit hour

Some broken subversion server gives timestamps with only one digit
in the hour part, like this:

    2014-01-07T5:58:36.048176Z

Loosen the regexp that expected to see two-digit hour, minute and
second parts to accept a single-digit hour (but not minute or
second).

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
------------------------------------------------------


>  perl/Git/SVN.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index a59564f..09cff13 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1321,7 +1321,7 @@ sub get_untracked {
>  sub parse_svn_date {
>  	my $date = shift || return '+0000 1970-01-01 00:00:00';
>  	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
> -	                                    (\d\d)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
> +	                                    (\d\d?)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
>  	                                 croak "Unable to parse date: $date\n";
>  	my $parsed_date;    # Set next.
