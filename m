From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: Merging using only fast-forward
Date: Sat, 19 Jan 2008 02:28:55 -0800
Message-ID: <402c10cd0801190228o68995493u9b8b40e1557092dd@mail.gmail.com>
References: <loom.20080116T151930-575@post.gmane.org>
	 <863asxivlj.fsf@blue.stonehenge.com>
	 <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0801162253n6ab19f51y53d0baa16319adaa@mail.gmail.com>
	 <402c10cd0801172258p9a1a97bt682fa012fcebd13c@mail.gmail.com>
	 <7vodbibzch.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 11:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGAx7-00083L-W8
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 11:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYASK27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 05:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbYASK27
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 05:28:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:23719 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbYASK26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 05:28:58 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1288649fga.17
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 02:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AFjKQwMmcxmBqNiD20QtIpwnJd0LbJeyTH6tSWJgXk8=;
        b=McWHu84cFQUduGWtLeSvcW22IABYz24aRvpChW5gJGnmE2K+XOOaWLQgDqv5wrsiMHMpJ1R12Hpsv3gw7ohDUvtmFbjYQAKzis9clVNbV69vmrsPGP1OWsqMxkv+pDDCgO93EiMym1Vde4W3EOTNESz1wo3wpHgokQDNl8Bdrwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LGHgOpyNBMlLmsYWJmN20qTNwhUz6bxicpH8y5RfeMnMkb4UqWzIevzWUUiR94++rwTX1lPIdGwPSmDQM8TcRmznmxWB8+Dg7LZfF+Sw+5yIX8eGjPQS4c7hgxrynqdngqlabh6aWm0sxCWUBuhjtRrg/5XSvORawvyPkxi2gOs=
Received: by 10.82.112.3 with SMTP id k3mr7971212buc.15.1200738535047;
        Sat, 19 Jan 2008 02:28:55 -0800 (PST)
Received: by 10.82.172.18 with HTTP; Sat, 19 Jan 2008 02:28:55 -0800 (PST)
In-Reply-To: <7vodbibzch.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71094>

On Jan 18, 2008 1:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
> So keep it simple, and do not use Octopus if there is no
> justification other than "it looks cool" you can come up with.
>
> I do not mind a patch to git-merge-octopus to discurage its use
> even more by detecting the casen where some of the merged
> branches are not independent and refusing to work, but that is
> a post 1.5.4 topic.

Instead of refusing to work, such merge commits can be fast forwarded,
recorded as a "normal" commit with two children, or an octopus with
fewer children than those specified by the user.

The more I think about this is that --ff-only should really be
specified as a merge strategy (single) and not as an special case of
--ff.  All merge strategies can then take any number of commits, but
will only succeed if the commits can be reduced down to two or fewer
for resolve/recursive and one for single.

Commit reduction is simpler for single than the other merge strategies.

I suggest we keep it simple and implement this new feature as a merge
strategy and the commit reduction is only done for fast-forward.

I will create a good number of test cases so we should be comfortable
with this new feature.

A later patch will implement the commit reduction for the other merge
strategies.  --no-ff will then have the meaning:  No fast forward of
any commit.  All commits specified by the user will be recorded.

-- 
Sverre Hvammen Johansen
