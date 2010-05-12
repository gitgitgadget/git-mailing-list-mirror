From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Multiple line ranges and files in line level history browser
Date: Wed, 12 May 2010 09:57:10 +0200
Message-ID: <201005120957.10961.trast@student.ethz.ch>
References: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com> <7v1vdl9btm.fsf@alter.siamese.dyndns.org> <AANLkTimCT7euE0CjGBx88MlfVJhxVo1GdOtnMhtZqBQs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Bo Yang <struggleyb.nku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 12 09:57:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC6p5-0006nj-FR
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 09:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873Ab0ELH5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 03:57:38 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:16688 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab0ELH5i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 03:57:38 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 12 May
 2010 09:57:36 +0200
Received: from thomas.localnet (129.132.211.224) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 12 May
 2010 09:57:14 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <AANLkTimCT7euE0CjGBx88MlfVJhxVo1GdOtnMhtZqBQs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146929>

Bo Yang wrote:
> On Mon, May 10, 2010 at 2:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > I'd rather not to see this in revision.c at all.  The revision.c parser
> > has always been options and then pathspecs and never takes individual
> > filnames, except for "--follow" that is an afterthought checkbox hack that
> > lets the main parser parse and then reject a generic pathspec after the
> > fact.
> 
> Ok, this will be put in the builtin/log.c
[...]
> 1. The definition of TREESAME. TREESAME will be changed to consider
> the line ranges if -L option is given;
> With this, the history simplification can be done very well for line
> level history traversal. And even well for parent rewriting to support
> --graph option.

Doesn't this actually mean it should go in revision.c, after all?

AFAICS you make a case that this feature is an extension of the path
filtering and also of --follow.  This is not strictly speaking true,
since '-- path' only cares about the path itself, '--follow -- path'
tracks only "sufficiently close" renames and '-L0,inf path'[0] tracks
the lines across files even if it's only small chunks.

But I still think it's a good argument.  And then if git-log learns
about it, why should this be a special case that only the log family
understands, but not rev-list?

And since we can't remove --follow for hysterical raisins, you might
as well link the whole "what moved where" tracking logic to a place
where it helps fixing --follow.

Or am I totally on the wrong page?


[0] making up syntax for the purposes of the example, please don't
    think of this as normative or even a good idea

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
