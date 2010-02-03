From: Scott Chacon <schacon@gmail.com>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 11:58:25 -0800
Message-ID: <d411cc4a1002031158k3e50db30l3f7d73d49e3dad23@mail.gmail.com>
References: <20100203174041.GC14799@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:58:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclN0-00030n-V5
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757756Ab0BCT63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 14:58:29 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:61973 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757731Ab0BCT62 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:58:28 -0500
Received: by ewy28 with SMTP id 28so1876729ewy.28
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=OkPaL2GZeIzXdZReYHkKT6gPc4UthZvi4om6rQW7v/8=;
        b=C2RDbGbx542wQ5DOesbguSeoTQTdWVSaGgLLnJxyIbUxCMwdTYj1lNVH9p3nDh3nII
         6adiDruvyMuO8JJ1IykzRCgfh2DC55GbH67yjCoqktWOI75+lRm4Fs0eNFtkCWHn8DxA
         TqRAboO9bnnmtw9IMHH1SDBwjz3Gk473Khjbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JQSHORfpckySPh88VtzJRdIbHKCWKD+pEz6wdq2AAoHeIITVm22z8bTcSTVemYsKKk
         lNdfh4m3t8N7DCK2phWQeX/4TeeeA/XkqC1Qe8AmbxXp0kHKCBHhLQf3gH2QGRAyqO3b
         t4Cnd+ws9Lin95qXSAKJXoX0Oz7hh0ClxpOF0=
Received: by 10.216.88.80 with SMTP id z58mr25617wee.116.1265227107071; Wed, 
	03 Feb 2010 11:58:27 -0800 (PST)
In-Reply-To: <20100203174041.GC14799@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138879>

Hey,

On Wed, Feb 3, 2010 at 9:40 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Today I came across this "bug fix" [1,2] in Dulwich, which is
> claiming to be a pure-Python implementation of Git.
>
> I haven't spoken with Jelmer Vernooij directly about it, but after
> some indirect email through a 3rd party, it seems he might be under
> the impression that this really is a bug in Dulwich, because "other
> git implementations do it".

At the risk of pissing you off for the second time in as many days,
this is entirely my fault.  I was having a beer with Jelmer in
Wellington a few weeks ago during LinuxConf.au and we were talking
about the difficulties in storing metadata having to do with cross-vcs
migrations - specifically his work with an bzr-git bridge and mine
with the hg-git project.  He was noting that I kept all my metadata
about original Hg commits in Git as formatted text in the commit
message, which is pretty uggo (especially with the amount of sometimes
inconsistent denormalization of data Hg does on commit, explicitly
recording renames and manifests and whatnot).

Anyhow, I was saying that _technically_ you can artificially write
extra headers into the commit object (though at the time Dulwich
didn't support reading them because of how it parsed commit objects -
I believe it would actually explode if it saw something it didn't
expect).  I said I was still going to keep the metadata in my
implementation in the message, but he was very interested in hiding
his in the commit headers.  To my defense, we (you and I, Shawn)
talked about this at the GitTogether this year and you and a few
others told me that CGit would not blow up but would just ignore them,
which is fine for his purposes.  I certainly did not get the
impression from that short discussion that this was something to be
absolutely avoided, but rather that it just wasn't really encouraged
or explicitly supported.

Oddly enough, this whole thing basically came up because we were
noting that you can hide extra data in Hg changesets, but it's a
ridiculous hack involving adding it after a null byte in the timestamp
field, much like we do in adding the capabilities after the first ref
in the negotiation phase of the tranfer protocol.  I was just casually
saying, "yeah, you can actually technically do that a lot cleaner in
Git"...

Sorry.  So, for future reference, though CGit _can_ handle it, don't?

thanks,
Scott
