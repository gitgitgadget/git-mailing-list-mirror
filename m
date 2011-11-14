From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Sun, 13 Nov 2011 19:29:05 -0800
Message-ID: <7vwrb3l6v2.fsf@alter.siamese.dyndns.org>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
 <CACBZZX7VTdc2wHYHb1BB-wCJbKLVEmbzQaBTV04S1KDrqeN73A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vinassa vinassa <vinassa.vinassa@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 04:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPnEb-0006ct-Mk
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 04:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab1KND3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 22:29:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44978 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274Ab1KND3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 22:29:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 032B1523D;
	Sun, 13 Nov 2011 22:29:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XPwBYYmn9+qZ
	708XcZ2KuvWv1vo=; b=ic4v30cAVCelYQSpYhHzFUBD6D8eBrReTkGuj1Hf7k7Y
	tUXI7xmxixXEeZKwrnZNbX1kd78phMRXUzMq+pkQTE2DoKshwa7hzXeSfwUIPLqR
	inBbmOgTNY2hCCxD2X2L4CHqhNJ1suAKliZzGYkbf5qf/PJ8yk9wt0IK87uAQHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TMHqNu
	3PHvoqYXdPlEI4yHjdxVYdNFmWgFip27Hf7OH2bbXf1HRjCfCjUrSAXk0shr15y1
	ZWXJF3jQP190fbhE9Kf6rfeIDqm56G58JMIbSWUgUX8PvVidrtnM6Cyrd8Rz+KmU
	sIZpkiZp9ZvzBU/FprXN8DPChikeSgscIqYTY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF164523C;
	Sun, 13 Nov 2011 22:29:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7076B523B; Sun, 13 Nov 2011
 22:29:07 -0500 (EST)
In-Reply-To: <CACBZZX7VTdc2wHYHb1BB-wCJbKLVEmbzQaBTV04S1KDrqeN73A@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 13 Nov
 2011 18:41:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF4A6CC2-0E70-11E1-BB1D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185360>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This is not something you have to worry about, just get on with using
> Git and stop worrying about phenomenally unlikely edge cases that are
> never going to happen.

People who repeated answers along this line, you can stop. The message =
has
been heard, but without answering the original question.

When we create a new object (i.e. "git add" to register a new blob
contents, "git commit" that internally generates new tree objects to
record updated "whole contents" and then records the commit object), we
first compute what the object name of the new object would be, and then
check if we already have an object with the same object name in the obj=
ect
store. If we do, we do not write the new copy of the object out (see th=
e
function write_sha1_file() in sha1_file.c and the call to has_sha1_file=
()
that bypasses write_loose_object()).

So the old contents will be kept without getting overwritten.

Which sounds nice, but it has interesting consequences, as we do not
bother running byte-for-byte comparison when we find what we tried to
write already existed in the object store in order to error out in fear=
 of
the miniscule chance that we would hit a SHA-1 collision.

If the collision is between commit objects, for example, we would write
the (old) commit object name to the tip of the current branch. Most
likely, the tree object recorded in the (old) commit would not match th=
e
tree object your "git commit" wanted to record (otherwise you have hit
SHA-1 collision twice in a row ;-), which would mean "git status" would
show that a whole bunch of paths have changed between the HEAD and the
index. Also "git log" would show the history leading to the (old) commi=
t
that is likely to be very different from what you would expect immediat=
ely
after committing the collided commit. Of course, you could recover from=
 it
with "git reset --soft" after finding out what the previous HEAD was fr=
om
the reflog, but it won't be a pleasant experience.

There can be other kinds of collisions (e.g. your latest commit might h=
ave
collided with an existing blob or tree, in which case it is likely that
almost nothing would work after finding a blob or tree in HEAD).
