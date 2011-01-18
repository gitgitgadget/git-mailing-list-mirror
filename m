From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: [RFC] Per-branch receive.* settings
Date: Wed, 19 Jan 2011 00:07:37 +0100
Message-ID: <AANLkTimt8BPKsiyVEO+7i+so8337LaUu4A4jpywvJ-Ar@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 00:07:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfKeO-0001qt-BW
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 00:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701Ab1ARXHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 18:07:39 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60319 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab1ARXHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 18:07:38 -0500
Received: by fxm20 with SMTP id 20so210738fxm.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 15:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=IcEG9W0pYNtmk1aKgQcKLMHqKOHNIyD0mKOSNdXZwQk=;
        b=LxSbrglNodaEkmgv1LdNE/mVoor18nTYgkkzmR6EOa75Sejn0z/eMoEM4Tz3Ikr2pe
         GXF4J1uoHUnfKiv9pf0VJ1IAqH/j43Of7KjdaGpxLl3IVKGrfyr9e5iBJmQl0h6QQb8i
         6Jgn2PuW1KLo2hyT0tYcNQfypuK3fyM1VKLUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ul9FDJs809QVmEliQwOninnx/1cmPgf61jVFcUBdKGIfGPMezKEw/TnmiX7+r1Cntq
         dht45IrGgA9I32KGtO4+iVN0SGSpjOW81rjn/l5zD001GzAkSPiVNP91MH8lgB3PL+UD
         7o8isbePk+3qFQwW4R5iGdLrOZo/JSdRyegng=
Received: by 10.223.103.4 with SMTP id i4mr6745646fao.123.1295392057665; Tue,
 18 Jan 2011 15:07:37 -0800 (PST)
Received: by 10.223.95.201 with HTTP; Tue, 18 Jan 2011 15:07:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165230>

Currently you can do in your server's git config:

    [receive]
        denyDeletes = true
        denyNonFastForwards = true

But for most servers that's not what you want, you actually want to
deny those things to the master branch, but allow people to have their
private topic branches that they can reset. So how about allowing:

    [receive]
        denyDeletes = false
        denyNonFastForwards = false

    [branch "master"]
        denyDeletes = true
        denyNonFastForwards = true

I.e. have a per-branch setting that overrides the global setting?

(Of course ideally this would be:
    "branch.master.receive.{denyDeletes,denyNonFastForwards}"

But the *.ini format can only have a depth of three, so it has to be:

    "branch.master.{denyDeletes,denyNonFastForwards}"

Or perhaps:

    "branch.master.receive-{denyDeletes,denyNonFastForwards}"

Anyway, I can code this up if there's interest in it. This could also
be done with a .git/hooks/update hook, but IMO it's better to have
this as a documented setting for the most common things you want to
deny/allow.
