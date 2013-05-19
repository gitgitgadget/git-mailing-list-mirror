From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Sun, 19 May 2013 17:14:43 +0530
Message-ID: <CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org> <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
 <7vobca3465.fsf@alter.siamese.dyndns.org> <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
 <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
 <7vk3mx1rox.fsf@alter.siamese.dyndns.org> <CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
 <7vk3mxze8v.fsf@alter.siamese.dyndns.org> <CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
 <7vmwrr1pem.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:45:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue23M-0000W5-96
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab3ESLpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:45:24 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46010 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab3ESLpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:45:23 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so12212500iej.30
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=naP7LGMh5hlwctS2XyF7WeG+WBokDO1iNZYYB2a19lM=;
        b=ITsTYDAq7mf57LWMHJzaKLqs6YDqVpfPxry/0pz6PVACakmGAvokoRdniyOiPdbCQ/
         j1X+lLiIUfRfy5eitEGDscFBSlxcuRKh+m/0C88613GsGRY78YDv2CPayeNtLMSDt/Me
         1kMoRG1hKB3R8osZusO910bL0mrb2OrU+gMcnb5V1AM44YyCO52ZLS3h9qqrzThcJDZf
         Y9sy6cuzRYj1GIG042EfrYA0oBF3YPRi1VdKh7sEFM+HLWvYkebW9DjRTfPSYwwwEV77
         21GomPuzYdxD9+5P9FLia3Rih7QKZNthQkg+lJd0J/TlnMzlK6OJMgSV4Dh2eAfxAkQz
         CKWw==
X-Received: by 10.42.47.77 with SMTP id n13mr515587icf.12.1368963923573; Sun,
 19 May 2013 04:45:23 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:44:43 -0700 (PDT)
In-Reply-To: <7vmwrr1pem.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224861>

Junio C Hamano wrote:
> If somebody implements the "push.default = single" (see the original
> message you are responding to), then the change might be smaller.

I think this is a bad hack covering up an underlying problem: it is
ugly, confusing, and inextensible in my opinion.  I think of
push.default as merely a default remote.<name>.push value for all
remotes, that can be overridden on a per-remote basis.

I suspect that the issue you're trying to address is:

[remote "ram"]
    push = refs/heads/*:refs/heads/rr/*

not dictating which refs to push when I say 'git push' (it'll push all
the refs under refs/heads/*, not respecting push.default=current in my
scheme).  That is a valid problem, and it is a problem with our
refspec: I can say "HEAD" (which is what push.default=current is) to
mean current branch, but I can't dictate the rhs of the refspec then.
In other words, I cannot have the refspec "HEAD:refs/heads/rr/%1", and
_this_ is the problem.

What do you think?
