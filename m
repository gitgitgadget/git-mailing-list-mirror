From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Requirements for integrating a new git subcommand
Date: Fri, 23 Nov 2012 10:53:06 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121123155306.GB20097@thyrsus.com>
References: <20121122053012.GA17265@thyrsus.com>
 <CAJo=hJsQjXEhmfRUEgBc=RkF3Lk8QVqUqmeAJiOZ0dtvcMYVFw@mail.gmail.com>
 <20121122221107.GA16069@thyrsus.com>
 <50AF3E36.4080800@drmicha.warpmail.net>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 23 16:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbva1-000618-Bz
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 16:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab2KWPx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 10:53:56 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59035
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab2KWPxy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 10:53:54 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id AF03C4065F; Fri, 23 Nov 2012 10:53:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50AF3E36.4080800@drmicha.warpmail.net>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210261>

Michael J Gruber <git@drmicha.warpmail.net>:
> Regarding git-weave, I'm wondering (without having looked at the code)
> how this relates to git-archiv and git-fast-import/export, i.e. how much
> this leverages existing infrastructure rather than reinventing the
> wheel. Do your "trees" correspond to a "git tree"?

The unravel operation of git-weave is something like running
git-archive on every revision and saving the results in
sequentially-named directories, except that it also produces a
metadata file that allows the operation to be inverted.
So it is strictly more powerful.

The weave operation could be implemented using git fast-import, which
I am quite intimately familiar with from having written reposurgeon.
Functionally, the difference is that it would be a PITA to patch a
fast-import stream to insert or modify or remove revisions in the
middle, because the content of any given revision is in blobs that can
stretch arbitrarily far back from its commit and are shared with
other revisions.  With git-weave tree-sequences these operations
are easy and safe.

> Again, without having looked at the code, it seems to me that exploding
> blob and tree objects might give you a structure not much unlike
> weave's, and your instruction sheet resembles that of fast-import quite
> a bit (plus date fill-in etc.).

The weave log resembles an import stream, yes - that's because they
have to capture the same data ontology.  One major difference is that weave
logs are designed to be generated and edited by humans.
 
> One could even dream about implementing this as a remote helper instead...

What is a "remote helper" in this context?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
