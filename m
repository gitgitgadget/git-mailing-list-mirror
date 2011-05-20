From: Rafael Gieschke <rafael@gieschke.de>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Fri, 20 May 2011 12:06:36 +0200
Message-ID: <A4C82C4A-4A6A-412C-89D5-803F6DC85FD3@gieschke.de>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de> <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de> <7v62p68ut0.fsf@alter.siamese.dyndns.org> <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com> <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de> <BANLkTi=y5uk2Oi+yx+f-cjUeBrzKeFzzmg@mail.gmail.com> <74D1D7FC-A747-4F85-8B1E-7ABFC9DA70A3@gieschke.de> <BANLkTimG8E_Riz3rYC9PMw_2-D=Za0Ar6w@mail.gmail.com> <BANLkTingSqEM5=4=rLq7Yu1x9YXstiSsNw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri May 20 12:09:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNMe6-0003pG-Sz
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 12:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935541Ab1ETKJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 06:09:18 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:56582 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935518Ab1ETKJR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2011 06:09:17 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 4DEDB1D23A1;
	Fri, 20 May 2011 12:09:16 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.832
X-Spam-Level: 
X-Spam-Status: No, score=-2.832 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.068, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YV2IZuSkmfWV; Fri, 20 May 2011 12:09:15 +0200 (CEST)
Received: from [10.151.37.67] (unknown [89.204.153.195])
	by smtp2.goneo.de (Postfix) with ESMTPSA id 88C401D23A7;
	Fri, 20 May 2011 12:09:11 +0200 (CEST)
In-Reply-To: <BANLkTingSqEM5=4=rLq7Yu1x9YXstiSsNw@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174053>


Am 19.05.2011 um 23:16 schrieb Erik Faye-Lund:
>> 
>> Well, those platforms would currently fail, since that's the limit on
>> the string returned from getpass. Since that hasn't happened yet, I
>> suspect that this is a very theoretical problem.
>> 
>> If we created our own define we could fix such problems by setting
>> NO_GETPASS and having a reasonable lengthy GIT_MAX_PASS. But let's
>> leave that theoretical fix for when/if it turns out to be real, huh?
>> 
> 
> Whoa: http://www.opengroup.org/csq/view.mhtml?norationale=1&noreferences=1&RID=sun%2FSE2%2F10
> 
> It seems that Solaris has a MAX_PASS of 8... That should mean that
> prompted passwords can't be above 8 characters there (without using
> GIT_ASKPASS). Can this really be the case?

Good find. At least under "SunOS opensolaris 5.11 snv_111b i86pc i386 i86pc" with packages from http://sunfreeware.com/indexintel10.html, I can confirm exactly this behavior. If you try to connect to an account with password > 8 chars, git-imap-send prints "IMAP command 'LOGIN <user> <pass>' returned response (NO) - incorrect password or account name", using <= 8 chars it works fine (couldn't check git clone on https because I only have an internal IP without NAT/proxy).

So maybe it would make sense to define NO_GETPASS and use compat/getpass.c on Solaris in the Makefile?
