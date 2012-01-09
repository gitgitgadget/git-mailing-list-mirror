From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email: bug with sendemail.multiedit
Date: Mon, 09 Jan 2012 15:15:21 -0800
Message-ID: <7vobuccvsm.fsf@alter.siamese.dyndns.org>
References: <1AC16B4B-8376-4A50-A900-BB8E704FAB82@gmail.com>
 <20120109225542.GB9902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 00:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkOR8-0005Zf-6o
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 00:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933425Ab2AIXPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 18:15:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932953Ab2AIXPY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 18:15:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6A126FEF;
	Mon,  9 Jan 2012 18:15:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XtFMTI0YGAGjT5hUvczfqhL7eHU=; b=nQsLbd
	IS9yfFFVHuQqOaqRZLhoDUDqQ9lt/+yckEhiCI83eUEEE3GzLg97nBf0E+dhonrY
	/QW4ulYopn/Jp1gVgz/wMsfAAYFlvLImpqP6mIL00gHcmed6n8glPrZAEM2o7W3k
	tv7h2ra/Parsrrk/NdKGI3/p8U+aG1G4hyNCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eCMt7RzdhD32l49EYCGvqt9drW3o71f0
	RvTJIa+K0IKh15JtOLoGfEjGqwxkEZYb+mDxW80qeupu7P8E2V1tspP/5JhYNprq
	9zVI6OhzjRwpFUHb4EAekxqj0pWbOfv0nK3X1sTf7eejkp4Tvx/ahR3nd2FptOfh
	HRu1iYvOBS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BECF06FEE;
	Mon,  9 Jan 2012 18:15:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4487E6FED; Mon,  9 Jan 2012
 18:15:23 -0500 (EST)
In-Reply-To: <20120109225542.GB9902@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 9 Jan 2012 17:55:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE84BEF4-3B17-11E1-9715-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188199>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 09, 2012 at 02:09:30PM -0500, Jean-Francois Dagenais wrote:
>
>> I think there is a bug with git-send-email.perl's evaluation of the
>> sendemail.multiedit config variable.
>> 
>> I was only able to make the "do_edit()" function detect it as false by
>> setting the variable to "0" instead of "false", like so:
>
> I think it's this:
>
> -- >8 --
> Subject: [PATCH] send-email: multiedit is a boolean config option
>
> The sendemail.multiedit variable is meant to be a boolean.
> However, it is not marked as such in the code, which means
> we store its value literally. Thus in the do_edit function,
> perl ends up coercing it to a boolean value according to
> perl rules, not git rules. This works for "0", but "false",
> "no", or "off" will erroneously be interpreted as true.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Looks like it.

And in case anybody is wondering by looking at the context, confirm is not
a boolean "do you want a confirmation or not?", so it can stay where it is.

Thanks.

>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index d491db9..ef30c55 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -210,6 +210,7 @@ my %config_bool_settings = (
>      "signedoffbycc" => [\$signed_off_by_cc, undef],
>      "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
>      "validate" => [\$validate, 1],
> +    "multiedit" => [\$multiedit, undef]
>  );
>  
>  my %config_settings = (
> @@ -227,7 +228,6 @@ my %config_settings = (
>      "bcc" => \@bcclist,
>      "suppresscc" => \@suppress_cc,
>      "envelopesender" => \$envelope_sender,
> -    "multiedit" => \$multiedit,
>      "confirm"   => \$confirm,
>      "from" => \$sender,
>      "assume8bitencoding" => \$auto_8bit_encoding,
