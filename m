From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Sat, 14 Nov 2009 15:46:20 -0800
Message-ID: <1258242380.9650.90.camel@swboyd-laptop>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
	 <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
	 <20091111220832.GA31620@progeny.tock> <4AFCFF50.5080401@gmail.com>
	 <20091113070652.GA3907@progeny.tock> <4AFD06CD.7090003@gmail.com>
	 <20091113085028.GA4804@progeny.tock> <20091113090343.GA5355@progeny.tock>
	 <4AFDC4F3.1050607@gmail.com>  <20091114110141.GB1829@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 00:46:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9SK6-00034A-Bo
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 00:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZKNXqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 18:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbZKNXqR
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 18:46:17 -0500
Received: from mail-px0-f180.google.com ([209.85.216.180]:36210 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbZKNXqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 18:46:17 -0500
Received: by pxi10 with SMTP id 10so399651pxi.33
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 15:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=BgTOVBFdv3RE7NugUq7fTjftpqvs7dZWUYR+b8xF5hk=;
        b=NZ5HWz52UTDwvhTJnLZa0U2uSohkdOnvx+nN70AuniVbpM7l6ye1MIF8KV38ftuMDS
         ZOa7mZ6dleAA2OXz/NeZthZxOa56nXVCjtM5HwvLjw5obB0eCa7pnkcRGjJ8AVCfhjQA
         fKAlF22uKUfxvj8OIk5l0QUHc+dRh9lm8aGkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ebnlL0NlMPTpSrm+c6jl1RF9D+T1ToXuNBSwSnpppNU+rqK20eAa1zfMsjpWLrWPsq
         ZMpEC5hpqfnjXSOcf/x08Y8znnMM5yZplnOva5+4v7guMG8fN7pGJhfzP3LRjnvIPbJr
         KPOsEHD8911dY9EbXbrV+Vmzs1Izd9/MIYT2Y=
Received: by 10.114.49.6 with SMTP id w6mr3170286waw.148.1258242383175;
        Sat, 14 Nov 2009 15:46:23 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm511398pxi.12.2009.11.14.15.46.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 15:46:22 -0800 (PST)
In-Reply-To: <20091114110141.GB1829@progeny.tock>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132898>

On Sat, 2009-11-14 at 05:01 -0600, Jonathan Nieder wrote:
> Stephen Boyd wrote:
> 
> > I see a small problem, but it can be fixed in another patch. git
> > merge -s <TAB><TAB> the first time when you're not in a git
> > directory will make git merge -s <TAB><TAB> after never complete
> > correctly even in a git directory.
> 
> Not good.  I think the sanest thing to do is avoid caching the merge
> strategy list entirely.  Listing merge strategies takes about 100 ms
> here, which is short enough not to be annoying.
> 

I was thinking of adding an option to git merge (like --strategies) to
list the strategies without requiring you to be in a git directory. It
doesn't look that easy at first glance so it might not be worth the
trouble.
