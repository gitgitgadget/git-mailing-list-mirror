From: Philip Hofstetter <phofstetter@sensational.ch>
Subject: Re: git-mailinfo doesn't stop parsing at the end of the header
Date: Wed, 18 Nov 2009 18:11:36 +0100
Message-ID: <aa2993680911180911o7e3af804m4ebdc20096baa609@mail.gmail.com>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com> 
	<20091118155154.GA15184@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 18:12:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAo4f-0006Hv-5e
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 18:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757878AbZKRRLx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 12:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757846AbZKRRLx
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 12:11:53 -0500
Received: from mail.sensational.ch ([195.226.6.199]:54500 "EHLO
	mail.sensational.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757816AbZKRRLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 12:11:53 -0500
Received: from [209.85.222.181] (helo=mail-pz0-f181.google.com)
	by mail.sensational.ch with esmtp (Exim 4.50)
	id 1NAo4T-0000Zm-MJ
	for git@vger.kernel.org; Wed, 18 Nov 2009 18:11:57 +0100
Received: by pzk11 with SMTP id 11so866909pzk.14
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 09:11:56 -0800 (PST)
Received: by 10.140.140.2 with SMTP id n2mr656806rvd.36.1258564316109; Wed, 18 
	Nov 2009 09:11:56 -0800 (PST)
In-Reply-To: <20091118155154.GA15184@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133191>

Hello,

On Wed, Nov 18, 2009 at 4:51 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 18, 2009 at 03:20:48PM +0100, Philip Hofstetter wrote:

> =A01. Improve the header-finding heuristic to actually look for somet=
hing
> =A0 =A0 more sane, like "From:.*<.*@.*>" (I don't recall off the top =
of my
> =A0 =A0 head which other headers we handle in this position. Probably
> =A0 =A0 Date, too).

or at least don't prefer obviously invalid data over valid data that
has already been seen.

> =A02. Give mailinfo a "--strict" mode to indicate that it is directly
> =A0 =A0 parsing the output of format-patch, and not some random email=
=2E Use
> =A0 =A0 --strict when invoking "git am" via "git rebase".

That would solve the problem too, though it feels like adding yet
another switch to guard against one specific issue. The purpose behind
options like this tends to get forgotten over time.

> As I explained above, there is a reason, but I don't think it's rude =
to
> have either of those lines. You were, after all, writing a commit
> message, not an email (and even if you were, it is a failure of the
> storage format if it can't represent your data correctly). So I think
> git is to blame here.

IMHO, another workable solution would be to reject a commit that later
can't be handled. That way the current attempts at getting an email
address can remain intact and the (much more) unlikely case that
somebody begins the commit message with from: will be caught before
damage is done.

So, just check that from-line for a valid email address at commit
time. If it is, ok. If not, treat it as an error and inform the user
that an invalid email address was given in the commit message.

Also, the error message by rebase (which is actually the message
printed by am) could have been a bit more helpful. If am fails during
a rebase, rebase could explicitly tell which commit am failed at. The
output I got made me suspect the problem to be in the first commit (as
that was the last one printed) when in fact it was in the second one
(which was not printed).

But that's just nit-picking.

Philip
