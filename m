From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 06/10] Unify the lenght of $SHORT* and the commits in
 the TODO list
Date: Sat, 12 Apr 2008 23:20:40 -0700
Message-ID: <7v63umff7r.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-4-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-5-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-6-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-7-git-send-email-joerg@alea.gnuu.de>
 <7vej9cndqp.fsf@gitster.siamese.dyndns.org>
 <20080412091345.GA31356@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Apr 13 08:21:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkvb4-00078h-Ox
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 08:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYDMGUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 02:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYDMGUv
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 02:20:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbYDMGUu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2008 02:20:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BB0D128D7;
	Sun, 13 Apr 2008 02:20:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1843A28D4; Sun, 13 Apr 2008 02:20:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79391>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> =E2=80=9CThis makes it easier to test for equality of a commit in the=
 TODO list
> and one of SHORTUPSTREAM, SHORTHEAD or SHORTONTO.=E2=80=9D

"Equality testing?" --- that makes me worried.  short=3D7 does not chom=
p
them at 7 but only tells rev-parse to use at least 7.  You may get 8 or
more if there are other objects that share the same prefix when you get
them.

Perhaps by forcing "at least 7" everywhere you are getting consistent
result that makes them easier to compare.

But considering that this is a candidate for a general mechanism to
eventual grow into the git-sequencer, and that we expect to have richer=
,
smarter, and/or more complex set of tools that feeds you the TODO list,
I'd feel safer if the internal comparison used to determine which one
commit the user meant in his TODO file is robust and does not rely on
where the abbreviated object name was chomped at.

Some of the tools may even do not show the raw TODO list in vi to the u=
ser
but instead present the list in a GUI, and you may get fed the full
40-hexdigit object name in the underlying TODO list they generate.
