From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] config doc: add dot-repository note
Date: Mon, 20 May 2013 10:50:53 -0700
Message-ID: <7v7gitwneq.fsf@alter.siamese.dyndns.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1368964449-2724-2-git-send-email-philipoakley@iee.org>
	<20130519174307.GC3362@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 19:51:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeUEl-0008E4-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 19:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab3ETRu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 13:50:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262Ab3ETRu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 13:50:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00710203F5;
	Mon, 20 May 2013 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u6UKoKenBDW+Srkz28WP9Ykv1aI=; b=nWMpCk
	XEI1hK37klKhQRJ518zem1yX1H1QGKhJnhljJBqWdvrvccdD7fNebbCmTpCw7Qdh
	xrEo9Qw5ew7hxxuwC+TM0ZHdQresGZ62G3A1UZAm4RtcliooSXFeXigyzcB7NBT7
	dQGi2uq/H//95qKqkS3+bPpKgeJ6PqNzrwMOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MYNceWIZpmnYBZtDJD6DaiD0DUDZ7DBn
	CqFmeOC6pBYXMfX5pwFE1tp0Hx6ufeZpo6EOyvve8Db6O8FWujqffXAui0+tqWPI
	kNcZ5NVuUg2Uuvy3TC7Yzp3mJgE10xbVfLZG2lJgLsrIN9DsLr6KxoJ3Q5Vdp49u
	wnCpKJHv1v4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAD54203F4;
	Mon, 20 May 2013 17:50:56 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAE9F203F1;
	Mon, 20 May 2013 17:50:55 +0000 (UTC)
In-Reply-To: <20130519174307.GC3362@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 19 May 2013 10:43:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2654D1E-C175-11E2-8029-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224968>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Philip Oakley wrote:
>
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -734,6 +734,8 @@ branch.<name>.remote::
>>  	overridden by `branch.<name>.pushremote`.  If no remote is
>>  	configured, or if you are not on any branch, it defaults to
>>  	`origin` for fetching and `remote.pushdefault` for pushing.
>> +	Additionally, a `.` (period) means the current local repository
>> +	(a dot-repository), see `branch.<name>.merge`'s final note below.
>
> Does this accept an arbitrary git URL, or only remote names?

The branch.<name>.remote variable refers to remote names, and '.'
often appears as a special name to refer to the local repository.

I think you can define it as URL and your "git fetch" (no args) will
do the right thing in that it would:

 (1) fetch the history leading to the tip branch.<name>.merge branch
     from there; and

 (2) leave the result in FETCH_HEAD, so that "git merge FETCH_HEAD"
     can conclude the "git pull" you split into two manually by
     running "git fetch" first,

but I do not think there is a "while we create this branch" side
effect UI like "--set-upstream-to" for doing so, except for setting
it to '.' when you set upstream to a branch in the local repository.
I.e.

	git checkout -t -b mywork master
        git branch --set-upstream-to master mywork

Also I think setting it to arbitrary URL would mean that you would
not see any remote tracking ref (they are to be defined as a
property of named remote with remote.<name>.fetch refspecs), so it
is unclear how @{u} would work.  @{u} works when the variable is set
to '.', though.

For the above reasons, describing '.' as a special value for the
variable that the end users are likely to see is a reasonable "white
lie" for this part of the documentation.
