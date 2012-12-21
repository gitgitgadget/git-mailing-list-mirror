From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-update-index: caution about tree
 objects
Date: Thu, 20 Dec 2012 18:56:58 -0800
Message-ID: <7vvcbw2jut.fsf@alter.siamese.dyndns.org>
References: <1356053738-14926-1-git-send-email-gdt@ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 03:57:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlsnY-0003t1-RG
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 03:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab2LUC5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 21:57:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab2LUC5B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 21:57:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C557A432;
	Thu, 20 Dec 2012 21:57:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kg5FMMPCmrnyVdjhpL1686153AE=; b=TP9uvQ
	u5TDbARQZoWWjY9zH/uRF9tr2OHQyCXFMnlTEF5n/U6enzTJb+z8aD0fnmd0saM4
	ge3/klMHOSke89vPiFXeo3An7tvZbXJWnrA0z0Nlh44KdbVsPOn0me8CSy44Ww2I
	qQwAsppxbqYwT432JVJOfkRFAVcFhid15O80A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ROoBp+5EMfw0Qdv8zZU7P2yiZUZp0fJs
	3aDJFIFAYQ/ly+A31lIPF/KrjtclVaai0R/74HkjaMH76ETTeQ4/0actl0MQhu5u
	PQctKpIRa/iW8q9zJUtf58R629nTIJz3a1r79O5nNp9Oh+vl2mwm9Kgd9OJqYQZ1
	GUbKfCuPmJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A0BBA431;
	Thu, 20 Dec 2012 21:57:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC03EA430; Thu, 20 Dec 2012
 21:56:59 -0500 (EST)
In-Reply-To: <1356053738-14926-1-git-send-email-gdt@ir.bbn.com> (Greg
 Troxel's message of "Thu, 20 Dec 2012 20:35:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16D8DD26-4B1A-11E2-848D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211941>

Greg Troxel <gdt@ir.bbn.com> writes:

> While one can add tree objects to the index, this is not currently
> useful.  Therefore, use "git ls-tree -r" as the example to be fed to
> --index-info.  Add a section explaining about expected index contents.
> (Thanks to Junio for explaining this to me in August of 2011.)
>
> Signed-off-by: Greg Troxel <gdt@ir.bbn.com>
> ---
>  Documentation/git-update-index.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 9d0b151..6ce65fa 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -29,6 +29,11 @@ Modifies the index or directory cache. Each file mentioned is updated
>  into the index and any 'unmerged' or 'needs updating' state is
>  cleared.
>  
> +Note that update-index does not check that the modifications preserve
> +the expected invariants.  In particular, an index normally holds
> +regular blobs, executable blobs, symlink blobs, and gitlinks.
> +Therefore, adding a tree object is not likely useful.
> +

I find this unnecessarily alarmist as a description meant for
general audiences.  For the normal mode of operations of the command
(e.g. "git update-index --add --remove hello.c"), whatever you mean
by "expected invariants" are fully preserved.

I think you meant this for --cacheinfo and --index-info options,
which are primarily meant for people who know what they are doing
(that includes the use of this command in scripted Porceains) or Git
developers who want to work on enhancing the index (and to them,
being able to record anything is more convenient).

> @@ -210,7 +215,7 @@ back on 3-way merge.
>  
>      . mode SP type SP sha1          TAB path
>  +
> -The second format is to stuff 'git ls-tree' output
> +The second format is to stuff 'git ls-tree -r' output
>  into the index file.

This hunk is good.

Thanks.
