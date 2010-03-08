From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push --no-mirror ?
Date: Mon, 08 Mar 2010 12:49:40 -0800
Message-ID: <7vzl2ipmhn.fsf@alter.siamese.dyndns.org>
References: <20100308123423.GA20486@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Mar 08 21:50:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nojtt-0002JG-Uh
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 21:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586Ab0CHUtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 15:49:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564Ab0CHUts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Mar 2010 15:49:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 579C2A01B8;
	Mon,  8 Mar 2010 15:49:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EQTqxljmgX/O
	xAlcF3CS2OndIjc=; b=lY8id33EkU3Np70Bz8kINEYLWeD7yFG2KETiWCIP9xJX
	iCuxy/CRWKGDbFTwR+dPkzipLLt8g+FJRA2bcHkhjitSRkQfBlAcUKv8fzKbf51h
	DVINPPuwH4lJkRn+EPFLizgZ/0xiVAhFpfxU6ekL/oPAI7R8D6XFx0OZWW4oA5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r1e966
	cJKlgctanHd2N65Z5esN41BFrHhm9NPlpOWBdkipCq6WhgSEb3/gWY+NnRiLCHOF
	tbsuZiIERXT6PuuVEko+QYF5vW5HT1xEj3rUalFPLDI6eph+qsEJ5Dj6cWlKRCKL
	pHAKF3w+VC8tbmO8Ra+Wkkmm82x59GHOwRquU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34BABA01B6;
	Mon,  8 Mar 2010 15:49:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FF23A01B2; Mon,  8 Mar
 2010 15:49:41 -0500 (EST)
In-Reply-To: <20100308123423.GA20486@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bo?=
 =?utf-8?Q?r=22's?= message of "Mon\, 8 Mar 2010 13\:34\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20034C90-2AF4-11DF-A50B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141787>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> I have a remote that I use mainly for backup with 'mirror =3D true' i=
n
> gitconfig, but also for sharing my "bleeding-edge" code with a
> student.  Now I came across the situation where I would liked to push
> only a single branch to that repo, only to discover that 'git push'
> has no '--no-mirror' option to override the related configuration
> setting.  Removing the 'mirror =3D true' line from the config, doing =
the
> push, restoring the config did the trick, of course, but I think ther=
e
> should be a simpler way to do that.  Is there a fundamental reason wh=
y
> there is no 'push --no-mirror', or just noone has noticed/bothered
> before?

I think that is the case.  How does this look (haven't thought it throu=
gh
nor even compile tested yet)?

 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index f7bc2b2..89df1ff 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -145,7 +145,7 @@ static int do_push(const char *repo, int flags)
 		die("No destination configured to push to.");
 	}
=20
-	if (remote->mirror)
+	if (!refspec && remote->mirror)
 		flags |=3D (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
=20
 	if ((flags & TRANSPORT_PUSH_ALL) && refspec) {
