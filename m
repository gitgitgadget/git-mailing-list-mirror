From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 11:41:05 +0100
Message-ID: <8c5c35580802110241i72169620s693a31f9a098f596@mail.gmail.com>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de>
	 <20080211074817.GA18898@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:41:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOW6e-0002m9-8u
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbYBKKlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbYBKKlJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:41:09 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:27124 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbYBKKlH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:41:07 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2093392wah.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 02:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/7/j+KaJMoofTYs3gn5abRLvHu3LPp44sIM49xpa/Sk=;
        b=fVtwxA/4mWQ44ZHaoRlggo0i0CmP8Z8H2vOa6+V6MadiQLfkcgXqTzIQZYaOilD5pqG1743g3uXV1j245LlSjbtwOHJUC/zNKR4IJ7dQOPn5c0kvLypiYFPERTBdogiPTi11GmoLDVDNHdAKuWXlYlI/+OycGaXd0mq/XHzX9DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rphn9ZhGmXg1y2joDP/2Qi400MXRJbWhEoSSVfSMdVfM7cLV7fZSAx7TdBSe0N0uS+P3oU6Bx6PE0l7M0JCbhL4Zx5m9SClrOju6Ps9x0JDWqP5iJ830OCJQ0bicuEk6/AbgnOmz/OEgKULpC0ZldtW7+m7oksSAeqf72c0u1Js=
Received: by 10.114.209.1 with SMTP id h1mr259826wag.115.1202726465968;
        Mon, 11 Feb 2008 02:41:05 -0800 (PST)
Received: by 10.115.73.7 with HTTP; Mon, 11 Feb 2008 02:41:05 -0800 (PST)
In-Reply-To: <20080211074817.GA18898@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73510>

On Feb 11, 2008 8:48 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 11, 2008 at 07:19:32AM +0100, Steffen Prohaska wrote:
>
> > I think that limiting rename detection during merge is a really
> > bad idea.  Either we should set it to unlimited, or at least we
> > should print a BIG WARNING that rename detection is limited
> > during the merge.  I'd propose to override diff.renamelimit
> > to unlimited for a merge, even if diff.renamelimit is explicitly
> > configured by the user.  It doesn't make sense not to detect
> > renames during a merge.
> >
> > Opinions?
>
> The point of diff.renamelimit was that some rename detection is
> literally so time-consuming that we might as well not bother starting
> it. The number '100' was pulled out of Linus', er, hat.

FWIW, prior to 07b45f8c merge-recursive ignored diff.renamelimit. The
effect of this was that 'git diff HEAD somebranch' could detect
renames which 'git merge somebranch' couldn't; Teaching
merge-recursive about diff.renamelimit made sense IMHO since 'git
merge' then would agree with 'git diff' regarding renames.

> It may also be that multiple rename limits are appropriate. I don't mind
> waiting 30 seconds for rename detection during a particularly tricky
> merge. I probably do when running 'git-log -p'.

Yeah, I guess we could add support for merge.renamelimit in addition
to diff.renamelimit (i.e. use diff.renamelimit if merge.renamelimit is
unspecified). And/or add the -l option of git-diff-* to
git-merge.sh/merge-recursive.c.

--
larsh
