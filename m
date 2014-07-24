From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Fri, 25 Jul 2014 00:03:44 +0530
Message-ID: <53D15188.2010209@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>	<vpqlhrjqmyw.fsf@anie.imag.fr> <xmqqiommadl0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:33:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XANpz-0002bx-8V
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 20:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934200AbaGXSdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 14:33:51 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50873 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbaGXSdu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 14:33:50 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so4467024pac.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vuW7MZhZMKgRHdyih+hqcBDPYZ+yiNuVEqazAGBTZZc=;
        b=XjUsMG8InfpR1NYMDxtNzi/e6mBW1NnzIgxukpvueaCtb/KAQAO/CpYbqn6EUDabub
         GgNU+qPJ1+cvxHeNg3ycXcmdyUKFf8jrYPh0Wnzc6PphNsh7qVMJxBbYVLJpDhD8QOH8
         7ti2Rz6DLnSra5bdulvj53m7DZwiSYovHGFjunBFf/QkdFzg6OwFEBGLsOsmIDKgNqIc
         YQEKy1noULAjljnQPgkJ/8YuKHMkGh+omfPJeKZ5YzGhAm6N8CLwcWLtXjy2twPqwwZO
         jchtKpxV2end983RIdKiIRMLrGmRhKLcbHzHtkTNN7/ym18P7NWXB8DM7ROhJTJfduYU
         nu5g==
X-Received: by 10.68.132.42 with SMTP id or10mr12867029pbb.80.1406226829918;
        Thu, 24 Jul 2014 11:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([117.96.50.136])
        by mx.google.com with ESMTPSA id pz10sm6331876pbb.33.2014.07.24.11.33.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 11:33:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqiommadl0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254174>


> 
> I haven't formed a firm opinion whether preserving the order is
> necessary at git_config() iteration level yet.  If the only in-core
> user that will be broken by not doing so is xfuncname vs funcname,
> it may not be too bad, but it will constrain us in the future, which
> is a lot bigger problem.

If we give users a choice between two methods git_config_raw() &
git_config_cache(), it would give us a easy fallback if we want
to do something like support xfuncname and funcname for performing
the same function differently.

For core the only test failing was xfuncname vs funcname,
so the situation is not as bad as you think. One course of action
would be leave git_config() as it is, so that third party apps
may not be broken. Provide a function like git_config_cache(),
then rename all the git_config() calls in core to git_config_cache(),
fallback to git_config() where it is not applicable (for example,
git config -l). I haven't thought a lot about it and I haven't
heard Matthieu's opinion about it yet.

Also can you name any third party apps that use the git_config()
system on which I can test the patches. I have seen gitk and gitgui
using the config files to save data.

Cheers,
Tanay Abhra.

  We will be forbidden from correcting a UI
> mistake by using the approach we took to transtion "funcname" over
> to "xfuncname" (i.e. giving users "funcname" and allowing the
> platform BRE parser that may or may not allow the users to write
> backslashed ERE is spreading possible incompatibility among the
> participants of a project; explicitly stating that the value is ERE
> has fewer compatibility issues), while still supporting "funcname"
> and have them interact in a sane way.
> 
