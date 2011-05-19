From: Rafael Gieschke <rafael@gieschke.de>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 21:42:36 +0200
Message-ID: <74D1D7FC-A747-4F85-8B1E-7ABFC9DA70A3@gieschke.de>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de> <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de> <7v62p68ut0.fsf@alter.siamese.dyndns.org> <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com> <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de> <BANLkTi=y5uk2Oi+yx+f-cjUeBrzKeFzzmg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 21:42:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN97W-00032i-OO
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 21:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934491Ab1ESTmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 15:42:49 -0400
Received: from smtp1.goneo.de ([212.90.139.80]:47341 "EHLO smtp1.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934363Ab1ESTmr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 15:42:47 -0400
Received: from smtp1.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 964063A384F;
	Thu, 19 May 2011 21:42:46 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.87
X-Spam-Level: 
X-Spam-Status: No, score=-2.87 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.030, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
	by smtp1.goneo.de (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAtqco9h+Rqj; Thu, 19 May 2011 21:42:44 +0200 (CEST)
Received: from [10.167.157.160] (unknown [89.204.137.160])
	by smtp1.goneo.de (Postfix) with ESMTPSA id BE17F3A38E0;
	Thu, 19 May 2011 21:42:40 +0200 (CEST)
In-Reply-To: <BANLkTi=y5uk2Oi+yx+f-cjUeBrzKeFzzmg@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173997>


Am 19.05.2011 um 21:19 schrieb Erik Faye-Lund:

> On Thu, May 19, 2011 at 9:16 PM, Rafael Gieschke <rafael@gieschke.de> wrote:
>> 
>> Am 19.05.2011 um 20:07 schrieb Erik Faye-Lund:
>>> diff --git a/compat/mingw.h b/compat/mingw.h
>>> index 62eccd3..e37d557 100644
>>> --- a/compat/mingw.h
>>> +++ b/compat/mingw.h
>>> @@ -48,6 +48,8 @@ typedef int socklen_t;
>>> #define EAFNOSUPPORT WSAEAFNOSUPPORT
>>> #define ECONNABORTED WSAECONNABORTED
>>> 
>>> +#define PASS_MAX 512
>>> +
>> 
>> It might be worth to have this in git-compat-util.h, so it can also be used by compat/getpass.c. I'm not sure about the name, however; it's a remote password and MAX_PASS is about local passwords AFAIK. Maybe PASS_MAX_REMOTE or something similiar. Like that, compat/getpass.c could also be used in case MAX_PASS has some insanely low value on a platform.
>> 
>> 
> 
> PASS_MAX should be defined in limits.h (which is included by
> git-compat-util.h) on POSIX platforms:
> http://pubs.opengroup.org/onlinepubs/007908799/xsh/limits.h.html
> 
> If it turns out it's not on some platforms, perhaps a define-guarded
> version would make sense in git-compat-util.h instead.

It is defined even on Android :-).

But I still wonder whether it's the right thing or if you should use it only for local passwords.

If you imagine a platform with MAX_PASS=8, git couldn't connect to an IMAP server with a password of 10 chars on this platform without any proper reason.
