From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 7 Oct 2011 05:06:46 -0500
Message-ID: <20111007100646.GA23193@elie.hsd1.il.comcast.net>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org>
 <4E8EBDA7.2040007@drmicha.warpmail.net>
 <20111007091636.GA22822@elie.hsd1.il.comcast.net>
 <4E8ECA25.205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 12:07:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC7Ka-0003d7-IR
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 12:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759650Ab1JGKG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 06:06:59 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50025 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab1JGKG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 06:06:58 -0400
Received: by iakk32 with SMTP id k32so4028648iak.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Rn9TknSkDlJ7N0kwoMMet6slnVR9vjO35gViy/YOwck=;
        b=gRIu7Qa8dwRmhIjDYulbRtNzO6KYJvupLUreZPJbR2CBU7KUL2oLBDiYb4GLpfdIZi
         NECgMOruJ/n6yZU3rbyNAvZ+qKBQzm47NFYKyQ3+MzqH7plAMDuKJlXHDDfbM5Ryqcy7
         AGOUpoXYwuhTKYunzacayY9xb4PnB3+puCpW8=
Received: by 10.43.130.133 with SMTP id hm5mr11476999icc.11.1317982017932;
        Fri, 07 Oct 2011 03:06:57 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 2sm18865501ibf.0.2011.10.07.03.06.56
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 03:06:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E8ECA25.205@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183073>

Michael J Gruber wrote:

> But my main point here is that we should discuss the pros and cons of
> each approach in context (the context of the original thread), and I
> haven't heard many pros and cons for either.

Ok, here are some thoughts (you can file them under the "pro" or "con"
column according to your taste):

Branch names are local.

The same tip commit can belong to multiple branches, which would make
using the tip commit as a key for the branch description problematic.
I don't think git notes are a good fit for this purpose.

I personally would prefer my branch descriptions to be non-versioned,
though I realize that is a matter of taste.

Some other information about a branch (such as which upstream branch
it pulls from) is stored in the [branch "<branchname>"] section of the
git configuration, so it makes a certain kind of sense to put the
branch description there, too.  On the other hand, the possibility of
a [branch "<branchname>"] section in ~/.gitconfig has always been
strange, and this is no exception.

> I'd be surprised if we changed the protocol just to be able to share
> some descriptions, when we have everything we need for sharing refs.

The impact of such a protocol change would not have to be as dramatic
as you seem to be suggesting.  Virtual hosts and peeled ref values
were added as backward-compatible extensions to the reference
discovery protocol (see Documentation/technical/pack-protocol.txt)
which can be taken as examples for inspiration.

Here's some discussion of the implementation based on branchname-keyed
notes that you mentioned [1].  It is nice to have multiple designs
available for trying out, and I hope experience using each reveals
potential improvements in the other.

[1] http://thread.gmane.org/gmane.comp.version-control.git/181953/focus=182000
