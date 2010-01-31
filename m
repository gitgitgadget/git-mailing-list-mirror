From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not install shell libraries executable
Date: Sat, 30 Jan 2010 23:08:14 -0800
Message-ID: <7vhbq2g3a9.fsf@alter.siamese.dyndns.org>
References: <20100129102518.GA5875@coredump.intra.peff.net>
 <20100129103723.GC6025@coredump.intra.peff.net>
 <20100129145025.GA22703@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 08:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbTzZ-0008Nx-HP
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 08:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab0AaHIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 02:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867Ab0AaHIb
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 02:08:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab0AaHIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 02:08:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F75394930;
	Sun, 31 Jan 2010 02:08:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kf1uiSVlNFf/g8cufcMUPDE1Ef8=; b=W0FgAM
	WPrEDq/55vm41gOpu0R7/5sUEAraKDRtGbJ4D39XIkoqpoFSBqYaqXsTXcJ6szVy
	YpzX0DuV71oUfhGkziFz7YdlfiEePHGO1RdKo26KBSVb2odr9DGDArrioNQayWTq
	poP/PQu7W8klJg4TOqEZj2V1ml4H0fEhnb+Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hd+50ZCZEv1sBtof1fQZj6QG/02su5Ei
	ruo60hW0YRvMKmWmqBtrWokuout9ivIdPlAqu26czritJOoxibE+p+s0UfEJoSBC
	1yBwXCNd7c1OLHr/lHZPS/cwFf8D75N6HHswFwgbSyj/upS8kwhCf42lhjxEArp+
	cNW5swOtpHs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 284FD9492F;
	Sun, 31 Jan 2010 02:08:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20E899492E; Sun, 31 Jan
 2010 02:08:15 -0500 (EST)
In-Reply-To: <20100129145025.GA22703@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 29 Jan 2010 08\:50\:25 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B5880AE-0E37-11DF-A862-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138529>

Jonathan Nieder <jrnieder@gmail.com> writes:

> @@ -1488,6 +1490,15 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
>  	chmod +x $@+ && \
>  	mv $@+ $@
>  
> +$(patsubst %.sh,%,$(SCRIPT_LIB_SH)) : % : %.sh
> +	$(QUIET_GEN)$(RM) $@ $@+ && \
> +	sed -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
> +	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
> +	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
> +	    -e $(BROKEN_PATH_FIX) \
> +	    $@.sh >$@+ && \
> +	mv $@+ $@
> +

Can't you do something about this repetition from existing $(SCRIPT_SH)
munging?  Other than that the patch looks like Ok.
