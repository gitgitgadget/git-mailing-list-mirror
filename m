From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between
 shorthand names and full refnames
Date: Wed, 15 May 2013 15:53:52 +0200
Message-ID: <CALKQrgdroLDSf=Xc58NiHSf7fp8cRMbrR0mGrfKY7Rg0FpPFJg@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-4-git-send-email-johan@herland.net>
	<7vmwrzsck1.fsf@alter.siamese.dyndns.org>
	<CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
	<7v8v3jqsy7.fsf@alter.siamese.dyndns.org>
	<7vwqr2liv6.fsf@alter.siamese.dyndns.org>
	<CALKQrgcDBMPeXPzTnpGyeosipR6Ln_zLh4Q_i1A7-eFUnTnBcA@mail.gmail.com>
	<51932F1B.9000200@alum.mit.edu>
	<CALKQrgdsBzcdtyej=qvaL-2rr-5t_UzXdOL-ZZ3a-rGW5V_i7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com, normalperson@yhbt.net
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 15 15:54:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucc9a-00060O-SU
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 15:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758976Ab3EONx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 09:53:59 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:50193 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666Ab3EONx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 09:53:58 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ucc9U-000DKV-Fw
	for git@vger.kernel.org; Wed, 15 May 2013 15:53:56 +0200
Received: from mail-oa0-f42.google.com ([209.85.219.42])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UcZvw-000MNr-Sn
	for git@vger.kernel.org; Wed, 15 May 2013 13:31:49 +0200
Received: by mail-oa0-f42.google.com with SMTP id i10so2201017oag.15
        for <git@vger.kernel.org>; Wed, 15 May 2013 06:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=M4a9omz5JwROgDSKJ4DgX45KDZW+UrASTNK6G3MLTsQ=;
        b=DqtXWJpt0MEx4vSOkbIzyWuWyGcQzz2CP1To5bDCqZHS4Wuqe3z1DUJhoFYOJ93nDG
         74Q+MqWM0qqnOZm/DrD71v8MCf1VuKCMUtoT+O+RbnUdtveiMJF0hk2Kn+3kqB5vIAUz
         CEAUA9L3X3e3wuXkMjl+Sx2rIDHHCH/f8oEiA1bpKF1VBDi8QvW7fHRIA7plNIfZBCgl
         jB+AT4DaWaR6kLU5LYCYv4rzPOWyGAzTbRu4G05iIQFdF6vAYDEX5Os/aTCV7NrCBVWH
         ZaLatPftfL6PgpTAA5MawVHLojZhiDB/HXQa6bQ4IJ5rtMgxZS7+Dl/P8Q4xQSbCPXkO
         THSw==
X-Received: by 10.60.80.197 with SMTP id t5mr16533685oex.1.1368626032539; Wed,
 15 May 2013 06:53:52 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Wed, 15 May 2013 06:53:52 -0700 (PDT)
In-Reply-To: <CALKQrgdsBzcdtyej=qvaL-2rr-5t_UzXdOL-ZZ3a-rGW5V_i7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224408>

On Wed, May 15, 2013 at 9:39 AM, Johan Herland <johan@herland.net> wrote:
> On Wed, May 15, 2013 at 8:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> "refs/remotes/%1/%2" (or "refs/remotes/%1/%*") might be a nice way to
>> imply that the rule should only be attempted if the input has at least
>> two components, whereas something like "refs/heads/%*" would be applied
>> even for inputs with no slashes.
>
> /me likes, at least for "refs/remotes/%1/%*".

Unfortunately, using "refs/remotes/%1/%*" instead of "refs/remotes/%*"
breaks a number of git-svn tests which puts refs directly within
refs/remotes/, and then does things like "git reset --hard trunk"
(expecting trunk -> refs/remotes/trunk, which the refs/remotes/%1/%*
doesn't match).

I don't know if putting refs directly within refs/remotes/ is
something that git-svn does by default (which would prevent us from
changing "refs/remotes/%*" to "refs/remotes/%1/%*"), or whether it is
specific to the tests (in which case we should fix the tests).

Also, there might be too many other users of refs directly within
refs/remotes/ that expect "foo_without_slash" to expand to
"refs/remotes/foo_without_slash", which would prevent us from doing
this change.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
