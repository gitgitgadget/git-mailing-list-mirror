From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 11:03:43 -0700
Organization: Twitter
Message-ID: <1430417023.22711.8.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
		<xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
		<1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
		<1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
		<20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
		<20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>
		<20150430033725.GB12361@peff.net>
	 <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
	 <5541E3D4.7040207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:04:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynsoe-00041a-9q
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 20:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbbD3SD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 14:03:58 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36267 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbD3SDz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 14:03:55 -0400
Received: by pdea3 with SMTP id a3so67817517pde.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 11:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=rUZ+yJcIEI+LMbGHKSAuIqnX/NVWcFAGdkzRjckNm4w=;
        b=Td6ZSw6BdzuJ+G+PtqyUjkA2lnhdKRx9Mb+KFa4cRYSZLLJh9soohsqbymNgRJuJxf
         /1tlgKZ1zes9A198GgGycfgtAID23u0/cGOzxvydpQDx1vt1CthPNZPl+DKJO7srPKRt
         y+ZiNzsnEDtmY7jI7kpJV8HaUy/TuDL/ueqjYNiVQte1ybq1k3QIxXZyNI0A8xw6cqfB
         YcNFBTEiPUjmTOgx+rbJxTJUUCBAy5Bujn9JUr4TH5IvUX/oXI0rId12A5dFX9SJar/Y
         B0Z5dzh8AsKxdLomh9I4vuOBF0FpZ7hFSa6ASLiguGAjA3htz6orVt2ucZasPMtr+2k6
         kMiQ==
X-Gm-Message-State: ALoCoQmdiDQbE1lQ/r1cbrsA3OgUo+0vlC1uu0SqazpLyz65tLyEkQKBApH/JqpVCW+8PXJG7Meb
X-Received: by 10.70.103.200 with SMTP id fy8mr10467254pdb.136.1430417035105;
        Thu, 30 Apr 2015 11:03:55 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id uf7sm2790837pab.37.2015.04.30.11.03.44
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 11:03:53 -0700 (PDT)
In-Reply-To: <5541E3D4.7040207@alum.mit.edu>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268084>

On Thu, 2015-04-30 at 10:12 +0200, Michael Haggerty wrote:
> On 04/30/2015 07:34 AM, Junio C Hamano wrote:
> > [...]
> > But stepping back a bit.
> > 
> > We have been talking about HEAD^{resolve}:fleem but how did we learn
> > that there is a path "fleem" in the tree of HEAD in the first place?
> > I would presume that the answer eventually boils down to "somebody
> > fed HEAD to 'ls-tree -r'", and then that somebody is an idiot if it
> > did not grab the mode bits to learn what kind of blob fleem is, or
> > if it did not tell the guy that wants to drive "cat-file --batch".
> 
> I think a plausible use case for this feature is to read
> `$tag^{resolve}:RelNotes`, in which case the reason we know it's there
> is "because the maintainer told us it is there".

Yes, that is approximately my use case.  Read on for details:
With a colleague, I'm building a mode for the free and open source Pants
build system that will support build-aware sparse checkouts.  Pants is a
build tool for monorepos (inspired by Google's Blaze and similar to
Facebook's Buck).  Most individual users will only be using a tiny
subset of the full repository, so it would be convenient if they only
had to check out what the plan to use.  Assume that they want to check
out only a certain target (a path, approximately) plus its transitive
dependencies, on a certain revision.  So pants first checks that
directory (at that rev) for a BUILD file.  That BUILD file might point
to other BUILD files as dependencies, so again, we must examine those,
recursively.  

In no case did we do a ls-files command, since we want to examine as
little of the repo as possible.  And even if we had done an ls-files, we
would still need to resolve all of the symlinks ourselves.

So that's the motivation here.
