From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: auto-packing on kernel.org? please?
Date: Wed, 23 Nov 2005 14:10:47 +0000
Message-ID: <b0943d9e0511230610x3bdd288ej@mail.gmail.com>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
	 <20051121190151.GA2568@hpsvcnb.fc.hp.com>
	 <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
	 <4382AC11.5090209@citi.umich.edu>
	 <Pine.LNX.4.64.0511212134330.13959@g5.osdl.org>
	 <b0943d9e0511220613h5978a600l@mail.gmail.com>
	 <7v64qkfwhe.fsf@assigned-by-dhcp.cox.net>
	 <b0943d9e0511220946o3b62842ey@mail.gmail.com>
	 <7v1x18eddp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 15:12:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EevKq-0005eP-NQ
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVKWOKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKWOKt
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:10:49 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:38013 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750808AbVKWOKs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:10:48 -0500
Received: by xproxy.gmail.com with SMTP id i30so1158884wxd
        for <git@vger.kernel.org>; Wed, 23 Nov 2005 06:10:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C6GsyAtPr/XDLwN45dzrIN6eqXsdhb/iKMufRa/13GsucY9wj1qjLt0FomRMgh00oSpqaWTGsflZTbNiRy5paIzdmSYwuwKuUAby5kR3oKLYNn5YiEpA9YzJjqD3J5wR/8f39jq4AWl86m7k7VJhfLGGeUUA75ExvA6DZ+LyknY=
Received: by 10.70.29.18 with SMTP id c18mr721120wxc;
        Wed, 23 Nov 2005 06:10:47 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Wed, 23 Nov 2005 06:10:47 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x18eddp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12622>

On 22/11/05, Junio C Hamano <junkio@cox.net> wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
>
> > What I meant is any object whose exact reference is found in
> > refs/patches (not reachable via refs/patches), even if it is reachable
> > from refs/heads.
>
> do you mean you
> keep blobs and trees in refs/patches, or "exactly found in
> refs/patches" imply "commits in refs/patches and trees and blobs
> reachable from it"?  If the latter I think it amounts to the
> same thing.  If some of the blobs are shared with what is
> reachable from refs/heads or refs/tags I would presume you would
> want to pack them.

Each patch needs to have 2 commit and 2 tree objects (with the
corresponding blobs). I now understand where the problem appears. Most
of the blobs should actually be packed since they are part of the base
of the stack.

Since refs/heads files always point to the top of the stack, the
applied patches (the corresponding objects) would be automatically
packed. The alternative would be to only pack the objects reachable
from refs/bases but that's really StGIT-specific.

Other algorithm would be to avoid packing objects reachable from
refs/patches but not reachable from refs/bases but this would probably
complicate GIT.

> And the "volatile" idea may be a good way of doing this.
> Perhaps "git repack --volatile <glob>" to name paths under
> .git/refs to mark things not to be packed, with a per-repository
> configuration item to give default 'volatile' patterns?  I could
> use it when packing my repository to exclude things that are
> only reachable from "pu" branch.

After I eventually understood what you meant, the above would still
include the already applied StGIT patches since they are reachable via
HEAD. Maybe StGIT could avoid modifying refs/heads but I think it
would lose some benefits.

--
Catalin
