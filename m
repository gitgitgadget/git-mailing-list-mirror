From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A branch question
Date: Tue, 10 Mar 2015 14:13:59 -0700
Message-ID: <xmqqoao0zhbc.fsf@gitster.dls.corp.google.com>
References: <6AC11CE0-764C-4CC5-89CD-05FFB6D29EA3@jrw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: "J. R. Westmoreland" <jr@jrw.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 22:14:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVRTd-0001Mp-4s
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 22:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbbCJVOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 17:14:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753045AbbCJVOD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 17:14:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C741A3E5AB;
	Tue, 10 Mar 2015 17:14:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rNFQrolqqUxBjJdaftcZ5IF5fBU=; b=IWisRR
	K4NaY2rN4TLuj7wrZuhAvppB24XpWZTyggBTO6y2hnKdzIeGN2iL4g22NNHyQh63
	/keh6j4l3unYddcFIsWRvCK+tGlsVVefbi+8adFqfd1avVXMu3CS2qT1yhBf3lBQ
	SJTq3f6cstQPBDuxb5MLMtE9BY4nVg9U4vqQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XYaSmZLLg6jR1EqwN40s8dXIPv9asmuz
	khFOFlaUSmV/w/FtjLzJM9DRpJK7YzMwyMjqXpTe+0OKriuHgJeFUfrmeeD0IrDg
	MgUlCKKYAcSpf50gFojyq6OcVpILH2P2rCkrRJlzGh5rKXiSpQkbXMtX089d4i5u
	C7vFLR/PJL8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B289D3E5AA;
	Tue, 10 Mar 2015 17:14:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 955053E5A6;
	Tue, 10 Mar 2015 17:14:00 -0400 (EDT)
In-Reply-To: <6AC11CE0-764C-4CC5-89CD-05FFB6D29EA3@jrw.org>
	(J. R. Westmoreland's message of "Tue, 10 Mar 2015 14:56:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F4B6474-C76A-11E4-A665-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265264>

"J. R. Westmoreland" <jr@jrw.org> writes:

> I have a number of repos that were converted from svn to git. After
> the conversion the branches that contained each release were named
> something like “branches/version_<version-number>”. We want to
> modify the repo so the branches are named something like
> “release/<version-number>”.
>
> I currently do a command sequence like this:
> git checkout <existing-branch>
> git branch -m <existing-branch> <new-branch>
> git push origin :<old-branch>
> git push origin <new-branch>
> Then I do a:
> git checkout master
> git branch -D <new-branch>
> to cleanup my local area.
>
> Note: These branches are only kept for historical purposes and not
> modified except occasionally the latest release may have an update so
> fix a bug.
>
> Finally, as we move forward, what is the accepted best practice for doing a release?

A few comments:

 1. You can rename a branch without checking it out, can't you?

    $ git branch -m version_1.0 v1.0
    $ git branch -m version_1.1 v1.1
    ...

 2. If you want to only correct what is shown at origin to the other
    people, then you do not have to update your local repository.

    $ git push origin version_1.0 v1.0
    $ git push origin version_1.1 v1.1
    ...

 3. If these old ones are meant to be immutable, then storing them as
    tags instead of leaving them as branches might make more sense,
    i.e.

    $ git push origin version_1.0 tags/v1.0
    $ git push origin version_1.1 tags/v1.1
    ...

   If you are still actively maintaining an older release, you would
   still want to have release points marked on the maintenance
   branch, so 2. and 3. can be combined.  Branch v1.0 may be used to
   backport fixes to produce v1.0.x releases, each of which would be
   tagged individually, perhaps like this:

    $ git checkout version_1.0
    
    : rename it to maint-1.0 to clarify this is for 1.0.x series
    : maintenance
    $ git branch -m maint-1.0

    : tag the released version, with GPG signature
    $ git tag -s v1.0 maint-1.0

    : push the whole thing out
    $ git push origin maint-1.0 v1.0

    : when it is time to do more on the older maintenance track
    $ git checkout maint-1.0
    : hack hack hack to prepare maintenance release
    $ git commit

    : sign the release tag
    $ git tag -s v1.0.1

    : push the whole thing out
    $ git push origin maint-1.0 v1.0.1


3. is what I would be using if I were you.
