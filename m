From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: First web interface and service API draft
Date: Sat, 23 Apr 2005 16:39:19 +1000
Message-ID: <2cfc403205042223393a769e57@mail.gmail.com>
References: <1114166517.3233.4.camel@localhost>
	 <20050422142342.GG30915@delft.aura.cs.cmu.edu>
	 <1114203423.3207.24.camel@localhost>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 08:35:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPEEG-0003iX-Qy
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 08:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVDWGj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 02:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDWGj0
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 02:39:26 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:63724 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261451AbVDWGjT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 02:39:19 -0400
Received: by rproxy.gmail.com with SMTP id j1so930303rnf
        for <git@vger.kernel.org>; Fri, 22 Apr 2005 23:39:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n+Gti6r2EAUVSqwzEf1KfJRIviGDdshGfQpWPzsAnLsMJJbfKwEcFOLf172NvVVQpcoOmtGwwwG2b+/cAK5mJtth4HjiwPhLtTFZAW227m+hKUe0gCm5bwewjnNoQtkHWvWe7hctsEox1qynUmLvKuNHevT6NEvzp9hrjWO5Q/A=
Received: by 10.39.2.54 with SMTP id e54mr753862rni;
        Fri, 22 Apr 2005 23:39:19 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Fri, 22 Apr 2005 23:39:19 -0700 (PDT)
To: Christian Meder <chris@absolutegiganten.org>
In-Reply-To: <1114203423.3207.24.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/23/05, Christian Meder <chris@absolutegiganten.org> wrote:
> On Fri, 2005-04-22 at 10:23 -0400, Jan Harkes wrote:
> > On Fri, Apr 22, 2005 at 12:41:56PM +0200, Christian Meder wrote:
> > > -------
> > > /<project>/blob/<blob-sha1>
> > > /<project>/commit/<commit-sha1>
> >
> > It is trivial to find an object when given a sha, but to know the object
> > type you'd have to decompress it and check inside. Also the way git
> > stores these things you can't have both a blob and a commit with the
> > same sha anyways.
> >
> > So why not use,
> >     /<project/<hexadecimal sha1 representation>
> >       will give you the raw object.
> 
> Hmm. I'm not sure about throwing away the <objecttype> information in
> the url. I think I'd prefer to retain the blob, tree and commit
> namespaces because I think they help API users to explicitly state what
> kind of object they expect. I can't think of a scenario where I'd want a
> <sha1> of unknown type. Do you have a specific use case in mind ?
> 

I was initially inclined to agree with Jan, but on brief reflection I
think Christian is correct to want to preserve the type info in the
URI. There are numerous reasons why this is a good idea:

- both carbon and silicon users of the URI who don't have direct
access to the repository can infer what the URI refers to without
actually fetching it

- programmatically the web server can make request routing decisions
based on the URI alone and is not forced to perfom a relatively
expensive and unnecessary db hit to derive the type.

That said, I can see some value in providing a web-based
type-resolution service.

So, given a URI of the form

     /<project>/object/<hexadecimal sha1 representation>

the server should resolve the type of the named object and issue an
HTTP re-direct to the typed URI, e.g.

     /<project>/blob/<hexadecimal sha1 representation>

Because browsers tend not to remember redirection sources, external
entities end up recording the typed URIs, but all the benefits of
Jan's suggestion still accrue.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
