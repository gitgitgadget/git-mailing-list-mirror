From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [bug] Working files created in bare repository when pushing to a rewound bare repository
Date: Mon, 31 Dec 2007 15:02:25 +0800
Message-ID: <46dff0320712302302p4c125ee1n2abc1561ba10c47e@mail.gmail.com>
References: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com>
	 <20071231064741.GA4250@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 31 08:02:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9Efm-0007qa-Hy
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 08:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbXLaHC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 02:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbXLaHC0
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 02:02:26 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:4253 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbXLaHC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 02:02:26 -0500
Received: by py-out-1112.google.com with SMTP id u52so8881106pyb.10
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 23:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gjJcFSPdx4UKn3nOkLyDFdsTBuhbhVQ9ITiMjWCzE3U=;
        b=doG4BBQUIO+g6XYYQBXGOhT6LSRehbQbXYo3JiVwSZMENxsCb6ybtBQ+HIMPUGaS1lxaBnGutDqDXqV2GPc8Hg6Q6kTDsop/RbAFvMFzmRVGo29yL3UHj3NbgvljV8CxRLrSr/OOb17A+jTupWkfAebiKUJTbAjHcBswrZIsrjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OwnVSvR0lN5vZxvjX446c6899q/CIWcfkf9aGoa7tIlq4CgEus/o626jpC5I+h5FsF0Z4WwabaC/xtWIis6Z37N1yS0FB+8E48dTBkNMJcar2VEW6OUCMNPdgb5ITWli8jpC2o6kyEv6OlxfxP/XCeXWKBA4LBrm4PP3A4rVKrw=
Received: by 10.35.30.8 with SMTP id h8mr14695940pyj.55.1199084545294;
        Sun, 30 Dec 2007 23:02:25 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 30 Dec 2007 23:02:25 -0800 (PST)
In-Reply-To: <20071231064741.GA4250@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69389>

On Dec 31, 2007 2:47 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 31, 2007 at 02:42:42PM +0800, Ping Yin wrote:
>
> > Following scripts can reproduce the problem: in the final line,
> > foo.txt is generated in bare foo.git
>
> No, your script is wrong.
>
> > # create bare foo.git and its clone foo
> > mkdir foo
> > cd foo && echo foo>foo.txt &&
> > git init && git add . && git commit -m 'create project foo' && cd ..
> > cd foo && echo foo1>foo.txt && git commit -a -m "update foo.txt" && cd ..
> > git clone --bare foo foo.git && rm -rf foo
> > git clone foo.git foo
> >
> > # reset bare and then push
> > cd foo.git && git reset --hard HEAD^ && cd ..
>
> Try looking in foo.git after this step. The "--hard" to git-reset is
> creating the file foo.txt. --hard makes no sense in a bare repository (I
> thought we were disallowing it, but apparently not).
>

Sorry for my inattention. However, i remembered the reason i added
'--hard' is to avoid  the warn 'foo.txt: needs update'  when 'git
reset HEAD^'. Now i know  '--soft' will do the right thing.

So how about use '--soft' as default in the bare repository?



-- 
Ping Yin
