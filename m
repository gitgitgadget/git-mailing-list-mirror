From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarified how "git submodule add" handles relative
 paths.
Date: Wed, 01 Jun 2011 09:59:01 -0700
Message-ID: <7vsjrth4iy.fsf@alter.siamese.dyndns.org>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org>
 <1306943792-1825-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:59:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRolJ-0000br-UE
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725Ab1FAQ7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 12:59:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291Ab1FAQ7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 12:59:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B98565F5A;
	Wed,  1 Jun 2011 13:01:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qD8YCBAUvsgRuiIyQJDyv/6Va8=; b=uZBzYf
	RaveuAjV1tqIehFH62V9j2mQsCfUKkL40DLnL4Nve0isc+F8RXD6pU3XeeoE1Gza
	k1JvFdgw/VbRZOgIDVFANEVI3BdRKJbSrRy2KjoMxZAEX7ips3rrtlpgXqPtSAtX
	ekd/D6cY25Qy2Vq02eeVBBpVvoJZG/LwGfEc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vZYV3yhm28gG/nfhDIKd0yOeet7oaH5p
	Pxk0ZRLjfZz5iVTZShj1slbY1QCBRZrjc00BA6Ch0A+CAHEd/j0baKtg69R6uiDV
	Bx75BKbcWgU5CyyGFScu+cnsHhbEwkuIUKMSx3rYefDJLe4cWdF1OC+NVvJXMTCV
	O1mmko1PwXY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 863195F59;
	Wed,  1 Jun 2011 13:01:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 570695F57; Wed,  1 Jun 2011
 13:01:12 -0400 (EDT)
In-Reply-To: <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> (Marc
 Branchaud's message of "Wed, 1 Jun 2011 11:56:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3760DAC-8C70-11E0-B2BB-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174882>

Marc Branchaud <marcnarc@xiplink.com> writes:

> So this is really about saving the users the hassle of modifying all the
> URLs in the .gitmodules file.  Does this patch document what you mean?

I do not necessarily think it is _solely_ about users. Another obvious
example I left unsaid was what would happen when your project gets popular
and gets mirrored to many places. Surely you need to advise people of
alternate locations of the top-level, but what is recorded in .gitmodules
will be relative to that top-level, so they do not have to be changed.
Even if you have only one public repository, I would imagine that the same
convenience would apply if you ever decide to switch the project hosting
site.

"Users can use a URL different from what was given by the maintainer" is
merely an example; I doubt it deserves stressing that much.

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 1a16ff6..54dfebb 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -77,8 +77,17 @@ to exist in the superproject. If <path> is not given, the
>  +
>  <repository> is the URL of the new submodule's origin repository.
>  This may be either an absolute URL, or (if it begins with ./
> -or ../), the location relative to the superproject's origin
> -repository.
> +or ../) a URL relative to one of the superproject's remote
> +repostories:  If the superprojet's currently checked-out branch tracks
> +a remote branch then that remote's URL is used, otherwise the "origin"
> +remote's URL is used.  Relative URLs allow users to easily clone the
> +superproject and its submodules using a different URL than what the
> +superproject's maintainer might use (e.g. the maintainer can use ssh://
> +URLs while the users might use git:// URLs).  With relative URLs in the
> +.gitmodules file, the users won't have to edit all the submodule URLs.
> ++
> +*NOTE*: This means that you can *not* use a relative path to refer to a
> +repository in your local filesystem.

It is not "can not" but "do not", is it?  More importantly, I do not think
it is limited to the case of relative path at all.

I thought that in general "submodule add" takes a URL and never a _local_
filesystem location, as the whole point [*1*] of running "submodule add"
command is to update the entry in the .gitmodules file for people who may
not have access to _your_ local filesystem in the first place?

I am starting to suspect that the original confusion that started this
thread is coming from misunderstanding in this area.

[Footnote]

*1* The command also adds a corresponding entry to your own .git/config
file so that you can work as if you are just one of your users and as if
you did "submodule init" based on what is in .gitmodules.
