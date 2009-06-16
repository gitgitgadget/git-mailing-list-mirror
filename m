From: Jeff King <peff@peff.net>
Subject: Re: branch.<branch>.merge and --format='%(upstream)'
Date: Tue, 16 Jun 2009 08:23:12 -0400
Message-ID: <20090616122312.GB5227@coredump.intra.peff.net>
References: <adf1fd3d0906160408s668f7a3fj5725cc4e98b317fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 14:23:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGXhD-0000Kz-EI
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 14:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbZFPMXO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 08:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbZFPMXN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 08:23:13 -0400
Received: from peff.net ([208.65.91.99]:54135 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbZFPMXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 08:23:12 -0400
Received: (qmail 4193 invoked by uid 107); 16 Jun 2009 12:24:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 08:24:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 08:23:12 -0400
Content-Disposition: inline
In-Reply-To: <adf1fd3d0906160408s668f7a3fj5725cc4e98b317fc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121679>

On Tue, Jun 16, 2009 at 01:08:02PM +0200, Santi B=C3=A9jar wrote:

>   I've noticed that having branch.<branch>.merge set with the branch
> name, and not with the full ref, cause problems with
> --format=3D'%(upstream)'  and also with the "branch -av" and "git
> status" upstream branch outputs. But git-fetch and git-pull works ok,
> so it is a valid setting.

Actually, it is broken in a lot of places. for-each-ref relies on the
same code as "git status", "git checkout", etc, which will all fail to
display tracking info. I believe the same code is also used for updatin=
g
tracking branches on push. So I'm not sure if it was ever intended to b=
e
a valid setting.

=46ixing it would involve tweaks to remote_find_tracking, I think, but =
I
haven't looked into it too closely.

I'm not sure of the impliciations of allowing non-qualified refs in tha=
t
config. Will we detect and warn about ambiguities? Does it actually wor=
k
with non-branches?

-Peff
