From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] imap-send: change msg_data from storing (char *,
 len) to storing strbuf
Date: Thu, 29 Nov 2012 13:30:54 -0800
Message-ID: <7vboegp04x.fsf@alter.siamese.dyndns.org>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
 <1353841721-16269-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 29 22:31:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeBhS-0000re-FL
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 22:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527Ab2K2Va6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 16:30:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755329Ab2K2Va5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 16:30:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA3ECA7C1;
	Thu, 29 Nov 2012 16:30:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=im8dSnU0hgu6Jp/jrY9AiXlwV5E=; b=kWhcFV
	dbe25j7Wz4xKUavQUrGDSB7Zq83wfpV4Q8ClxTfRsUX8QThYmfLj6dK+ds1RHTJB
	NGQ4KRvzD0qKshizEt03aTquF/GKmclYANjy5huQAlcdpAAkWICJSP3a+EXkLMtk
	T+zV43tFtFNg7PAH/xqOE+rDkf5avzHQarM28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GXkdQ1kCrjjM4vQDUfHSgilxEtMBxNpF
	ZI9oqtu8cUSUsNrwhmbPEBuhgepUq3p161ErWUxVBnBkUsJLgp34a30+eR4Yxh2g
	SPSYknQf9BxpE/cIqBLGjakIpmCgm8U2hohVJOOqANg4Pa+YZCQvaPf5Rz8Fk2by
	jgPhM4dEj4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9783EA7C0;
	Thu, 29 Nov 2012 16:30:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1285A7BF; Thu, 29 Nov 2012
 16:30:55 -0500 (EST)
In-Reply-To: <1353841721-16269-7-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Sun, 25 Nov 2012 12:08:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F2C1728-3A6C-11E2-89C9-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210877>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> struct msg_data stored (char *, len) of the data to be included in a

That (<type>, <varname>) is a bit funny notation, even though it is
understandable.

> message, kept the character data NUL-terminated, etc., much like a
> strbuf would do.  So change it to use a struct strbuf.  This makes the
> code clearer and reduces copying a little bit.
>
> A side effect of this change is that the memory for each message is
> freed after it is used rather than leaked, though that detail is
> unimportant given that imap-send is a top-level command.
>
> --

?

> For some reason, there is a bunch of infrastructure in this file for
> dealing with IMAP flags, although there is nothing in the code that
> actually allows any flags to be set.  If there is no plan to add
> support for flags in the future, a bunch of code could be ripped out
> and "struct msg_data" could be completely replaced with strbuf.

Yeah, after all these years we have kept the unused flags field
there and nobody needed anything out of it.  I am OK with a removal
if it is done at the very end of the series.

Thanks.
