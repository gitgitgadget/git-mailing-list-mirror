From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/19] transport-helper: change import semantics
Date: Wed, 8 Jun 2011 15:47:54 -0500
Message-ID: <20110608204754.GK27715@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-17-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:48:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUPfa-0005Xc-9l
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 22:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab1FHUsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 16:48:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45984 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025Ab1FHUr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 16:47:59 -0400
Received: by iyb14 with SMTP id 14so752059iyb.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VNBX49M41PZoCJ6bOg06s2B6yxqGpQIjcsw0QduSQJw=;
        b=cTvrKJWA5LFE5ELAeVeD0qYeuwxso9I+BYd+CTXJ5rbeVj8LDbxpPRIiQvoZ1YKKDv
         qhxZaCkYvXVx0SDa4yNPtCgCQYVqcQ+AO8UqEFbRvZfuut/T7IyufdEmJIqjU38m6P7V
         ic7lZH8puttk8g8ScV0XrsCOsJDA+ElTTvAuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SbRCQtIknXzFf5cPAEMQYJtF83Q00QWNk52dWRxnRCRIv+KFrFD7z81n+S1qrgFvR5
         fMCs6ZoxRO4feM89tQsiFsWJIP/ZawX1rVcPS4LcMRxjeop9LtmwcSAWQz06NtRCh3cD
         h1OwEWCHN5E2F2coKKLVGX60of4HX3ZF1oapY=
Received: by 10.43.61.196 with SMTP id wx4mr943444icb.310.1307566078861;
        Wed, 08 Jun 2011 13:47:58 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.sbcglobal.net [69.209.61.87])
        by mx.google.com with ESMTPS id a9sm722409icy.18.2011.06.08.13.47.57
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 13:47:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307558930-16074-17-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175456>

Sverre Rabbelier wrote:

> Currently the helper must somehow guess how many import statements to
> read before it starts outputting its fast-export stream.

I'm guessing one way is to read until EOF.

> This is
> because the remote helper infrastructure runs fast-import only once,
> so the helper is forced to output one stream for all import commands
> it will receive. The only reason this worked in the past was because
> only one ref was imported at a time.
>
> Change the semantics of the import statement such that it matches
> that of the list statement. That is, 'import\n' is followed by a list
> of refs that should be exported, followed by '\n'.

Seems like a good idea to me.  Documentation/git-remote-helpers.txt
could use a corresponding update ---

Wait, now that I look there, wouldn't it be more consistent with
what "push" does to make the semantics

	... A batch sequence of
	one or more import commands is terminated with a blank line.

?  In other words, what was the rationale for making push work like

	push +src1:dst1
	push +src2:dst2
	push +src3:dst3

	[... command stream continues here ...]

instead of

	push
	+src1:dst1
	+src2:dst2
	+src3:dst3

	[... command stream continues ...]

and does it apply for import, too?
