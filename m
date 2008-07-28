From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git submodules
Date: Mon, 28 Jul 2008 18:32:54 -0400
Message-ID: <32541b130807281532v3eed94ebv8037247618e9bd55@mail.gmail.com>
References: <20080728162003.GA4584@artemis.madism.org>
	 <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
	 <20080728205545.GB10409@artemis.madism.org>
	 <20080728205923.GC10409@artemis.madism.org>
	 <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
	 <20080728220308.GF10409@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Nigel Magnay" <nigel.magnay@gmail.com>,
	"Git ML" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 00:34:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNbHw-000463-DN
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 00:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbYG1Wc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 18:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbYG1Wc4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 18:32:56 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:34373 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbYG1Wcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 18:32:55 -0400
Received: by qw-out-2122.google.com with SMTP id 3so342352qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 15:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XZG3xGNGw7WYMRDVMkd++SMr3axrFIGt9RLn5FFnr+E=;
        b=dldj3/w4614VeuhjEDZgeHWxBmzsrmR6/2GLTBX7q6LxMa30q13r0T6FK2sHTsbnnl
         ypKsmv5xuCGbQx/LHqS44Jnie6EHG5AN7D8qTXitD7y6VyasT6/2iID/ncxAEp8ZCPDb
         BzMZOf2DByDElqWJXCLg+VETDJfFe6cH+2148=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=K5uDqK54sBZQRpT9fxDtYIo+aPBXRnBcyjakFSPVzsH6y9x2gK+O5xDsRO3AOmvQw5
         RPFPS1GyjUaLPFQhUYELPSA9ux7CKJk5936wOxwRtr4CFBZ3t1HPgoE1xc2CPKFQHdvg
         4iUneZX3hcVRHLCq+8zUOAVINPihFhHXRWuoo=
Received: by 10.214.26.20 with SMTP id 20mr619503qaz.9.1217284374513;
        Mon, 28 Jul 2008 15:32:54 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Mon, 28 Jul 2008 15:32:54 -0700 (PDT)
In-Reply-To: <20080728220308.GF10409@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90515>

On 7/28/08, Pierre Habouzit <madcoder@debian.org> wrote:
>  > It's unfortunate that submodules involve a commit->tree->commit link
>  > structure.
>
> Actually it's not a big problem, you just have to "dereference" twice
>  instead of one, and be prepared to the fact that the second dereference
>  may fail (because you miss some objects). I instead believe that
>  gitlinks are a good idea.

It's actually complicated to generate the log, however.  To be 100%
accurate in creating a combined log of the supermodule and submodule,
you'd have to check *for each supermodule commit* whether there were
any changes in gitlinks.  And gitlinks might move around between
revisions, so you can't just look up a particular path in each
revision; you have to traverse the entire tree.  And you can't just
look at the start and end supermodule commits to see if the gitlinks
changed; they might have changed and then changed back, which is quite
relevant to log messages.

Probably it's more useful to just commit the git-shortlog of the
submodule whenever you update the gitlink.  It won't work with bisect,
exactly, but that's less important than generally having an idea of
what happened by reading the log.  ISTR somenoe submitted a
git-submodule patch for that already somewhere, but I've been known to
imagine things.

> Well, using the same [branch] as the supermodule is probably the less confusing
>  way. Of course, not being in the "same" branch as the supermodule would
>  clearly be a case of your tree being "dirty", and it would prevent a
>  "git checkout" to work in the very same way that git checkout doesn't
>  work if you have locally modified files.
>
>  If your submodule branching layout uses the same names as the
>  supermodule branches then yes, it's going to hurt, but I believe it to
>  be unlikely (else you would become insane just trying to remember what
>  you are doing ;p).

I think this is much more common than you think.  An easy example is
that I'm developing a new version of my application in the
supermodule's "master", but it relies on a released version of my
submodule, definitely not the experimental "master" version.  Using
your logic, the local branch of the submodule would be called master,
but wouldn't correspond at all to the remote submodule's master.

I believe such a situation would be even worse than no branch at all.
It could lead to people pushing/pulling all sorts of bad things from
the wrong places.  At least right now, people become confused and ask
for help instead of becoming confused and making a mess.

Have fun,

Avery
