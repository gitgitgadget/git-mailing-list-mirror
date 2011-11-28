From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a "--follow" equvalent argument to git-rev-list?
Date: Mon, 28 Nov 2011 11:53:46 -0800
Message-ID: <7vaa7guiph.fsf@alter.siamese.dyndns.org>
References: <87vcq4zg6p.fsf@dod.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steinar Bang <sb@dod.no>
X-From: git-owner@vger.kernel.org Mon Nov 28 20:53:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV7H0-0004aD-Oo
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 20:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab1K1Txt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 14:53:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab1K1Txt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 14:53:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83AB165A3;
	Mon, 28 Nov 2011 14:53:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cnD4JI0wCC5s6T5PEEv1vC7TJ14=; b=DCUdOK
	foZzY0nA+uMgA2oS2RZN1WwXqnIa6B6BWtU4v6D89t81UFoy2xxLjELXfj13XF+y
	i4BjNFAESoHL4drZd6hWitynxANgzbunzrtqm7y6yQam/q8SZH5Yv27sQJqlgzd0
	toA3BNZW73unD7Ra5JUWIiy7e+FtcZmW/lemQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJ7K7vIzW4ygAihdMFUJXboMxFFEn5ML
	cpnTUgGIyCMuZWi/j1TuC8RrEZPimWYxWo5y5gX33tV3uc4lPllMVOqMeTDlxn+8
	4o+ptMBRksWlZ2fWsji2XO54eaElcsll6XbojE3yYRj4AOJvCkVbb4CUuVb0fzcu
	IRs1cswVawY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A1F965A2;
	Mon, 28 Nov 2011 14:53:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F1E165A1; Mon, 28 Nov 2011
 14:53:47 -0500 (EST)
In-Reply-To: <87vcq4zg6p.fsf@dod.no> (Steinar Bang's message of "Mon, 28 Nov
 2011 11:37:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFDB4290-19FA-11E1-9281-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186032>

[administrivia: do not use Mail-Followup-To here]

Steinar Bang <sb@dod.no> writes:

> Is there an argument to "git rev-list" that will make it track across
> renames?

There isn't, and it is more or less deliberate.

The "log --follow" is not meant as anything more than a checkbox hack. The
intended audience of "rev-list" is scripts that reads plumbing output and
it is expected to be capable of doing all of what "follow" does and more.
It can notice that the path you were following has disappeared at a
particular commit, see what other paths (notice the plural, which is not
what --follow does) in the older tree may have contributed the contents of
the newly added path by running "diff-tree -M" (or -C), etc. That way the
scripts can even notice a case where a file you were following originally
were two separate files that the commit merged into one, which "follow"
would never do.
