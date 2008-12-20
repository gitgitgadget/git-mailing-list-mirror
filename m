From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Security] gitweb local privilege escalation (fix)
Date: Sat, 20 Dec 2008 02:54:25 -0800 (PST)
Message-ID: <m3myerce39.fsf@localhost.localdomain>
References: <7vljub1h92.fsf@gitster.siamese.dyndns.org>
	<7vhc4z1gys.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 11:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDzUr-0005YL-LJ
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 11:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbYLTKy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 05:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbYLTKy3
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 05:54:29 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:45873 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYLTKy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 05:54:27 -0500
Received: by ewy10 with SMTP id 10so1469589ewy.13
        for <multiple recipients>; Sat, 20 Dec 2008 02:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ZXRDP8UN9ITFBclckzbVZsan5y+9vOMDQRLKZmGpOvE=;
        b=qZTaQeG1tX2/pH35dUz0LV+0INrgpOPa6bWn/NTlo0GDFjAhsVZHcUQwKKmLVtkNJc
         oWGmaUzTbSpCoDtr6CokdAG51sgnxLUKCvz6rhx7LuoqdWn1pt8UCZUK5BN/ZToUghun
         ohv5P0B5FBZJ/8HiSgTsLYCvciBpXlHJL1Khk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=iDgXu8Fj2mDaPcEeig7BcmMAlnJCO9TixCp0BlOUo5lDDAmyG14WF4FWHM/2ezpSO2
         r2NxGkQFhsK9TkknQZaFvTm+dnEcN56mdYPp1IGvq5HKKq7Mb6eSrf56Kt5riCCM9gAP
         zVLM410Xfi64ph9Mr169nQB/56kjwqFfFab5Q=
Received: by 10.210.119.16 with SMTP id r16mr1270355ebc.143.1229770465628;
        Sat, 20 Dec 2008 02:54:25 -0800 (PST)
Received: from localhost.localdomain (abvm23.neoplus.adsl.tpnet.pl [83.8.210.23])
        by mx.google.com with ESMTPS id 5sm94222eyh.58.2008.12.20.02.54.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Dec 2008 02:54:25 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBKArpwb008184;
	Sat, 20 Dec 2008 11:54:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBKArVoF008177;
	Sat, 20 Dec 2008 11:53:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vhc4z1gys.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103637>

Junio C Hamano <gitster@pobox.com> writes:

> Current gitweb has a possible local privilege escalation bug that allows a
> malicious repository owner to run a command of his choice by specifying
> diff.external configuration variable in his repository and running a
> crafted gitweb query.
> 
> Recent (post 1.4.3) gitweb itself never generates a link that would result
> in such a query, and the safest and cleanest fix to this issue is to
> simply drop the support for it.  Maintenance release v1.6.0.6, v1.5.6.6,
> v1.5.5.6 and v1.5.4.7 are already available at k.org (see the announcement
> for v1.6.0.6 I sent out a few minutes ago), and the master branch and
> others pushed out tonight have the same fix.

>From what I have found diff.external works only since v1.5.4 (see
commit cbe02100), so when gitweb started using git-diff for old
legacy links to not use $tmpdir and /usr/bin/diff -u it wasn't an
issue...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
