From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not unquote + into ' ' in URLs
Date: Fri, 23 Jul 2010 15:26:42 -0700
Message-ID: <7viq45eswt.fsf@alter.siamese.dyndns.org>
References: <AANLkTinsixPihZRtduuB_0puX_ucC0HYqHPU0UJMX2e-@mail.gmail.com>
 <db9c97908966fa332be07b2a9f5215679e35b9e0.1279920066.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	<avarab@gmail.com>, <jstpierre@mecheye.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 24 00:27:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcQi0-0007x6-Ml
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 00:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab0GWW05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 18:26:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab0GWW04 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 18:26:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28C8CC7E16;
	Fri, 23 Jul 2010 18:26:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p1f9WZAFaDaLoaS2nvgZzNBR2TE=; b=cSiVf4
	bkaAvkVaEWL2j7HLoxUKAogcjbpSkoVaxXBmevZwGhL3B7whD9I5UI+AOFyF2yQ5
	Syrqlx0JIcszw9Rthg0OKoXeejC08YOBE7wJUXqBW8lJv3ZvTQh++fLwQea5sV/V
	/SKEyroFfBIW+Jv6oh5Cgn2wtLa7HJEVD/yM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SsV9UOTSKLHek+IRA32MsPqiU9T2nXC9
	fsLrhp8tpAIJT6Kd9OKUjfVDvEAts6E354i3PjsKxfW4obT0wLFoskfuPwpAmWZ5
	XYxv2ItrRQsc8x7j2F+VgMBeVxcpgVlSNEhzhzVhYFlE9V0mBXd/8yEwdHi95z26
	iYBhkMJD5PA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C884BC7E14;
	Fri, 23 Jul 2010 18:26:49 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCDA3C7E10; Fri, 23 Jul
 2010 18:26:43 -0400 (EDT)
In-Reply-To: <db9c97908966fa332be07b2a9f5215679e35b9e0.1279920066.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 23 Jul 2010 23\:23\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 62F00892-96A9-11DF-9612-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151578>

Thomas Rast <trast@student.ethz.ch> writes:

> Since 9d2e942 (decode file:// and ssh:// URLs, 2010-05-23) the URL
> logic unquotes escaped URLs.  For the %2B type of escape, this is
> conformant with RFC 2396.  However, it also unquotes + into a space
> character, which is only appropriate for the query strings in HTTP.
> This notably broke fetching from the gtk+ repository.

Wait a minute.

> Based on the discussion, I would consider this a bugfix that should go
> in 1.7.2.1.

Some form of this may need to be applied to help the client side, but what
will happen to

  http-backend.c::get_info_refs()
   -> http-backend.c::get_parameter()
     -> http-backend.c::get_parameters()
       -> url.c::url_decode_parameter_value()
         -> url.c::url_decode_internal()

codepath, which is the server-side handing of query strings?
