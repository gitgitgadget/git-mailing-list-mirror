From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 11/18] merge: Add a new --index-only option, not yet implemented
Date: Fri, 08 Apr 2016 15:33:10 -0700
Message-ID: <xmqqzit3u3x5.fsf@gitster.mtv.corp.google.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
	<1460098726-5958-12-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:33:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoext-0007xI-Ag
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 00:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759233AbcDHWdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 18:33:14 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759087AbcDHWdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 18:33:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BC7052D27;
	Fri,  8 Apr 2016 18:33:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NgSnsDF7I3LNlAZViH9yHyBw6G0=; b=Ub32ml
	CUQcVKscfu8Vf6Nvd3K9798IL9cOlavEq2fRklKp76Er9O+u2eTSzAkPzOgylI/Z
	rhJX1KqIInRRhfdC1mgagE329q+oK7PALPkoIQ7pEPO8QDYR1Kd/Mx4NLWBKTD+M
	dp4WtfYpNkJI3Hm8DzBo4Hjvc3l40tmcPNK6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=as5SkAyIrmnSrD1AVtiZ+x4SjRnmygcp
	9FpB3b5rprKyHIxmnmif1Q79Kj0FR7pZzTFbtSSZ7YN3Kj6ZFO6XlqLzlRBxPX/E
	8UuJjifrBOvpuaRkofMVMaICz0MbNJCuVS6neBspmKnQ5TiVspQYkyw8xurPaT5J
	8ie9mYnyDbg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02E1052D25;
	Fri,  8 Apr 2016 18:33:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7D84E52D24;
	Fri,  8 Apr 2016 18:33:11 -0400 (EDT)
In-Reply-To: <1460098726-5958-12-git-send-email-newren@gmail.com> (Elijah
	Newren's message of "Thu, 7 Apr 2016 23:58:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E02A8F9C-FDD9-11E5-9AF8-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291075>

Elijah Newren <newren@gmail.com> writes:

> +--index-only::
> +	Perform merge on index only, leaving working tree alone.  Most
> +	users do NOT want to use this flag, as it will leave the
> +	working tree and the index completely out of sync, which is
> +	very likely to confuse users and prevent a subsequent 'git
> +	merge --abort' from working.

This whole paragraph is a strong sign that this feature as-is is not
a good addition.

On the other hand ...

> +	It is intended for script
> +	writers to have a way to easily check whether a merge would
> +	succeed and which files would conflict, typically from bare
> +	clones.

... this may be a good goal to aim for, but I think you are
understating.  You seem to be wanting a lot more than "easily check
whether..."; isn't this more like "It is for scripts to create a
merge and advance the branch when no need for manual conflict
resolution in a bare repository, and to learn which paths would
require manual conflicts when it fails", no?

I'd think either (1) limit this to bare repository only, or (2) do
the "git merge --into master en/topic" I outlined in the other
message, (or both) would be a sensible alternative for a feature
whose description has to begin with "Most users do not want this".
