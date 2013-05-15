From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between
 shorthand names and full refnames
Date: Wed, 15 May 2013 09:39:55 +0200
Message-ID: <CALKQrgdsBzcdtyej=qvaL-2rr-5t_UzXdOL-ZZ3a-rGW5V_i7Q@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-4-git-send-email-johan@herland.net>
	<7vmwrzsck1.fsf@alter.siamese.dyndns.org>
	<CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
	<7v8v3jqsy7.fsf@alter.siamese.dyndns.org>
	<7vwqr2liv6.fsf@alter.siamese.dyndns.org>
	<CALKQrgcDBMPeXPzTnpGyeosipR6Ln_zLh4Q_i1A7-eFUnTnBcA@mail.gmail.com>
	<51932F1B.9000200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 15 09:40:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcWJk-00024g-R3
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 09:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960Ab3EOHkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 03:40:04 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:57396 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721Ab3EOHkB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 03:40:01 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UcWJb-0009ZW-Fi
	for git@vger.kernel.org; Wed, 15 May 2013 09:39:59 +0200
Received: from mail-oa0-f50.google.com ([209.85.219.50])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UcU64-0009Vz-DW
	for git@vger.kernel.org; Wed, 15 May 2013 07:17:52 +0200
Received: by mail-oa0-f50.google.com with SMTP id l20so1739854oag.23
        for <git@vger.kernel.org>; Wed, 15 May 2013 00:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MJEqkikV87U/QC5hFcfHeCLWwxBJcTJJbavSacYxjnA=;
        b=T1B/wgPoMjvzE6OWGqhl8wEMYKP9sVO2vqRxcaC7Ff0Jwtwdp0tYNWafVXtD8rvB5T
         pUpZ3l/VvmVfMm1JHIfrjlO5MLx825q5+zWVSEHSB0kbD/w2ec9ALAx0pyouCavFOaL4
         HSGs3jV9OSLdOYGcQ8VnLBO1MzYe3vFXbMJKB8j89ig1DfD5SJURbGCZg1ooLBrH8MDj
         MLpJGuOtY8Ed3/HKgwKOHqjt2a/dRXihhOVGw4SVtke8uLFIlBMUN2+aSlZTunFuNyF1
         RfiICgdT9OcspAx/scGL1HFJqlafMBwe4sPdFZgjcGYcu+cTrddtvb2nIHakoWe1dXPc
         jm1Q==
X-Received: by 10.182.137.196 with SMTP id qk4mr2640656obb.53.1368603595736;
 Wed, 15 May 2013 00:39:55 -0700 (PDT)
Received: by 10.182.113.66 with HTTP; Wed, 15 May 2013 00:39:55 -0700 (PDT)
In-Reply-To: <51932F1B.9000200@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224390>

On Wed, May 15, 2013 at 8:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/14/2013 04:24 PM, Johan Herland wrote:
>> I am not sure why we would want "refs/remotes/%1/%2" instead of
>> "refs/remote/%*". Maybe I've been staring at this for too long, but I
>> find the latter shorter and more descriptive and the "%1/%2" notation
>> needlessly cumbersome, especially if it's also supposed to match
>> "foo/bar/baz"
>
> "refs/remotes/%1/%2" (or "refs/remotes/%1/%*") might be a nice way to
> imply that the rule should only be attempted if the input has at least
> two components, whereas something like "refs/heads/%*" would be applied
> even for inputs with no slashes.

/me likes, at least for "refs/remotes/%1/%*".

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
