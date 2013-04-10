From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 02:25:59 +0530
Message-ID: <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
References: <7vobdnnpx6.fsf@alter.siamese.dyndns.org> <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org> <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org> <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 <20130410200548.GC24177@sigill.intra.peff.net> <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
 <20130410202456.GF24177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:56:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ24T-0006hw-MQ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092Ab3DJU4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:56:41 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38022 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764955Ab3DJU4k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:56:40 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so1155224iec.41
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hQhQF3Dg0/H8yQS8GDoryi8N9e0Stho1EIdjtHssjyY=;
        b=ycMV1ekVHdWEumzeggpjWb6zFvv/Bi8/TicrxIpHAyI0dVBU4G9dXKLdaXPITBmDq7
         t2oF4Sj3YTLeXmAyVozqloOrTaCXeFtpklxYbQKYKKbPSdPGk/BaisAs1kzLyeZBujk9
         FGZnOhw37BzVCscP1L9BGcUpkHZvgiZ1ywtpChH/DBc+ecDFaEShzm4/WEwhX4wc6OHe
         VmGlCDq0yvt5EXYC2a9aQRTVfBcrrQIyK7Zrudsu9cZ8JVmzO4iQOYd0G2MPggro/ukF
         TQqSU47A73WTtur9PrCX3MEoedMPDEaJjyppE/hHJjwJbEnxsnuF2nYb6Wfcl+v969Ec
         FNyg==
X-Received: by 10.50.50.71 with SMTP id a7mr14173345igo.14.1365627400414; Wed,
 10 Apr 2013 13:56:40 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 13:55:59 -0700 (PDT)
In-Reply-To: <20130410202456.GF24177@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220760>

Jeff King wrote:
> On Thu, Apr 11, 2013 at 01:49:54AM +0530, Ramkumar Ramachandra wrote:
>> Huh, why?  Simply because he specified master alongside it?  How can
>> we infer what you said in a consistent system?
>
> That's kind of my point. Why would they put two refs together in a
> single push command? Did they mean "I am pushing up master, and since I
> just tagged it, send the tag along, too"? Or did they really mean to
> push them to two different places? If so, why not just run two separate
> push commands?

I disagree.  The protocol was built ground up to support updating
multiple refs in the same git push.  Running N separate push commands
is _not_ the same thing at all; it running N times as slowly aside.

Pushing multiple refs is a valid and cogent usecase (while multiple
remotes is not).  git is a distributed system: I make lots of changes
to various branches, tags and decide to push only when I'm taking a
break for lunch: at this point, I want to update all my refs on the
remote.  In other words, I batch up ref updates because git is _meant_
to do that: creating/ modifying/ moving/ deleting refs is super-fast
(and happens all the time), while pushing is a slow and dangerous
(because gc runs) operation.
