From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive.c: Fix case-changing merge bug
Date: Tue, 06 May 2014 12:46:13 -0700
Message-ID: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
References: <CAE+yK_m_bPt2pS6MQOrpvVDuLAJf8NFxYOgM8i98tU6-gLcTDw@mail.gmail.com>
	<1398990069.19099.5.camel@stross>
	<xmqqwqdyg7jt.fsf@gitster.dls.corp.google.com>
	<1399397774.11843.46.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:06:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhlJm-0000cs-OM
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbaEFTqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:46:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52466 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbaEFTqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:46:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5690D14DC4;
	Tue,  6 May 2014 15:46:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qb3j/FXLcL1jnfYRsQ2olufQe8k=; b=e4K5YC
	Od0SuEZk3d7E+nObFAQ8dR4N/87UaOIucdMmasLXtEG2+z2ETyaLYVW18/cXNaiM
	CCVefuNDLKkck2SsY3wXwoBDuuUExyMbNtw27TfcVuHDOfB8DL6UUC62/x+AGjzG
	+vkyiJKwaPL3i7M402JmHx251jPeXCCh5ArOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oOhBUAK5wWnBpghpOlwF961Bna1EslDT
	O8wXD3aYqTGz0wEiT31oo2aCooZwbzMkf4tQlmOANfUjlyUQMMbOKon9Egag5Sgv
	og4UNMKrajndNHyZtS4cOGQhYW0nqcEm4wXZn6XMNRKlW0ds6A3wN7f88GykpY/r
	W120deXpNjE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CA0414DC3;
	Tue,  6 May 2014 15:46:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F094214DC2;
	Tue,  6 May 2014 15:46:14 -0400 (EDT)
In-Reply-To: <1399397774.11843.46.camel@stross> (David Turner's message of
	"Tue, 06 May 2014 10:36:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1572D5EA-D557-11E3-9F7C-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248230>

David Turner <dturner@twopensource.com> writes:

> Would you prefer that I add it to t6022-merge-rename.sh?  Or I could
> add it to t7062-wtstatus-ignorecase.sh and rename that file to
> t7062-ignorecase.sh.  

If I had only these two choices, t6022 would be it, as 6xxx series
is where we have other tests for merge-recursive.

I actually do not have a problem with adding a new file in t6xxx
series as you did in this patch, if a longer term direction is to
add more cases to it to make sure various paths that are only
different in their cases (not just <TC, TC, tc> combination where
one side renames, but things like <tc, TC TC> combination where both
sides rename, etc.) are handled correctly during a merge.

Thanks.

By the way, I see "touch" used to create a new file in the test,
like this:

+	touch foo &&
+	git add foo &&

Please don't.  Instead, do it perhaps like this:

	>foo &&
        git add foo &&

The primary purpose to use "touch" is to update a file's timestamp,
and using it to create a file is misleading to readers.
