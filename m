From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git-svn and repository hierarchy?
Date: Wed, 25 Feb 2009 20:02:45 -0500
Message-ID: <eaa105840902251702l68bc35f3ia15b1c804a6825f3@mail.gmail.com>
References: <20090224223412.GA4573@raven.wolf.lan>
	 <49A50EB2.80300@drmicha.warpmail.net>
	 <20090225232442.GC4573@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 02:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcUfx-0005fv-I6
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 02:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbZBZBCu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 20:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbZBZBCt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 20:02:49 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:62841 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbZBZBCs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 20:02:48 -0500
Received: by an-out-0708.google.com with SMTP id c2so241004anc.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 17:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=H8cH/TbBHSkCoBoJxDaAdlV0T/ulYfHpBkLa70BRI00=;
        b=I7u5K4pquAKlvw76m0n4ZE4/ikpNgEt1UiRVAGiOWHYNisZHQdn2VdVtrL2+nN3zJq
         87L+EPfYAvIZBpIpaoP7MZ8HYTueCrBObpntJuCGR0pQRQx0gVs1RoJtAZuerVrEIlyO
         EPtMpNiPnbCz3aRy4tRixi9Mf62klfnWXu1YI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=GZbVCGo5DZfqLt175t4I3McwcVxGylj3Fwq4bx/OgTQYUdokLPxv+wiVaXulpto1gu
         Ku1zbXzBDFfuaE48sqvNe5gIUqjn5YMaahDaPMBDQnP8yR2QbylUTkyfn9SxkfAyNo5V
         ir+a21SJp8eo/89ieURQyy/pWooAEdfYZ5iT0=
Received: by 10.229.74.68 with SMTP id t4mr899625qcj.102.1235610165985; Wed, 
	25 Feb 2009 17:02:45 -0800 (PST)
In-Reply-To: <20090225232442.GC4573@raven.wolf.lan>
X-Google-Sender-Auth: 66df341ead3934b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111516>

On Wed, Feb 25, 2009 at 6:24 PM, Josef Wolf wrote:
> And IMHO, there's one catch: to synchronize, I need to tightly
> coordinate the work on git-svn-repos with the work on its clones. =A0=
The
> clones are not reachable most of the time, so tightly coordinating
> would slow down the flow of changesets extremely.

Not sure if it helps, but for what it's worth, I use a circular setup:
git-svn-repos is updated from subversion-repos (by cron), but is
otherwise read-only. cloneN can pull from git-svn-repos (since
git-pull is a whole lot faster than git svn fetch, especially for the
initial clone), but has to "git svn dcommit" to push changes back
upstream.

This configuration puts any potential rebase conflicts back into the
hands of cloneN. No need to coordinate clones, aside from each clone
needing to know how to work in a "commits will be rebased by upstream"
type of environment (which isn't unique to git-svn). Oh, and make sure
you're using a recent git; older git-svn didn't have the incremental
index rebuild.

Peter Harris
