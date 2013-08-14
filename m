From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 11:25:59 -0600
Organization: CAF
Message-ID: <201308141125.59991.mfick@codeaurora.org>
References: <520BAF9F.70105@googlemail.com> <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com> <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, iveqy@iveqy.com,
	Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 19:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9epk-0008JR-On
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 19:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759996Ab3HNR0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 13:26:04 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:54483 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759967Ab3HNR0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 13:26:03 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2984013EF10;
	Wed, 14 Aug 2013 17:26:03 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 1983613EF93; Wed, 14 Aug 2013 17:26:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from mfick-lnx.localnet (mfick-lnx.qualcomm.com [129.46.10.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id B47D313EF83;
	Wed, 14 Aug 2013 17:26:02 +0000 (UTC)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232301>

On Wednesday, August 14, 2013 10:49:58 am Antoine Pelisse 
wrote:
> On Wed, Aug 14, 2013 at 6:27 PM, Stefan Beller
> 
> <stefanbeller@googlemail.com> wrote:
> >  builtin/repack.c               | 410
> >  +++++++++++++++++++++++++++++++++++++++++
> >  contrib/examples/git-repack.sh | 194
> >  +++++++++++++++++++ git-repack.sh                  |
> >  194 -------------------
> 
> I'm still not sure I understand the trade-off here.
> 
> Most of what git-repack does is compute some file paths,
> (re)move those files and call git-pack-objects, and
> potentially git-prune-packed and git-update-server-info.
> Maybe I'm wrong, but I have the feeling that the correct
> tool for that is Shell, rather than C (and I think the
> code looks less intuitive in C for that matter).
> I'm not sure anyone would run that command a thousand
> times a second, so I'm not sure it would make a
> real-life performance difference.

I have been holding off a bit on expressing this opinion too 
because I don't want to squash someone's energy to improve 
things, and because I am not yet a git dev, but since it was 
brought up anyway...
 
I can say that as a user, having git-repack as a shell 
script has been very valuable.  For example:  we have 
modified it for our internal use to no longer ever overwrite
new packfiles with the same name as the current packfile.  
This modification was relatively easy to do and see in shell 
script.  If this were C code I can't imagine having 
personally: 1) identified that there was an issue with the 
original git-repack (it temporarily makes objects 
unavailable) 2) made a simple custom fix to that policy.

The script really is mostly a policy script, and with the 
discussions happening in other threads about how to improve 
git gc, I think it is helpful to potentially be able to 
quickly modify the policies in this script, it makes it 
easier to prototype things.  Shell portability issues aside, 
this script is not a low level type of tool that I feel will 
benefit from being in C, I feel it will in fact be worse off 
in C,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
 
