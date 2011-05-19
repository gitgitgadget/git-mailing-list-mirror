From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 21:19:14 +0200
Message-ID: <BANLkTi=y5uk2Oi+yx+f-cjUeBrzKeFzzmg@mail.gmail.com>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de>
 <7v62p68ut0.fsf@alter.siamese.dyndns.org> <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com>
 <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Thu May 19 21:19:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN8l2-0002wH-0g
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 21:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933911Ab1ESTTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 15:19:35 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36439 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab1ESTTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 15:19:34 -0400
Received: by pvg12 with SMTP id 12so1327166pvg.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hBIRd/6MS0HxvNsqrYJfDOaLr2irnk5hdC41YeL5BBY=;
        b=ZfvIY1Fqzd7jbzmL20ohe+xy+yNIntDpd0iW6KLEMGLOjItKKh9+nCFfzme71jjjPg
         7js5uZtLmbkFOb7o3Ar2dcfs67lsI0wi3Hn2pCugDhJ+LUlk97I75hGhDGDeyZ2FEZXj
         0y2cjDOgwahvD1oc5OucqHMqzzQrDIVucryLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=km+onBSuAN/hIEuJR6MeS0aRhY6Ijtk2FRKsODBWN0WpuD7ZcxMp7zChD/N9RbypPA
         BwIjPYRjm7x4ND1MdjFBXBMe6PqqHcm3WuXT6jCMq5l3SgmJndes9k3XWM3GE5TR6YKJ
         uv//yuBh/mzZIfw2hXe7DVKGPcqc3mmiix28A=
Received: by 10.68.71.135 with SMTP id v7mr5454512pbu.232.1305832774067; Thu,
 19 May 2011 12:19:34 -0700 (PDT)
Received: by 10.68.64.229 with HTTP; Thu, 19 May 2011 12:19:14 -0700 (PDT)
In-Reply-To: <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173993>

On Thu, May 19, 2011 at 9:16 PM, Rafael Gieschke <rafael@gieschke.de> wrote:
>
> Am 19.05.2011 um 20:07 schrieb Erik Faye-Lund:
>> diff --git a/compat/mingw.h b/compat/mingw.h
>> index 62eccd3..e37d557 100644
>> --- a/compat/mingw.h
>> +++ b/compat/mingw.h
>> @@ -48,6 +48,8 @@ typedef int socklen_t;
>> #define EAFNOSUPPORT WSAEAFNOSUPPORT
>> #define ECONNABORTED WSAECONNABORTED
>>
>> +#define PASS_MAX 512
>> +
>
> It might be worth to have this in git-compat-util.h, so it can also be used by compat/getpass.c. I'm not sure about the name, however; it's a remote password and MAX_PASS is about local passwords AFAIK. Maybe PASS_MAX_REMOTE or something similiar. Like that, compat/getpass.c could also be used in case MAX_PASS has some insanely low value on a platform.
>
>

PASS_MAX should be defined in limits.h (which is included by
git-compat-util.h) on POSIX platforms:
http://pubs.opengroup.org/onlinepubs/007908799/xsh/limits.h.html

If it turns out it's not on some platforms, perhaps a define-guarded
version would make sense in git-compat-util.h instead.
