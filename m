From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] "diff -B -M"
Date: Fri, 06 Feb 2015 14:47:24 -0800
Message-ID: <xmqqegq2d5dv.fsf@gitster.dls.corp.google.com>
References: <xmqqvbjed76s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 23:47:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJrgS-0002uC-BL
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 23:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbbBFWr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 17:47:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751334AbbBFWr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 17:47:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 967C43411C;
	Fri,  6 Feb 2015 17:47:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ErqLNVK4KTSqilYi0t2pwttGZrc=; b=R/qJgk
	TodldGd+66oeXZbpzBXhzJx+1LpGslR5VosGteQc2/+Hu7QSLa38YlKzSbjDGAh4
	H6OM0DB8WN9hDJeT7oLxXNWmkdnLkNY/On9tlA8+RmUmg1YIDW7DbpZTaN8aOhO2
	LIIqxXqeF4vMmvAjVIjBVETyUxIk4qx48Pu5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dfujDG29Tv8vMzLBWEPXSYvO834qoOjW
	A5iWtl7tP4j8zIygaVy1bKmsnp4mAR45uYF0y1lBk4193Tqb9D5wDUpu3ukOLsXX
	XiZFBw2/kJzcyiK31o64zg0crkdSLNenfDEBO6XJ+LQj9TpOXK11SDBVurbocadR
	OK7BJq6pd+8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E24C3411B;
	Fri,  6 Feb 2015 17:47:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16A8F3411A;
	Fri,  6 Feb 2015 17:47:26 -0500 (EST)
In-Reply-To: <xmqqvbjed76s.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Feb 2015 14:08:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F251452-AE52-11E4-B89B-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263433>

Junio C Hamano <gitster@pobox.com> writes:

> 5. Third twist: rewriting by copying
> ...
> One possible way to fix this is to include another patch in the same
> patchset that shows the deletion of major-11.txt.  The rule 2. would
> be further revised to something like:
>
>  rule 2. a patch renaming file A to file B requires that file A
>          exists and file B does not exist in the target tree, unless
>          another patch in the patchset renames file B to some other
>          file (possibly but not necessarily file A) or removed file

Typofix: s/removed/removes/

>          B, in which case file B must appear in the target tree.
>
> Such a patchset would look like this:
>
>     diff --git a/major-08.txt b/major-11.txt
>     similarity index 97%
>     rename from major-08.txt
>     rename to major-11.txt
> ...
>     diff --git a/major-11.txt b/major-11.txt
>     deleted file mode 100644
> ...
>
> And these patches, under the re-revised rule 2. and rule 4., would
> apply cleanly to the old tree.
>
> What about the reverse application?  It would be a patchset that
> creates major-11.txt from nothingness, and creates major-08.txt by
> renaming major-11.txt and editing.  Is the rule 2. re-revised above
> sufficient?
>
>     renaming major-11.txt to major-08.txt requires that major-08.txt
>     does not exist in the target tree, unless...
>
> and the new tree (which is the target of the reverse application)
> only has major-11.txt and not major-08.txt, so this rename should go
> through.  The reverse of the deletion of major-11.txt is a creation
> of it with the contents fully given as the pre-image of the
> (original) patch before reversing it, so that should also be OK with
> rule 3.

... But rule 3. needs tweaking.  The second patch would be creating
major-11.txt which requires major-11.txt to be missing in the target
tree.  But obviously, the new tree the patch we are applying in
reverse was taken from has major-11.txt.  So we would need a
revision to it as well.

 rule 3. a patch that creates file A requires that file A does not exist
         in the target tree, unless another patch in the same patchset
         renames file A away or removes it.

> So tentatively, I would say...
>
> 	Action item: do not filter delete-half of the broken pair
> 	out, even when the other create-half of the pair no longer
> 	is in the output.
>
> 	Action item: update "git apply" to honor the rule 2.
> 	re-revised above.

The latter should read:

	update "git apply" to honor the revised rule 2. and 3.
