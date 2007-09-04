From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 13:44:47 -0400
Message-ID: <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
	 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IScSL-0004Vk-8s
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbXIDRot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754993AbXIDRot
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:44:49 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:1934 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964AbXIDRos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 13:44:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1231785rvb
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 10:44:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ewh5VQ+OfM00W4IJ59gu/E2PifuowJv5EUR+C0Zc5qfd59xIpbWfC1jeobAC60h2Vsvl0MM6iCge0YXHKB64GbLAkuOwN/rJJCq2NeFjG3I/2V1oopXoKsP+am919e987sH95Jw/RIpJTtyoijIr9mX0csFTCmiWcU8o11t+ufI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WQjE2Xz9eG4VbMseI83RdL8nZEHxodHrHJTKt6ee0WcnB04r9Kx/LfkT2Hb6HlBr+mB2aCWsfj+0siAq64v9jjij+Sui6/cSe2iRQ/FX/+gPLTZHuTsdE9dfoArm2TxoFkyVrvdNmVcApLnRk+E8VOHIevKPm3G8fTPeM/1COZI=
Received: by 10.141.180.5 with SMTP id h5mr2394047rvp.1188927887805;
        Tue, 04 Sep 2007 10:44:47 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Tue, 4 Sep 2007 10:44:47 -0700 (PDT)
In-Reply-To: <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57626>

On 9/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > Another way of looking at the problem,
> >
> > Let's build a full-text index for git. You put a string into the index
> > and it returns the SHAs of all the file nodes that contain the string.
> > How do I recover the path names of these SHAs?
>
> That question does not make much sense without specifying "which
> commit's path you are talking about".
>
> If you want to encode such "contextual information" in addition
> to "contents", you could do so, but you essentially need to
> record commit + pathname + mode bits + contents as "blob" and
> hash that to come up with a name.

I left the details out of the full-text example to make it more
obvious that we can't recover the path names.

Doing this type of analysis may point out that even more fields are
missing from the blob table such as commit id.

The current data store design is not very flexible. Databases solved
the flexibility problem long ago. I'm just wondering if we should
steal some good ideas out of the database world and apply them to git.
Ten years from now we may have 100GB git databases and really wish we
had more flexible ways of querying them.

The reason databases don't encode the fields into the index is that
you can only have a single index on the table if you do that.
Databases do sometimes duplicate the field in both the index and the
table. Databases also have the property that indexes are just a cache
and can be dropped at any time.

-- 
Jon Smirl
jonsmirl@gmail.com
