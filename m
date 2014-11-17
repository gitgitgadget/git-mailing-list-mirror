From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge without marking conflicts in working tree
Date: Mon, 17 Nov 2014 15:19:26 -0800
Message-ID: <xmqqzjbpwh35.fsf@gitster.dls.corp.google.com>
References: <20141117223836.GH615@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 00:19:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqVa8-0004JU-SR
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 00:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbaKQXTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 18:19:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752873AbaKQXT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 18:19:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E1211FEE3;
	Mon, 17 Nov 2014 18:19:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bg3e5sgdTkeyKQ90HZYteh8f4rw=; b=rV7ySJ
	PV5vAC56U490aUb8fd6hQZjVbRa2ewIfhRiQLRThMIoJ2tJvcXY7pvGceDKLbppx
	fh6fghxn+jl5/1chWwZZISL42+H4S3v3zs6Z35F9gfMypZ80RnJ6owsiiQ85CSwR
	4pmPoPdm0jZM0ajEkUI8ZoTI09emOsRnlCWMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=istvefDao+ojldMMYeHu6RVrc5dJHNrJ
	7+pgxBW6oe6/dYyQEO5gyWwLRQ336Dwj5awI9/dv09ELdEyIO60jjiFNDbYj/IiA
	0Mf/xjwyCATRPs7mek3V0dOAAqp1D6gpatKE1jHkC7YErb9Y/TbbELx5jQGd6UlV
	Rc65Urz/x6g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74EC31FEE2;
	Mon, 17 Nov 2014 18:19:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07F211FEE1;
	Mon, 17 Nov 2014 18:19:29 -0500 (EST)
In-Reply-To: <20141117223836.GH615@pug.qqx.org> (Aaron Schrab's message of
	"Mon, 17 Nov 2014 17:38:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E70F782-6EB0-11E4-8246-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Schrab <aaron@schrab.com> writes:

> Is there a way to do a merge but only record conflicts in the index,
> not update the working versions of files with conflict markers?

Not with Porcelain, but "read-tree -m <ancestor> <ours> <theirs>"
should give you something close to it.

"merge-recursive" is probably beyond salvaging and coaxing --cached
option (i.e. tell a command that usually works both on the index and
on the working tree to only work on the index) into it would be too
messy to think about.  Restructuring it so that it first computes
the end result only in the index and then optionally allows it to
check out to the working tree has been something I've wanted to do
for a long time, but there is only limited amount of time in a day
and the list is never dormant, so... X-<.
