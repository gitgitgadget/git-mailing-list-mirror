From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Wed, 15 Jan 2014 18:50:33 -0500
Message-ID: <CACPiFC+koU1Fan+tbE2YgOstWGsDtDihpK-7CMOct7XAEpwJ2A@mail.gmail.com>
References: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
 <CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com>
 <201401141236.44393.mfick@codeaurora.org> <CACPiFCLxiCOqv=wLeq9LxisWn5T62hk8xDYwXmeFRNT05HY0iQ@mail.gmail.com>
 <20140115091220.GB14335@sigill.intra.peff.net> <CACPiFCKeOYHUb22d_Ea0PcbU-uAn=fVAn0QP1qbLAiNh1KEoqQ@mail.gmail.com>
 <xmqqr4892l0u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 00:51:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3aEd-0001l6-5n
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 00:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbaAOXuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 18:50:55 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33809 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaAOXuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 18:50:54 -0500
Received: by mail-wi0-f174.google.com with SMTP id g10so4891168wiw.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iPZb2O0+Pjw5pDKLgKK9vBA/AfS74INBdbvbBesUQ+c=;
        b=NI/VEE38Ktgad9gRpYDJKuqSed0keP9tZUZjHlxYeIzz7omSreYxXZQjOxG4n+eRct
         4Wn8melgGCEk06TQuO0rqGE4TFgISzj7XhwrtMSy9dsEo/h2BopXMiHXkF42E4cI+TnY
         cSvEOwX7tybSjKE4ANCI+8xU2+p6xgn+vCSiLweZ9LBchBdyi6EkI5mGeHtWRodQRpvu
         +s+D4hhyVX9o1XF4WPENupLrUORwJ5lCOpVP4c9foe97UFhvFLSv8SR9kfUxfC8QSQBX
         HMpP15XHNCvcymE5eJRP/ZboXctGsOABhlLf2QbIhaQuz2DvbT5xz4Qv7UkmesJG5T5F
         zIQA==
X-Received: by 10.194.61.133 with SMTP id p5mr349712wjr.73.1389829853483; Wed,
 15 Jan 2014 15:50:53 -0800 (PST)
Received: by 10.216.64.66 with HTTP; Wed, 15 Jan 2014 15:50:33 -0800 (PST)
In-Reply-To: <xmqqr4892l0u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240490>

On Wed, Jan 15, 2014 at 12:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> As long as we can reliably determine that it is safe to do so
> without risking races, automatically cleaning .lock files is a good
> thing to do.

If the .lock file is a day old, it seems to me that it should be safe
to call it stale.

Can anyone "take the lock" if there is already a lock file?

> Cleaning .keep files needs the same care and a bit more, though.
> You of course have to be sure that no other concurrent process is in
> the middle of doing something, but you also need to be sure that the
> ".keep" file is not a marker created by the end user to say "keep
> this pack, do not subject its contents to repacking" after a careful
> repacking of the stable part of the history.

For the keep files, I already drafted a script that looks inside the
keep file, if it reads 'receive-pack [pid] [host]' it checks whether
the hostname matches, and if so whether the pid matches a running
process.

Only if the host matches and the pid is dead we call it stale.

Seems fairly conservative to me. Are there scenarios where we think
this can misfire?




m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
