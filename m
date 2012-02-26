From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: do not print dangling objects by default
Date: Sun, 26 Feb 2012 13:57:40 -0800
Message-ID: <7vty2ddzqj.fsf@alter.siamese.dyndns.org>
References: <20120226204357.GA26088@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Feb 26 22:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1m6N-0004gd-Kp
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 22:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab2BZV5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 16:57:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab2BZV5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 16:57:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F1986A51;
	Sun, 26 Feb 2012 16:57:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XJfELE0Auh8k26Vc9H8INWCqDFg=; b=DETfGJ
	8tIGicopKy71gPlhHXJr3LtET2GALk75jn6tq3vEgOBHIr1FjKLzWyfR55U+QxyQ
	MqdoPKGQA8LE6l+o3yny3JR3YbgtKkVQAGUx2skwEZZHCoxAoTXTVupynOzJGlJE
	uc61PA+Fmax0PzVQ+7juA04wuNs602IQL5vi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K9huHJXSC+pOh0nMYyvhL8dHD6bu85fn
	pe3IyEyRW/74Jp9hjZzB30fYxkO4/p+fh4179vqVVL6e/+oiaAlaoRQlu/0UwnWe
	i2zbk3ZZv2wAeHmK0adyy4J4BFa7vZc/FN00OBJpJZHCdn3cmXSlblydWHgSUtHA
	YtbKV58IWhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26EF16A50;
	Sun, 26 Feb 2012 16:57:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88E356A4F; Sun, 26 Feb 2012
 16:57:41 -0500 (EST)
In-Reply-To: <20120226204357.GA26088@ecki> (Clemens Buchacher's message of
 "Sun, 26 Feb 2012 21:43:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7BEA006-60C4-11E1-B571-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191577>

Clemens Buchacher <drizzd@aon.at> writes:

> Every reference to git fsck that I could find in the documentation or on
> the web is followed by the some kind of assurance that dangling objects
> are "not a problem", "nothing to worry about" or "not at all
> interesting".
>
> Instead of telling the user everywhere to ignore those messages, let's
> not print them in the first place. The --dangling flag can be used to
> explicitly enable printing dangling objects.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Thanks.

I think that both the ultimate goal explained above, and the direction in
which the documentation updates tries to move us, are good.  I only gave a
cursory look at the code changes, but what they implement seems to match
the intention.

Of course I may be missing something, so objections from others to argue
why we shouldn't do this is very much welcomed to stop me and Clemens ;-).

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index f13a846..09ffbcc 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1582,25 +1582,12 @@ Checking the repository for corruption
>  
>  The linkgit:git-fsck[1] command runs a number of self-consistency checks
>  on the repository, and reports on any problems.  This may take some
> +time.
>  ...
> -Dangling objects are not a problem.  At worst they may take up a little
> -extra disk space.  They can sometimes provide a last-resort method for
> -recovering lost work--see <<dangling-objects>> for details.

Losing this description is not a problem and is indeed an improvement in
this section in the user manual, but let's make a mental note that the
user needs to also learn what the third sentence says elsewhere in this
document.

 << reads on >>

> @@ -1665,7 +1652,7 @@ commits in the dangling objects that `git fsck` reports.  See
>  <<dangling-objects>> for the details.
>  
>  -------------------------------------------------
> -$ git fsck
> +$ git fsck --dangling
>  dangling commit 7281251ddd2a61e38657c827739c57015671a6b3
>  dangling commit 2706a059f258c6b245f298dc4ff2ccd30ec21a63
>  dangling commit 13472b7c4b80851a1bc551779171dcb03655e9b5
> @@ -3301,9 +3288,6 @@ broken link from    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
>  missing blob 4b9458b3786228369c63936db65827de3cc06200
>  ------------------------------------------------
>  
> -(Typically there will be some "dangling object" messages too, but they
> -aren't interesting.)
> -

The old sentence becomes stale as the example _explicitly_ asks the
command to show the dangling ones.

>  Now you know that blob 4b9458b3 is missing, and that the tree 2d9263c6
>  points to it.  If you could find just one copy of that missing blob
>  object, possibly in some other repository, you could move it into

And this part, together with the introductory text of the section (not
shown in the context), says what the "third sentence" above wanted to say.

So overall I think this is a vast improvement without losing any
information or clarity.

Nice.
