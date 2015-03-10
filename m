From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Tue, 10 Mar 2015 23:55:09 +0100
Message-ID: <20150310225509.GA5442@vps892.directvps.nl>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
 <1425934575-19581-1-git-send-email-me@ikke.info>
 <xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:55:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVT3U-00083N-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbbCJWzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:55:12 -0400
Received: from ikke.info ([178.21.113.177]:39737 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbbCJWzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 18:55:11 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id ABD181DCF6D; Tue, 10 Mar 2015 23:55:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265277>

On Tue, Mar 10, 2015 at 03:09:54PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > rev-list --bisect is used by git bisect, but never together with
> > --first-parent. Because rev-list --bisect together with --first-parent
> > is not handled currently, and even leads to segfaults, refuse to use
> > both options together.
> >
> > Suggested-by: Junio C. Hamano <gitster@pobox.com>
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: Kevin Daudt <me@ikke.info>
> > ---
> > Changes since v3:
> >
> > * Added an ifdef::git-rev-list[] guard around the warning in the
> >   --first-parent section so that it only shows up in `man git-rev-list`
> >   and not in `man git log`
> >
> > * Added the warning also to the --bisect section.
> 
> I wonder what "git log --first-parent --bisect A..B" should do,
> though.
> 
> Wouldn't the rejection belong to revision.c::setup_revisions(),
> where we reject combined use of (--reverse, --walk-reflogs) and
> (--children, --parents), to apply this to all commands in the "log"
> family that uses the revision walker machinery?
> 

git log --bisect seems to do something different then git rev-list
--bisect

>From git-log(1):

    Pretend as if the bad bisection ref refs/bisect/bad was listed and
    as if it was followed by --not and the good bisection refs
    refs/bisect/good-* on the command line.

This seems to just add addition refs to the log command, which seems
unrelated to what rev-list --bisect does.

So I don't see why git log --bisect --first-parent should be prohibited
(unless this combination doesn't make sense on itself).

Kevin.
