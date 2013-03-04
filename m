From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] status: show the ref that is checked out, even if
 it's detached
Date: Mon, 04 Mar 2013 07:49:53 -0800
Message-ID: <7v38wbxizi.fsf@alter.siamese.dyndns.org>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362303681-6585-5-git-send-email-pclouds@gmail.com>
 <7vy5e49l3i.fsf@alter.siamese.dyndns.org>
 <CACsJy8A+gw9oJYrJqa-b8noKM7qJTkZEd7ovmxqR68i6miCatA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 16:50:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCXei-0008Ih-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 16:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758388Ab3CDPt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 10:49:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758371Ab3CDPt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 10:49:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D4BFA7E6;
	Mon,  4 Mar 2013 10:49:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p1ugl2pjQGxsjacv3WNpEot94Zs=; b=BCYNie
	dR8OASwIkFhIBGH1nGlfTkY1SIEYAdR2mEnSKFqVzJrr48jOvP+n/G8CUElr0LaA
	s6AsNYt+ASq9USwA8I/tBvVZaQ3JaUzkwnx8sahSxC4gu8GCafnN3+iNi+FutimS
	txWS1QJ0fbI7RED/lGlgxj0x+R5cV6VG5Kztc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GNJWe4FGe9zbsBnQ/6HHLq8RAtDk90g8
	oxTQkFf+V7rIFsbTMaLq9KD4nSQyQMNPc1Z2XQgS68RlEH5kJh+i4JqwcHmxJ4VA
	6MYagwdcIq38RRbzpG8yUZR1FmBKHXfgmt2FuCtMsri6jvmo/+bCmh2vaf7srOE5
	7UcFC9Akcaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35FF0A7E5;
	Mon,  4 Mar 2013 10:49:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E32BA7E2; Mon,  4 Mar 2013
 10:49:55 -0500 (EST)
In-Reply-To: <CACsJy8A+gw9oJYrJqa-b8noKM7qJTkZEd7ovmxqR68i6miCatA@mail.gmail.com> (Duy
 Nguyen's message of "Mon, 4 Mar 2013 19:17:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 291A2C12-84E3-11E2-8B89-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217401>

Duy Nguyen <pclouds@gmail.com> writes:

>> Instead of punting to "Currently not on any branch", would it help
>> to show the place you first detached at, so that the user can then
>> grab that commit object name and run
>>
>>     $ git log --oneline $that_commit..
>>
>> or something?
>
> $that_commit would be HEAD@{-1} right? Should that be used instead of
> grabbing random SHA-1 shown in git-status?

You can say "git checkout @{-1}" to go back.  That is the commit you
came _from_.

But I think what you were computing for $that_commit was different.
It's "the ref that is checked out, even if it's detached".

After doing:

	: start from anywhere
        git checkout master	;# on master
        git checkout branch~4   ;# detach at that commit
        ... hack hack hack ...
        git commit; git commit

your @{-1} is 'master'; "the ref that is checked out, even if its'
detached" is 'branch~4', and that is what you want as $that_commit
in the example.  That shows your _progress_, which has no relation
with 'master' that is @{-1}.
