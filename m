From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: git submodule add fails when .git is a symlink
Date: Tue, 01 Mar 2016 13:50:53 -0800
Message-ID: <xmqq8u217tqa.fsf@gitster.mtv.corp.google.com>
References: <20160301204218.GA4083@kitenet.net>
	<CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Joey Hess <id@joeyh.name>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 22:51:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aasC4-0006gC-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 22:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbcCAVu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 16:50:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751659AbcCAVu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 16:50:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2918249DD4;
	Tue,  1 Mar 2016 16:50:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=soUmp46JIwERecB2b3NJUvTVdgU=; b=tdIeRU
	NK2vEYuZ9Yo1krul6XfDcXV8QEghSQ0NdTiH+YOjtUXOzvpW70JaL99ZPKYN8Sx1
	TL/OXwDb+fnEImY9zp2AuD3tbtV8cUrRSi1i4FLIjtjZA4Cv1IavZD3vU5CePOqh
	SHumumoYcK42QEuhMKCjAHuko38NStXSRQDII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bxNNYLadYjI73q0WRcqnv4X749HhZJSZ
	bAKX5CVhqzo5FZ9qUP9TQoXLINwbZ2yT+D7Msxhxs6e/gcpP9ghlO1QEsFCBEmeV
	2Q0dRQ3YdL12Te8pgFVnB0Sqe8xghGKm5KtLSw4g4T7TagE5tCivY8teoXZvtAqF
	JgdB0I19LOM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 214CD49DD3;
	Tue,  1 Mar 2016 16:50:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 95EDC49DD1;
	Tue,  1 Mar 2016 16:50:54 -0500 (EST)
In-Reply-To: <CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
	(Stefan Beller's message of "Tue, 1 Mar 2016 13:39:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC5C06F0-DFF7-11E5-BE2A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288069>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Mar 1, 2016 at 12:42 PM, Joey Hess <id@joeyh.name> wrote:
>>         git init gitdir
>>         mkdir worktree
>>         cd worktree
>>         ln -s ../gitdir/.git .git
>>         git submodule add /any/git/repo sub
>>
>>         fatal: Could not chdir to '../../../sub': No such file or directory
>>
>> Fairly sure this is a bug..
>
> Which version(s) of Git do you use?

A more pertinent question may be which version of Git did the above
ever work, I guess.  We fairly liberally chdir around and I do not
think we deliberately avoid assuming that "cd .git && cd .." might
not come back to the original directory, for example, so I wouldn't
be surprised if it never worked.
