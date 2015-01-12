From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rerere forget isn't working?
Date: Mon, 12 Jan 2015 10:24:59 -0800
Message-ID: <xmqq7fwrambo.fsf@gitster.dls.corp.google.com>
References: <CAHd499C6opP_0RBGDS=h+1qhrr=7sD0w0hf_bpGWT-wPP4iJoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 19:25:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAjg1-0007Sx-IU
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 19:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbbALSZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 13:25:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753857AbbALSZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 13:25:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D1DC2FC15;
	Mon, 12 Jan 2015 13:25:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bpYIWBMqadrAsSzoLQcycpnxRGA=; b=hJKGeJ
	GqgkflghXxuHVyPD/iWGAOt7ziLL+2PdvHXq4lyTbUeTeBdkB38VotMZBmOIQNWy
	ZYEaY8lB8bIB588m3hQefhrD7053q1FEJozoO4yjtRo5aLnLlnqHsOZMbiU7EaT9
	VPdWg8B5sPFFYOQHi5JpLYemRWBFJ3lVyvaqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NKHhrO213t2PECO9lWemapD3iwIy5Ff5
	aHXojJ/tStmXucvxfZaIRciy3j0coQ36m1oiFgytl+t50DxYDM4A2tGoBzK/Jx08
	bUYncisz4Gs0nUUEhzB7LxmsyH6DepsqezyxKDLuU2wFfXd6g+Xwqlpt5/4srEso
	x4MmsEecFwI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42A132FC14;
	Mon, 12 Jan 2015 13:25:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DD722FC0D;
	Mon, 12 Jan 2015 13:25:01 -0500 (EST)
In-Reply-To: <CAHd499C6opP_0RBGDS=h+1qhrr=7sD0w0hf_bpGWT-wPP4iJoQ@mail.gmail.com>
	(Robert Dailey's message of "Mon, 12 Jan 2015 08:20:27 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5230E3E0-9A88-11E4-9A96-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262286>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> So I want a way to clear out the whole rerere cache (i.e. every
> remembered conflict resolution). So I try this command:
>
> $ git rerere forget .

The forget subcommand is to tell Git that you screwed up in this
sequence:

    $ git merge other ;# or any "mergy" operation that leaves conflict
    $ edit foo ;# help Git resolve conflicts
    $ git rerere foo ;# and tell it to remember
    ... and then later find that your earlier resolution was wrong
    $ git rerere forget foo

The "dot" there may mean "all paths", but it is still "all paths I
resolved for this particular set of conflicts the "mergy" operation
produced.  There is no "I do not care if there are good resolutions
remembered that do not have anything to do with the current merge,
just remove all of them"---that is what "rm -fr .git/rr-cache" is
for.
