From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 12/16] refs: always handle non-normal refs in files
 backend
Date: Wed, 06 Jan 2016 18:42:29 -0500
Organization: Twitter
Message-ID: <1452123749.3892.114.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-13-git-send-email-dturner@twopensource.com>
	 <567A5516.9070209@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 00:42:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGxiy-0003G6-1p
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 00:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbcAFXmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 18:42:35 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:32902 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbcAFXmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 18:42:31 -0500
Received: by mail-qg0-f43.google.com with SMTP id b35so185773619qge.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 15:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=t1aP9peK/bxEP9NkSjMx+NKMlA8jbBCurTaoPYArsjY=;
        b=jVWaZYZD2BRLWH+EuoqJaHe/IiEbpaZIZF9ytMQUwPO53eeuThGmzNofgv7l49zSRi
         hxfvKTxzARcpHWz9gJ/8pvynKTOQRcVnHYfAeORVI8Y/npqvaeBXfYhSHgQ1192aMwVs
         buuBiynW0oH6QosmOkslKm88QizEqMkomuU7fIzsyQaricuy0tv9fogLliQWGwohne99
         Iq3Op2a3MvtXYT5vi1MT3WVdfLIuhpBrqbtDtTgIwmss/KE9dSq1IKVL6aPicl17XUmM
         4aF5TM2vk7obL2APxNpOWlR1d/NIVnrnzMN2qUC/xGcI941E/YaML7ngXEilfUEYCATE
         4LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=t1aP9peK/bxEP9NkSjMx+NKMlA8jbBCurTaoPYArsjY=;
        b=YKYNJhAvWKy78xPqSHXVDSP6G2BgJD1rUm+EKxb3nropYFkcyi967xCuCpvt32/LKh
         +Drd3+ulv3iU6IxpxQjfqi4IwPvUdu59iVaNSab2izdH30Re+7TeJJ1LDxmyPFVd5rEK
         D1wCmRxi6HVVcQLu0V+05UMDYKo3quvABypa9GFwSKIZIzj+pSzYDFTsYb8/0uRYbIYT
         /TtnRtR5CKi9eFY3/sDf+kPOBQeRU6haAQK47uQ8H2Fsh0mjyx7vjLNLSvpX+Z8zghtL
         EuJnC/0hz5aE+bU7P8B+DdtGWYY62ItpnRI4pOfUZSsnj/rBHEOCUpVhpCaBpB8lO4Pr
         d4xQ==
X-Gm-Message-State: ALoCoQlrkv96uBTOr/nTurrkqxduPi3tnyjZSFSG26mn0uxn07jBurvZ06rWdoEy6yMijKGN6X35bO1wcvRiBDnd2gb3BzysTw==
X-Received: by 10.140.105.36 with SMTP id b33mr134310280qgf.94.1452123750945;
        Wed, 06 Jan 2016 15:42:30 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c2sm45417160qkb.41.2016.01.06.15.42.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jan 2016 15:42:30 -0800 (PST)
In-Reply-To: <567A5516.9070209@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283461>

On Wed, 2015-12-23 at 09:02 +0100, Michael Haggerty wrote:
> I very much like the idea of introducing special handling for
> symbolic
> reference updates within a transaction. In fact, I think I would go
> even
> farther:
> 
> Let's take the example of an update to HEAD, which currently points
> at
> refs/heads/master. I think it would *always* be a good idea (i.e.,
> even
> when only the files backend is in use) to split that ref_update into
> two
> ref_updates:
> 
> 1. One to update refs/heads/master and add a reflog entry for that
>    reference.
> 
> 2. One to add a reflog entry for HEAD (i.e. using the new
> REF_LOG_ONLY
>    flag suggested above).

Having now implemented this, I think it's ugly.

While committing a ref_update, we read the ref's old value.  We need
this value for two things: 1. confirming that it matches old_sha1 in
the ref_update and 2. writing to the reflog.  In the case of a symbolic
ref, we need to resolve it in order to get its old value.  But we've
already resolved it during the splitting step (in order to know that it
was a symbolic ref).  So we're duplicating effort.  We can store the
resolved SHA from the split phase (along with the resolved ref type),
but that's just leaking more weird details.  

In addition, this doesn't actually solve the problem that this patch is
intended to solve; I still have to split refs into normal and non
-normal (files-backend).  It's true that this splitting is simplified,
since we don't need to do weird things for the reflogs, but I'm not
sure it's a net win.

I'm going to send just these patches in reply to your mail (I hope),
and see what you think before continuing down this path.  
