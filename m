From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [feature request] 2) Remove many tags at once and 1) Prune tags
 on old-branch-before-rebase
Date: Thu, 07 Mar 2013 15:33:44 -0800
Message-ID: <7v38w6lr8n.fsf@alter.siamese.dyndns.org>
References: <51390E43.60704@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Fri Mar 08 00:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDkKC-0006IX-TX
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 00:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759877Ab3CGXdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 18:33:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50338 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab3CGXdq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 18:33:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CA57A579;
	Thu,  7 Mar 2013 18:33:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PQwVgWW5LL0cAmiQdGat62yji2A=; b=igxcWS
	93Wel9ID2odjT2cf1s39QKoaaXxbOMJt3Pa8vHCgHAu6RlKdOEH8FtBwcOzwZ+Ol
	3tmtn0st+7/S7VeH+sLirO80Bkg9ZbUCe92ippUJWi1c/o0Px555tY7Vy+QqC0jX
	528QrSue/4N1QOCQnwL05OBxDVhCHhn49ZjXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fju7hg4f7R6o3Qvne1nxU2Pf/ASQs6if
	+bjr4PCFH0fIyzySdOABM0uyGkW1UZ/h7yp3nlbIbwu2vkWFm4I9Nb2AhclSi+/8
	tS6lK+gbN2chCuLlkrs4wDtxQctvvLTMi1vsiDWdhr0GNfC2OllU6yrsYJ993FxH
	N7kAmLhusF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4262EA578;
	Thu,  7 Mar 2013 18:33:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E55FA577; Thu,  7 Mar 2013
 18:33:45 -0500 (EST)
In-Reply-To: <51390E43.60704@giref.ulaval.ca> (Eric Chamberland's message of
 "Thu, 07 Mar 2013 17:01:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 745061EE-877F-11E2-987D-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217630>

Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:

> 1) git tag --delete-tags-to-danglings-and-unnamed-banches
>
> This would be able to remove all tags that refers to commits which are
> on branches that are no more referenced by any branch name.  This is
> happening when you tag something, then "git rebase".  Your tag will
> still be there on the old-and-before-rebase branch and won't be
> "pruned" by any git command... (that I know of...)

Not interesting for at least two reasons.

Why are "tags" any special?  "git branch --delete-merged" may also
be of interest, and for that matter "git update-ref -d" to deal with
any ref in general would be equally valid if such an option were a
good idea.

What you want is a way to compute, given a set of tags (or refs in
general) and a set of branches (or another set of refs in general),
find the ones in the former that none of the latter can reach.  With
that, you can drive "git tag -d $(that way)".

In other words, the feature does not belong to "git tag" command.

> 2) git tag -d "TOKEN*"

Again, not interesting.  You already have:

    git for-each-ref --format='%(refname:short)' refs/tags/TOKEN\* |
    xargs -r git tag -d
