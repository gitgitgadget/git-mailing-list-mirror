From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 16:08:36 +0300
Message-ID: <20100222130836.GG10191@dpotapov.dyndns.org>
References: <1266599485.29753.54.camel@ganieda>
 <1266687636-sup-7641@ben-laptop>
 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
 <20100221063433.GA2840@coredump.intra.peff.net>
 <1266754646.12035.23.camel@ganieda>
 <20100222051748.GB10191@dpotapov.dyndns.org>
 <1266832607.31769.37.camel@ganieda>
 <20100222112845.GE10191@dpotapov.dyndns.org>
 <1266839972.4575.38.camel@ganieda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:34:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjY1o-0006ev-TU
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 14:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab0BVNIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 08:08:43 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:56642 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260Ab0BVNIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 08:08:42 -0500
Received: by fxm19 with SMTP id 19so2458028fxm.21
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 05:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=smscbE7Y/WpdJjWZB5etwzXbVaCDtNupl+3Kxqf6JbM=;
        b=GiGlNatZzq5SiZ+91uIu7fV9eDo//fYUMiK36odCDHGAGmUJxQJGVsUzwICr5gjNIl
         XvXz0jsU/sHX6S9OsZ4R7INlvqFN/CYeJ+Eu9XX1MIrrM5AUab6SoOYPJ6vptf7o43Vl
         yUCxmqL4SRg87TQuVctnnNK0ue4WpEjeGsI/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Wcn/8jMFc+n3RkO9idXq0fWEOvGia6IX432vpzGq9doehkvKpNEf3qDox5vBX9Ibfu
         eEz3hSID4l1mb+jsnWb5TVYRf1JGR4R1spDVeJObN3GfV1HW8XD5BV16+03gNvXAwsT6
         e2qCyobsHSeH6UmOMguVBbsTW/xffmBDfezx8=
Received: by 10.223.5.212 with SMTP id 20mr1224893faw.19.1266844120673;
        Mon, 22 Feb 2010 05:08:40 -0800 (PST)
Received: from localhost (ppp91-77-227-64.pppoe.mtu-net.ru [91.77.227.64])
        by mx.google.com with ESMTPS id 13sm1464744fxm.14.2010.02.22.05.08.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 05:08:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266839972.4575.38.camel@ganieda>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140679>

On Mon, Feb 22, 2010 at 12:59:32PM +0100, Jelmer Vernooij wrote:
> 
> We'd like to have the extra metadata in Git so that we can push Bazaar
> commits into a Git repository losslessly. If we can't do this losslessly
> then the identity of the commit changes just like it does in git if you
> aren't able to produce the same tree, blob and commit objects.

but the problem is that you may want to add some information when you
import some Git to Bazaar. For instance, Git does not record file
renames explicitly and relies on content of files to detect renames
automatically. So, when I use gitk, I can see that what file is renamed.
If you work in Bazaar, you probably also want to see renames, but this
requires that you add this information when you import commits to
Bazaaar. But if you do that, the export to Git will produce a different
commit just because you added this Bazaar-specific data.

> 
> > > Having a bzr/master ref means that the extra metadata will not always be
> > > copied around (unless git is patched), so if I push my work from Bazaar
> > > into Git, somebody works on it in Git and pushes a derived branch and
> > > then somebody else clones that derived Git branch into Bazaar again, I
> > > will not be able to communicate with that person's branch.
> > No matter how many times a branch was cloned, it is exactly same branch
> > (i.e. it consists of commits having exactly the same id). So, if you can
> > work with the original branch, you can work with any cloned branch. So,
> > I see no need to copy this data around for people who do not work with
> > Bazaar directly.
> The original branch is a Bazaar branch here, so that's not true. You can
> only work with any cloned branch if the matching bzr/ branch is also
> around. If it isn't then you won't be able to find the original commit. 

Obviously bzr/ branch should be around somewhere, but it does not have
to be in any cloned repo. It is sufficient to have it in one place,
because it refers to commit-id, which does not change when you clone it.

> 
> hg-git already does something similar by putting a --HG-- line followed
> by hg-git specific metadata in the commit message when it pushes into
> Git. I'd like to find a place to put this data that's not as intruisive
> for users.

I still think it is wrong to hide some information in the commit object.
I am not sure that the commit object is the right place to store that
metadata, but hidding this information is even more problematic. Let's
suppose that someone cherry-pick your Bazaar originated commit. Now when
you try to synchronize with Bazaar, your synchronizer will see that it
has some Bazaar revision ID and branch name, but, in fact, it is new
commit on a completely different branch...


Dmitry
