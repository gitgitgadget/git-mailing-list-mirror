From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Sun, 19 Feb 2012 22:03:37 +0100
Message-ID: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 22:11:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzE2v-0005v2-Ow
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 22:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab2BSVLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Feb 2012 16:11:44 -0500
Received: from smtpout3.laposte.net ([193.253.67.228]:50506 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927Ab2BSVLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 16:11:44 -0500
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Feb 2012 16:11:43 EST
Received: from arekh.dyndns.org ([88.174.226.208])
	by mwinf8505-out with ME
	id bx3f1i0034WQcrc03x3ftK; Sun, 19 Feb 2012 22:03:41 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP id 67DA179F
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 22:03:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at arekh.dyndns.org
Received: from arekh.dyndns.org ([127.0.0.1])
	by localhost (arekh.okg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w9evZ2q7qJ4g for <git@vger.kernel.org>;
	Sun, 19 Feb 2012 22:03:37 +0100 (CET)
Received: from arekh.dyndns.org (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP
	for <git@vger.kernel.org>; Sun, 19 Feb 2012 22:03:37 +0100 (CET)
Received: from 192.168.0.4
        (SquirrelMail authenticated user nim)
        by arekh.dyndns.org with HTTP;
        Sun, 19 Feb 2012 22:03:37 +0100
User-Agent: SquirrelMail/1.4.22-4.fc17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191029>

Since
http://code.google.com/p/chromium/issues/detail?id=3D7338 and
https://bugzilla.mozilla.org/show_bug.cgi?id=3D479880

there is no clean way for a proxy or captive portal to get a web client=
 to
display an authentication dialog when user credentials expire while he =
is
browsing on an https url.

(to be sure, the previous methods were insecure and hackish but they ex=
isted
because nothing better was available)

The IETF finally set up to fix this problem and defined a standard HTTP=
 error
that lets access control equipments tell the web client authentication =
or
re-authentication is needed and where the authentication form is locate=
d.

http://tools.ietf.org/id/draft-nottingham-http-new-status-04.txt

=E2=86=92 <http://www.rfc-editor.org/queue2.html#draft-nottingham-http-=
new-status> (the
spec is approved and in the queue for publication as RFC)

Please add error 511 handling in git, so git users that try to access e=
xternal
git repositories over http can authenticate on the corporate proxy
