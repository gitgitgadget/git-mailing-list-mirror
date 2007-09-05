From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git's database structure
Date: Wed, 5 Sep 2007 11:37:28 -0400
Message-ID: <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
	 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
	 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
	 <20070904212507.GA24434@thunk.org>
	 <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>
	 <46DE5861.4050201@op5.se>
	 <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
	 <46DEC26E.7030809@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 05 17:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISwwr-000338-Mt
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 17:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009AbXIEPhc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 11:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756985AbXIEPhb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 11:37:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:63898 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897AbXIEPh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 11:37:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2627750wah
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 08:37:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H0H2cKBFhRrufdFWopnn12gQXtEHozq8pU8rV5oGAIWFKU7ZEtvOmaw2Qdx21wS950hR4Br2hZ300hsIj95WwovoUQqqfl1hbnItoITXow7njkSTeQZpZV+WRVKl/789RH4alTOPeXIQJ2jCM+wpOXSUJ2a3FFWbmIy/GNVlUMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qh1fSpHTUQb7wU25SwUnFlYsqQS0dE6rwx7cOVn75E4E9arUkpydDpkzcGi7xrDDigCbxjNroiIhvxcSw0ioIMqi4IoblWtKLMmXvrn4SMhtH8P8srmvFnQbekeLh+m1LlxbY+Z5x7157ntbXGUPmT+AsuPa555wCy3dFmwn3Es=
Received: by 10.114.58.1 with SMTP id g1mr1609047waa.1189006648549;
        Wed, 05 Sep 2007 08:37:28 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Wed, 5 Sep 2007 08:37:28 -0700 (PDT)
In-Reply-To: <46DEC26E.7030809@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57716>

On 9/5/07, Andreas Ericsson <ae@op5.se> wrote:
> Jon Smirl wrote:
> >
> > The path name field needs to be moved back into the blobs to support
> > alternative indexes. For example I want an index on the Signed-off-by
> > field. I use this index to give me the SHAs for the blobs
> > Signed-off-by a particular person. In the current design I have no way
> > of recovering the path name for these blobs other than a brute force
> > search following every path looking for the right SHA.
> >
>
> Ah, there we go. A use-case at last :)
>
> So now we have a concrete problem that we can formulate thus:
> "How can one create a database listing the relationship between 'signers'
> and blobs?"
>
> So the second question: Do you seriously argue that git should take a
> huge performance loss on its common operations to accommodate a need that
> I suspect very few people have?

Why do you keep jumping to a performance loss? Both schemes will have
an index based on paths. The problem is how those indexes are
constructed, not the existence of the index. Moving the paths into the
blobs in no way prevents you from creating an index on that field.

The problem is that the SHAs have been intertwined with the tree
nodes. This blending has made it impossible to create other indexes on
the blobs.

The path index in the flat scheme will probably look just like tree
nodes do today but these new tree nodes won't be intertwined with the
SHAs.


>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>


-- 
Jon Smirl
jonsmirl@gmail.com
