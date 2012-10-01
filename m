From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove the hard coded length limit on variable names in
 config files
Date: Mon, 01 Oct 2012 12:33:02 -0700
Message-ID: <7vvceuasy9.fsf@alter.siamese.dyndns.org>
References: <CAP30j15wKa7wbLyaLo8omHcAh5u7O=Yt8Tjy4bD3V_0nT1zJPQ@mail.gmail.com>
 <1349034276-10690-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hagger@alum.mit.edu, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 21:34:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIll1-00018W-SB
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 21:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab2JATdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 15:33:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754208Ab2JATdF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 15:33:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FFB68F3C;
	Mon,  1 Oct 2012 15:33:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9r1bVStUkjWo7XTTDv1QdzYnzEg=; b=TX/0gG
	F6/Zv3PoM7q1G22To0WV3zhC/XChyrN3twM3FvwyaDecZP49HoW1jb9IHZTIv2cY
	49BlFsOpNCDDv1gpKLzwbSGss7tN7XFhQiq1FEJnxhTBkWyPyUR7wN4bACBhRDcl
	uleT6WCbYVqv5Q7w5odGzEXmLhRGR41GMa9EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nXERypSCeMBaglu6XBQpcFV9Jmz5PixG
	IYjeHx39w5UcXIP8lRK/c25kUnpKjZs0iikQd+jtjVpvVrzg2qXCHlusJg4SfQtO
	82OlFMxDRZ6WRIPrwnAU9zWT5nPKqbLEgN23rdfc04DyGOaGbmfkUrP9k640s25d
	H6PY5bqhkbY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF958F3B;
	Mon,  1 Oct 2012 15:33:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3B978F3A; Mon,  1 Oct 2012
 15:33:03 -0400 (EDT)
In-Reply-To: <1349034276-10690-1-git-send-email-bdwalton@gmail.com> (Ben
 Walton's message of "Sun, 30 Sep 2012 20:44:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D168BC52-0BFE-11E2-8111-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206760>

Ben Walton <bdwalton@gmail.com> writes:

> Previously while reading the variable names in config files, there was
> a 256 character limit with at most 128 of those characters being used
> by the section header portion of the variable name.  This limitation
> was only enforced while reading the config files.  It was possible to
> write a config file that was not subsequently readable.
>
> Instead of enforcing this limitation for both reading and writing,
> remove it entirely by changing the var member of the config_file
> struct to a strbuf instead of a fixed length buffer.  Update all of
> the parsing functions in config.c to use the strbuf instead of the
> static buffer.
>
> The parsing functions that returned the base length of the variable
> name now return simply 0 for success and -1 for failure.  The base
> length information is obtained through the strbuf's len member.
>
> We now send the buf member of the strbuf to external callback
> functions to preserve the external api.  None of the external callers
> rely on the old size limitation for sizing their own buffers so
> removing the limit should have no externally visible effect.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>  config.c |   59 +++++++++++++++++++++++++++++------------------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)

Makes sense, and I found the patch very readable.

Thanks, both.
