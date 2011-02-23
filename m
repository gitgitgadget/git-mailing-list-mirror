From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive
 filesystems
Date: Wed, 23 Feb 2011 11:27:50 -0800
Message-ID: <7vfwre8sax.fsf@alter.siamese.dyndns.org>
References: <201102231811.45948.johan@herland.net>
 <7vmxlm8trt.fsf@alter.siamese.dyndns.org>
 <AANLkTi=gAM3LGwU47_EkENerZeKmjwuhWhpHZJGSiW=n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 23 20:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsKNh-0003rA-CT
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 20:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486Ab1BWT2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 14:28:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab1BWT2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 14:28:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 98FEF478C;
	Wed, 23 Feb 2011 14:29:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j/hNx8EkJam2HFbaK6EPp+jolS0=; b=Lf8K4x
	5G4dllJy6z2q3PJv9R0C0hbWP2w4IKxHokZYjCFSkVHXZU32a08LgTcgZnWkRt2T
	DqOnZHCcmYoBF/mcZpgrSdCSr0Uyipy3UDxUOqZT8zQ/hNW6iLGYllcyOHdB14Qh
	qBVHMALdvMO51AWrTif+woG3uMm5XfuZewgJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jWcvy49A2Ol8VzK7SdflxqHASQJ+5eL5
	8BTInSCyGUmS9553lyOYUCRcv+ZG/Gl9PhGi0gGu1gMRxNJKpiH561YsWKba7JyO
	Yl/BPBPq3bK9VrNYwU7IRvR95JWrzEiYGDKf5uOc93kQlKGtK39fBFIs3whr6aJS
	u3+9Oq41zBk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 657B0478B;
	Wed, 23 Feb 2011 14:29:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3BB284787; Wed, 23 Feb 2011
 14:29:04 -0500 (EST)
In-Reply-To: <AANLkTi=gAM3LGwU47_EkENerZeKmjwuhWhpHZJGSiW=n@mail.gmail.com>
 (Shawn Pearce's message of "Wed\, 23 Feb 2011 11\:01\:03 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2FA56904-3F83-11E0-8487-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167716>

Shawn Pearce <spearce@spearce.org> writes:

> On Wed, Feb 23, 2011 at 10:56, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>
>>> Are there better suggestions on how to deal with this?
>>
>> Just from the top off my head, perhaps you can go to the same route as
>> symbolic link support on filesystems that are not symlink-capable?
>
> I don't know how that helps here Junio. On those systems we write a
> text file holding the symlink contents. That text file name is at
> least still unique in the working directory.

Heh, I probably should have more explicitly hinted that I was suggesting
to rename, e.g. foo-1.txt, when checking out conflicting paths.  I chose
not to be precise because I knew readers were intelligent enough to read
what's between my lines themselves ;-).

Just like a text file that records link target is useless as a symlink,
such a file would be useless for its original purpose (e.g. renaming
xt_TCPMSS.c to xt_tcpmss-1.c to avoid a collision with xt_tcpmss.c would
not help when its associated Makefile wants to build xt_TCPMSS.o and
xt_tcpmss.o next to each other), just like your "treat everybody the same
way and make that a directory" approach.

I think two things are sensible to do, are relatively low hanging fruits,
and are of low risk:

 - break checkout on such a tree on incapable filesystems; and

 - per project configuration (or attribute given to paths underneath a
   particular directory) that forbids or warns addition of case colliding
   paths to the index; enforce it at write_index() codepath; and

 - if we choose to just warn in the second item above instead of downright
   forbidding, barf in cache_tree_update() codepath when the per project
   configuration (or attribute) triggers upon case colliding paths, to
   prevent a commit from being made.

I think "warn at add time, fail at write-tree time" is more preferrable,
as it might be more convenient if you can add hello.c while you still have
HELLO.c in the index as long as you do not forget to remove HELLO.c from
the index before making your next commit.
