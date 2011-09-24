From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Sat, 24 Sep 2011 08:05:29 +0200
Message-ID: <4E7D7329.7070800@alum.mit.edu>
References: <4E7A3BDE.3040301@alum.mit.edu> <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4E7AF1AE.5030005@alum.mit.edu> <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com> <20110922171340.GA2934@sigill.intra.peff.net> <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com> <20110922205856.GA8563@sigill.intra.peff.net> <4E7C5A3B.10703@alum.mit.edu> <20110923193341.GA26820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 24 08:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7LMu-000665-94
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 08:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab1IXGFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 02:05:39 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36707 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab1IXGFj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 02:05:39 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEB3E5.dip.t-dialin.net [84.190.179.229])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8O65TJ8024229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 24 Sep 2011 08:05:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <20110923193341.GA26820@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182019>

On 09/23/2011 09:33 PM, Jeff King wrote:
> [1] I really wish we had an elegant way of versioning meta-information
>     about a repository (like config, info/attributes, etc). I've hacked
>     around this before by having a special meta-branch for each repo,
>     checkout it out in an alternate directory, and then symlinking bits
>     of it into .git. But that's kind of ugly, too.
> 
>     I'm not sure what a good solution would look like. There's a real
>     can of worms with respect to picking and choosing local versus
>     remote bits of meta-information, with some security implications.

This could be implemented by having a single local config option that
enables the use of an in-tree .gitconfig file:

    git config core.useTreeConfig true

(or whatever the correct naming convention would be).  This option would
default to false, so the in-tree config would only occur following an
affirmative decision by the cloner.

If finer granularity is required, config options could be classified
into "security-relevant" and "non-security-relevant" options, where the
former group basically includes anything that can cause arbitrary code
to be executed.  Then there could be a "core.useTreeConfig = safeonly"
option to allow only the harmless options.

I think the priority of config options (highest to lowest) should be

       $GIT_DIR/config
       in-tree .gitconfig
       ~/.gitconfig
       $(prefix)/etc/gitconfig

Of course, just like for attributes, it would have to be decided which
version of the .gitconfig to use in which situations.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
