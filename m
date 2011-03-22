From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: dependable submodules
Date: Mon, 21 Mar 2011 22:13:20 -0700
Message-ID: <AANLkTi=yb24MDN8JzBa0WFaZ+g4iF5a=OQNw0yOM0k73@mail.gmail.com>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>
 <7vd3lmv2k1.fsf@alter.siamese.dyndns.org> <AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>
 <4D877A70.8070907@jku.at> <AANLkTikv+Wf_nSt0GZj0WgPjpbk6Kr_WG-ueO6US9bUM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robert Pollak <robert.pollak@jku.at>, git <git@vger.kernel.org>
To: Daniel <daniel@netwalk.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 06:13:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1tud-0003RO-Bj
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 06:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623Ab1CVFNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 01:13:42 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47996 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602Ab1CVFNl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 01:13:41 -0400
Received: by qwk3 with SMTP id 3so4741543qwk.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 22:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=9fSAXxYdU3LwYpsktpG701qqqyC4Ze0Ub5k64A7qN4s=;
        b=vMSIkka5Ttfz54D6wBrMeRgKBpTbmmDYw7ec9Sf/332J0xuspycZzwpYJJwS2PByJC
         ms29SrH2PKwC+LIX4AVs9K27C2MJzRJmFtKn8Z4xoTWjRSPR1l6/3q8w/DvsBqD3bFze
         Q+NpAGQCRtj0Eg+QinUinbAZeVzSV/lBZC9NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Tcp2qby8LsltydJGtsWY0iK+ufa1uGXaSzoABwLg3oFceIX1WwIXsBLqi/MKnG8L/q
         M5oAx12ysS84zBYxfw1/ctE5hSX2HDGCrZb5bzDwurmDE+Vmt1Jw45TMLDXgi+vZwsDf
         x4vnFxQQjFkcPCdPgoYNee8QiLPO11tisIZVo=
Received: by 10.224.181.139 with SMTP id by11mr4263985qab.138.1300770820158;
 Mon, 21 Mar 2011 22:13:40 -0700 (PDT)
Received: by 10.52.155.74 with HTTP; Mon, 21 Mar 2011 22:13:20 -0700 (PDT)
In-Reply-To: <AANLkTikv+Wf_nSt0GZj0WgPjpbk6Kr_WG-ueO6US9bUM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169699>

On Mon, Mar 21, 2011 at 8:56 PM, Daniel <daniel@netwalk.org> wrote:
> I tried git-subtree. thanks but this is not what I wanted. This
> removed the .git dir for the subtree and hence updating the subtree is
> not easy.
>
> I want the functionality of git submodule except that I don't want the
> version checked in as part of the superproject to have to be fetched
> remotely.

Well, as the logic goes, you commit to the imported project a lot more
often than you submit upstream, so git-subtree makes the common part
much easier and the less-common part slightly harder, which is a
better tradeoff than git submodules.  But it does seem to be a matter
of preference.

If you just want the submodule's commit to be auto-fetched from the
same repo as the supermodule, I've been experimenting with a tool I've
created called 'git tie' that makes this possible.  It's not yet ready
for prime time, but you can use the same trick yourself if you're in a
hurry.  The idea is simple enough: just maintain a branch named
refs/heads/tie that is a continually updated "merge -s ours" of all
your submodule commits, all jammed together in a single branch that
nobody will ever look at.

Then when you 'git fetch origin', it'll fetch both the 'tie' branch
and all your other branches, which have references to the commits in
the 'tie' branch.  The 'tie' branch is what makes it so they'll get
auto-downloaded.  (Don't forget to push it, too, when you push
master.)

The tool I'm working on is basically just one that will auto-maintain
the 'tie' branch for you.

Oh, and the second half of this is to just use '.' in your .gitmodules
as the path to your submodule repo.  It would be nice if 'git
submodule update' would use the alternates mechanism (git clone
--reference) to get all objects from your subproject's local repo,
since we know they're there anyway.  I was going to make 'git tie' do
this part right too, so you wouldn't even need a .gitmodules file.
But either way, you'll survive, it might just be slower than optimal
if it downloads everything twice.

And there you go... I've now told you my secrets and regaled you with
vapourware.  Hope that helps more than it hurts :)

Have fun,

Avery
