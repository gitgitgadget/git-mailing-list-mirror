From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 GSOC 01/11] gitweb: fix esc_url
Date: Thu, 15 Jul 2010 11:57:48 -0700
Message-ID: <7vfwzkvahf.fsf@alter.siamese.dyndns.org>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
 <1279178951-23712-2-git-send-email-pavan.sss1991@gmail.com>
 <201007151552.23324.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 20:58:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZTdL-0004e6-Vw
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 20:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934331Ab0GOS6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 14:58:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934314Ab0GOS6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 14:58:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79898C456B;
	Thu, 15 Jul 2010 14:58:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NsDHRYauBQTPo/GG4MGgrDR92mw=; b=CMlCT6
	dpJKfc2/8ZS9/dVFeZMt6WpNvUQgCD0S7u1uj7aSW6XUtGpP/86FiqOpy3LUpET1
	se7a6zG3ddjkw+nKa5N9r344CJFRXR4CsxyJppGyVT8lB18fNOSbguRuBg+SKkUz
	/F/rLISpr+hAjQCHuItKaag65fWcKg6BzPYAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PUymt5a6JC5Htlcyj09N/jhFVzkSZKae
	IbhaOpPakGDQl0kloz0vZ8Yl80u5Cnd+cMhAfhuOCxT8J+A5YzPHkmk56oNWIw4k
	EzY0O4hGS3ze2qkgTNaOtcJf9FibA39NPzgt7c5xTowwLf/vqNWZQjwFUo7idz6V
	zMksV89bWiE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD6B9C4568;
	Thu, 15 Jul 2010 14:57:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC8DCC4567; Thu, 15 Jul
 2010 14:57:50 -0400 (EDT)
In-Reply-To: <201007151552.23324.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu\, 15 Jul 2010 15\:52\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1FD8906-9042-11DF-8B1D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151106>

Jakub Narebski <jnareb@gmail.com> writes:

> On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:
>> The custom CGI escaping done in esc_url failed to escape UTF-8
>> properly. Fix by using CGI::escape on each sequence of matched
>> characters instead of sprintf()ing a custom escaping for each byte.
>> 
>> Additionally, the space -> + escape was being escaped due to greedy
>> matching on the first substitution. Fix by adding space to the
>> list of characters not handled on the first substitution.
>> 
>> Finally, remove an unnecessary escaping of the + sign.
>> 
>> commit 452e225 has missed fixing esc_url.
>> 
>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>
> First, as this patch is independent and unrelated to either splitting
> gitweb, or write support, it would be better if this patch was sent
> individually to git mailing list, and not only as a part of a large
> patch series.  It would likely to be applied, as it is pure bugfix.
>
> Second, I would probably write commit message differently, to emphasize
> that it is just finishing work of commit 452e225 (gitweb: fix esc_param,
> 2009-10-13) by fixing esc_url like it fixed esc_params.  But it is not
> something very important.

I tentatively rewrote the message like so:

    Earlier, 452e225 (gitweb: fix esc_param, 2009-10-13) fixed CGI
    escaping rules used in esc_url.  A very similar logic exists in
    esc_param and needs to be fixed the same way.

It makes one wonder why they have to be separate functions, doesn't it,
though?

> For what it is worth, ACK from me for this patch.

Thanks
