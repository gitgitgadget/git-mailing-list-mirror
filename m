From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Thu, 02 Jan 2014 21:48:43 +0100
Message-ID: <52C5D0AB.7050309@gmail.com>
References: <52C5A039.6030408@gmail.com>	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info> <xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:48:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypCL-0006Oa-3u
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbaABUsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:48:53 -0500
Received: from mail-bk0-f48.google.com ([209.85.214.48]:59567 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbaABUsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:48:52 -0500
Received: by mail-bk0-f48.google.com with SMTP id r7so4586711bkg.7
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nb2fjVN7BJLWO9x1bTYk9Mwm/SfjqtwkeyXK7E1Gzbc=;
        b=WYP0rjpXzK/M1LAsrziZgpamwm6GX8FZYhx8fyd4unWZFQWre39sQn0kqxoYL+Lg8Y
         Dnt4+nSPvtyHwrBKqoHCET6af0xyI02kbzGB+R+ovQmWaPnFV/XpLyKFZAHCW3zIHOTp
         BKQ03YmXTnQ7Px8Q1xVw1blnU8Fe04whzZvdgJlLSIghe+NhvO6LeOgWEizSxmYTQl1H
         4nXBSU6DqQWX+jLR7wHO+pFWAoXoHdIjKmDiBwTms00JvZaIakQrwO6o6Ec9coSX1Xca
         0pH2umSVgUWiK3GDUUHzF9Ih/Ci8vNBlTjCoegX7JkqAie1odCZ8SUbyHKNCFZlyJo35
         GGeA==
X-Received: by 10.204.172.145 with SMTP id l17mr26703803bkz.26.1388695731290;
        Thu, 02 Jan 2014 12:48:51 -0800 (PST)
Received: from [192.168.188.20] (p5DDB39A7.dip0.t-ipconnect.de. [93.219.57.167])
        by mx.google.com with ESMTPSA id sx5sm44080779bkb.0.2014.01.02.12.48.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Jan 2014 12:48:50 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239877>

On 02.01.2014 20:55, Junio C Hamano wrote:

> Thanks; the conclusion is correct --- you need a good commit
> message in the recorded history.  That does not have anything to do
> with integrating with pulling from subsystem maintainers, which we
> regularly do.

I'll send a v2 which adds a proper commits message inline.

> Perhaps with s|Linux|POSIX|, but more importantly, was there a
> specific error scenario that triggered this change?

Yes, cloning to a non-existent directory with Windows paths fails like:

fatal: could not create work tree dir 'c:\foo\bar'.: No such file or directory

Seems like the path to clone to is taken as-is from argv in cmd_clone(). So maybe another solution would be to replace all backslashes with forward slashes already there?

-- 
Sebastian Schuberth
