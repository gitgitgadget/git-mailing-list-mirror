From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Query on git commit amend
Date: Thu, 08 Dec 2011 09:52:04 -0800
Message-ID: <7vvcprar3v.fsf@alter.siamese.dyndns.org>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com>
 <7vobvlfowk.fsf@alter.siamese.dyndns.org> <87wra9und4.fsf@gmail.com>
 <4EDEE988.2070902@st.com> <20111207045325.GA22990@atjola.homenet>
 <4EDEFD66.4020404@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Vijay Lakshminarayanan <laksvij@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Viresh Kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 18:52:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYi8k-0008Dr-DC
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 18:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab1LHRwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 12:52:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507Ab1LHRwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 12:52:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DC9D74CE;
	Thu,  8 Dec 2011 12:52:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H6X48Wc96zNMlaYUSZ3ZHidLvXc=; b=mIjD4x
	fOCu4mbXfdlwrNTkgM9MTfzvHbd3IulJ0cCQktvCEpZadojSdDtqVrQUG4q6sfyH
	b7XWr4p1HoSM9wm50v9AT818iYlbtzq6h+h0KDppnDe4cHTPNeFcmE6mQzw+T5ps
	7fCjWq6x0yaGWTpYD8sfdeSKbeIXaTd5yoLRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DYGHBSOBbC98O+kXlblMvZ/l11uVK8+M
	i3N5nTONPYWgYMtGq6uYMasNnawu09fAe8GqOYKomOwfHGEoIT9BQu4W3thB6Mz5
	0TkHTwOttvX4chBDyElWe0/blMZCZ3pqvtMiZTumPSFVF5hAUk916T3K57Q4H7iM
	G4zofeww978=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65AC374CD;
	Thu,  8 Dec 2011 12:52:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3E0474CC; Thu,  8 Dec 2011
 12:52:05 -0500 (EST)
In-Reply-To: <4EDEFD66.4020404@st.com> (Viresh Kumar's message of "Wed, 7 Dec
 2011 11:15:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57990932-21C5-11E1-9D57-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186580>

Viresh Kumar <viresh.kumar@st.com> writes:

> GIT_EDITOR=cat git commit --amend
>
> over
>
> git commit --amend -C HEAD
>
> ?
>
> ...
> But for single commit probably second one looks easier. Isn't it?

I saw "--amend -C HEAD" mentioned in some newbie-guide webpages, and I
think you just copy/learned from one of them, so it is not entirely your
fault, but the combination of --amend and "-C HEAD" is an idiotic thing
that happens to work, if you think about what exactly you are telling to
the command.

The point of --amend is twofold. One is to let you tweak the contents of
what is committed, which is not the topic of this thread, and the other is
to allow the user to reuse the log message from the commit being amended,
instead of typing the message from scratch.

The "-c <commit>" and its cousin "-C <commit>" options are about telling
Git that the user does _not_ want the other usual logic to come up with
the initial commit template (e.g. when committing anew, it may read the
log template file, when committing a merge, it may read the MERGE_MSG
prepared by fmt-merge-msg, and most importantly in this context, when
amending, the one that is prepared by the --amend logic is used) kick in
at all, and instead wants to start from the log message of the named
commit.

So by saying "--amend -C HEAD" you are saying "I want to reuse the log
message of the commit I am amending,... eh, scratch that, I instead want
to use the log message of the HEAD commit", as if the commit you are
amending and HEAD are two different things. That is idiotic.

And you say that only for the side effect that capital "-C" stops the
editor.

Compared to that idiotic statement, "EDITOR=: git commit --amend" is a lot
saner way to say the same thing in a more direct and straightforward
way. "I want to reuse the log message of the commit I am amending, and the
editor to use it while running that commit is the command 'true', i.e. the
one that does not really touch any line in the text file and successfully
exits, because I am not going to change anything".

Of course, if "git commit --amend" honoured "--no-edit", that is even more
direct, straightforward and intuitive way to say so ;-)
