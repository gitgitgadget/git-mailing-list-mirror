From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git merge FETCH_HEAD produced bad commit message
Date: Fri, 26 Jan 2007 10:02:17 +0100
Message-ID: <81b0412b0701260102j7d1c44d5nd5aa489cb8312722@mail.gmail.com>
References: <20070125145229.GE25265@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:02:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAMyV-0005Vj-G1
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030840AbXAZJCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030838AbXAZJCU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:02:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:39434 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030841AbXAZJCT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:02:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so663244uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 01:02:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eR9aJ4hoWDNMWTVMgahIVu11AJtR7XCuzqFbh4Q/L0wQq6ypkZ30/Rxw3hHMGVFxdN1Qgwt5EJKBgRKcPKV/AygO0aT7fkFs7nvf5QU0P4eQ1dkaeTDwieGlg5pxYs42d7JDKbb02v+4x2ZJWx/Zc26DwcBIdTt4ebmObClK53c=
Received: by 10.78.204.7 with SMTP id b7mr2130803hug.1169802137701;
        Fri, 26 Jan 2007 01:02:17 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Fri, 26 Jan 2007 01:02:17 -0800 (PST)
In-Reply-To: <20070125145229.GE25265@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37818>

On 1/25/07, Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> Hi!
> I like to do
>         $git fetch <URL>
>
>         $git log FETCH_HEAD
>
>         $git merge FETCH_HEAD
>
> I would expect this to be equivalent to
>
>         git pull <URL>
>
> However, the message that git merge produces in this case
> is less than informative:
>
> commit 3c11f564846227d80aa76b579c974913c3602862
> Merge: 9871244... f5e6d63...
> Author: Michael S. Tsirkin <mst@mellanox.co.il>
> Date:   Thu Jan 25 16:46:51 2007 +0200
>
>     Merge commit 'FETCH_HEAD' into ofed_1_2
>
> I note that FETCH_HEAD actually has the information on where
> the commit came from:
> $cat .git/FETCH_HEAD
> f5e6d63839970f4785c36b6be3835f037e74195c ssh://<hidden>/usr/src/ofed_1_2
>
> So can not git merge be enhanced to put this data in commit log?
>

Does it need to?
Is the below enough (could be line-wrapped):

git merge --no-commit FETCH_HEAD && \
git commit -M "Merge $(cut -d ' ' -f 2- < $(git rev-parse
--git-dir)/FETCH_HEAD) \
into $(git name-rev HEAD | cut -d ' ' -f 2-)"

In the long run you'll almost certainly find this commit message
useless, though.
