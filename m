From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick generates bogus conflicts on removed files
Date: Thu, 17 Oct 2013 14:14:48 -0700
Message-ID: <xmqqiowvy4zb.fsf@gitster.dls.corp.google.com>
References: <52604166.8000501@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 23:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWuuG-0004Y8-DJ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 23:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136Ab3JQVOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 17:14:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758386Ab3JQVOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 17:14:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B754A4B11B;
	Thu, 17 Oct 2013 21:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AyiETW9V20R4Ojf5HsQq+CMXB1w=; b=ZEUKxv
	1UmIiWkrULVZld4xCj+iJNvBvfDffaUiwCNNrs+V0sDlqNXsv/i9MKQzXDo3wZ3I
	7Dvex/wFeDnuC17Tv9QxAyrd/1rrqKTP8wCoCYyTKgx7/Y30lJreWhFla0q1JiFV
	DWHK85i6+LqI3mwtiIu6v94/RoL9fsY5pRz9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kOXjJK+Wj0NuVVqJmppmOarC1f96vk13
	RH4S/rePd1+k2B0C6R31CRN7TRxtSSACSu4AkEt0k1kJoriVcZyAAKZn3mbGvYR4
	x6MlVa5demqsZRgSKFnx/B6IoXxHStCs8cmaGWstkq5YnIpmHOWFOcsIJTGg29mh
	r2KjDWewjus=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA38C4B11A;
	Thu, 17 Oct 2013 21:14:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1641F4B112;
	Thu, 17 Oct 2013 21:14:50 +0000 (UTC)
In-Reply-To: <52604166.8000501@ubuntu.com> (Phillip Susi's message of "Thu, 17
	Oct 2013 15:58:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2877B180-3771-11E3-8F03-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236322>

Phillip Susi <psusi@ubuntu.com> writes:

> I have a commit I am trying to cherry pick that removes a number of
> files.  It seems to generate conflicts for those files that have been
> modified on this branch since the common ancestor.

Correct.

Without inspecting them, you would not know what you would be losing
by blindly resolving to removal, hence we do not auto-resolve "one
side removed, the other side changed" to a removal.

That does not need to mean that we should not make it easier for the
user to say "resolve these 'one side removed, the other side
changed' paths to removal".

"add -u" will be a way to say "Record the changes I made to my
working tree files to the index".  So presumably

	rm -f those files that the other branch removed
        git add -u

would be one way to do so.  Of course, you can also use "git rm"
directly, i.e.

	git rm -f those files that the other branch removed
