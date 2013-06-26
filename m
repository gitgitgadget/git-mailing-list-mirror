From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 1/3] remote: Add warnings about mixin --mirror and other
 remotes
Date: Wed, 26 Jun 2013 23:10:06 +0200
Message-ID: <1372281006.3602.2.camel@localhost>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
	 <1371809051-29988-2-git-send-email-dennis@kaarsemaker.net>
	 <7v8v23mhjy.fsf@alter.siamese.dyndns.org>
	 <1371994516.24315.8.camel@localhost>
	 <7vvc54ed53.fsf@alter.siamese.dyndns.org>
	 <1372023811.24315.15.camel@localhost>
	 <7vmwqge9u9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 23:10:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urwyo-0006LP-RC
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 23:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab3FZVKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 17:10:12 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:64855 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab3FZVKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 17:10:11 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so10820150wgh.27
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 14:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version:content-transfer-encoding
         :x-gm-message-state;
        bh=pLCrjId4kq5HgEGzm94Z8vKMzM/JYv1iCG1sSa6Ldyc=;
        b=OsFSIcj157sE/1U45KZFC6lMOI6pBOZODBb1cQKcH1Bxh3FJuTh1HvTlHRs4PvdkFI
         g2NQ5s2PzhTZxlYSSL9aJGP+7nhs20G1xT1rklA/wNhUUy/fTIdJhhTOK2EdJ7fE52Is
         N0/15hJp3rrekfLy6w2nydgaI7T5VS10i32TqmPviuvaRPSIhdEwdh7MVtIlLCw8qz/d
         /ky+6jscF96gp4HlS2bX0T2m/GHAbX9P56ax7oNIhiWmXRQNLf0pxkOKpcZAzGY69rtX
         Bo8sGnaqYwbaIqcHyf/v6G2nQYoiCIqz421MqVAtC065gwaFT+7bfwprvxrLE5rIshhC
         NLAg==
X-Received: by 10.181.13.7 with SMTP id eu7mr8622871wid.54.1372281009970;
        Wed, 26 Jun 2013 14:10:09 -0700 (PDT)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id fs8sm13468404wib.0.2013.06.26.14.10.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Jun 2013 14:10:08 -0700 (PDT)
In-Reply-To: <7vmwqge9u9.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQk5l8h/YJZsTGWyQ+XWFfGL8zAZycCX09oG47vr1X6eVr3Or7zxLTZi0Ks014S0trDBJey9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229061>

On zo, 2013-06-23 at 15:33 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > On zo, 2013-06-23 at 14:22 -0700, Junio C Hamano wrote:
> >> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> >> 
> >> > Equality for
> >> > wildcards is allowed and tested for, so do we really want to 'outlaw'
> >> > equality of non-wildcard refspecs?
> >> 
> >> I am not sure what you mean by "equality for wildcards is allowed".
> >> Do you mean this pair of remote definition is sane and not warned?
> >> 
> >> 	[remote "one"]
> >>         	fetch = refs/heads/*:refs/remotes/mixed/*
> >> 
> >> 	[remote "two"]
> >>         	fetch = refs/heads/*:refs/remotes/mixed/*
> >
> > I personally don't consider them very sane and didn't originally support
> > that. But this behavior is tested for in t5505-remote.sh test 27, which
> > started failing until I stopped warning for equal refspecs. This support
> > for "alt remotes" in prune was added by c175a7ad in 2008. The commit
> > message for that commit give a plausible reason for using them.
> 
> I actually do not read it that way.  What it wanted to do primarily
> was to avoid pruning "refs/remotes/alt/*" based on what it observed
> at the remote named "alt", when the refs fetched from that remote is
> set to update "refs/remotes/origin/*".
>
> The example in the log message is a special case where two
> physically different remotes are actually copies of a single logical
> repository, so in that narrow use case, it may be OK, but it is an
> unusual thing to do and we should "warn" about it, I think.

Apart from the exactly matching refspecs, does git in any other way
treat this as a special case?

> In any case, I've been assuming in this discussion "allow" is to
> silently accept, and overlaps are "warned" but not "rejected".  So
> if you meant by 'outlaw' to die and refuse to run, that is not what
> I meant.

Well, 1/3 is a warning on add, 3/3 is a warning and refusing to prune.
Should 3/3 do something else instead? Perhaps prompt for confirmation or
require some sort of --force?

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
