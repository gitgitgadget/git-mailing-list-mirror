From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: verify-tag is not plumbing
Date: Mon, 01 Feb 2016 10:51:51 -0800
Message-ID: <xmqq8u34w9fc.fsf@gitster.mtv.corp.google.com>
References: <60839686604d60632e1c80ef4fdd51eacb6b9290.1454244258.git.john@keeping.me.uk>
	<20160131143759.Horde.Ylcq6ydVoLduXCzBPzVjZMh@webmail.informatik.kit.edu>
	<20160201104411.GD29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:52:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQJZv-0007kh-W8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 19:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbcBASv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 13:51:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752180AbcBASvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 13:51:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78F9F402DA;
	Mon,  1 Feb 2016 13:51:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a48oa3nc35seiIXZPtC33LQXBUY=; b=ff6OI4
	v11ufVWDHjKFVjUrhkP455/NQn3YfPbujnJZoairEZ9H88GnXjPhKDJBKG+asEdL
	BvpaM0BLCOl9qmjX+Fjgpt3gkwJ1irf/j6pWunbklcfjRyNBCMb8ceFhwxvzrf97
	Ipqj/0ppM6CQ+01oMLJb5yiCakc9Zz2pkdJIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GCLB4CwyH607KwsXQ6XzIF3uefwGTuaV
	kynNJQjO6NvGmua/zerpUXpBFNcWgkTQo6QvzLkX/HslhxZlIlcz7R5wUzdqkv36
	tzoTB8NCYewxKbOjfNQ+o8v1CtXI+cJUedrFwAVg0iloT/PJRXTqJ8RzsnWiip4n
	59Ws32vohWw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FD69402D8;
	Mon,  1 Feb 2016 13:51:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C587D402D6;
	Mon,  1 Feb 2016 13:51:53 -0500 (EST)
In-Reply-To: <20160201104411.GD29880@serenity.lan> (John Keeping's message of
	"Mon, 1 Feb 2016 10:44:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC5C884C-C914-11E5-BE16-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285207>

John Keeping <john@keeping.me.uk> writes:

> I can accept that argument about verify-commit and verify-tag, but
> listing verify-tag as plumbing is incorrect according to
> command-list.txt (and thus git(1)).  If we're going to classify
> commands, shouldn't we be consistent in how we do so?

These are not meant to be "classifications", but "justifications".
When somebody asks "why isn't this command tab-completed?", you can
find the explanation e.g. "because it is rarely used".

A command being 'plumbing' does not have to make it automatically
ineligible from getting tab-completed.  For some small tasks,
running a plumbing command may be the easiest way to achieve them in
the interactive session, and it helps to have tab-completion for
such a plumbing command (e.g. "git apply" is completed, IIRC).

Also often the line between plumbing and Porcelain is somewhat
blurry.  I'd consider ancillaryX categories in command-list.txt a
cop-out myself.

In this particular case, saying "better use 'tag --verify'" there
instead of "plumbing" may be more helpful for those who are reading
this script.

>> > Signed-off-by: John Keeping <john@keeping.me.uk>
>> > ---
>> >  contrib/completion/git-completion.bash | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> > diff --git a/contrib/completion/git-completion.bash
>> > b/contrib/completion/git-completion.bash
>> > index 51f5223..250788a 100644
>> > --- a/contrib/completion/git-completion.bash
>> > +++ b/contrib/completion/git-completion.bash
>> > @@ -728,7 +728,6 @@ __git_list_porcelain_commands ()
>> >  		write-tree)       : plumbing;;
>> >  		var)              : infrequent;;
>> >  		verify-pack)      : infrequent;;
>> > -		verify-tag)       : plumbing;;
>> >  		*) echo $i;;
>> >  		esac
>> >  	done
>> > --
>> > 2.7.0
