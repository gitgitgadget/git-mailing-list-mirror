From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Multiple clients accessing git over NFS
Date: Sun, 14 Nov 2010 18:32:59 -0600
Message-ID: <20101115003259.GC26104@burratino>
References: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
 <rmi39r3mrf6.fsf@fnord.ir.bbn.com>
 <AANLkTim1bUbofDzC5HJnB--0WkT45ewbWCa25RebEgae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Khawaja Shams <kshams@usc.edu>
X-From: git-owner@vger.kernel.org Mon Nov 15 01:33:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHn0u-0006om-1t
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 01:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113Ab0KOAdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 19:33:35 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48766 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab0KOAde (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 19:33:34 -0500
Received: by ywc21 with SMTP id 21so1453328ywc.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 16:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tO+F0JM8r6mi/feLxgZw4i73ilQGpteDTQ4HYdoE6kA=;
        b=oZoe2ncxRQx/LIoYb/J16EO7V/mJ0ft+qSoh0dyhUBkq9h4DFr5btAzIfjTTjqNG8J
         N5VDcu6cFjajI8Jc2grQXngbPrOQo4yvau92qO3D2EwedsEtRR/YsxKZKE8sMeS9LdEE
         EMOUoCONZypBWsytXDjl3fQ908phPXQmO6VfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FlPgkG3nbraJNEk2vuyj/Ie3sx+M7O4IsJUePiFSa1AkADUJypY0WenjoGS5ZySSYv
         Mz9QwHYGoHFvEwcuCRLSBCO9ViWNWGGmCiUuE4/kgajDzgjtCLlrl0Jq7y2ox2lskORg
         gzHUfotIg8hhf8Gf0L0A2uCe+4G7y0e6LIyQw=
Received: by 10.150.199.15 with SMTP id w15mr8271481ybf.326.1289781212979;
        Sun, 14 Nov 2010 16:33:32 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id p1sm2670091ybn.17.2010.11.14.16.33.31
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 16:33:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim1bUbofDzC5HJnB--0WkT45ewbWCa25RebEgae@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161468>

Khawaja Shams wrote:

>    I am still interested in knowing if git can handle multiple
> simultaneous pushes on the same repository without encountering
> corruption issues.

Yes, concurrent attempts to update a branch are serialized.  (But
please don't ask me to answer about NFS semantics.  See

http://stackoverflow.com/questions/750765/concurrency-in-a-git-repo-on-a-network-shared-folder

for some notes.)  See the note about fast-fowards in the git push
manual for how integrity is preserved.

After reading that, you might wonder: if there are many, many clients
pushing to the same branch, how is starvation avoided?  Good question!
It isn't.  If you have so many clients wanting to push to a single
branch, I would suggest having a single person or a few people
maintaining it, pulling from others.  Life will be better for many
reasons, especially quality control.

Hope that helps.
Jonathan
