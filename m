From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 16:42:07 -0500
Message-ID: <76718490902161342w176c2dfawb35e97fcaf934b05@mail.gmail.com>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
	 <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
	 <7veixybw7u.fsf@gitster.siamese.dyndns.org>
	 <loom.20090216T101457-231@post.gmane.org>
	 <20090216135812.GA20377@coredump.intra.peff.net>
	 <49999ED6.7010608@gmail.com>
	 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
	 <4999BD54.8090805@gmail.com>
	 <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:43:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBFW-0007Sx-Ls
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZBPVmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbZBPVmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:42:09 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:61206 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbZBPVmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:42:08 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1717836rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 13:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JC6hR61oJ0PgzpyDzfReDE5QhH/+NjdK4cobKZThSAk=;
        b=BrVui56aqDvbtoscUMzZMux6GqUuF9Q6Y86X2kQSkJJzKQ69LvdKw+5qcIeqBbJavN
         smV1XhIiIR1hmcMrvbk5ClAKi2hYVlPPXviyF803LrTmCqdi1FgJZ+hHHlTb3r+S90r9
         WwIqhs6sxtJ3muZCLrcKTzCHYIeRvdHqffEGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=snMx5ihsJJViWNEleL/Li58+Gh2TCLmSokLeLvuzSaCdII8lziM65ZJJCWSqKvNKxe
         T0ntvJQNJXiFy4R7gB6BMMutubJKy14pTQm6u0uChIVSn3RlAQyv0/8JPGlJTjRCPmdP
         1375dtGsDVEQDEVpot53KXMSE/uo4N9GJB8OQ=
Received: by 10.141.100.15 with SMTP id c15mr1314888rvm.52.1234820527483; Mon, 
	16 Feb 2009 13:42:07 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902162103580.6289@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110247>

On Mon, Feb 16, 2009 at 3:09 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> What you are suggesting, though, is that the _pusher_ detaches the HEAD.
> So the _local_ user will never know.

I'm going to be presumptuous here and say that I think that you're
thinking about this the wrong way.

I would wager that when someone is pushing into a non-bare repo, it is
very likely that the pusher and the local user are the same person.
i.e., there are two common combinations: 1) a shared bare repo; 2) an
individual (non-shared) non-bare repo.

I think it is the shared non-bare repo which is rather uncommon, and
used mostly by advanced users or for specialized situations like
publishing web-roots.

If I'm right, then I still think that what might better sense is:


non-bare repo                     non-bare repo
-------------------               ---------------------
refs/heads            ---push-->  refs/remotes/incoming
   ^                                     |
   |                                   merge
 merge                                   |
   |                                     v
refs/remotes/origin   <--fetch--  refs/heads


Yes, you can set this up, but it is quite a few extra steps to do so.
The defaults assume there is a bare repo that you're pulling/pushing
from/to, hence the confusion for new users when that's not the
scenario they are in.

But instead of all this talk, maybe I should pony up some RFC patches. :-)

j.
