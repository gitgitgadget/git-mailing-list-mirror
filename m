From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Allow reading svn dumps from files via file:// urls.
Date: Wed, 11 Jul 2012 10:00:29 -0700
Message-ID: <7vbojmfd1u.fsf@alter.siamese.dyndns.org>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342013933-14381-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342013933-14381-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <loom.20120711T162346-654@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 19:00:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp0HG-0002Zd-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 19:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992Ab2GKRAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 13:00:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932987Ab2GKRAc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 13:00:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15BFF4733;
	Wed, 11 Jul 2012 13:00:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kjx1UYqUJgLGbQwF7S+2BkXQj9U=; b=QJrglo
	lCtPBJqmlOe3Piy6Qyp/RXZIoi1m2jNcBqbTokW3FFFbayda7rF/g4dZNyq4kNo6
	rLqJJTaWUwJtpDBTNDNg18NyEkn1HLRZJulzF+XhfpoG2/wPDl2hYQStP10Xuy2L
	7eLPznjb4NQD1ALpRNqeKdZc0Vs4oVBPOJ1gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ibiyEs2DcLzv9SyWp8faHDi4Q2+dLs03
	zx3Xe1C0oe7+StqiPrXrcj/j+9d07RihIxmLyX5J2znC92V8E1cbfs/c2bL4PqHy
	YSju7jWNZp/YHGzWWFCpsWzrWiCqqKyoHOSUUUbzyvV2wPXyeVH5vcVGBb+pMbWk
	+YGA7yW9vjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08D224732;
	Wed, 11 Jul 2012 13:00:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63E304731; Wed, 11 Jul 2012
 13:00:31 -0400 (EDT)
In-Reply-To: <loom.20120711T162346-654@post.gmane.org> (Dmitry Ivankov's
 message of "Wed, 11 Jul 2012 14:29:08 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC538238-CB79-11E1-A08D-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201317>

Dmitry Ivankov <divanorama@gmail.com> writes:

> Florian Achleitner <florian.achleitner.2.6.31 <at> gmail.com> writes:
>
>> 
>> Especially for testing and development it's useful
>> to bypass svnrdump and replay the svndump from a file
>> without connecting to an svn server.
>> 
>> Add support for file:// urls in the remote url.
>> e.g. svn::file:///path/to/dump
>> When the remote helper finds an url starting with
>> file:// it tries to open that file instead of invoking svnrdump.
>
> file:// is a bad choice because file:// style repo urls are valid for svn and 
> it's for local repos rather than dumpfiles.

Thanks; I had the same reaction when I saw it.

> Maybe something like dumpfile:// instead?

If dumpfile:// pseudo URL is an established convention in the
Subversion land, that sounds like a sensible direction, but if that
is not the case, it may be cleaner if you can find some other way to
convey the information to the backend out-of-band, instead of
overloading it in the URL used to access the repository.
