From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit 5841520b makes it impossible to connect to github from behind my company's firewall.
Date: Wed, 21 Oct 2015 11:29:17 -0700
Message-ID: <xmqqh9lk5b42.fsf@gitster.mtv.corp.google.com>
References: <loom.20151020T131513-529@post.gmane.org>
	<vpq37x54vav.fsf@grenoble-inp.fr>
	<cbf2c2c2c137445ebb9e2c5f1012cb10@EXMBNJE8.ad.twosigma.com>
	<xmqqr3kp8qqe.fsf@gitster.mtv.corp.google.com>
	<33632f538b4a406fb8f0e1eb2b016c43@EXMBNJE8.ad.twosigma.com>
	<loom.20151021T091641-32@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Enrique Tobis <Enrique.Tobis@twosigma.com>
To: Johan Laenen <johan.laenen+cygwin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 20:29:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoy8e-00020u-Ub
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 20:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbbJUS3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 14:29:22 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34180 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbbJUS3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 14:29:19 -0400
Received: by padhk11 with SMTP id hk11so61752005pad.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gNYtNwe4+4QaJaZx6pwaSVSXfCTzlgn8DpDY1ghTXcQ=;
        b=uc6uLWaCWKOoXIW1HhhS/AU6d2kXuoygtbnKql6PXUDoub1MFNTuG5whLxHFvAwpcD
         vOkLEnyLWF60xsJysXbFBJVKru18Uhbq4bGW7N+r9oiQFtvAnnnBUg6O6RqjZBztGxN9
         28qDuwlavTL6pgifuT/txz4mpGM4NGpPBEtPyxmxmvPbo9QKJz9N+sJrIecRtu84nqVc
         NhtzGThHCBw/t46YabCtVnhAC3uZLpzO2AhPKPUZVpAAvb9jZvWEXu4uSs6eKx0a+e3j
         AD1LRLVCRs6s5bJ9KVUxq8/OtNvfWEfwree2g76BbVsW5FaAJ+nlW4OkFCdCnU5lZtX1
         8jIQ==
X-Received: by 10.66.157.3 with SMTP id wi3mr12216398pab.17.1445452159231;
        Wed, 21 Oct 2015 11:29:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id j16sm10361249pbq.23.2015.10.21.11.29.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Oct 2015 11:29:18 -0700 (PDT)
In-Reply-To: <loom.20151021T091641-32@post.gmane.org> (Johan Laenen's message
	of "Wed, 21 Oct 2015 07:19:40 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279997>

[administrivia: please do not cull people out of the Cc: list]

Johan Laenen <johan.laenen+cygwin@gmail.com> writes:

> Enrique Tobis <Enrique.Tobis <at> twosigma.com> writes:
>
>> There is something I don't understand, though. Johan must be
>> configuring his proxy either a) through git config files; or b)
>> through environment variables. Johan says his proxy uses NTLM
>> authentication. If he is doing a), then my change should not have
>> had any impact. We were already setting CURLOPT_PROXYAUTH to
>> CURLAUTH_ANY in that case. If it's b), then his proxy couldn't
>> have been using NTLM authentication. In the old code path, only
>> _BASIC was available as an authentication mechanism.  That
>> default is what prompted me to make the change in the first
>> place.
>
> Interesting!
>
> I tried both git versions, the one with the revert of commit 5841520b and
> the one without and both gave me the fatal error "Unknown SSL protocol error
> in connection to github.com:443" when using the ~/.gitconfig [https] and
> [http] proxy settings instead of using the https_proxy environment variable.

OK, so the conclusion I draw here is that your NTLM setting is not
working at all, you have been using Basic auth happily before that
commit, and you have to either (1) get NTLM auth working, or (2)
find a way to tell Git that your proxy appears to support NTLM
but it is unusable and you need to use Basic.

Even though you may be capable to do (1), other people in the same
situation might not be, in which case we would also need a way to do
(2).

Am I reading the above correctly?
