From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked GIT 0.7
Date: Mon, 3 Oct 2005 14:56:39 +0100
Message-ID: <b0943d9e0510030656l4535bec7u@mail.gmail.com>
References: <1128244627.9740.6.camel@localhost.localdomain>
	 <20051002121059.GA32367@elte.hu>
	 <b0943d9e0510021233n39daa5bao@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 03 15:57:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMQoC-0007nf-1K
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 15:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVJCN4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 09:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVJCN4n
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 09:56:43 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:73 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932233AbVJCN4m convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 09:56:42 -0400
Received: by xproxy.gmail.com with SMTP id t15so196250wxc
        for <git@vger.kernel.org>; Mon, 03 Oct 2005 06:56:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ssjYIuf4jmOSDObS0quaymYjH8cYP4fUxRd4CBpxUI5Jqn60JG9f6/NSMVGNmm/lg247//vLWAgyLkslQf8Y9c9Xq/v0wEQcvmuQWrxU968dwIDw8zssnU8ID5x82IBpGdsKqmns4aPX61KV2H8umE1AIOLkBG5UD1ilw2IhSkY=
Received: by 10.70.109.11 with SMTP id h11mr1629046wxc;
        Mon, 03 Oct 2005 06:56:39 -0700 (PDT)
Received: by 10.70.31.3 with HTTP; Mon, 3 Oct 2005 06:56:39 -0700 (PDT)
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <b0943d9e0510021233n39daa5bao@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9634>

On 02/10/05, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> An optimisation would be to keep the patches in diff format and apply
> them but this would mean losing the advantages of the three-way
> merging.

After some tests, it looks like 'git-diff-tree -p ... | git-apply
--index' is about 3 times faster than 'git-read-tree -m' (in the best
case for git-read-tree with minor modifications of the base). It now
takes ~0.5s to push a single patch (compared to ~1.5s).

Since most of the patches, for routine updates of the base, don't
generate conflicts, git-apply should work fine. I'll modify StGIT to
use this method by default and fall back to the three-way merge in
case it fails. This will also solve the problem with complex
modifications of the base of the stack (i.e. file removals/additions)
when there won't be any need to call the external index merger if
git-apply succeeds.

--
Catalin
