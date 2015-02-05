From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report: Folder and files are deleted by git stash -u
Date: Thu, 05 Feb 2015 11:37:31 -0800
Message-ID: <xmqqegq4kv44.fsf@gitster.dls.corp.google.com>
References: <CADEaiE8zSptYy9GTi4ZZ2bZptbretW6kDM4srmrSqaYeavfFhg@mail.gmail.com>
	<xmqqvbjgkw4i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Tobias Preuss <tobias.preuss@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:38:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJSFf-0004pQ-JV
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbbBEThu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:37:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754313AbbBEThe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:37:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5164735CD4;
	Thu,  5 Feb 2015 14:37:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Rmw+rLG7qZgenTEjCwrZ3cbDlU=; b=aRlpSc
	wX95BwAU70QJibQAyLDzIUPbVmYs0lN23nAejKg+4dhHfuA7tKdBkVNL9rEUBxjW
	q5ObVtgqLWQFr7Duv2dxsmESeQzsZdiee7lIsAb23+A3D/FmTvV2uEldCLf3fZqH
	BjopGrv7jtG8ebu3rbPLJgkvd1rqMVThAXVmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yekotJULkTtKsd4If8FXWtETTnVbpR6F
	AKZS5h2SAZrJydzMB/CURDMPVzDBt1i2nMbzLgUcAXp8upamanZSUzwNt0rGMPuf
	pomOKEnLcpvDB7j7E17JYPEbaLLC4wnW/zYJ2SEcrdTxugpkXB9aOlj/bBC/GK6B
	Af4KZIsNios=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4963935CD2;
	Thu,  5 Feb 2015 14:37:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C703835CD0;
	Thu,  5 Feb 2015 14:37:32 -0500 (EST)
In-Reply-To: <xmqqvbjgkw4i.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 05 Feb 2015 11:15:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6DCED8FC-AD6E-11E4-90AD-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263392>

Junio C Hamano <gitster@pobox.com> writes:

> Tobias Preuss <tobias.preuss@googlemail.com> writes:
>
>> I noticed some bizarre behaviour when using: git stash -u.
>> It deletes folders which contain files configured to be ignored.
>
> The files you mark as ignored are expendable and this is not limited
> to "stash".
> ...
> Here is what should happen when you go to 'master':
>
>     $ git checkout master
>     Switched to branch 'master'
>     $ /bin/ls -AF
>     a  .git/  .gitignore
>
> That is, a/file.c that is safely stored in 'side' branch is removed,
> a/file.o that is expendable is deleted, and the empty directory 'a'
> now can be replaced with the regular file 'a' the 'master' branch
> wants to have.

Addendum 1.

    If *.o files are not treated expendable, you would be forced to
    "make clean" every time you switch between these two branches,
    which is unacceptable.

Addendum 2.

    There was an old wishlist item to introduce another class of
    paths (in addition to the "tracked", "untracked" and "ignored")
    that are "ignored-but-precious".  Then "*.o" would still be
    expendable while a directory that must become a regular file
    with "ignored-but-precious" files in it would prevent switching
    from branch 'side' to 'master' in the illustration in the
    previous message in order to keep that "ignored-but-precious"
    file.

    But nobody needed such a feature badly enough to step up and
    implement it.

    cf. http://article.gmane.org/gmane.comp.version-control.git/185746
