From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: what's a useful definition of full text index on a repository?
Date: Tue, 2 Oct 2007 10:34:19 +0100
Message-ID: <e1dab3980710020234l1951349r38657c68aa7ef5@mail.gmail.com>
References: <e1dab3980710010933u6a7324f0wa8230d67ee0846e2@mail.gmail.com>
	 <9e4733910710011025y790800b5s4e8cf65409bc2cce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 11:34:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ice98-0007Nh-63
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 11:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXJBJeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 05:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbXJBJeV
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 05:34:21 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:22560 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbXJBJeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 05:34:20 -0400
Received: by nz-out-0506.google.com with SMTP id s18so2860209nze
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=m6S5boFhV5NRA4cHgEb8WILzcKTo23+VuIQyyGx0hs4=;
        b=V7hmDevHT+4s/hqZjp2cla1aN3eCB+DEw2Iyw1mSoXdK0ya1rfNZz1SZkqvsuPvYwxO5D/ISSMxsR8qFQktA5cLiMP0E5nSSYzMpo4osp44G+gZuj/vGnCcLlPBFSnkrWqt6GsakO7UTa+TCBkJ42DSUIsu6Q5PzVWEO9iNJfAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I7qpmQjm4ihie7zWS2xyEd+On0RTZbaMi901fJbDt2AYvblM/lqfPV7bGXMLAI5NyvW2JoIGhg3HFUbGp+ah/rEFHIOZ9FTxwxrXxTupPdtDkjr4nEsRPSI6Wpps1PG1/SAFagY5oxKME+rV4Ntruv+W6E1QnFQkamoU9Y1l5/c=
Received: by 10.64.241.3 with SMTP id o3mr5672874qbh.1191317659490;
        Tue, 02 Oct 2007 02:34:19 -0700 (PDT)
Received: by 10.64.181.10 with HTTP; Tue, 2 Oct 2007 02:34:19 -0700 (PDT)
In-Reply-To: <9e4733910710011025y790800b5s4e8cf65409bc2cce@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59676>

On 10/1/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> This is what full text is used for with code:
> http://lxr.mozilla.org/
>
> It makes grep instant.

I'd thought that keeping a full-text index of all my program files was
my dirty little secret that shows I'm not a "pro" programmer ;-)

> For source code you can take the full text concept further and store
> parse trees.
[details snipped]

This sounds interesting in principle but is beyond what I'm thinking
in practice (particularly since I'm not in the "C is the only language
worth ever using" camp).

> Full text indexing can also achieve high levels of compression as
> stated in the earlier threads. It is full scale dictionary
> compression. When it is being used for compression you want to apply
> it to all revisions.

Well, as I say I'm not convinced it makes sense to integrate this with
existing pack stuff precisely because I don't think it's universally
useful. So you seem to end up with all the usual tricks, eg, Golomb
coding inverted indexes, etc, _if_ you treat each blob as completely
independent. I was wondering if there was anything else you can do
given the special structure that might be both more useful and more
compact?

> You would full text index the expanded source text for each revision,
> not the delta. There are forms of full text indexes that record the
> words position in the document. They let you search for "vision NEAR
> feedback"

Well, the kind of question I was thinking was "clearly you can use the
existing sort of full text indexing (eg, the stuff covered in Cleary,
Witten & Bell's covered Managing Gigabytes), but is that the most
useful way of doing things in the context of an evolving database?" If
you treat every blob as essentially a different document there are
indexing tools out there already you can use. What I was wondering was
if it's really that useful to a human user to report every revision of
a document containing those keywords even if the differences are in
other parts of the text far removed from the text containing the
keywords. I don't know the answer.

> > (One question is "why do you want to build a table rather than
> > actively search the full git repo for each query (ie, combination of
> > words) as you make it?" My primary motivation is that I might in the
> > future like to do queries on some sort of low processor power
> > UMPC-type thing, having built the file containing a "full text index"
> > data structure for the index on a quite beefy desktop. The other point
> > is that searching natural language text based on a fallible memory
> > you're more likely to try different combinations of search terms
> > iteratively to try and hit the right one, so there might be some point
> > in trying to build an index.)
>
> I do admit that these indexes are used to make functions that can be
> done with brute force faster. As computers get faster the need for
> these decrease. Right now the size of the kernel repo is not growing
> faster than the progress of hardware. If you went back are tried to do
> these things on a 386 you'd be shouting for indexes tomorrow.

The other point is that direct searching is easier because you know
exactly what the query is at the point you have access to the full
text, whereas building an index you want to extract no more and no
less information to be able to answer all allowed queries. But I still
like the idea of getting a UMPC type thing if they become affordable.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
