From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Using git for code deployment on webservers?
Date: Wed, 17 Jun 2009 22:26:13 +0200
Message-ID: <81b0412b0906171326y6821d511u5b93cda4a5c14458@mail.gmail.com>
References: <200906160111.47325.ioe-git@rameria.de>
	 <alpine.LNX.2.00.0906161332080.2147@iabervon.org>
	 <200906171923.08034.ioe-git@rameria.de>
	 <alpine.LNX.2.00.0906171328080.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Ingo Oeser <ioe-git@rameria.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:26:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH1iB-0002Re-Re
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 22:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbZFQU0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 16:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbZFQU0N
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 16:26:13 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:39492 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZFQU0L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 16:26:11 -0400
Received: by fxm8 with SMTP id 8so612862fxm.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 13:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lMTkJOZEdBavJSsmPYx+OWLS7E86TWe/uMccke4ZBtk=;
        b=Zw5LGFS9hWYl5f4+gArA/MlDSPFtLrV6JtqsxwD/uroIfkszaEO0O1ZHIVpXIJAdpn
         2gIi3FVaz3ZVjPQ6KgIQIPK3+yjjdWuFT/3iQqo3d9e80rkArfd7RKhS4c6Iob9SoPze
         8LZDD1G78YYVhPeHIZLN1S0ku1mpDWmgDk2u4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BCJt6fggN0hIj507slPbUKMSwrtpeRD3akgKyAb9CV8IiVAG5Ck+x8qQhGq1FBsVJ8
         zhnWCw+4VfobxNqlGmf04veKPY/ITQSMRrh6GY+OxoFtXN3LgX2+CgKG9F1XDDfR7PQ5
         kQBsk+c4eeio0rgW/qS/UGta/o+4Du9L+I2mo=
Received: by 10.204.60.148 with SMTP id p20mr484707bkh.160.1245270373259; Wed, 
	17 Jun 2009 13:26:13 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0906171328080.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121770>

2009/6/17 Daniel Barkalow <barkalow@iabervon.org>:
> On Wed, 17 Jun 2009, Ingo Oeser wrote:
>> > Of course, the other possibility is to check out versions on the slaves,
>> > and rsync that to the webservers, which is probably the optimal method if
>> > you're not in a situation where you benefit from anything git does in
>> > transit.
>>
>> I would benefit from noticing local changes. But simple rsync is what is tried now.
>> Problem is, we get no de-duplication from rsync, which git could do.
>
> In that case, fetching trees is probably the right thing; that should give
> you a point-to-point de-duplication without any history (although you may
> also turn up git bugs, since this isn't how git is normally used).

Or, you can just keep a namespace for each server in the intermediate
repositories, which records the version the server has and the version
it should have. Then you can use git diff-tree to find you which files
have to be transferred. You wont be able to record changes on the servers,
though.
