From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Suggestion on git-push --porcelain
Date: Wed, 10 Feb 2010 10:34:00 +0800
Message-ID: <be6fef0d1002091834i1c4b202cp5afacc326bd1a4d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Larry D'Anna" <larry@elder-gods.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 03:34:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf2P5-0001ot-8R
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 03:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346Ab0BJCeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 21:34:04 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:34935 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab0BJCeB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 21:34:01 -0500
Received: by iwn39 with SMTP id 39so9294352iwn.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 18:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=idUuXjEXImUo9s8g7gxb1ghQf07yCG4AezjxIQ0/Vh8=;
        b=gzd0OLrALPMBzTTKQT/CPIELelGn1fLyWKupnMNKcu5Gt8fBdCidwX1DD4wGkEkso3
         jjToSnMBGK5nW4/0PmtlgDMzi5mKybrGJkN7XLr9DHbE6KajH2ZqJA/Iw+D4hYqBiC0F
         oYUoNOBccF2S0nj0nT9OpEmbsofwIhrJyJDco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=G806eTQNd7scziF63m+E/dwtSqP88yRhHq9cQQ/3ptABu4linsys8CCj3tdi9ZhTbk
         g8G6TTqGMLBQ3tzlFDD7mzUrA1q84r7ibAajPvoexQNdLeyFKbZF57bN7dGfNkfiGnFL
         JNQfJOsZcGAry7+/UvOatK8fZbJH6Y29HATcM=
Received: by 10.231.148.83 with SMTP id o19mr505494ibv.39.1265769240044; Tue, 
	09 Feb 2010 18:34:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139474>

Hi,

this is regarding the recent patch series from Larry. (I thought
replying to any of the patch messages was appropriate, I couldn't find
a cover-letter, so I'm starting a new thread.)

Around June last year, a patch from Larry was made to add the
--porcelain option, so as to produce machine-readable output regarding
ref status.

The latest patch series goes a step further, and tries to change
output - for example, suppressing user-friendly advice and giving "To:
<destination>".

I think this is an untenable path - adding/suppressing output of
certain messages for porcelain writers, while trying to keep things
fixed enough for porcelain writers to depend on. We will also have to
keep and eye out for future patches from adding fprintfs to stdout and
stderr that may break porcelain scripts.

I believe a better approach would be to prefix messages intended for
porcelain writers. For example, a push session might look like this:

  $ git push --porcelain
  PORCELAIN To git://foo.com/git/myrepo.git
  PORCELAIN uptodate refs/heads/baz:refs/heads/baz 1234ab ba4321
  PORCELAIN nonff refs/heads/bar:refs/heads/bar 2345cd 3456de

This is an "positive" approach, in the sense that we don't remove
anything from the current output; we just add more printf("PORCELAIN")
lines to wherever is appropriate.

-- 
Cheers,
Ray Chuan
