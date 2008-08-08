From: "Giovanni Funchal" <gafunchal@gmail.com>
Subject: Re: Can't get git clone over https with proxy and invalid certificate...
Date: Fri, 8 Aug 2008 17:13:30 +0200
Message-ID: <c475e2e60808080813o4498fc1eu1a08ae05218cec83@mail.gmail.com>
References: <c475e2e60808080448x40683db1wadcd834e94d7d263@mail.gmail.com>
	 <20080808142819.GJ28749@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Matthieu Moy" <Matthieu.Moy@imag.fr>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 17:14:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRTfo-0002W7-0n
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 17:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbYHHPNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 11:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbYHHPNd
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 11:13:33 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:2023 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbYHHPNc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 11:13:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so738338fkq.5
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kHmxbfXFcaVcLFvVN70pu8RtRUVw6TPOmJhxwB3QrAM=;
        b=qvsxKmNs7eDO5O2jIk0bRAnCePBeyFt647Y2tkwQz5uJQhk0Gy+juf3k/6BVWxSaiT
         dTZi/IxE/QmRoLnpMUmrTI2pB79ZIY4AV6aijliv2Mu5pcEXf0+ACvbfn5WG+sTgq0EL
         Mrp3PApFSCNz65wqSz5PMtwj/R1m+znp0V//8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=etKW1VIDuSCXLw2TZowlFlV09sSU1oFuMF0Gp4/UunL3UBd2QoZbKz70qdiTFtVeuF
         h/ECzkZbvm+nKeN0jv6ouAWoVTHOHewJtENBlvCYEuKRkZ6BQiMNpbM6yvz1z/motuqR
         ggkCysGMgaa4jKeJHY8zvO3CFWGW74ZH1tkRQ=
Received: by 10.187.194.1 with SMTP id w1mr187095fap.41.1218208410309;
        Fri, 08 Aug 2008 08:13:30 -0700 (PDT)
Received: by 10.187.187.17 with HTTP; Fri, 8 Aug 2008 08:13:30 -0700 (PDT)
In-Reply-To: <20080808142819.GJ28749@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91679>

Hello,

Well, turns out that my problem was that my gcc doesn't like the `-R'
switch!! Strangely enough, ./configure does not check this!! (one
should define Makefile's existing option NO_R_TO_GCC_LINKER)

While this seems pretty serious, gcc only shows a tiny message while
compiling ("unrecognized option -R"), not even a warning, and compiles
anyway. So if you "make all install doc install-doc" like me, you
won't see the bug.

I think git build system could be improved somehow to check for that.
I'll perhaps try to make a patch to this during the weekend.

Regards,
-- Giovanni

On Fri, Aug 8, 2008 at 4:28 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Giovanni Funchal <gafunchal@gmail.com> wrote:
>> Ok, so I have created the following ~/.curlrc:
>>    netrc
>>    proxytunnel
>>    insecure
>>    proxy = http://proxyserver.com:8080
>>    proxy-user = proxyuser:proxypassword
> ...
>> $ git clone https://remoteuser@remoteserver.com/.git/
>> Initialized empty Git repository in /home/user/.git/
>> error: Proxy requires authorization!
>> warning: remote HEAD refers to nonexistent ref, unable to checkout.
>
> Last time I used Git with an HTTP proxy that required authentication
> I was doing it with an environment variable:
>
>  http_proxy=http://me:pass@proxyserver.com:8080 git clone ...
>
> Fortunately this was on a Windows desktop where I was the only
> user who was logged into the system, so leaking my password into my
> environment for a short duration was about the same risk as putting
> into a ~/. file.
>
> --
> Shawn.
>
