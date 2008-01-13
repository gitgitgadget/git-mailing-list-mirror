From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Sun, 13 Jan 2008 15:01:10 -0800
Message-ID: <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Gr=C3=A9goire?= Barbier <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:01:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEBq1-0000MZ-SJ
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 00:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbYAMXB3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2008 18:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754208AbYAMXB3
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 18:01:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbYAMXB2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2008 18:01:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 31E8B4B0B;
	Sun, 13 Jan 2008 18:01:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B262D4B0A;
	Sun, 13 Jan 2008 18:01:23 -0500 (EST)
In-Reply-To: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
 (=?utf-8?Q?Gr=C3=A9goire?=
	Barbier's message of "Sun, 13 Jan 2008 20:02:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70420>

Gr=C3=A9goire Barbier <gb@gbarbier.org> writes:

> Fail when info/refs exists and is already locked (avoiding strange be=
haviour
> and errors, and maybe avoiding some repository corruption).
>
> Warn if the URL does not end with '/' (since 302 is not yet handled)
>
> More explicit error message when the URL or password is not set corre=
ctly
> (instead of "no DAV locking support").
>
> DAV locking time of 1 minute instead of 10 minutes (avoid waiting 10 =
minutes
> for a orphan lock to expire before anyone can do a push on the repo).

I do not remember these discussed on the list, and would like to
see people who do use http-push to comment on these.  Especially
because there is no correct timeout that is good for everybody,
the last item might be contentious.

The second one to add a couple of "goto cleanup" looked
correct.  Acks, people?

Also http-push being unusable without CURL_MULTI was also a news
to me.  Is this something that came up on #git perhaps?

This change means people need curl 7.10 or newer (post May 2003,
that is).  I do not think it is too new a version to require,
but then it makes me wonder if it makes much sense for us to
keep supporting non CURL_MULTI build these days.  Perhaps we
should schedule such a move to drop non MULTI build in the
future?
