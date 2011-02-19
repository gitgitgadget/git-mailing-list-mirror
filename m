From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Merging limitations after directory renames -- interesting test repo
Date: Sat, 19 Feb 2011 10:22:29 -0500
Message-ID: <AANLkTimiZo8yiwnqzbOTg1FmM4rZn7ypSdZ3-zukLees@mail.gmail.com>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
 <20110218222151.GB4258@sigill.intra.peff.net> <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
 <20110219101936.GB20577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 19 16:23:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqoeA-0003nJ-6R
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 16:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab1BSPWu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 10:22:50 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50182 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470Ab1BSPWt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 10:22:49 -0500
Received: by ywj3 with SMTP id 3so252430ywj.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 07:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=oqWbjegJSm53r0CJmxAXCo0MQGwWST2OHHH4Mmm6sxU=;
        b=fgGVSxDzSa9QuCN6R0uVR4uuNSN9SSCjYPWd0eek+ffzg/QtXGO+oVczq7pKDPdZqZ
         DDu1oupDBPqOMzGi6xEA03bQadTBydu1oYZMHdusWAmsDPJZ3cpvBmt5sldbKRqz/8eW
         bYVj51x8HG5DZx9x2a+H04hBT/R12OEuA4QSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sw7G7xXwwjg02J7iCw+KJeWNn/ZjGWOYcK4mbAbBdVMkFT/OueNZL1CH+k3yXG7/xF
         K3GL6S9Ytx4T9BqVJioYA3XFg/PZs4T1g/p35H0RU5jr7X8w+aDfN8A9Ehc1Hr5zxtU0
         Bgx2UIr2cISSlkFOW6+jJH8VP+C5MWMg3eiCo=
Received: by 10.90.224.6 with SMTP id w6mr2715772agg.167.1298128969178; Sat,
 19 Feb 2011 07:22:49 -0800 (PST)
Received: by 10.90.53.7 with HTTP; Sat, 19 Feb 2011 07:22:29 -0800 (PST)
In-Reply-To: <20110219101936.GB20577@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167285>

On Sat, Feb 19, 2011 at 5:19 AM, Jeff King <peff@peff.net> wrote:
> So here's a patch series. It's built on your other 3 patches (all of
> which I thought looked good, btw).

Right, this is looking better! Applied Linus and Jeff's patches, and
things are much more civilized.

Now, I still have a ton of cases where the 2 branches renamed it just
slightly different. In those cases, what I want to do is have a merge
helper script that does...

 git merge-helper --prefer-path foo/orig/README foo/preferred/README
foo/other/README

if git could keep the rename trios that it recognizes during the merge
operation in a "merge notes" file, we could just name

 git merge-helper --prefer-path foo/preferred/README

and have it infer the "non-preferred" paths.

The result of the operation should be the same as if git had magically
known what I wanted to do during merge: git attempts a git-smart diff3
type merge, and stores the results accordingly in the index.

Even for a large messy merge like this, it means I can say

 git merge
 git merge-helper --prefer-path src/templates/themes/default/* other/di=
r/foo/*

and that will clear out 99% of the stupid work with minimal fuss;
leaving the interesting merge work to be cleared up by hand.

I suspect that teaching git merge to accept about 'preferred paths',
and perhaps "cache/learn" about them, is also desirable. Harder
though.

Thoughts?

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
