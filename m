From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Core and Not-So Core
Date: Thu, 12 May 2005 07:09:38 +1000
Message-ID: <2cfc403205051114096117e62f@mail.gmail.com>
References: <2cfc403205051016205d722f23@mail.gmail.com>
	 <Pine.LNX.4.21.0505111235030.30848-100000@iabervon.org>
	 <2cfc403205051114087d283279@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 11 23:04:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVyML-0003CR-7U
	for gcvg-git@gmane.org; Wed, 11 May 2005 23:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVEKVKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 17:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVEKVKO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 17:10:14 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:29748 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262051AbVEKVJj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 17:09:39 -0400
Received: by rproxy.gmail.com with SMTP id j1so164326rnf
        for <git@vger.kernel.org>; Wed, 11 May 2005 14:09:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hIJLNXwVWScyypQMSW/uMX4ibnlDVZtRAq6dYo8Hp3Yr0Er91DSBnaMy7yvLxvpPDEJBS+CpoZzn/Q2HiSwQqsrmqN+vSKSVXO/ezOwgeBDHn9r17lMUOleZDayfsy4C/FzGc8LFTzaRvshX1J135lL9xxfTZ+MQ5oAbnU+98w8=
Received: by 10.39.3.79 with SMTP id f79mr630683rni;
        Wed, 11 May 2005 14:09:38 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Wed, 11 May 2005 14:09:38 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc403205051114087d283279@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/12/05, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Wed, 11 May 2005, Jon Seymour wrote:
>
> > The repository API would contain functionality equivalent to cat-file,
> > ls-tree, most of fsck-cache, rev-list, rev-tree, diff-tree, most of
> > the transport code - things that don't involve use of the index.
> >
> > The workspace API would contain read-tree, write-tree, commit-tree,
> > etc - things that do involve use of the the index.
>
> Unfortunately for this idea, you can't actually check files into or out of
> the repository using the git tools without the index (in memory at least,
> if not on disk). This is a bit like having a libc with all the system
> calls except read and write. Sure, there are a number of programs that
> would be fine that way, but it makes the API unintuitive, and most serious
> programs need the extension anyway.
>

Daniel,

Checking in/checking out is definitely a workspace API function that
involves an index (almost certainly) an on-disk index, but reading and
writing from and to the repository is purely a repository API
function.

There is no reason why the workspace API can't make use of
"lower-level" functions in the repository API. I guess I would argue
that the repository API really shouldn't need much, if any knowledge,
of the workspace API.

The repository API knows about the on-disk structure of repository
objects - it knows how to write writing compressed, SHA1 signed
objects, it also knows how to pack and unpack the various object types
from their on-disk representation into structures manipulated by the
workspace API.

On the otherhand the workspace API knows about managing index
(workspace) state. It knows how to determine whether the
pre-conditions for a commit have been reached. It knows how to read
the workspace structures and coordinate read and writes from and to
the repository.

I really don't think this makes the API unintuitive, but then I don't
really understand why you think this is the case.

jon.
--
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com
