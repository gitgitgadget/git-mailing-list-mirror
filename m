From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Tue, 8 Jul 2008 18:12:14 +0200
Message-ID: <200807081812.15651.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <200807080939.31216.jnareb@gmail.com> <20080708144239.GJ6726@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 18:13:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGFp3-0003Zo-RW
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 18:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbYGHQMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 12:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbYGHQMc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 12:12:32 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:29084 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYGHQMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 12:12:31 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1199134ywe.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vlS5LkqHyEgjwjzSifsUimy4D6jInmvSevYY9xX+jRE=;
        b=Ztsd/zP+1a2qbled9ngzctx4m9R1p0sJ9v2J6OVhULA1RXKLXTPGdED0deM5TBhuwe
         VLNGP3zQ1hwm3Sy+i+FvcRBlh4HOwNEGFGcsL6seCovZ4/hKBabOK9Dux9Zm8heUl18C
         tsKO4OpDRZ3fwEymJdShwSdWqpTqgpj7dhx/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gUh5vM2NNIi8JR9eXB87dUHfjFJ50zfLXSan8T2xgbzYMB8JXooXqIvzRvHgWyVc6P
         J/ZBGmsTrWVuPftn4e0SIPpNmExdS1K6qBXrpnz9/Fdo5Cn15HcjsBhYmjwzuSB70tFI
         g7H/irkQWMl47IlHmp0zjXLWBQDtgXMDf+pK8=
Received: by 10.125.125.6 with SMTP id c6mr1413898mkn.108.1215533541297;
        Tue, 08 Jul 2008 09:12:21 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.205.145])
        by mx.google.com with ESMTPS id 23sm3776812hud.52.2008.07.08.09.12.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 09:12:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080708144239.GJ6726@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87768>

Stephan Beyer wrote:
> Jakub Narebski wrote:

>>> Yes, you are right that am --rebasing is a no-op.
>>> That option was a little mystery to me, because it seemed to do nothing
>>> special, but I'll check again (bash-completion etc) and do appropriate
>>> changes.
>> 
>> Undocumented option '--rebasing' to git-am is internal option changing
>> git-am behavior to be better used by git-rebase, namely it does not
>> change commit message even if it doesn't follow git commit message
>> convention,
> 
> Ah yes, I've seen it now.
>
> It is taking the commit message from the commit in the "From <commit> .*"
> line, does *not* change it in any way and then applies the changes using
> threeway merge.

Not exactly.  "git am --rebasing" still tries to first just *apply*
the patch, then (I think) it falls back on blob-id based 3way merge.
 
> Keeping that in mind what about dealing with --rebasing like that:
> if --rebasing is given, git am simply generates
> 	pick <commit>
> lines, instead of
> 	patch -3 -k <msg>
> as it is now (and this is not enough, as it seems).

It is not.

Nevertheless it would be I think better for ordinary patch based rebase
to fall back not on git-am 3way merge, but on cherry-pick based merge
(i.e. on pick).

> The alternative for doing "pick" is teaching git-sequencer's "patch"
> insn an option that emulates the --rebasing behavior.
> 
> For me this feels somehow unclean. But perhaps there are good reasons.

Why unclean?

But I agree that it would be nice to simplify '--rebasing' logic, for
example using patch or 2way merge to generate tree, and commit message
taken directly from commit, not via 'format-patch | am' pipeline.
 
> Of course, somehow I think that rebase and rebase-i should be merged,
> calling sequencer directly, with the main difference that -i will
> invoke an editor to allow editing of the TODO file.
> But nobody is hurt, if I put such a change far far away.

rebase-m and rebase-i can be merged; ordinary rebase uses other
mechanism: git-am pipeline, and not cherry-picking.

-- 
Jakub Narebski
Poland
