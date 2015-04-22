From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file:
 freshen existing objects
Date: Wed, 22 Apr 2015 10:04:12 +1000
Message-ID: <CADoxLGNgWy7o4Kz2Zw-H=k9Dcrmff3_hd1pu1yrotZjKNqFENQ@mail.gmail.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
 <20150417140315.GA13506@peff.net> <CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
 <20150420195337.GA15447@peff.net> <xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
 <20150420200956.GA16249@peff.net> <CADoxLGOdvJVgjRFrC81nM6A4=PRABSiL_EGOUtN7d-MAKXrzzg@mail.gmail.com>
 <xmqqiocpif8p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 02:05:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkiA3-0000HS-5b
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 02:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbbDVAEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 20:04:54 -0400
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35038 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964887AbbDVAEx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2015 20:04:53 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]) (using TLSv1) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVTblpZSjDQIfkpLAPXoHyR6l4AgbIGse@postini.com; Tue, 21 Apr 2015 17:04:53 PDT
Received: by iebrs15 with SMTP id rs15so26148002ieb.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 17:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6Zlm6+dkjaRpUloePxFB5ZGQzsa5WFgK5+VudyzqTPM=;
        b=Egqs+eLzVzj1npjGP6gORGh/bnlg712JGvZ/oJdyHF47E+EPSlXZQ/BFyW3b6IT7Da
         2ml82bjut+0jVUT8Wk4wysKiNRrrKAZnx+SNqJFd6IW+aA3iBm2qwtLUJj6wuA5Xgtth
         EZKPq88zGdJ9aVfBlve4m3fco8kdjPnD7tQovueDiAW148Y40cAt1aQiQHJUThaqZ13V
         NTczdcVg8oXEKqIPiawPpujowQSF96j8TPisv79Ws97K7qvyVA1bdhFKge3tN4kkk/PK
         0YWV7SKyLsBzqZBd4Q6BVQAUUatvnNFlUch3QU6Y7pta45Bl6uhvNGgZAQae0RWiGl1w
         67fg==
X-Gm-Message-State: ALoCoQkWR92WhnBzVcFoQ3HoVjWDZlm9ZfGZvZPcPnRYEAVOUCBXHOMj8H/xk1kMckYT0KPCQilXVYDhYdFy4kAMV5fqHYkhmitiFJ5Fk/ZedLHuAf9XTy6nNNkLRcbL52NFInMSEuHagUmqREida9rjqFmZG0oCpA==
X-Received: by 10.43.39.1 with SMTP id tk1mr6478890icb.26.1429661093102;
        Tue, 21 Apr 2015 17:04:53 -0700 (PDT)
X-Received: by 10.43.39.1 with SMTP id tk1mr6478885icb.26.1429661093028; Tue,
 21 Apr 2015 17:04:53 -0700 (PDT)
Received: by 10.36.118.133 with HTTP; Tue, 21 Apr 2015 17:04:12 -0700 (PDT)
In-Reply-To: <xmqqiocpif8p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267574>

>> I've noticed Peff's patches on pu which suggest they will be available
>> in git 2.5?
>
> Being on 'pu' (or 'next' for that matter) is not a suggestion for a
> change to appear in any future version at all, even though it often
> means that it would soon be merged to 'master' and will be in the
> upcoming release to be on 'next' in early part of a development
> cycle.  Some larger topics would stay on 'next' for a few cycles.
>
>> Do you Junio, have plans to merge them to maint (2.3.x) and/or next (2.4)?
>
> The topic will hopefully be merged to 'master' after 2.4 final is
> released end of this month, down to 'maint' early May and will ship
> with 2.4.1, unless there is unforeseen issues discovered in the
> change while people try it out while it is in 'next' (which will
> happen today, hopefully).

Thanks for the clarification Junio.
