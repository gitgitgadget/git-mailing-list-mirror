From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 6/7] git-submodule: multi-level module definition
Date: Fri, 14 Mar 2008 22:20:38 +0800
Message-ID: <46dff0320803140720h619107c6v83ef1a3d13866fb9@mail.gmail.com>
References: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
	 <1205431001-18590-2-git-send-email-pkufranky@gmail.com>
	 <1205431001-18590-3-git-send-email-pkufranky@gmail.com>
	 <1205431001-18590-4-git-send-email-pkufranky@gmail.com>
	 <1205431001-18590-5-git-send-email-pkufranky@gmail.com>
	 <1205431001-18590-6-git-send-email-pkufranky@gmail.com>
	 <1205431001-18590-7-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, "Ping Yin" <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 15:21:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaAmf-0001yL-7I
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 15:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbYCNOUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 10:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbYCNOUl
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 10:20:41 -0400
Received: from rn-out-0910.google.com ([64.233.170.186]:6963 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYCNOUk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 10:20:40 -0400
Received: by rn-out-0910.google.com with SMTP id v46so2718304rnb.15
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lDVAe1w8kwXvKXLIhSxVxgKEaxWD5NyNNpo01dfKFvM=;
        b=CZiTx9AQ7Qp3+u0mGgtZAso5HS9oqSHTeuF8SvfFZb8lVMBlBcjRambzi7w/ryb0nhSnNFCViFzH13IbR1WZo5vty6CKLJ5l+XqAyU5giIpY9meXpvn5zY6Gm1sxcjDHMq2MrFzIYtQbYUeb5V0BPBhM198i5OxBY+MD7X8J5nY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LyjbqJD8RjrzbLA7EQF3J7IKfU3SW/BWi1RGSyn3jod9A/PZbU3dP2W8HxfSn5G91Z2Wxyi+K3mjVtXa++iv1nAHi6RnnfJtdLXtsF/hBSJYozIM4bfqFbxgCBjJjRdp5sb/qVyZMagMk+y/3JwDIRoWqh8QLQLfDMEpZMBDoDY=
Received: by 10.151.143.3 with SMTP id v3mr6329872ybn.176.1205504438576;
        Fri, 14 Mar 2008 07:20:38 -0700 (PDT)
Received: by 10.151.14.4 with HTTP; Fri, 14 Mar 2008 07:20:38 -0700 (PDT)
In-Reply-To: <1205431001-18590-7-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77228>

On Fri, Mar 14, 2008 at 1:56 AM, Ping Yin <pkufranky@gmail.com> wrote:

>  In the no "--module-name" form, the path parameter may be not the real
>  submodule path, and it just acts as the filter for real submodule paths.
>  While in the "--module-name" form, the name parameter must be the logical
>  name, and the real paths corresponding to the logical name may be neither
>  a submodule path nor even existent.
>
>  This patch handles such a path for different subcommands as follows.
>
>   - status: Output 0{40} as the sha1. Doing this can remind the user to
>    add the path as submodule or delete the path from .gitmodules.
>   - update: Skip that path and issue a "Not a submodule" warning

Sometime it's useful to also update (or clone) the non-submodule
instead of "Not as submodule" warning. So we can add a --force option
to allow this kind of behaviour.

There are cases that we want to clone a group of repositories in batch.

One way is to put all urls and paths of these repositories in
.gitmodules which form a submodule group, for example "all", and then
run "git submodule --module-name update --force all" which will clone
all the repositories in batch even if they are not submodules yet.

Another way is use the "git submodule --module-name recurse clone"
(recurse patch series sent many days ago but not accept yet). But this
needs some discuss since we have no place for the module group name
"all" as the argument.

There may be other ways. i don't know which way is better and don't
care much now. What i care is whether the submodule subcommand should
operate on the non-submodule path.

More precisely, with --module-name, we can designate a group of names
by a logical group name. However, some paths corresponding to these
names may not be submodules yet. So should the submodule subcommands
(especially update for now) operate on these paths?

-- 
Ping Yin
