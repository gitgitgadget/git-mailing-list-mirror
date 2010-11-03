From: Shinya Kuribayashi <skuribay@pobox.com>
Subject: Re: [stgit PATCH] commands.{new,rename}: verify patch names
Date: Wed, 03 Nov 2010 11:43:29 +0900
Message-ID: <4CD0CC51.5030402@pobox.com>
References: <20101005125631.17466.95192.stgit@woodpecker.blarg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Max Kellermann <max@duempel.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 03:58:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDTYU-0001eE-Gb
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 03:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab0KCC60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 22:58:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750988Ab0KCC6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 22:58:24 -0400
X-Greylist: delayed 885 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Nov 2010 22:58:24 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47FC217A3;
	Tue,  2 Nov 2010 22:43:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=MYGgK6l6flLq
	jmWpg+7AbaTlWzA=; b=fHNFwL0QQIDUoL7AFf/uE5CjUaf6KWWlHMVGi20380RW
	mnWugWFzxa396Wi8pCYwCiwtY+paz2CVwdd+20mCFgzAvnzxoWtS0HDT3hXWCe/b
	EnmhMqHHAlVJgdii8hOuyt2d4A7m4pSsEGz6XGEJGKgJqquK6zPwLf6YhIsVV70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XNNVQn
	HdvAoVD/wLWfwqwHUcbV0Z5dNOjcXtLsMhrIyZBVHJfBviJhGgeMOArIkR0LGc2t
	3cDeXYrx5ekJcwu+4mPYykOiLip+3NWWjhjb0CjTwmD0BuPUKyjz+zCy+crRQfm0
	KpSr6gLx3CEkO7qZPMTtV8MP7pHOPBQ6z+PII=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2543F17A2;
	Tue,  2 Nov 2010 22:43:37 -0400 (EDT)
Received: from Shinya-Kuribayashis-MacBook.local (unknown [180.12.66.33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits)) (No client certificate
 requested) by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2421E179E;
 Tue,  2 Nov 2010 22:43:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US;
 rv:1.9.1.15) Gecko/20101027 Thunderbird/3.0.10
In-Reply-To: <20101005125631.17466.95192.stgit@woodpecker.blarg.de>
X-Pobox-Relay-ID: 288EE006-E6F4-11DF-A4BB-A167C76EB067-47602734!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160569>

Hi,

On 10/5/10 9:56 PM, Max Kellermann wrote:
> Don't allow patches with invalid names.  For example, a patch with a
> slash in the name will cause the underlying git command to fail, and
> stgit doesn't handle this error condition properly.
> ---
>   stgit/commands/new.py    |    3 +++
>   stgit/commands/rename.py |    3 +++
>   stgit/utils.py           |    6 ++++++
>   3 files changed, 12 insertions(+), 0 deletions(-)

It would be nice to mention about what's updated when revising
patches, even though it's even +1 line.  And we'd also like to
have a sign within Subject:, e.g., [stgit PATCH v2] will suffice.

> diff --git a/stgit/utils.py b/stgit/utils.py
> index 2955adf..a41457b 100644
> --- a/stgit/utils.py
> +++ b/stgit/utils.py
> @@ -241,6 +241,12 @@ def make_patch_name(msg, unacceptable, default_name = 'patch'):
>           patchname = default_name
>       return find_patch_name(patchname, unacceptable)
>
> +def check_patch_name(name):
> +    """Checks if the specified name is a valid patch name. For
> +    technical reasons, we cannot allow a slash and other characters."""
> +    return len(name)>  0 and name[0] not in '.-' and '/' not in name and \
> +           '..' not in name and re.search(r'[\x00-\x20]', name) is None
> +
>   # any and all functions are builtin in Python 2.5 and higher, but not
>   # in 2.4.
>   if not 'any' in dir(__builtins__):

".." is now taken care, too.  That's nice.

By the way, you're not the first person encountered this issue,
and we already have corresponding bug# at gna.org, you might be
interested in:

* https://gna.org/bugs/?10919
   sanity check patch names

* https://gna.org/bugs/?15654
   stg new when path contains slash stops stg from doing everything

I don't speak Python, so couldn't help the patch itself.
Catalin and Karl hopefully will guide you (they seem to busy
these days, or just failed to find this thread).
