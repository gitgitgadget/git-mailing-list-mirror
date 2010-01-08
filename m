From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Two versions of a project in one GIT repository
Date: Fri, 8 Jan 2010 06:57:29 +0300
Message-ID: <20100108035729.GB28263@dpotapov.dyndns.org>
References: <1262912794001-4269785.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper <kacper.gazda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 04:58:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT5zu-0000nq-FB
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 04:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab0AHD6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 22:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076Ab0AHD6p
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 22:58:45 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:41516 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab0AHD6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 22:58:45 -0500
Received: by fxm25 with SMTP id 25so12319632fxm.21
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 19:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mXLsgi/MDyYXahZLN9uq50gQkEGq8NelshF8Z4kJ4S4=;
        b=WXQJet6ULOxqA7qGv5hmVzSb+nWY7EPgNVVWed3xlwK703RCZkXoc5vZaM39Pj49YX
         q8lClBtavYr+VlsSBlJuLD+MII4E+HWOJD95NfQAjhzd5a1aE9A8vqx63SFa7fqOZOKM
         yS4812yPmeywH3ixmsq7kD/08frCZHCQy730k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O/+bFbUH8MFza7Jr6iDd52C1OxGfxR9tfQL+QKKmTEyc4B+ffEq7RSdl7SzyQFum35
         uISQmGiZGX68QTO87qQIJjZhbN49Ego6Rx1Q9bV7pyNBbzlt9hFKLxPcRVOhg6x/j5pS
         ZTQz1RdwmtpvuR/U5O3V3ZgWjEf4G8EJW1Yj4=
Received: by 10.87.74.14 with SMTP id b14mr2004965fgl.65.1262923122477;
        Thu, 07 Jan 2010 19:58:42 -0800 (PST)
Received: from localhost (ppp85-141-235-181.pppoe.mtu-net.ru [85.141.235.181])
        by mx.google.com with ESMTPS id d4sm47763138fga.6.2010.01.07.19.58.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 19:58:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1262912794001-4269785.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136414>

On Thu, Jan 07, 2010 at 05:06:34PM -0800, Kacper wrote:
>
> I have two versions of one project in one local git repository. I have to
> commit this repository into 2 remote repositories, one for each version;
>
> LOCAL GIT(V1/V2) -> REMOTE GIT(V1), REMOTE GIT(V2)
>
> I have some files in the LOCAL GIT repository which should only go to REMOTE
> GIT(V1) and other should only go to REMOTE GIT(V2). Now I commit full local
> repository to both remotes. Can I only commit some files to REMOTE1?

You do not commit to any remote. You _always_ commit to the local repository.
Then using 'git push', you propagate your changes, and you can propagate any
commit to any remote repository of your choice, but you can only to push the
_whole_ commit, which implies the whole tree and all parents commits as well.

> I need to have both version of the project in one repository, but would like
> to have an options to divide history a bit.

You can add as many remote repository as you like using 'git remote add'.

> I do not think that any
> branching can help as then I would have to make the same changes to both
> branches mostly. Most of the code, 90% of the code is the same for VER 1 and
> VER 2. New code is usually the same for both versions.

You can commit only to one branch and then merge your changes to another. In
general case, you may want to have a special branch to commit common changes
and then to merge it to V1 and V2. Though, I guess it is a bit inconvinient.

However, if the difference between V1 and V2 is not large, and you do mind
having V1 history visible as part of V2 history then you may have just two
branches. You create V2 based on V1, by adding V2 specific files and removing
V1 specific files. After that you made all your work on V1 and periodically
merge V1 to V2. Changes made to V1 specific files will cause conflict during
merge to V2, but you can easily resolve by doing 'git rm' on V1 specific
files.

To better understand Git model, I suggest you read "Git for Computer
Scientists" http://eagain.net/articles/git-for-computer-scientists/


Dmitry
