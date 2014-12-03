From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-gpg: adjust permissions for gnupg 2.1
Date: Wed, 03 Dec 2014 08:21:12 -0800
Message-ID: <xmqqsigwk8lj.fsf@gitster.dls.corp.google.com>
References: <547DB6C3.5010704@drmicha.warpmail.net>
	<9c28f16c677bbc774e5b8dfc79b6ffe2c55d1720.1417527514.git.git@drmicha.warpmail.net>
	<20141202210753.GD23461@peff.net>
	<xmqqiohtli4h.fsf@gitster.dls.corp.google.com>
	<20141203000553.GA28969@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:21:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwCg6-0001a4-Am
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 17:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbaLCQVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 11:21:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753371AbaLCQVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 11:21:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBAE622AA7;
	Wed,  3 Dec 2014 11:21:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=89mQgCrRItQHl70Jk+/QEKdT58A=; b=CO0q+H
	rydejjyaj1dXgGTNErElDN3bU5562F3BHGjqQa3CphanrdOLW0shaxrTU1D6fX1O
	1SvMDvOnaaoU0jG1ki+Irlc0+4sWOWn6qD8nVdpSWmhU0i7y14c+N82b7Be93fUl
	VPIKWUh18lqUeB4zTjEfEliJVHjDTDVqR5wuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gyjbLb1HTTp6lt8EWJ56KMMLDIEvr3VY
	KwzZEe0IaGzXgpT7IqGGp7s7okW1hkvyff93DzBTm5DKl8vmk0xVdWGNvDchXplo
	7cddK2gKRBRoqPoyIHeY+jeKW65BM+1+j6JXXVjRoLxXfei0scoJRNSLy9CxYcAf
	Z8iLDEqVFME=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B328222AA6;
	Wed,  3 Dec 2014 11:21:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39B1722AA5;
	Wed,  3 Dec 2014 11:21:13 -0500 (EST)
In-Reply-To: <20141203000553.GA28969@peff.net> (Jeff King's message of "Tue, 2
	Dec 2014 19:05:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6631D506-7B08-11E4-8996-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260658>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 02, 2014 at 03:57:50PM -0800, Junio C Hamano wrote:
>
>> Wait.  After doing this,
>> 
>>     $ mkdir -p src/a && >src/b 2>src/a/c && chmod a-w src/b src/a/c
>>     $ cp -R src dst
>>     $ ls -lR dst
>> 
>> dst/b and dst/a/c are 0440 (with umask 0027, which makes src/b and
>> src/a/c also 0440, which is copied with "cp -R").
>
> Who is running that chmod and why? I know you are trying to simulate
> "somehow they lost their 'w' bit" here, but what is that "somehow"?

The very first thing I do after downloading and extracting a tarball
for any random project, before doing configure or make, is to a-w on
its files (but not directories, as I typically build in-place in the
source tree even for projects that support VPATH build).

Some ill-mannered projects' build break with this by trying to munge
their own source files.  They are, well, badly written, and I would
want to know about them, and that is one of the reasons behind a-w.

I do not know how widespread the practice is, but that was what I
did for this project, too, when I tried out Linus's first version
;-) These days, I do "git init && git add ." instead, so it does not
matter to me personally, but "cp -R" we do will matter to people who
still care without fixing the mode bits of the copied ones that we
intend to modify inside our tests and build procedure.
