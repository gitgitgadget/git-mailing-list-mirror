From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Sun, 27 Feb 2011 22:40:19 -0800
Message-ID: <7v39n8ll0s.fsf@alter.siamese.dyndns.org>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
 <4D68D630.9000608@drmicha.warpmail.net>
 <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net> <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 07:40:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptwma-0005oS-IJ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 07:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605Ab1B1Gkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 01:40:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab1B1Gkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 01:40:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A4492948;
	Mon, 28 Feb 2011 01:41:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=mj+XBLK22V4bEWdBbrZIkFUrvlo=; b=l0mPkSm/hDpxBXp9QM5ub1u
	mNrvuEZ8j2eSoS4b74kU3UdpelQr3RCUmkcCua667KZoHpO86nmc2nZDdpnWye0j
	4WFGGv7ZlI2WwUZqjLfGx7WE6fz4mevotWnUqFqPfuaeVWoEj9BZR8txgbdUlC9q
	4kQvSAYq9GeDBooNlpOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WV0G1ND+XwQfMZGwndv+iJ34Q1YgrHmFrjem7CBHeeUxPLq4T
	1EhqjzaCcoksHfHFOSO9uG9JpENcKHIWG0PSOYoM90fIzJeF4khCVSxhSCz629j9
	CplS/IahiCuP3/eBTbCW/4XMFGmkWjWCJ0b0HZwTthQXUy85QmTP23FJTc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDC512947;
	Mon, 28 Feb 2011 01:41:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 743E32946; Mon, 28 Feb 2011
 01:41:38 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE739FF8-4305-11E0-A7A9-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168069>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Should -u now print warnings to help script writers migrate to -a? Or
> do we plan to keep hidden -u forever?

I'd rather not to apply 2 and 3 from this series for now, until we have a
more reasonable solution.  Yes, I said "add --add-tracked" _might_ be
worth considering, but that is in contrast to "add --tracked" which was
out of the question.

Like it or not, "add -u" has already been quite established, and the 'u'
stands for "update(d)" (i.e. "run update-index to the files updated in the
work tree"), which I think makes perfect sense.

I would suggest just keeping "add -u" as is.  As I said in the review in
the previous round, if Michael really wants to, it probably is Ok to give
"commit -a" a synonym "commit --update".

I further find that the verb form "--update" doesn't rhyme well as the
option name to select what classes of paths are operated on; it might make
sense to change the fully spelled version of the option for both commands
from "--update" to "--updated" while we are at it.  This would not bother
end users at all, as parse-options will complete "--update" typed by the
user or in scripts uniquely to "--updated" just fine.

Michael seems to be resisting against introducing "commit --update", and I
understand one reason is because "status -u" means something totally
different from "updated paths"; I am somewhat sympathetic to that fear.

But we started making "status" independent from being "commit --dry-run"
in 1.7.0 for a reason---it would be Ok if "status -u" means something
completely different from "commit -u", _as long as_ existing "commit -u"
does not make much sense.  I think that is the case here.

I don't think the distinction between "commit -a" vs "commit -A" is all
that bad.  When people talk about "all" files in the context of SCM, we
almost always think about already tracked paths, and other files do not
get into the picture unless you first "add" them (this is not limited to
git; even "svn commit" or "cvs commit" wouldn't touch untracked paths).
For this reason, it is not unexpected that the normal version of "all"
excludes untracked files, and you would need to ask for the unusual
version of "all" to include them (i.e. "commit -A" or "add -A") when
dealing with usual SCM commands.

The same argument however does _NOT_ hold for "add", as "add" (especially
in other SCM's context) is about making paths that haven't been tracked so
far into tracked ones; iow, it is natural to expect that "all" would mean
more than normal "all" (i.e. "all what are tracked") in the context of the
"add" command (and "add" command only).

IOW, renaming "add -u" to "add -a" and having "add -a" vs "add -A" is more
confusing than necessary, because of the nature of the word "add" that has
a connotation of affecting paths that have been untracked so far, and
keeping "add -u" and "add -A" distinct to avoid confusion is probably a
reasonable solution to avoid "which variant of 'all' are we talking about"
confusion.  This compromise unfortunately does not give us the uniformity
between '-a' vs '-A' applied to 'add' vs 'commit'.  That is why I would
suggest '-u' vs '-A' if we _really_ want to have such a uniformity between
two commands, i.e. not adding "add -a" but adding "commit -u".
