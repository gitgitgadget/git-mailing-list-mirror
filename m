From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 14:34:43 -0800
Message-ID: <xmqq4mqqrc70.fsf@gitster.dls.corp.google.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
	<20150212092824.GA19626@peff.net>
	<xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
	<CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
	<xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com>
	<CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: David Glasser <glasser@davidglasser.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 23:34:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM2LT-0000Ol-86
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 23:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbbBLWer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 17:34:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750959AbbBLWeq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 17:34:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 938D437549;
	Thu, 12 Feb 2015 17:34:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wO+Sr6nvEgRiEHMtU4SBNVOqG1k=; b=fu0et4
	hJQ7hoHRIFBpgOHhAE+kXVPZiffcOf3xLQZ306X8R4jz3is8OaZNPTUTlPWxDsCY
	MgBzVwMIumLCkNmTW+/2KLjMZvxDeXJRWS9b8zZhscKIvZiORml5K0quS/n1/OmO
	RVZcDAonqqy3MrTjn8O1mHOXoqXFTmfiYLHPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e4b0bCbFEmEZSsk3+iWwdKhVTaystGwU
	CZIT2q6Tcu5F1h4WPIXUQ7OTklHTIFwAKjKQl0m1AU5QJHJSX9p/MT7SXwJ8nRm2
	3yiRiwqgERd6GSfy557Jk0ixxgGQQdVUR2/5nJpuu925ZZ+f8utAxR+4Vr7w7sIy
	1a7y+v2BowY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ABDD37548;
	Thu, 12 Feb 2015 17:34:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0E5937545;
	Thu, 12 Feb 2015 17:34:44 -0500 (EST)
In-Reply-To: <CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
	(David Glasser's message of "Thu, 12 Feb 2015 14:16:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57F7FB3C-B307-11E4-A2CD-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263776>

David Glasser <glasser@davidglasser.net> writes:

> So to be concrete: What I'm proposing (and I'm excited to implement
> it!) is the following:
>
> When running "git commit" and:
> - You've fallen into the case where the message was read from SQUASH_MSG
> - You haven't used another method of specifying the author (--author,
>   -C, -c, --amend)
> - You have not specified --reset-author
> - You have set the "commit.useSquashAuthor" option
> - Before invoking prepare-commit-msg, all of the `Author:` lines found
>   in SQUASH_MSG have the same value
>
> then that author is used, as if it were specified with --author.  (And
> this will show up, commented-out, at the bottom of COMMIT_EDITMSG.)


I actually was hoping that this would extend to cases other than
"git merge --squash".

When running "git commit" and:

 - You didn't use a more explicit method of specifying the
   authorship identity (--author, --date, -C, -c --amend,
   --reset-author options, or environment variables GIT_AUTHOR_*);

 - You have commit.useAuthorFromEditorComment variable;

 - You have "# Author: " line that are identical in the result of
   the editor,

then use that author.  That would allow "git commit --amend" to
update a misspelled author name, for example.

Is that a bit too liberal?  Would it invite mistakes?
