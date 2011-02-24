From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: complete "git diff ...branc<TAB>"
Date: Thu, 24 Feb 2011 09:09:48 -0800
Message-ID: <7vfwrd2wbn.fsf@alter.siamese.dyndns.org>
References: <7vlj1677gz.fsf@alter.siamese.dyndns.org>
 <20110224151328.GB14720@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 18:10:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psehd-00023s-CC
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 18:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665Ab1BXRKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 12:10:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab1BXRKD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 12:10:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4151238D9;
	Thu, 24 Feb 2011 12:11:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qf+F2zIlxDQK
	g4Uxd50AN90MsUk=; b=goJOYjmwcfAXfLOzRdLiUC6Da/8yPYnrlPGaaZtcsV3a
	Xrft2ZxEpdN0zRBV7gSNsuKzW9uNi/nV9dUFAY82Q3M5wRjVyXuKwu8Gdo9T9ool
	Hpqm3khHEW5LvG8ah/6tege4PYmh1BH+kVrQBlfjmeao79ggOLQBYZ/p33XgsOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Kw4FIe
	S1HbeRJHuzjLbOEcA/D+gXpfoJ5syScaG53RpInW66etQuJFJhWg/DsFgswwG1WS
	EKGsOXnr21skZhX3mWHkqGgegW0jDIDlkJxHl/HPNI7ev649DBKwIA12ETLt2PYt
	Lg6kcnZj5f7qChGXwziju2K8x5838TCj4kEE8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F397838D8;
	Thu, 24 Feb 2011 12:11:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9553138D4; Thu, 24 Feb 2011
 12:11:04 -0500 (EST)
In-Reply-To: <20110224151328.GB14720@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bo?=
 =?utf-8?Q?r=22's?= message of "Thu\, 24 Feb 2011 16\:13\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1323FD0C-4039-11E0-83D0-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167838>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> There is this 'ref:file' notation (as in 'git show master:README', bu=
t
> I don't know the proper term for it), which is understood by
> __git_complete_file(), and can be useful for 'git diff', e.g. to
> compare a file in two branches when the file was renamed in between:
>
>   git diff branchA:old branchB:new
>
> However, __git_complete_revlist() doesn't understand this notation,

If that is the case, I wonder if complete-revlist should learn it as we=
ll.
The "<tree>:<path>" notation is just one of the "extended SHA-1
expressions" to name an entry in a tree object and should be usable
anywhere an object name is expected to occur.

The users of complete-revlist seems to be "log" and their friends, and
they don't expect arbitrary object names; they are only interested in
commit objects and tags and then paths.  Teaching <tree>:<path> to it m=
ay
make "git log HEAD:bar<TAB>" to complete to "git log HEAD:bar/boz" that
would be a nonsense, but anything that the original "git log HEAD:bar"
would complete would be a nonsense to begin with (as soon as you said
"HEAD:<something to follow>", you are naming either a blob or a tree
object, and you cannot start log from them), so I don't see a harm done=
 in
doing so.

IOW, shouldn't there be just one unified complete-rev-then-path that is=
 a
superset of the current complete-revlist and complete-file that all the
current users of complete-revlist and complete-file should use?
