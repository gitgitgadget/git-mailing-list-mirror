From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file:
 freshen existing objects
Date: Tue, 21 Apr 2015 11:49:33 +1000
Message-ID: <CADoxLGOdvJVgjRFrC81nM6A4=PRABSiL_EGOUtN7d-MAKXrzzg@mail.gmail.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
 <20150417140315.GA13506@peff.net> <CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
 <20150420195337.GA15447@peff.net> <xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
 <20150420200956.GA16249@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 03:50:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkNKO-0005iM-Mw
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 03:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbbDUBuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 21:50:15 -0400
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:58708 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751818AbbDUBuO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2015 21:50:14 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]) (using TLSv1) by na3sys009aob116.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVTWs1flAIZWgNNsRMWMfmDrYNrh1pW9S@postini.com; Mon, 20 Apr 2015 18:50:14 PDT
Received: by iedfl3 with SMTP id fl3so4132490ied.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 18:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=bgHVtHiQj4CllPgtTg7/eMSxpQ8xNTro+r6ZLbK+a00=;
        b=lWz/fnHUocnnigUeDSUMa14GZWAbERpdYG09Aa7iRZXeqgrGKu1GOcYpLAjofAkSuk
         3n3X5wMPwE36qRG+0mUJArzgyP6ICQ170yd768mLmJi14jqVTjIxDe0Rzgu6CQxlqHkC
         s/ufltRimxUGXZznLgkDaCtmm5DIMFb5y/pxKjQeif8rAzuybKzHbNVrHhKHW9x9wMQW
         pZaVJAOGOwnCPDQ6+kgSYaXsOVZe43cBsfFiqtHBp6HJAY1VSiPzpAxzBh+rHQdY3vQd
         kZPpJB9yjY3Qg3UeOQijBLmT61OZhJIB2xhOm18QfocQeSLUHHdyp4vf6oj/5qoH/+rn
         4vdw==
X-Gm-Message-State: ALoCoQmSTmtFT5n+zupe3kXsNAsLDMwowxBpYhxKOgkU7hGpnYbjgs2PeAoAN0U63a87bZhAd4k6iM4UvdOi8fhz4aV/+DS/AQ5TEiK9Oi62abuaLGrXe+M/4xZAAhr4yCSiEQAl/wJdGcpMRNm4wfvrPqqMBQp/ig==
X-Received: by 10.42.137.202 with SMTP id z10mr733883ict.37.1429581013567;
        Mon, 20 Apr 2015 18:50:13 -0700 (PDT)
X-Received: by 10.42.137.202 with SMTP id z10mr733871ict.37.1429581013421;
 Mon, 20 Apr 2015 18:50:13 -0700 (PDT)
Received: by 10.36.118.133 with HTTP; Mon, 20 Apr 2015 18:49:33 -0700 (PDT)
In-Reply-To: <20150420200956.GA16249@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267517>

>> If it is critical to some people, they can downmerge to their custom
>> old installations of Git they maintain with ease, of course, and
>> that "with ease" part is the reason why I try to apply fixes to tip
>> of the original topic branch even though they were merged to the
>> mainline eons ago ;-).
>
> I think it is a bigger deal for folks who do not ship a custom
> installation, but expect to ship a third-party system that interacts
> with whatever version of git their customers happen to have (in which
> case they can only recommend their customers to upgrade).

Yes, this is the situation we are facing. We allow our customers to
use the git version that is supported/available on their OS (within a
certain range of supported versions) so our customers usually don't
compile from source.

> Either way, though, I do not think it is the upstream Git project's
> problem.

That's fair enough, I was mostly enquiring about the official git
versions this will land in so that we can advise customers what git
version to use (or not to use).

I've noticed Peff's patches on pu which suggest they will be available
in git 2.5?
Do you Junio, have plans to merge them to maint (2.3.x) and/or next (2.4)?

While I certainly agree that this is specific to Git on NFS and not a
more widespread git performance problem, I'd love to be able to
message something other than "skip all the git version between and
including git 2.2 - 2.4".

I appreciate your consideration and thanks again for the swift response on this.

Cheers,
Stefan
