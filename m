From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 14:04:30 -0700
Message-ID: <7vobop5zmp.fsf@alter.siamese.dyndns.org>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
 <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr> <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com> <7vaa097k3q.fsf@alter.siamese.dyndns.org> <CAMUXYmUg12z8LUcFKwjH0Utrvxx0fa5Sne0u9adgoZ=oooBbig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Leila <muhtasib@gmail.com>, konglu@minatec.inpg.fr,
	git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: =?utf-8?Q?Cl=C3=A1udio_Louren=C3=A7o?= <pt.smooke@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:04:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBmv-00076r-GX
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab2FKVEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 17:04:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988Ab2FKVEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 17:04:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6CC28E3A;
	Mon, 11 Jun 2012 17:04:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2aFDIinloU9r
	A1XcNcvyhKwfgFc=; b=vOC4/Q96UmQbSMZMC72PgrxzfuGMMxJbXfvrK6DBqqKB
	SX1xZgSA+zcL4F86p5IOmWkeFJqEbEVVefScl6G93LpM4uxxvH3XMoySNr0j+jW2
	pvImzoZOLUWXUsB5G+JR1Q7W95nu+4d7yLPs5sM9nLoA64r8dqCxl+mmXk6JrbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UPeeNe
	0rI64WkzdfUzWk1+5iXXeZfMQaHLzF76cRtxDs3tlkTb9NjyeRc8gUlQYyT5GItc
	De7+n8QDaAM5B9hYdCtzESCMad8x86sdIuKyoha6SCaWTWAvZSr0SDq1djQEea2w
	9kCNOpg3aOP6P+2H2I5s1/FNEQJn9rGU+O8q4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCC9B8E39;
	Mon, 11 Jun 2012 17:04:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 737378E38; Mon, 11 Jun 2012
 17:04:31 -0400 (EDT)
In-Reply-To: <CAMUXYmUg12z8LUcFKwjH0Utrvxx0fa5Sne0u9adgoZ=oooBbig@mail.gmail.com>
 (=?utf-8?Q?=22Cl=C3=A1udio_Louren=C3=A7o=22's?= message of "Mon, 11 Jun 2012
 21:48:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A1783CE-B409-11E1-860E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199729>

Cl=C3=A1udio Louren=C3=A7o <pt.smooke@gmail.com> writes:

> The deleted files from index, are just ignored (we think the bug come=
s
> from here).

Not really.  In general, "git checkout b" (no path arguments,
checking out the branch "b") will try to keep the local changes you
made to the index and to the working tree for a path that are the
same between your current branch and the branch "b".  So it is
perfectly normal to see:

        $ git checkout master
        $ git ls-files file
        file
	... ok, the master branch has "file"
	$ git diff master side | grep file
        ... ok, the side branch also has it and it is the same
        $ git rm file
        $ git checkout side
	D	file
	Switched to branch 'side'

So it actually _actively_ pays attention to paths deleted or
modified in the index.

Another thing it does is when the local change to the index matches
that of the branch you are switching to, checkout is allowed even if
path is different between two branches.

When checking the differences between the two branches (the current
and the new), unpack-trees notices that the path "something" is not
present in "b" branch, and even though your current branch and the
index differs (the index does not have "something" as you have
removed it), it thinks it is OK for the result to not have it (which
is correct).  And when it does that, it forgets that a new path
"something/f1" still needs to be kept (which is not correct), which
is where the problem you are seeing comes from, methinks.
