From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 20:34:43 +1200
Message-ID: <46a038f90606120134n21c269bbj3e8c7e31d4d93a23@mail.gmail.com>
References: <11500407193506-git-send-email-octo@verplant.org>
	 <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com>
	 <20060612082448.GA11857@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 10:34:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fphsn-0004Dr-PT
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 10:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWFLIeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 04:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWFLIeq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 04:34:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:50210 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751104AbWFLIep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 04:34:45 -0400
Received: by wr-out-0506.google.com with SMTP id i20so1095637wra
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 01:34:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sEOrZ9I94ealvbPFDSx/vzFDChI0o+hEsB7qSjhmcGCPpexJXlyhvJKObIG1ERAB7jhXnRR/pLd4MLTKFSJAGl9pxnspkIZxNuEeaDfP4YZvqlCw2VIAC5EmsjZNN8Nixagk2nURApXq8A2Y6n62R/ycaWW5dGdPhDz5Gu2Du54=
Received: by 10.54.153.12 with SMTP id a12mr5150790wre;
        Mon, 12 Jun 2006 01:34:45 -0700 (PDT)
Received: by 10.54.71.9 with HTTP; Mon, 12 Jun 2006 01:34:43 -0700 (PDT)
To: "Florian Forster" <octo@verplant.org>
In-Reply-To: <20060612082448.GA11857@verplant.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21696>

On 6/12/06, Florian Forster <octo@verplant.org> wrote:
> On Mon, Jun 12, 2006 at 10:02:05AM +1200, Martin Langhoff wrote:
> > good! git-blame/git-annotate are quite expensive to run. Do you think
> > it would make sense making it conditional on a git-repo-config option
> > (gitweb.blame=1)?
>
> sure, that it's a big change and if it helps the kernel.org folks ;)
> I'll follow-up with a patch for this in a second..

That'd be great. I am looking into integrating other feature patches
too (like tarball downloads) that are useful but costly, making them
conditional too...

> Would it help to cache `git-annotate's output, e.g. using one of the

I think we can rely on proxies doing good caching -- a busy host like
kernel.org will have big reverse proxies in front. A git-blame for a
given file+commitsha doesn't change, so we can give it a long cache
time, like... forever ;-)

> I have two more points regarding gitweb's configuration:
> - IMHO it would make sense to move the general gitweb-configuration
>   (where are the repositories, where are the binaries, etc) out of the
>   script.  As far as I know the Debian maintainer of the `gitweb'
>   package has asked for this before but was refused for some reason..

Sounds like a reasonable request. I would make it rely on env vars,
$ENV{GITWEB_CONFIG} can generally point to /etc/gitweb.conf, and that
would override the config values we have.

This is trivial, and it means we buy a lot of flexibility from
apache's httpd.conf being able to point to different config files
depending on arbitrarty conditions.

BTW, I haven't seen the debian maintainer's request, was that on the list?

> - If `GIT_DIR/description' is only used by gitweb it may be more
>   consistent to use the git-repo-config option `gitweb.description' in
>   the future.

Not sure how git-repo configurations deal with long entries. Right now
the description may contain html for instance.



martin
