From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash merge
Date: Mon, 20 Apr 2015 11:12:50 -0700
Message-ID: <xmqqy4lmllct.fsf@gitster.dls.corp.google.com>
References: <CAJmOuEwEgA-9NCtBXjij-rLhsCWMyw+DcRVGo4=0b1V2nC==cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pawel Por <porparek@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:12:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkGBl-0001W2-W0
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 20:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbbDTSMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 14:12:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752466AbbDTSMw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 14:12:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ECF4A460CA;
	Mon, 20 Apr 2015 14:12:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FNmypoSTKO6lVUf2e7aDf1IjITA=; b=XRWz9U
	mJQUOfPAd1AdIH4DEj4pnG7rW2P1V/nKaZny2CVd2AJ0KHgXxCt1D56VI0+/u+JO
	9M7+7fk8vEb9ZTCbq2NfrWBZnZjP9CbeaImU8t/3zoOpiKIoxFildFeGqiMnJjsR
	okFqeAo7q8EkykzeAKcpWYy+fm8bSXCIr7Xls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RPKQ3eUA19/I5GxZlp7MW9pDEEga3jvq
	Ki3QXnydXhGV2Px4x410k9CZK+tQ38NVfa7SWn5zMUijxt+izIMIqZROBu3eMWTo
	k5GThqGcGw3vKzNLHpitNZBl9/mkGrP6a8aeSUQqBiwmFHUYA2hphksZ9a+nFsup
	X1Mlxeas2lY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5AAD460C5;
	Mon, 20 Apr 2015 14:12:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 580EF460C3;
	Mon, 20 Apr 2015 14:12:51 -0400 (EDT)
In-Reply-To: <CAJmOuEwEgA-9NCtBXjij-rLhsCWMyw+DcRVGo4=0b1V2nC==cA@mail.gmail.com>
	(Pawel Por's message of "Mon, 20 Apr 2015 18:36:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB98B6E2-E788-11E4-9332-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267481>

Pawel Por <porparek@gmail.com> writes:

> I've just upgraded the linux kernel git source tree and I want to
> "pop" my stashed work. I do the following:
> git stash pop
>
> and I got the following message:
> mm/Makefile: needs merge
> unable to refresh index

The symptom indicates that "upgraded the linux kernel git source
tree" has not been cleanly completed and has an unmerged entry in
the index.  That is the first thing "stash pop" tries to check that
the source tree does not have any pending change that does not have
anything to do with your application of the stash, and you seem to
be triggering that safety check.

If your working tree does not have changes of any value, perhaps
"git reset --hard && git pull" (or you may even want to resort to
"git fetch && git reset --hard origin") to make sure "upgraded the
source tree" part truly has cleanly completed may be a good second
step to get "stash pop" going.  The good first step is to see what
local changes you have, of course---perhaps your "upgraded the linux
kernel git source tree" conflicted with your local changes that you
need to resolve first.
