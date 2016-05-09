From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] mingw: introduce the 'core.hideDotFiles' setting
Date: Mon, 09 May 2016 10:23:09 -0700
Message-ID: <xmqqeg9bw3gi.fsf@gitster.mtv.corp.google.com>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
	<cover.1462603453.git.johannes.schindelin@gmx.de>
	<32f14c212946c7c1da8007c8eff536fe82872f5b.1462603453.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 19:33:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azp1v-000897-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbcEIRXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:23:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751154AbcEIRXN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:23:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D77818250;
	Mon,  9 May 2016 13:23:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hri+LRGk/gh4hgYQ2TP0Tn7f3Xc=; b=sQPAAb
	+B7FYDapo/l+UtMOyDwUne84LU+sMzgE/ir5fL8cMmdg7M1WuPsL3SzsoYJ5CIzZ
	4qZVSDtnCL0L7WFq2TSmeHCdOi3cr4ahlFWf9OcGUXu1l0/NrEYOVc4fJtcgqEWs
	yz4ULWiT+gr8yFfm+K0TfcLDngmSjc7Ez7JCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gkq1PFrDBD/FaKF3hyDcqch7aEmyt5xE
	uZ7E+4hpOwiYo2flsynr6VK2tuYHM/x8qVg7Q/zYT37VRjkWRDvPus0QL23ARy8A
	CCabLYa7SXFMKkFDxU8hFOk2SArSEKDPzTMJSsN6QMfhJsso/vZrQfJixULTzoSv
	5GZmNCOP5BQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1560D1824E;
	Mon,  9 May 2016 13:23:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86AC31824D;
	Mon,  9 May 2016 13:23:11 -0400 (EDT)
In-Reply-To: <32f14c212946c7c1da8007c8eff536fe82872f5b.1462603453.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sat, 7 May 2016 08:45:03 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B487F728-160A-11E6-9993-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294022>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +core.hideDotFiles::
> +	(Windows-only) If true, mark newly-created directories and files whose
> +	name starts with a dot as hidden.  If 'dotGitOnly', only the `.git/`
> +	directory is hidden, but no other files starting with a dot.  The
> +	default mode is to mark only the `.git/` directory as hidden.

I think "The default mode is 'dotGitOnly'" is sufficient, given that
it is described just one sentence before, which is still likely to
be in readers' mind.  But I'll let it pass without tweaking.

> +enum hide_dotfiles_type {
> +	HIDE_DOTFILES_FALSE = 0,
> +	HIDE_DOTFILES_TRUE,
> +	HIDE_DOTFILES_DOTGITONLY,

We allow ',' after the last array initializer, but not after the
last enum definition.  I'll tweak it out while queuing.

> @@ -319,6 +364,21 @@ int mingw_open (const char *filename, int oflags, ...)
>  		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
>  			errno = EISDIR;
>  	}
> +	if ((oflags & O_CREAT) && needs_hiding(filename)) {
> +		/*
> +		 * Internally, _wopen() uses the CreateFile() API which errors
> +		 * out with an ERROR_ACCESS_DENIED if CREATE_ALWAYS was
> +		 * specified and an already existing file's attributes do not
> +		 * match *exactly*. As there is no mode or flag we can set that
> +		 * would correspond to FILE_ATTRIBUTE_HIDDEN, let's just try
> +		 * again *without* the O_CREAT flag (that corresponds to the
> +		 * CREATE_ALWAYS flag of CreateFile()).
> +		 */
> +		if (fd < 0 && errno == EACCES)
> +			fd = _wopen(wfilename, oflags & ~O_CREAT, mode);

This "retry if we got EACCESS" felt strange to me in two ways.  One
is explained well in the comment and you know what you are doing, as
opposed to me who is clueless with CreateFile() API.

The other is why you do not have to retry creation in a similar way
when !needs_hiding(filename).  I didn't see anything in the function
before reaching this point that does anything differently based on
needs_hiding().  Can't the same 'ERROR_ACCESS_DENIED' error trigger
if CREATE_ALWAYS was specified and file attributes of an existing
file match, and if it can, don't you want to retry that too, even if
you are not going to hide the filename?

That is, I am wondering, without knowing much about Windows API, why
the code is more like this:

	fd = _wopen(...);
        if (fd < 0 && ...) {
        	if (attrs != INVALID_...)
                	errno = ISDIR;
	}
        if ((oflags & O_CREAT) && fd < 0 && errno == EACCESS)
		/* That big comment here ... */
		fd = _open(wfilename, oflags & ~O_CREAT, mode);
	if ((oflags & O_CREAT) && needs_hiding(filename)) {
		if (fd >= 0 && set_hidden_flag(wfilename, 1))
                	warning("could not mark '%s' as hidden"...);
	}

Obviously, I will *not* do this tweak myself ;-)


> +		if (fd >= 0 && set_hidden_flag(wfilename, 1))
> +			warning("Could not mark '%s' as hidden.", filename);
> +	}

I'll tweak all new instances of "Could" with s/Could/could/ to save
Micheal trouble (cf. b846ae21daf).


Thanks.
