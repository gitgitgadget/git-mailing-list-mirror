From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 12:22:32 -0400
Message-ID: <32541b130807240922r733dce6aw8b123bbb28c9002@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <alpine.DEB.1.00.0807231713280.8986@racer>
	 <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>
	 <alpine.DEB.1.00.0807231753240.8986@racer>
	 <fcaeb9bf0807240127p5226822atcd4a0711f1bc9c5c@mail.gmail.com>
	 <alpine.DEB.1.00.0807241340490.8986@racer>
	 <fcaeb9bf0807240629v6958014bpfa9aebde281ff57@mail.gmail.com>
	 <alpine.DEB.1.00.0807241443230.8986@racer>
	 <fcaeb9bf0807240650v6eab6ad4n63c39973b3b43658@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM3bf-0002P2-GM
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbYGXQW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 12:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbYGXQWz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:22:55 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:7954 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYGXQWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:22:55 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1250396ywe.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mBJIRn5Svq23NhKC4YqoLntGSzH3KuaXCsSfT84HhT8=;
        b=V61sYFvOQujkS+5cDOkqUYL8KX932Ita6gEE3O0npysSu5O27jnRot64RvmzJwcdmw
         Z4Wh2Icjn71cjTiyLqQadcJcgcJnyuIHUPz1bnlDQidXsIJd41htJrpBk5hNB3XpqVcB
         RKDIrskbeo9xnIapvb1FzFb/OUF5YrVXQUftE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HwrhZFel4tVYmJOTvLFIQ6XD+i+ZtFt05VcJ8VBJTacMgxnp5wRJVZ5erU7GK5Vfdd
         cA1ZH2wVE5xmK+njzF3om1vtRO/dGoWBXzldLDerDEZ+xJZY0Hl+BsJuaYsl3vDXc+tx
         QVaKeLxjBsRDgy2IuRF62d8a4y3w4jLdeZMhg=
Received: by 10.114.178.1 with SMTP id a1mr673990waf.20.1216916552244;
        Thu, 24 Jul 2008 09:22:32 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 24 Jul 2008 09:22:32 -0700 (PDT)
In-Reply-To: <fcaeb9bf0807240650v6eab6ad4n63c39973b3b43658@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89900>

On 7/24/08, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> OK. I am lost here. I do not know how putting sparse prefix and index
>  together could fix "it" (I think you meant the index guarding).

I think what Dscho is saying is simply that it's natural to put
information about the currently-checked-out tree in the index, and
unnatural to put it in the config.

If I switch branches, or checkout different versions, or git add, or
git rm, it all affects the index, never the config.  The index stores
the attributes of which files are checked out, and can detect whether
those files are different from before.  Choosing which subtrees to
check out sounds a lot more like one of those operations than it does
like a configuration change.

Also, I don't know if git supports this right now, but I can imagine
situations where you'd want to have more than one index (and
associated working trees) sharing the exact same .git folder.  It
would be fine to share the config between these parallel checkouts,
but you certainly couldn't share the index.  And you probably wouldn't
want to check out exactly the same set of subtrees in every working
tree.

The information required to do a checkout is in the index.  And
"sparse checkout" is all about checking out :)

Have fun,

Avery
