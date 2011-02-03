From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Thu, 3 Feb 2011 18:35:20 +0700
Message-ID: <AANLkTinrqCaD_vg7Ah4Tjgoa-njEBEmiYt15ojtsazKw@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net> <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 12:36:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkxTi-0000vz-Ko
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 12:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284Ab1BCLfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 06:35:53 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41196 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240Ab1BCLfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 06:35:52 -0500
Received: by wyb28 with SMTP id 28so1038771wyb.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 03:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=fMsYvDb9esLvAxo+v7u6sffFpuN5ZeOYJ4TVyzpRtAA=;
        b=gyat2c9AhUbcqOeZI6Ss62BBuJ8iPogFKiCwq24pOD2gtjbd/o0qe2zp+VHWI360Hf
         XhYLWoT7TPx9OK1zbYqTUzPLKI12w7AVoTT2k5v/3oNKLtIMzo0U04g9teYdddlRlxYt
         i6CZ7SLCWejID+ZElBo44IS2Fm5CWQLwNjh+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=g/BvTnNsQKiP3Nlr6Lb7Cpfup0FavUTlewOUZJdWDNhmfKFX22w+Z/Elxdgf8nzHVA
         hK2hmzbN+4cFTze5WAV/nTbViYHLPZm0YYlqov5AGXDYSjN6G8kQn2wztukn5G68wdOy
         jdUoDpAURrFycGx1wYYciqHOak9+sFmLsrliw=
Received: by 10.216.89.71 with SMTP id b49mr9672356wef.28.1296732951248; Thu,
 03 Feb 2011 03:35:51 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Thu, 3 Feb 2011 03:35:20 -0800 (PST)
In-Reply-To: <201102020322.00171.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165968>

On Wed, Feb 2, 2011 at 9:21 AM, Johan Herland <johan@herland.net> wrote:
> Migration plan:
> ...
> In v1.8.0, we should default to the new default refspecs when creating new
> remotes. However, existing remotes (created pre-v1.8.0) must continue to
> work as before, so we cannot simply remove the implicit refspecs (or tag
> auto-following). Instead we need to make sure that the implicit refspecs is
> NOT applied to the new-style remotes. Identifying new-style vs. old-style
> remotes can be done by looking at the refspec itself (old-style:
> "refs/remotes/$remote/*", new-style: "refs/remotes/$remote/heads/*"), or
> (worst case) by introducing a config variable specifying the desired
> behavior (defaulting to old-style).

I'd prefer config var (remote.*.implicitRules, maybe). We don't
reserve heads, tags... in remote namespace for ourselves. Some users
might have already have branches heads/ant, heads/bee... making new
style detection unreliable.

So I propose add remote.*.implicitRules = false since 1.8.0 for new
remotes as a way to detect new/old style. The default value would be
true.

But I don't want to keep adding remote.*.implicitRules on new remotes
forever. I suppose one year after 1.8.0, the new behavior is
widespread enough. We can then annoy users to add
remote.*.implicitRules for all old remotes. There should be no more
default value after 1-2 years. We then flip the default value and
won't automatically add remote.*.implicitRules = false on new remotes.
-- 
Duy
