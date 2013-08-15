From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email uses contacts to propose recipients
Date: Thu, 15 Aug 2013 15:29:58 -0700
Message-ID: <7vhaeqpoyh.fsf@alter.siamese.dyndns.org>
References: <1376605069-525-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mst@kernel.org, felipe.contreras@gmail.com, bebarino@gmail.com,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 00:30:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA63W-00023t-5y
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 00:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab3HOWaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 18:30:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406Ab3HOWaD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 18:30:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AB903944A;
	Thu, 15 Aug 2013 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aUiUW9dorA9NNhFC5Vvh6ZAdTiM=; b=TAzel5
	6pPW4bLlk4azTiHe/leWetqf67mxRFB66Zmfz7r8Rfl5fGEYo8zGicCW/h0mVIwW
	WhEixjQGRND4Im/9GZ79aZghILFiayeMduyovy2P8sAbzIfMmvLW2ZplEe/Wr4II
	box+4EeCPIB85T63EosjotiHMnzkNcyLrOEgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lh1Do0APD2ePKwzuCDUVn5+XvsAuCwDz
	TGxCFZSkJjx/TKttstPV2M1L6dhzTY+4ein7uSOrdQDs1RbNYPLCvyo0u45v8hpf
	QQELJfbV0eyU3FE3e9LmfKXAi4RhdpVpQMlhUJQSq1at6q7OqkvrJIL3b694iEiX
	5u4XFO8r2hE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B4BF39448;
	Thu, 15 Aug 2013 22:30:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B9FD39443;
	Thu, 15 Aug 2013 22:29:59 +0000 (UTC)
In-Reply-To: <1376605069-525-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Fri, 16 Aug 2013 00:17:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 389F6C4A-05FA-11E3-ABB4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232381>

Stefan Beller <stefanbeller@googlemail.com> writes:

> I have got an idea regarding the send-email. If there are no recipients
> given, it could propose recipients using the new 'git contacts'
> This would help people new to projects to not forget people, who may have
> the most knowledge reviewing that specific patch.
>
> Unfortunately I cannot read/write perl, so I cannot solve it
> myself in the near future, but I'd put it on my todo list for later.
> ---
>  git-send-email.perl | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2162478..a34723d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -757,6 +757,12 @@ $sender = sanitize_address($sender);
>  
>  my $prompting = 0;
>  if (!@initial_to && !defined $to_cmd) {
> +	if (git contacts is available) {
> +		proposed senders = git contacts on the same range or set of patches
> +		print "Suggesting these receivers:\n"
> +		print proposed senders
> +	}
> +
>  	my $to = ask("Who should the emails be sent to (if any)? ",
>  		     default => "",
>  		     valid_re => qr/\@.*\./, confirm_only => 1);

Cute.

It is OK while "contacts" is in contrib/, because people who has
"git contact" are those who opted into the heuristics of implemented
by that script. But if we are to eventually move the script out of
the contrib/ area, we may have to restrict "is available" a bit
tighter.  Not everybody has to agree with its heuristics before the
script moves out of the contrib/ area, so there will be users who
are annoyed by the suggestion the script makes, which may not suit
their needs at all.

For contributors of _this_ list, the above will not kick in at all,
as they should always have sendemail.to set to the list, and
@initial_to will not be empty for them.
