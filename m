From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Fri, 13 Jan 2012 00:55:58 +0530
Message-ID: <CALkWK0kk0mVNaetr=triuVYva7inyx2aZvam81qTVA9=Q=UzGw@mail.gmail.com>
References: <20120111173101.GQ30469@goldbirke> <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke> <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com> <7vaa5s3hiq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:26:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlQI7-0006EQ-H8
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 20:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab2ALT0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 14:26:22 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48583 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab2ALT0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 14:26:20 -0500
Received: by wgbdt14 with SMTP id dt14so564605wgb.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 11:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MTHA73hklp2xJ/UOp5CkfvEm7+p7wkGajp7UOGsc76A=;
        b=QPnPOJHmgU65TFIpoZg7Igaq6CNcN84umxEHv+oExnejYTzdMi3uEEDrnAOgMSm5eg
         esEqjaKr+BPCwcReMXJvWnJX/B0YfmQYI4klcH1S9AROUHxAa9tkj7Q0l0ssv+J57jgS
         QzDwb13JFjdKiOe31JnVYnsL3nj/u9/HFbOTI=
Received: by 10.180.82.5 with SMTP id e5mr2760468wiy.18.1326396379240; Thu, 12
 Jan 2012 11:26:19 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Thu, 12 Jan 2012 11:25:58 -0800 (PST)
In-Reply-To: <7vaa5s3hiq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188474>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> What are your thoughts on making it a flag in the revision API to be
>> activated with "cherry-pick --literal-order commit1 commit3 commit2"
>> or similar?
>
> That is an insane UI for the sake of flexibility.
>
> You should be able to look at revs->cmdline and tell if you need to let
> cherry-pick walk (i.e. "cherry-pick master..next"), or if the user wants
> individual commits (i.e. "cherry-pick A B C").
>
> And you do prepare_revision_walk() only when you need to walk; otherwise
> you use the contents of revs->pending in order.

Okay, just to make sure I understand this correctly: if more than one
argument is literally specified, I should not set up the revision
walker and pick the commits listed in revs->pending, correct?  Then,
when I encounter the following command,

  $ git cherry-pick maint ^master

I should just pick two commits: maint, and ^master.  But won't this
introduce some kind of regression for those who expect me to pick the
master..maint range instead?  Has this double-interpretation issue
come up in other commands?  Have we documented this somewhere?

Thanks.

-- Ram
