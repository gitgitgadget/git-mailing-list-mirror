From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7300: repair filesystem permissions with test_when_finished
Date: Wed, 02 Jul 2014 13:05:14 -0700
Message-ID: <xmqq7g3vh6h1.fsf@gitster.dls.corp.google.com>
References: <20140702184429.GA32538@sigill.intra.peff.net>
	<20140702190159.GC5816@google.com>
	<20140702190331.GA9869@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 22:05:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2QmV-0000iY-Hj
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 22:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567AbaGBUFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 16:05:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65366 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754391AbaGBUFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 16:05:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E46823F8D;
	Wed,  2 Jul 2014 16:05:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TEPzKO46Kc3T1YHbtcW3PB8PcZs=; b=ZDKTOg
	yElvrvP4LONIneRJ30lFJNLj1Zu/KZpKei0FBd/21THOpbRfM9bVt/hAnuVsRJIK
	oNzZgQrzwZs82a5LlrDnPnaPpMBM8KZckxOImmeQuqlxFlxt1IK0xYRW/cmoAxOM
	DUaeuUfMaHIg+ROrB/J5NC37XlvhOyNoC7DkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jDMNiFSO3BR4t3EjlsbAtZbJuZ8JAAax
	pSNYcYdxxaPmOMZcNzmg1xMMmEgF4e4rU+a31lHRu4gtnkNyEOaEewpss10gvLuD
	DF9F5NjV3iJ5jCZuYuLe7xhjN55HdNaWLFujPXDaGLqrwT35W+lH8OF+GnuFjSB/
	Xd5uFga0Q00=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C909123F8C;
	Wed,  2 Jul 2014 16:05:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3303923F8A;
	Wed,  2 Jul 2014 16:05:05 -0400 (EDT)
In-Reply-To: <20140702190331.GA9869@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Jul 2014 15:03:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 28C07568-0224-11E4-A516-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252836>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 02, 2014 at 12:01:59PM -0700, Jonathan Nieder wrote:
>
>> Jeff King wrote:
>> 
>> > Signed-off-by: Jeff King <peff@peff.net>
>> > ---
>> >  t/t7300-clean.sh | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> Does the later "git clean -d with an unreadable empty directory" test
>> need the same treatment?
>
> I don't think so, because it is also failing during the experiments I'm
> doing and it is not causing the same problem.

It tests that "clean -d" is happy if a blind rmdir(2) removes the
directory.  If it fails for whatever reason (e.g. add "exit(0)" at
the beginning of cmd_clean(), for example) to remove the directory,
we do leave an empty unreadable directory behind.

But as long as that directory is empty, that will not cause us to
remove the trash directory at the end, so we should be OK.
