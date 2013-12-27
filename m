From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 5/5] Teach checkout to recursively checkout submodules
Date: Fri, 27 Dec 2013 15:14:26 +0100
Message-ID: <52BD8B42.2060507@web.de>
References: <20131226155857.GL20443@google.com> <20131226162238.GQ20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 27 15:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYBO-0007qv-Ae
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab3L0OO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:14:29 -0500
Received: from mout.web.de ([212.227.15.3]:63001 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530Ab3L0OO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:14:28 -0500
Received: from [192.168.178.41] ([84.132.152.21]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LhNs4-1VA4I70R5E-00maTX for <git@vger.kernel.org>;
 Fri, 27 Dec 2013 15:14:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131226162238.GQ20443@google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:culFiaY+1R1TPzBJl74PLZ4CyJSMK5nBwM06n9Z82tUBJcP1FNr
 xfW6wM6oLY1C0Jpr8A2DgRPQTzTmL8JBfWWf5kHHt4nSv9W78JWK8M1uI/YycZG7sdcW/nO
 Rv3NGmgv+lVZaxR1NrHxj2mx0jCr61vt226+OFV0wSytTYvfQXI5g/1Gk1gjjwJuCwcO8nr
 Z+Xh2W2gAa0hHafF5lH4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239732>

Am 26.12.2013 17:22, schrieb Jonathan Nieder:
> From: Jens Lehmann <Jens.Lehmann@web.de>
> Date: Wed, 13 Jun 2012 18:50:10 +0200
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This is the patch that actually introduces the --recurse-submodules
> option, which makes the rest work.
> 
> The tests indicate some future directions for improving this, but
> it works reasonably well already.  I think I'd be most comfortable
> applying these if they were rearranged a little to the following
> order:
> 
>  1. First, introducing the --recurse-submodules option, perhaps
>     with no actual effect, with tests that it is parsed correctly,
>     the default works, etc.
> 
>  2. Then, adding the desired behaviors one by one with corresponding
>     tests (handling submodule modifications, removals, additions).
> 
>  3. Finally, any needed tweaks on top.
> 
> That way, it is easy to play around with early patches without
> worrying about the later ones at first, and the patches are easy
> to review to confirm that they at least don't break anything in
> the --no-recurse-submodules case.

Makes tons of sense.

The only feature I'm aware of that is currently missing is to
read the path <-> name mappings from the correct .gitmodules
blob, which is needed to populate submodules that appear.

> That said, Debian experimental has these applied as is already,
> and there haven't been any complaints yet.

Great!

I'm also using this code at $dayjob successfully for quite some
time now. Additionally I also enable unconditional recursive
checkout by putting a "return 1" in the first line of the
submodule_needs_update() function (Which is a hack to emulate
"autoupdate=true" while at the same time pretending to already
having added "--recurse-submodules=config" to all call sites in
git porcelain scripts that call plumbing themselves). Only in a
few corner cases submodules aren't properly updated, but we'll
weed those out while implementing the tests. And we need lots
of those to cover all important combinations ...
