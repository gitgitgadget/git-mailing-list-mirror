From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 2/4] builtin-status: submodule summary support
Date: Fri, 14 Mar 2008 02:01:06 +0800
Message-ID: <46dff0320803131101g62c16db2wf999c851672a8e0@mail.gmail.com>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-2-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-3-git-send-email-pkufranky@gmail.com>
	 <47D935FE.8010107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrkT-00045H-OS
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbYCMSBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbYCMSBJ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:01:09 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:45725 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbYCMSBI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:01:08 -0400
Received: by an-out-0708.google.com with SMTP id d31so842002and.103
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7/2v2/nXj8LEUZsdSqffB8Temy24Oo/KBulNTHuDGu0=;
        b=t2MUZ/29CgLSyfezUHjDfPvglcSUNXTF4m18RN1Tz3wLL7YKVLYpKo+s6autVgI/Kq6xu2CCcB2xW5NeeRLsByDX1pvRMoTmDBwqaPsYle6hKTvRlNhwCockS90KL+K+4/7QtwrkriUZNGmyazFH/2rSECHdMPr5u3kqjp3mqF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cPzmRS7f5DOaBQBCXOCpmCNWWLNWFMrsFYGjf1XlbMUudf6u5HJDt2A6y0Hhss9G//oRWUc6SldQwh8pBvEU0zx2/gQ6Zbo1qpsMOQ/FqBrOF1xbNenF8dCTvti9ajfIOAM2EXoR4D4jVdp1KfKs/6+QM55vowXwXJ4umVtKzZY=
Received: by 10.100.91.17 with SMTP id o17mr20147097anb.62.1205431266878;
        Thu, 13 Mar 2008 11:01:06 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Thu, 13 Mar 2008 11:01:06 -0700 (PDT)
In-Reply-To: <47D935FE.8010107@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77119>

On Thu, Mar 13, 2008 at 10:11 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Ping Yin schrieb:
>
>  >       wt_status_print_changed(s);
>  > +     // must flush s->fp since following call will write to s->fp in a child process
>  > +     fflush(s->fp);
>  > +     wt_status_print_submodule_summary(s);
>  >       wt_status_print_untracked(s);
>
>  But then we don't need the fflush() here. Right?
>
You are right.

diff --git a/wt-status.c b/wt-status.c
index 2f47e36..468c14c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -352,8 +352,6 @@ void wt_status_print(struct wt_status *s)
        }

        wt_status_print_changed(s);
-       // must flush s->fp since following call will write to s->fp
in a child process
-       fflush(s->fp);
        wt_status_print_submodule_summary(s);
        wt_status_print_untracked(s)


-- 
Ping Yin
