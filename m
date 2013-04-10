From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 01:23:57 +0530
Message-ID: <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
References: <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org> <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org> <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org> <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org> <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ16R-00038P-Ta
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763884Ab3DJTyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:54:38 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:59760 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab3DJTyi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:54:38 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so1089729iec.27
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ShHY5lAKI2J16Ycau54Z4LhBYFggE2qGLKe0Q592VLY=;
        b=vTIvhn9Qq0bNAm2Wk1eMG24rBXU06eTwiuROfNkSUuAweJx4C4KiCo0yNTb1IW7EHT
         7jugM+qLVRsE4rCuWBYYmUNvyGyCIVV8QeULavtrlixaPSNl1L45KgjAGJcYRxZRkSXa
         WpDgh48GdsAEX0WxqzKdasrkaF9SdN0gOTakX70G4AfDIby6ekM963UdP5Db+q50MRCp
         E0JeDjcO+dAGeOH46Dr617bW87gG2xawbNusEI0IOxfJ+Zxl+DLQHDZOdibLGghAsi8V
         nzX3+32k0aKmdu+8ks/wjERWtUPAp1t1ZDUju7eKwgGxVjkFBRZLEUGjZvXiR6jbMIj8
         XmmA==
X-Received: by 10.50.17.166 with SMTP id p6mr14200417igd.12.1365623677653;
 Wed, 10 Apr 2013 12:54:37 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 12:53:57 -0700 (PDT)
In-Reply-To: <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220739>

Ramkumar Ramachandra wrote:
> git push -- master next; pushes to my current branch's
> branch.<name>.pushremote?  Isn't that a disaster?

Actually, branch.<name>.pushremote already breaks the current design
in a way, as Junio pointed out in a different email: a push.default
set to anything except "current" is already nonsensical.  Why should
"matching" branches be pushed to the remote that my current branch
specifies?  That might well have their own branch.<name>.pushremote
configured, which should be respected.

We should fix this now.  I think the fault lies in the rather old
design of push.default.  Do you have any suggestions as what would
make sense here?  Ultimately, I think a git push; needs to pick
remotes for each refspec separately.  The orthogonal design is
definitely not right in my opinion.

As the author of branch.<name>.pushremote, I apologize for not having
caught this earlier.  I've been using push.default = current for a
long time, and don't often think about the other settings.
