From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git web--browse error handling URL with & in it (Was Re: [RFC/PATCH] Configurable hyperlinking in gitk)
Date: Sun, 18 Sep 2011 16:46:35 +0200
Message-ID: <201109181646.36821.chriscool@tuxfamily.org>
References: <20110917022903.GA2445@unpythonic.net> <4E753C04.1070202@gmail.com> <20110918032933.GA17977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 18 16:46:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5Idx-0003Uq-SN
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 16:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab1IROqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 10:46:49 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40063 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab1IROqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 10:46:49 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 42450A621E;
	Sun, 18 Sep 2011 16:46:39 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-10-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <20110918032933.GA17977@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181611>

Hi,

On Sunday 18 September 2011 05:29:34 Jeff King wrote:
> On Sun, Sep 18, 2011 at 12:32:04PM +1200, Chris Packham wrote:
> > Update: it's the call to eval that causes the problem
> > 
> >   eval kfmclient newTab https://internalhost/code\&stuff/bugs.php?id=foo
> >   [1] 14728
> >   bash: stuff/bugs.php?id=foo: No such file or directory
> 
> Hmm. The offending lines look like:
> 
>   eval "$browser_path" "$@" &
> 
> Normally in git we treat user-configured commands as shell snippets,
> meaning the user is responsible for any quoting. But in this script, we
> seem to run:
> 
>   type "$browser_path"
> 
> several times. Which implies that "$browser_path" must be the actual
> executable. In which case, I would think that:
> 
>   "$browser_path" "$@" &
> 
> would be the right thing. And indeed, that is what the firefox arm of
> the case statement does. But chrome, konqueror, and others use eval.

Yeah, I don't remember why I sometimes used 'eval "$browser_path" "$@"' when I 
wrote this code. Sorry!
 
> Unrelated, but it also looks like $browser_path is used unquoted in the
> firefox case (see inside the vers=$(...)).

Thanks,
Christian.
