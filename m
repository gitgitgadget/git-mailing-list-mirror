From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Sat, 09 Jun 2012 23:41:39 -0700
Message-ID: <7v4nqjbrdo.fsf@alter.siamese.dyndns.org>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
 <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr> <7vvcj1dep7.fsf@alter.siamese.dyndns.org> <20120609125336.Horde.iUq0R3wdC4BP0yswpGlGBZA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu.Moy@grenoble-inp.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 08:41:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdbqM-0005v5-QK
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 08:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab2FJGln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 02:41:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab2FJGlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 02:41:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2E89379A;
	Sun, 10 Jun 2012 02:41:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CEEPVpVjL4k0BhB/mbqx++X2iG4=; b=TX0Vt+
	Rp/Bln4nhNo1fzU++OSJZC+171hvBJAXkylBNTRQIn26BXRA2pFPI0f8CUkbqHU+
	qbAaPlgddLIuFzlGQFX48gRtLEKCkCVRD6lL85znLCErrDDPP5Bv3UZunqMMZzuJ
	z1ETJoXw5DyQapLHGOUnLyp3YbRpGOklWk6us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lr37FGSUnNckd0y4l4p1kJxMP9m3wBvl
	E0aEPSjgppxkGizWNv6OO7pLS5+ITZN61R4lAk0ODseU+pPByluBhvv0Tb3EL38y
	Q0Ip/CUq+dUByX/3rxiFXIDoaZQSpmMnwPdnXp+UvK8ReS89oDjIwHdDFz0WWE0s
	tXK+qtw8mEo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8FF73799;
	Sun, 10 Jun 2012 02:41:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 711C13798; Sun, 10 Jun 2012
 02:41:41 -0400 (EDT)
In-Reply-To: <20120609125336.Horde.iUq0R3wdC4BP0yswpGlGBZA@webmail.minatec.grenoble-inp.fr> (nguyenhu@minatec.inpg.fr's message of "Sat, 09 Jun 2012 12:53:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 565D39F6-B2C7-11E1-BD3F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199568>

nguyenhu@minatec.inpg.fr writes:

>> Modulo
>>
>> 	path = strbuf_detach(&sb, NULL);
>>
>> that is more or less what I meant.
>
> So now the mkpathdup() function looks like:
>
> char *mkpathdup(const char *fmt, ...)
> {
> 	char *path;
> 	struct strbuf sb = STRBUF_INIT;
> 	va_list args;
>
> 	va_start(args, fmt);
> 	strbuf_vaddf(&sb, fmt, args);
> 	va_end(args);
> 	path = strbuf_detach(&sb, NULL);
>
> 	strbuf_release(&sb);
> 	return path;
> }
>
> This new variation of mkpathdup() function both fix the bug addressed
> by commit 05bab3ea and avoid the use of bounded buffer.

I didn't mean to suggest removing the call to clean-up-path
function.  What I meant was that strbuf_detach() is a way to take
the ownership of the buffer, so that you do not have to call
strbuf_release() on it.
