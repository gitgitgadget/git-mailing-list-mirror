From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 00/11] gitweb: Change timezone in dates using
 JavaScript
Date: Tue, 19 Apr 2011 09:58:49 -0700
Message-ID: <7vmxjm5gae.fsf@alter.siamese.dyndns.org>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
 <7vei4z6omh.fsf@alter.siamese.dyndns.org>
 <201104190326.29922.jnareb@gmail.com> <201104190836.16221.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCEGd-0003lb-Uc
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 18:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab1DSQ7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 12:59:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab1DSQ7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 12:59:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1D7040F1;
	Tue, 19 Apr 2011 13:01:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=acBlEpKT8t20Nhmldwqn4UWSXyI=; b=ji5yOM
	/zW3InSIfTWnyX5Q5dmTMu1Q8m8amWKetptXf3r2oyD+h64NiXL51MtDpn7BZ3a2
	mmQ438Onlvp+iyCyv19SGlfejln7DV/MnNSf3Thcr/PC47GufbJbHiGN9XkDeWp6
	kd6K4dvC3lZRxaKXSAcftH25rGgef476RgrHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KDtgEH2SZ/CJsvZrrFlwIqkZTwHOLwcK
	Lq68byVvcwkyWUvkiJRFiNyRNiRbSBCEkhSRJDMmWID25KqLOH0Xqv5OpaupP4AY
	GFYJDQoVVKZTck2uHCuLTKeBvKSNMSS0gSbDlpaLRJAsjyOooolb7k3tBybTbq+l
	SfX6wh0MRyU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 881F740EF;
	Tue, 19 Apr 2011 13:00:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2FFA640EE; Tue, 19 Apr 2011
 13:00:52 -0400 (EDT)
In-Reply-To: <201104190836.16221.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 19 Apr 2011 08:36:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98FA6D52-6AA6-11E0-BA09-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171801>

Jakub Narebski <jnareb@gmail.com> writes:

> Perhaps something like that would be a good change, what do you think?

Should be a lot saner thing to do.

Do we even need to know about JSMIN, GITWEB_JS, etc., in our main
Makefile?  Shouldn't we be delegating both the build and the install
targets to "$(MAKE) -C gitweb $@"?

> diff --git i/Makefile w/Makefile
> index cbc3fce..8960cee 100644
> --- i/Makefile
> +++ w/Makefile
> @@ -1773,7 +1773,7 @@ gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
>  endif # CSSMIN
>  
>  
> -git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js
> +git-instaweb: git-instaweb.sh gitweb
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>  	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
>  	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
