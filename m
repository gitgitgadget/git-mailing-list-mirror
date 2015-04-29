From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 15:47:52 -0700
Organization: Twitter
Message-ID: <1430347672.14907.48.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
	 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	 <1430343059.14907.18.camel@ubuntu>
	 <xmqqh9ry4nbx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:48:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynals-0004Ks-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 00:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbbD2Wr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 18:47:56 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34087 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbbD2Wrz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 18:47:55 -0400
Received: by pacyx8 with SMTP id yx8so40706803pac.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 15:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=vRlHRlFtk/+/sNgwI8Omu4selvevVEh0gYYohm4af5g=;
        b=O78jUbimO6m5Ug0XsNos6jNbX8GWI5n8ggNtVQhORiEktKS/W4U2hHg+ubgq1dAMiI
         SNx8utBw7RaOFwUR4qTQqBQw0/sROlsCs9oijsrNEN/nqWHoylyO2opsMm4kA6PhQAd2
         VVOZqUoweJjfF1pGeky38a2LTP3DVhnxa03LlpHjaAluidQjd/2MZNw+qUJmupp0E/h9
         A/fZ9zbyqKNJdLHIht3NWnaXxO46gSQ4YZp/BsvSAi8B5w7aSGIGp095j6R99svLmPTy
         71bvWXt3ISy22x9rx/uG0rY01+EoqGuJIzKw4fbVq6XA8httMxQ9a+eqiet9CCIerbXY
         NiWw==
X-Gm-Message-State: ALoCoQmMRo2coWRBMgUAPkvA9SxmOKSfEid+sdLSJRXMGKbRXRCIvcgpicnlzSJujrRTy2uHIzBt
X-Received: by 10.68.209.193 with SMTP id mo1mr2409055pbc.142.1430347675259;
        Wed, 29 Apr 2015 15:47:55 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id kh6sm219986pbc.50.2015.04.29.15.47.53
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2015 15:47:54 -0700 (PDT)
In-Reply-To: <xmqqh9ry4nbx.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268033>

On Wed, 2015-04-29 at 14:49 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> >> Perhaps an ideal interface might be something like this:
> >> 
> >>     $ echo HEAD:RelNotes |
> >>       git cat-file --batch='%(objecttype) %(intreemode)
> >>     %(objectsize)' blob 160000 32
> >>     Documentation/RelNotes/2.4.0.txt
> >> 
> >> I suspect it would be just the matter of teaching "cat-file
> >> --batch" to read from get_sha1_with_context() in
> >> batch_one_object(), instead of reading from get_sha1() which it
> >> currently does.
> >> 
> >> And that inteferface I think I can live with.
> >
> > Even if I had %(intreemode), I would still have to do a recursive
> > search to figure out whether Documentation or RelNotes was a
> > symlink.

I apologize.  I have misread your example.  All of my text was assuming
that Documentation/Relnotes/2.4.0.txt was a symlink, instead
of /RelNotes being a symlink to Documentation/Relnotes/2.4.0.txt.  So my
previous message was very difficult to interpret.  I think Jeff King's
reply is a better starting point for discussion, since it lays out the
advantages and disadvantages of the proposal.

> allowing it to make policy decisions (e.g. "if
> outside repository, always look at the filesystem that the program
> happens to be running" [*1*]) 

Despite my confusion, I don't think I ever proposed doing this.  I
proposed that in the case that a symlink points outside the repo,
cat-file would tell the caller that it has done so, so that the caller
can decide what to do.
