From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Thu, 24 Jan 2013 11:51:27 -0800
Message-ID: <7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
References: <50FBD4AD.2060208@tu-clausthal.de>
 <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	davvid@gmail.com, Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TySq1-0004TX-7R
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab3AXTvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 14:51:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755144Ab3AXTva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 14:51:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A35CBCF04;
	Thu, 24 Jan 2013 14:51:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wSx2qpU/2A2GhpHDoX+YuSLGlYw=; b=UVd0eN
	zS+wq+chveth3vxVh9+SSmM29qUiWHchSEFOYzCrkUvkNoXXQQxmlmOQ09gX/jur
	2b/8QrKdzSEn34Ku8XhtL3pheOaDfKEP9uRzU3yYUjvUiTiikjtgCu8bYNnYyk1l
	KeTIh6WDIP1pEiMmqr7uNS7UeS1Igi4tWoSSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DiBe6o6Um8Oz8vG9n+je4xKjBgDGqFXI
	swJ1+kCYk/UXG6Xu+c9TdoM2SPQzTzaJbiny5fr91zJ4C6to/pkBteGtzHvZQ/Lw
	yRNCMsdrCf4uj6NtXtMH8IFataJyhTBJIMlZCKEcy2Jqi5iE6/zvJkceMD78/vtY
	kKuClkk1a5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96E21CF03;
	Thu, 24 Jan 2013 14:51:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBB3ECF01; Thu, 24 Jan 2013
 14:51:28 -0500 (EST)
In-Reply-To: <50FCFBBB.2080305@tu-clausthal.de> (Sven Strickroth's message of
 "Mon, 21 Jan 2013 09:26:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71AEB684-665F-11E2-84C6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214443>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> - The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
>   (starting with 1.8.0) in order to make clear that this one has special
>   support for git and prevent confusion with the TortoiseSVN TortoiseMerge
>   version.

Wouldn't it make more sense in such a situation if your users can
keep using the old "tortoisemerge" configured in their configuration
and when the renamed one is found the mergetool automatically used
it, rather than the way your patch is done?  It seems that you are
forcing all the users to reconfigure or retrain their fingers.  Is
that the best we can do?  Is it too cumbersome to autodetect the
presense of tortoisegitmerge and redirect a request for tortoisemerge
to it, perhaps using translate_merge_tool_path (cf. mergetools/bc3)?

Assuming that people that have both variants will always want
mergetool to use tortoisegitmerge, that is.  If there are some
features missing from or extra bugs in tortoisegitmerge that makes
some people favor tortoisemerge, then giving two choices like your
patch does may make more sense.  I only know the difference between
the two from your four-line description above, but it does not look
like it is the case.

> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 4314ad0..13cbe5b 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -151,7 +151,7 @@ diff.<driver>.cachetextconv::
>  diff.tool::
>  	The diff tool to be used by linkgit:git-difftool[1].  This
>  	option overrides `merge.tool`, and has the same valid built-in
> -	values as `merge.tool` minus "tortoisemerge" and plus
> -	"kompare".  Any other value is treated as a custom diff tool,
> +	values as `merge.tool` minus "tortoisemerge"/"tortoisegitmerge" and
> +	plus "kompare".  Any other value is treated as a custom diff tool,
>  	and there must be a corresponding `difftool.<tool>.cmd`
>  	option.

So in short, two tortoises and kompare are only valid as mergetool
but cannot be used as difftool?  No, I am reading it wrong.
merge.tool can be used for both, kompare can be used as difftool,
and two tortoises can only be used as mergetool.

This paragraph needs to be rewritten to unconfuse readers.  The
original is barely intelligible, and it becomes unreadable as the
set of tools subtracted by "minus" and added by "plus" grows.
