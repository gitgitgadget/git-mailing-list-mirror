From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Fix file mark handling and sort side-effects in git.el
Date: Sun, 15 Feb 2009 18:08:53 +0100
Message-ID: <87ocx3hbkq.fsf@wine.dyndns.org>
References: <18834.27724.991388.339214@hungover.brentg.com>
	<87hc31kzrb.fsf@wine.dyndns.org>
	<e38bce640902120738h7b9bb75o42e1524cbfd95169@mail.gmail.com>
	<18836.22386.987021.484807@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 18:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYkVl-0002uk-Hd
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 18:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbZBORJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 12:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbZBORJF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 12:09:05 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:42730 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbZBORJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 12:09:04 -0500
Received: from adsl-84-226-2-29.adslplus.ch ([84.226.2.29] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LYkUC-0005ax-3W; Sun, 15 Feb 2009 11:09:02 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 305371E7203; Sun, 15 Feb 2009 18:08:53 +0100 (CET)
In-Reply-To: <18836.22386.987021.484807@hungover.brentg.com> (Brent Goodrick's
	message of "Thu, 12 Feb 2009 09:08:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.90 (gnu/linux)
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110023>

Brent Goodrick <bgoodr@gmail.com> writes:

> My rationale for adding append function calls to the sort calls is to
> leave the callers value alone since the caller needs to make use of
> the list value in subsequent operations, especially for issuing
> messages.

My point is that the callers that need it should take care of it
themselves, instead of forcing a copy even in cases where it's not
necessary. And the copy can most likely be avoided completely by
changing how the success message is printed.

>  > If you mean using git-add-file to do an update-index on an already
>  > tracked file, that's not what it's meant to do.
>
> That would be fine in, say, Perforce where once a file is added it
> stays added even if the user mades additional edits. I don't agree
> that is the best approach in the case the Emacs interface to git in
> git.el, since there is that "third" state where I could have added the
> file, then edited it, then forgot that I had edited it and proceeded
> naively to commit, only to be surprised later that the subsequent edit
> to the file was not committed. 

The design of git.el is that the index is not exposed directly, it's
treated as an implementation detail. So "add" in git.el is only for
adding an untracked file, it's not for updating the index contents of an
already tracked file; that's an unnecessary operation since git.el uses
the file marks to determine what gets committed.

It does get a bit confusing if you constantly mix command-line and
git.el commands, but you are not supposed to do that, you should be able
to do everything from the git.el buffer. I'm sure hiding the index
offends the git purists, but IMHO it makes things more Emacs-ish and
easier to use, especially if you are used to things like dired or
pcl-cvs or vc-dir with other VC systems.

-- 
Alexandre Julliard
julliard@winehq.org
