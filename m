From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2] contrib: added git-diffall
Date: Thu, 23 Feb 2012 10:56:21 +0100
Message-ID: <4F460D45.7000804@gmail.com>
References: <1329948749-5908-1-git-send-email-tim.henigan@gmail.com> <7vipiy8m5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org,
	davvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 10:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0VPb-0001LE-KX
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 10:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab2BWJ41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 04:56:27 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41372 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2BWJ40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 04:56:26 -0500
Received: by bkcjm19 with SMTP id jm19so847546bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 01:56:25 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.204.156.219 as permitted sender) client-ip=10.204.156.219;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.204.156.219 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.204.156.219])
        by 10.204.156.219 with SMTP id y27mr298320bkw.110.1329990985271 (num_hops = 1);
        Thu, 23 Feb 2012 01:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=YCTdw02q6HgzwQOz5i5++95CRTfQsLaVwXwDBe5ycyo=;
        b=B/dSwpnpLcampOWYmHEk1rluMmWM/6JUUXTfxzcqMDRC5aTFj7eIlva5jyM4GNg7DO
         6gx6pI8FjvzT66U4Zu2sVd9QEX7q7sSBQoibX4p7vgzPJ+fXia95pCr+CukwPDSCEp8P
         geVgSY41t26jTg7yTJOSbH+qrUNpm4xpALFJE=
Received: by 10.204.156.219 with SMTP id y27mr250144bkw.110.1329990985197;
        Thu, 23 Feb 2012 01:56:25 -0800 (PST)
Received: from [80.116.81.101] (host101-81-dynamic.116-80-r.retail.telecomitalia.it. [80.116.81.101])
        by mx.google.com with ESMTPS id e13sm1580450bku.12.2012.02.23.01.56.22
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 01:56:23 -0800 (PST)
In-Reply-To: <7vipiy8m5q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191343>

Hello everybody.  Hope you don't mind 2 cents from an outsider ...

On 02/23/2012 12:48 AM, Junio C Hamano wrote:
>
> Tim Henigan <tim.henigan@gmail.com> writes:
> 
>> +# mktemp is not available on all platforms (missing from msysgit)
>> +# Use a hard-coded tmp dir if it is not available
>> +tmp="$(mktemp -d -t tmp.XXXXXX 2>/dev/null)" || {
>> +	tmp=/tmp/git-diffall-tmp
>> +}
> 
> It would not withstand malicious attacks, but doing
> 
> 	tmp=/tmp/git-diffall-tmp.$$
> 
> would at least protect you from accidental name crashes better in the
> fallback codepath.
>
Maybe this would be enough to withstand malicious attacks (even if not
denial-of-service attacks):

  # mktemp is not available on all platforms (missing from msysgit)
   tmp=$(mktemp -d -t tmp.XXXXXX 2>/dev/null) || {
       tmp=/tmp/git-diffall-tmp.$$
       mkdir "$tmp" || fatal "couldn't create temporary directory"
  }

> 
>> +mkdir -p "$tmp"
>
At which point this should be removed, of course.

Regards,
  Stefano
