From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] rebase --onto doesn't abort properly
Date: Mon, 06 Jan 2014 10:44:32 -0800
Message-ID: <xmqqha9hhrvz.fsf@gitster.dls.corp.google.com>
References: <CALkWK0mEN=LjWKKdWznCXk5YwRQXVDPwtxUvVJnrG9zPPvH-Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 19:44:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0FAH-0003zL-BU
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 19:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbaAFSoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 13:44:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755831AbaAFSog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 13:44:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD62F5FC8E;
	Mon,  6 Jan 2014 13:44:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fEIbQfOWZU6rO9fe8ErAiJTXnhQ=; b=efX1Ca
	BZ/khPVRVzJHa9cHUVuHeujUoNdRp5sM7+Pa/CkJkm4h5JVwCOaIKBUyMdzw+nF7
	wDWLWv0aeada7/lWcUlmG/v5ECuwn8uaaCszKjVLQmRCxBvYO3SeRkxA9oxcwLZP
	nGBERrXI6YK/bAbOw5r3Ruid0kzvL7AT9+dVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YlY78lriYKlnIjL5fSm0bgHe/+fEA/e2
	s6eZm/LkJxZMEWncVmHHZcUBp4429GRXrMJnn1krctFRrF+cUA5EAn4Hr8/FGha8
	VTm6QKQotlhQ/VPCo+PdtlCJT32fukQp9JVRhHjLem+I/tMK6U6XLbw+l3kOwUqm
	r7sIyyilCZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB87D5FC8C;
	Mon,  6 Jan 2014 13:44:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C24ED5FC8B;
	Mon,  6 Jan 2014 13:44:34 -0500 (EST)
In-Reply-To: <CALkWK0mEN=LjWKKdWznCXk5YwRQXVDPwtxUvVJnrG9zPPvH-Rw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 6 Jan 2014 23:12:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 966433B4-7702-11E3-884E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240046>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi,
>
> On the latest git, I noticed that a rebase --onto doesn't abort
> properly. Steps to reproduce:
>
>   # on some topic branch
>   $ git rebase --onto master @~10
>   ^C # quickly!
>   $ git rebase --abort
>   # HEAD is still detached

I do not think --abort was designed to abort an uncontrolled stop
like ^C in the first place.  To allow that kind of "recovery", you
need to teach "rebase" to first record the state you would want to
go back to before doing anything, but then what happens if the ^C
comes when you are still in the middle of doing so?
