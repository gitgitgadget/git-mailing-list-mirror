From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: check whether systems nice command works or
 disable it
Date: Sun, 07 Feb 2010 16:21:40 -0800
Message-ID: <7vhbps4lwr.fsf@alter.siamese.dyndns.org>
References: <20100207214755.GB3034@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 01:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeHOk-0002YP-8B
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 01:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757097Ab0BHAVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 19:21:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066Ab0BHAVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 19:21:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41A739706F;
	Sun,  7 Feb 2010 19:21:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3QRPPitkqrJRGtx+jujHjuOi2xE=; b=mltBfO
	aOp9nK3U2Jkr1hjDgSlI041Lv/L8AAhJgoNztZ3gvtcKZ2sSmJ7IEdiJwc4xZVll
	AD9qegcFNrevfZ7BtS0r9PSXohykVv3ojuIJH0NIjmFBaffO5wA23BOGeVnRQRKY
	xxqdqXwS05b8WW2+5R1KZgWTZfjUA1CDfSkC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ErYjto2bgMPHCH8paebqHEolJ76bnM44
	wCvve1Y0amMOM1YLjPOgYJWEd3N4XGr72WFuKyubhSDjWELU2RGfbYmv8/uGusUX
	3aJzL7/4iHDE687YQNHxFJkzmL5yXDhrez0ftMlBcsaZ+n06XxQbk6/SGlLimBUU
	pJXYchlgbGE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F9CB9706D;
	Sun,  7 Feb 2010 19:21:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B9D89706C; Sun,  7 Feb
 2010 19:21:42 -0500 (EST)
In-Reply-To: <20100207214755.GB3034@book.hvoigt.net> (Heiko Voigt's message
 of "Sun\, 7 Feb 2010 22\:47\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F170BA2E-1447-11DF-9B7A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139267>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This fixes issue 394 from msysgit. It seems that the Gnuwin32 project
> provides a nice command but it returns a "not implemented" error. To
> help users we now try to execute once and disable it in case it fails.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>
> see: http://code.google.com/p/msysgit/issues/detail?id=394
> for more information.
>
> cheers Heiko
>
>  git-gui/git-gui.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 1fb3cbf..eec2dc9 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -388,6 +388,9 @@ proc _lappend_nice {cmd_var} {
>  
>  	if {![info exists _nice]} {
>  		set _nice [_which nice]
> +		if {[catch {exec $_nice git version}]} {
> +			set _nice {}
> +		}

Where does the output from this "git version" invocation go?

>  	}
>  	if {$_nice ne {}} {
>  		lappend cmd $_nice
> -- 
> 1.7.0.rc1.7.gc0da5
