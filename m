From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add script for importing bits-and-pieces to Git.
Date: Mon, 24 Aug 2009 12:10:19 -0700
Message-ID: <7vy6p9do4k.fsf@alter.siamese.dyndns.org>
References: <20090824171110.DA9202FC20@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Aug 24 21:10:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfewO-0005kL-Eo
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 21:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbZHXTKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 15:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbZHXTKc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 15:10:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbZHXTKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 15:10:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19E4636E36;
	Mon, 24 Aug 2009 15:10:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9+vuZiAuqxI6yWtjuIL/TayvR1M=; b=Wg6yHT
	a+gtDsSrWA2hfi5S/d7JRpRc4zq+1uDuFVYu+2czv73aIVmznqOYK9miPTMuOKzQ
	39We0FJEtq5GteThNQFqyyKf319WTlFxm9ryaVH9UteiQQ9UjbxDmdNdIj/vFJpv
	aqwTeTw2rE+mSpUAHILMEH8JsZ5iil62oLRqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SBNmbdPNR1s8xDm6GLTH7uFv/kA5vM8K
	Q/prgidSCPIAyb/3FqIAEw2ujp1p6gJEYhg7mytL0jO3IuXqDLoSy1DiSKyD+oEJ
	D4Q2BRT3UCIZvUoZPDjQ1HR11rBZWoO4qkpd3K+xWyBcVS0WEjAjBVtBKbFELjp1
	fRqI6JFqjj8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC57936E35;
	Mon, 24 Aug 2009 15:10:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B36136E34; Mon, 24 Aug 2009
 15:10:21 -0400 (EDT)
In-Reply-To: <20090824171110.DA9202FC20@perkele> (Peter Krefting's message of
 "Mon\, 24 Aug 2009 18\:09\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C7A49236-90E1-11DE-B637-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126961>

Peter Krefting <peter@softwolves.pp.se> writes:

> +=head1 NAME
> +
> +import-directories - Import bits and pieces to Git.
> +
> +=head1 SYNOPSIS
> +
> +B<import-directories.perl> F<configfile>
> +
> +=head1 DESCRIPTION
> +
> +Script to import arbitrary projects version controlled by the "copy the
> +source directory to a new location and edit it there"-version controlled
> +projects into version control. Handles projects with arbitrary branching
> +and version trees, taking a file describing the inputs and generating a
> +file compatible with the L<git-fast-import(1)> format.

Nice write-up.

> +=head1 CONFIGURATION FILE
> +
> +=head2 Format
> +
> +The configuration file is using a standard I<.ini> format.

You might want to mention that this format is different from what git uses
for its .git/config and .gitmodules files, and none of the rules apply to
them (namely, two/three-level names, case sensitivity, allowed letters in
variable names, stripping of whitespaces around values, and value quoting)
described in 'git help config' apply to this file.

It was the first "huh" I had when reading your description below, when you
used "[3]" as a section name and "source.c" as a variable.

> +=head2 Revision configuration
> +
> +Each revision that is to be imported is described in three
> +sections. Sections should be defined chronologically, so that a
> +revision's parent has always been defined when a new revision
> +is introduced. All sections for one revision should be defined
> +before defining the next revision.
> +
> +Revisions are specified numerically, but they numbers need not be
> +consecutive, only unique.

You might want to clarify that they do not need to be monotonically
increasing either---you can have #3 as the root and then #1 with its
parent set to #3, right?

As you seem to be supporting merges, you might want to say topologically
instead of chronologically---this is minor, as you give more precise
definition "all parents must come before a child" in that sentence later.

> + timestamp=3/source.c
> + ...
> +=head3 Revision contents section
> +
> +A section whose section name is an integer followed by B<.files>
> +describes the files included in this revision.

To somebody who knows git it may be obvious but perhaps "describes all the
files" (or "lists all the files") would be clearer?  Otherwise, a naive
reader might be frustrated by getting unexpected results after listing
only modified or added files in this section.

> + [3.files]
> + ; the key is the path inside the repository, the value is the path
> + ; as seen from the importer script.
> + source.c=3/source.c
> + source.h=3/source.h

How are problematic characters in pathnames (say, SP, '=' or worse LF)
handled?  Do they need to be quoted, and if so how?

As an example in the documentation, 3/source.c is a bit unfortunate.  It
may be risking to get misunderstood that somehow the directory name must
match the revision label (numeric section name), which I think is not what
you meant to say here.  Perhaps use something like:

	source.c = project-v0.0.3/soruce.c

to clarify?

> +=head3 Revision commit message section
> +
> +A section whose section name is an integer followed by B<.message>
> +gives the commit message. This section is read verbatim.

Meaning "everything up to the beginning of the next section"?  Can a
commit message have a line that begins with a '[', perhaps as long as it
does not contain a matching ']', so that such a line does not
misinterpreted as starting a new, possibly invalid, section?
