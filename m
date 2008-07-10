From: Junio C Hamano <gitster@pobox.com>
Subject: Re: THREADED_DELTA_SEARCH
Date: Thu, 10 Jul 2008 08:34:45 -0700
Message-ID: <7vy749pxbe.fsf@gitster.siamese.dyndns.org>
References: <20080710075327.GD24819@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 17:36:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGyCS-0006Tc-Pu
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 17:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbYGJPe5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 11:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbYGJPe5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 11:34:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbYGJPe4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 11:34:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8389F242B3;
	Thu, 10 Jul 2008 11:34:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 69203242AF; Thu, 10 Jul 2008 11:34:51 -0400 (EDT)
In-Reply-To: <20080710075327.GD24819@artemis.madism.org> (Pierre Habouzit's
 message of "Thu, 10 Jul 2008 09:53:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF2A07EC-4E95-11DD-BDAE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87982>

Pierre Habouzit <madcoder@debian.org> writes:

>   I'm using it in production for quite a long time now, and I wonder =
if
> there is any specific reason why it's not default. Debian activated i=
t
> by default too a couple of weeks ago, which means that it's in
> production on quite a large scale, and there are no issues reported
> either. Would a patch making it default be accepted ? It's quite hand=
y
> given that SMP machines are really pervasive nowadays=E2=80=A6

There were two issues, IIRC.

 (1) resulting pack could be suboptimal, due to delta-chain getting cut
     betweeen the worker thread boundary.

 (2) exploding memory use, suspected to be due to malloc pool
     fragmentation under multithreading.

The former was only an issue with early iterations of the code and the
current code has much improved behaviour on this point, but I do not
recall the latter issue has been addressed.
