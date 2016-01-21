From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add tests for git-sh-setup's require_clean_work_tree()
Date: Wed, 20 Jan 2016 20:52:48 -0800
Message-ID: <xmqqa8nzzg7z.fsf@gitster.mtv.corp.google.com>
References: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
	<xmqqbn8f3iq5.fsf@gitster.mtv.corp.google.com>
	<20160121022711.Horde.7Nh0N0fTAbd0JWIA99KKFQF@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 21 05:52:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM7Et-00055z-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 05:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495AbcAUEww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 23:52:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755552AbcAUEwv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 23:52:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C00D3E5D4;
	Wed, 20 Jan 2016 23:52:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AKyDl0iZKgLG
	S4J2ThGnREZtmto=; b=aYdwWbjGge36U8QGuMxqXbi2cKtnkjeQ/cyFxK5bBTzE
	9twRprJirm0NqdBuZiMmkup5E5xmG9NoTw3hMBVCpeAFzZZ26eF/ObrCcATSiwIh
	F6QLNluL6UdC5hvwD6l0QT5bEadvtNDVOs17hQKoVh7l/PAwH2Y9ugfBjYLQZuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gQiLI3
	7gzR7zY8z8nSWishTPY6Zyq3ODu+in35lyyEeXvDKRUZ09ouzVDWMUsx3I08GT/g
	TGvuaw8tDaOvZGZgn7oEBdM1Ndv+TE+5NO7EmNyKvJz2y5T8w6ImobWDoex5XB9W
	29NKQuLi0bFAENlpkAw3vb3Bnn5aMYq4nvogE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83D2F3E5D3;
	Wed, 20 Jan 2016 23:52:50 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 00BE33E5D2;
	Wed, 20 Jan 2016 23:52:49 -0500 (EST)
In-Reply-To: <20160121022711.Horde.7Nh0N0fTAbd0JWIA99KKFQF@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 21 Jan 2016 02:27:11
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D291B710-BFFA-11E5-BFE4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284503>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>>> +test_expect_success 'error on clean index and worktree while on =20
>>> orphan branch' '
>>> +	test_when_finished "git checkout master" &&
>>> +	git checkout --orphan orphan &&
>>> +	git reset --hard &&
>>> +	test_must_fail run_require_clean_work_tree
>>> +'
>>
>> The title is wrong.  Immediately after creating and getting on an
>> orphan branch, you have stuff in the index that is not committed to
>> the branch, so your index cannot be clean by definition.
>
> The index contains the file 'file', so it's not clean indeed.
>
>> The
>> contents of the working tree may or may not be clean immediately
>> after getting on a new orphan branch, but you are doing "reset
>> --hard" to make the index and the working tree agree,
>
> ... and match HEAD, which in this case means both the index and the
> worktree become empty.
>
> 'git rm -r .' would have made the intent clearer.  Or 'git init empty=
repo'.
>
>> so this is
>> testing the "clean working tree" case, I think.
>
> So the question is, before we go any further: are an empty index and
> empty worktree clean when HEAD doesn't point to a commit?  (either af=
ter
> the command sequence in the above test, or right after 'git init').
>
> I do think they are clean.

That is "rm -fr test && git init test && cd test" case, right?

It may be consistent to define it as clean, but I am not sure
existing operations that require a clean working tree is useful in
such a state (filter-branch, pull-rebase and rebase are the big
users, and none of them is so useful with an unborn history), so
loosening the definition would be not just helpful for them but
would be harmful, as they (implicitly) rely on require-clean to
stop the command early before they try to do something that needs
an existing history.

So, I am not sure if it is a good idea.
