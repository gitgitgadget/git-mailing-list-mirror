From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: validate & reconfirm interactive responses
Date: Thu, 06 Sep 2012 13:03:40 -0700
Message-ID: <7vipbq3omb.fsf@alter.siamese.dyndns.org>
References: <CAOeW2eGZm7PLRaktjQQdDJm2BqAihS0pzsY2GUNFUO83s8qBPQ@mail.gmail.com>
 <1344983132-22578-1-git-send-email-gitster@pobox.com>
 <CALaEz9WVCj0gu-CbUJgydik1bC7z7JCcveKTdyxgrTWokXq5JA@mail.gmail.com>
 <7vsjav6d85.fsf@alter.siamese.dyndns.org>
 <CALaEz9W_RR70KEzxk7GxjOu1_yv4UudckcsKAP2C_39Nc2yLbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 22:03:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9iIq-00038K-37
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 22:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759663Ab2IFUDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 16:03:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758131Ab2IFUDn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 16:03:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A90369EDC;
	Thu,  6 Sep 2012 16:03:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bmm2V93fx39L8C2hg1onWoPLd4w=; b=WhiMyD
	kFRFE+OM/pu31rzrHXnvMVSMkohiq+o0tJ/5Q+URJiSMUqp2J0PwwEGlxzZRUpiD
	JMWaHuIh7kDAUXzyt2rP3XChCVmQbtmZ5PSnEgTrLv8JiMVm29hi3Jiv2pVBxxsk
	Fsa1cqWvvUh/HRv5hoTH4AZU0qnQdtEaYIdPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MKQo9uAO65oyb1FDNz2QcDchxB6j8D/6
	csisRGb9T5CRGT9vQghySCG9d07i1nCC/ZucUEKBS+CMtJsRaxSsjZafWs1TjlMv
	8tFd2CQ0CEaFHylYMre+aan/EgZaxmgIRRTcaPTd4QBaZ62vg1coK/Tn5E4UiQZ1
	8GrZ7x55yp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 962869EDA;
	Thu,  6 Sep 2012 16:03:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6E529ED8; Thu,  6 Sep 2012
 16:03:41 -0400 (EDT)
In-Reply-To: <CALaEz9W_RR70KEzxk7GxjOu1_yv4UudckcsKAP2C_39Nc2yLbw@mail.gmail.com> (Stephen
 Boyd's message of "Thu, 6 Sep 2012 11:31:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4BD867E-F85D-11E1-B1E3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204918>

Stephen Boyd <bebarino@gmail.com> writes:

> It works fine for "Who should the emails appear to be from?" but
> beyond that we have "Who should the emails be sent to?" and
> "Message-ID to be used as In-Reply-To for the first email?" which I
> typically just hit enter to. It seems that they have no "default"
> argument so that second if fails. I suppose we can add a default => ""
> to these two asks?

For $initial_reply_to, I think "empty" means "I do not want to make
this message reply to anything", so I think it is OK to either give
a default "", or extendign valid_re to also catch an empty string.
In either case, the prompt message may want to clarify what happens
when you give an empty input (e.g. "leave this empty to start a new
thread", or something).

If you let $to to go empty with the first hunk of your patch, where
does the mail eventually go?  Does anybody later in the code decide
to add some recipient?  If there is a reason why an empty input is a
valid here, I think there is a stronger need (that is, stronger than
the above ase for $initial_reply_to) to explain when the user wants
to leave this empty.

> ----8<-----
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 607137b..13d813e 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -760,6 +760,7 @@ if (!defined $sender) {
>
>  if (!@initial_to && !defined $to_cmd) {
>         my $to = ask("Who should the emails be sent to? ",
> +                    default => "",
>                      valid_re => qr/\@.*\./, confirm_only => 1);
>         push @initial_to, parse_address_line($to) if defined $to; #
> sanitized/validated later
>         $prompting++;
> @@ -787,6 +788,7 @@ sub expand_one_alias {
>  if ($thread && !defined $initial_reply_to && $prompting) {
>         $initial_reply_to = ask(
>                 "Message-ID to be used as In-Reply-To for the first email? ",
> +               default => "",
>                 valid_re => qr/\@.*\./, confirm_only => 1);
>  }
>  if (defined $initial_reply_to) {
