From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add --exclude to git-clean.
Date: Mon, 19 Jul 2010 10:43:43 -0700
Message-ID: <7vbpa3pdtc.fsf@alter.siamese.dyndns.org>
References: <bf4ea4e83162ebf1d915b87413aad54a1162a637.1279556172.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 19:44:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OauNn-000849-Fx
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 19:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403Ab0GSRn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 13:43:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760747Ab0GSRn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 13:43:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC5EFC6AC4;
	Mon, 19 Jul 2010 13:43:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xcExicP4A7I8pydh79zMWpYhZIo=; b=FL8Bds
	FtBxr4nc7Odv/eZiWy9TZBrXScRqbf5YFsictQ3O3zyST4wgJrBiNnoChOqeCoIF
	oOq1V8v5p4a2XaztyKzEJBd2a+nrDqCdCZ6PdpifSl4JjoPs/IlisND7WdIoh2E6
	E0UQzOCcrDFpGwrcOO3uW+xAo4o2ZERTHozik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OwJfzX0SDVs7rEhfFfwKp1jAvbRYX9dL
	Z5sMkGThaX/p5aTzFQ6IL1kHD/xDsNV1mvtWH/s+zsPWvUHH0ceXsl5H26l/LuZB
	0nq0UAKBQn27H8SXlr6spBcM8Tvl55yWYgCQGaTeD1U1FevCK5zvFY751InL/xXg
	pz+dHW9mEqU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98FFCC6AC3;
	Mon, 19 Jul 2010 13:43:53 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F15AC6AC0; Mon, 19 Jul
 2010 13:43:50 -0400 (EDT)
In-Reply-To: <bf4ea4e83162ebf1d915b87413aad54a1162a637.1279556172.git.jaredhance@gmail.com> (Jared Hance's message of "Mon\, 19 Jul 2010 12\:18\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32AF664A-935D-11DF-9002-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151263>

Jared Hance <jaredhance@gmail.com> writes:

> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index a81cb6c..2bf9cf2 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
>  SYNOPSIS
>  --------
>  [verse]
> -'git clean' [-d] [-f] [-n] [-q] [-x | -X] [--] <path>...
> +'git clean' [-d] [-f] [-n] [-q] [-e] [-x | -X] [--] <path>...

This and ...

>  DESCRIPTION
>  -----------
> @@ -45,6 +45,10 @@ OPTIONS
>  	Be quiet, only report errors, but not the files that are
>  	successfully removed.
>  
> +-e::
> +--exclude::

this both look wrong.  They do not tell the readers that the option takes
a mandatory argument that specifies the "exceptions".  Worse yet,

> +	Specify special exceptions to not be cleaned. Separate with colon.

this does not tell _how_ exceptions are specified.

What should each element on the list look like?

Is it a dot-suffix without dot (e.g. "html") or with dot (e.g. ".html")?
Or is it a glob (e.g. "*.html")?  Or is it a full path relative to the
worktree root (e.g. "Documentation/index.html")?

Using colon as an inter-element separator makes sense only if last one is
true (i.e. "concrete path, not glob nor suffix"), so an intelligent reader
could probably guess what you meant, but you shouldn't make readers guess
in the first place.

If on the other hand you wanted to allow specifying the same kind of
patterns used in the gitignore files from the command line:

 (1) A list separated with whitespace would be more natural, not a colon;
     and

 (2) I have to wonder why do we give such a command line exclude override
     to begin with.

     (2-a) wouldn't it be easier for the user to add such a local
           configuration to $GIT_DIR/info/exclude once and be done with
           it?

     (2-b) if command-line override has benefit, why is it limited to only
           _exclude_ and not include (iow, additional ignore patterns)?
