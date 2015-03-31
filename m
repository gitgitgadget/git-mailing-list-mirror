From: Jeff King <peff@peff.net>
Subject: Re: Forcing git top-level
Date: Tue, 31 Mar 2015 14:15:52 -0400
Message-ID: <20150331181552.GC19206@peff.net>
References: <0FD999DB-3DBF-40D4-8128-715BDC49EAAB@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Cedric Gava <gava.c@free.fr>
X-From: git-owner@vger.kernel.org Tue Mar 31 20:16:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd0hj-0002jf-N1
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 20:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbbCaSPz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2015 14:15:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:40479 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753202AbbCaSPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 14:15:54 -0400
Received: (qmail 18543 invoked by uid 102); 31 Mar 2015 18:15:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:15:54 -0500
Received: (qmail 26190 invoked by uid 107); 31 Mar 2015 18:16:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 14:16:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 14:15:52 -0400
Content-Disposition: inline
In-Reply-To: <0FD999DB-3DBF-40D4-8128-715BDC49EAAB@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266544>

On Tue, Mar 31, 2015 at 11:25:58AM +0200, Cedric Gava wrote:

> I=E2=80=99ve copied a .git folder located at the root (/) of a filesy=
stem,
> into another directory (/home/mydir). If I issue a git rev-parse
> =E2=80=94show-toplevel I got "/"...
> I would like to change the top-level to point to /home/mydir.

Try running "git config --unset core.worktree" in the .git dir.

It looks like "git init" will write a core.worktree entry in this case,
even though it isn't technically needed. I think it is due to these
lines in builtin/init-db.c:

                if (!starts_with(git_dir, work_tree) ||
                    strcmp(git_dir + strlen(work_tree), "/.git")) {
                        git_config_set("core.worktree", work_tree);
                }

The check returns a false positive for the root directory because we
only have one slash (i.e., appending "/.git" to our worktree would be
"//.git" in this case).

-Peff
