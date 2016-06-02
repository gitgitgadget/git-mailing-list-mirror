From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 02 Jun 2016 09:10:07 -0700
Message-ID: <xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com>
References: <20160601235233.21040-1-sbeller@google.com>
	<574F800D.6070107@ramsayjones.plus.com>
	<xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
	<57505105.2000801@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, pclouds@gmail.com,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 18:10:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8VCS-0008NJ-CY
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 18:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161375AbcFBQKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 12:10:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932191AbcFBQKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 12:10:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BF171F8FC;
	Thu,  2 Jun 2016 12:10:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gfkBECEwf7YbucZ8loL940LSsT8=; b=w9WY7S
	iCFyWlNJbd7y0OuE1xwDrmdPydTz4fTlD8RwohRBfWtrFUdNbpxWtEZ55VRWHUsN
	GjKGLhiOsWFmUBkw/KAsHcGQGgQiM4cIdcyBH5CRzw9IMc5v4iEZ79woSnVnr3Jv
	IfcjTv0CxYkYdm+0PAiw6YVwoEp4lYq9QQ9Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yGGD8AjE4PJ5OIfe95o8vaBqKEOe4apu
	DvfydQxL8xcFx5vmHogJlWIhIUhtj01wK+Dov3GMMcg7HBNQ5pCgEcIsX9lTIIyD
	il9B5dMFKmu4gfEUURxXWAl1HOUoBefqyQMd19l7DK0nSX2Mo/gWM7fECQRhtU64
	3VGnNZQH9VY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 035DC1F8FB;
	Thu,  2 Jun 2016 12:10:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92BBF1F8FA;
	Thu,  2 Jun 2016 12:10:10 -0400 (EDT)
In-Reply-To: <57505105.2000801@ramsayjones.plus.com> (Ramsay Jones's message
	of "Thu, 2 Jun 2016 16:30:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7B310430-28DC-11E6-B979-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296211>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> So, at risk of annoying you, let me continue in my ignorance a little
> longer and ask: even if you have to protect all of this 'magic' from
> the shell with '/" quoting, could you not use (nested) quotes to
> protect the <value> part of an <attr>? For example:
>
>     git ls-files ':(attr:whitespace="indent,trail,space",icase)'

That would be workable, I would think.  Before attr:VAR=VAL
extention, supported pathspec <magic> were only single lowercase-ascii
alphabet tokens, so nobody would have used " as a part of magic.  So
quting with double-quote pair would work.

You'd need to come up with a way to quote a double quote that
happens to be a part of VAL somehow, though.  I think attribute
value is limited to a string with non-whitespace letters; even
though the built-in attributes that have defined meaning to the Git
itself may not use values with letters beyond [-a-zA-Z0-9,], end
users and projects can add arbitrary values within the allowed
syntax, so it is not unconceivable that some project may have a
custom attribute that lists forbidden characters in a path with

	=== .gitattributes ===
        *.txt forbidden=`"

that tells their documentation cannot have these letters in it, or
something like that.
