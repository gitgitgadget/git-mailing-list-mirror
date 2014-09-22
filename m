From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] archive: support filtering paths with glob
Date: Tue, 23 Sep 2014 06:04:31 +0700
Message-ID: <CACsJy8CwwzOuiL1GMcK9OWZSdSqCpLzVJPyNkHocH10_1VmXSA@mail.gmail.com>
References: <1433062.XhRCATRB3s@al> <1411271706-1151-1-git-send-email-pclouds@gmail.com>
 <xmqq4mvzlb5c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Peter Wu <peter@lekensteyn.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 01:05:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWCfN-0003W3-JL
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 01:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbaIVXFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 19:05:03 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:52675 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbaIVXFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 19:05:02 -0400
Received: by mail-ig0-f178.google.com with SMTP id r10so3649586igi.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PxIcNp3VpWOzUQqhjWHuECjd+rLAtY7wFju4mGxqHH4=;
        b=qhFXVZe4uy6D2l+mS+IqOmvqSOTZrdoRxNz7eu0H6oT0QgHsZyuiezFtKEvT7g2sZX
         HACRtZnK9S8BQz269kwpv8Zg/KE939n3pBf962JYAcDtetfI2nYZJhhC7Tq+JxUCPT08
         KWnj46nhMlAl1iLa97QjLCeuPEuhOTrsX1OM+Oshf5l3o/Wv6t3vvncPBSBLcym3JAdC
         x9Tf8yX9ZEZGnTIHBS/0mbBaumQYZeZXZ+MXiNjMPSP222y/Q8ZioqMS750zRXgyohC7
         AOkPlS5RUlyPZ20KD5cCTZuAfu2iXEGSLiXj1zvw1OTc+CIm3LTV8A5r/BW8QSICbu4p
         701Q==
X-Received: by 10.50.103.106 with SMTP id fv10mr18063117igb.40.1411427101571;
 Mon, 22 Sep 2014 16:05:01 -0700 (PDT)
Received: by 10.107.131.150 with HTTP; Mon, 22 Sep 2014 16:04:31 -0700 (PDT)
In-Reply-To: <xmqq4mvzlb5c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257391>

On Tue, Sep 23, 2014 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> When we have a/b/c and a/d/e to be written, the first round would
> write a/ and then a/b/ with the above, and presumably elsewhere
> somebody will write a/b/c; next time around we do need to write a/d/
> but we wouldn't want to write a/ itself.  How is this code
> preventing the recursion going all the way up every time to avoid
> repeating a/?
>
> Puzzled...

We never traverse 'a' (or any directory) twice and we only push a
directory to the stack when we examine it. After a/b and a are written
down and we examine 'd', 'a/d' is pushed to the stack. When we hit
'a/d/e', we only have 'a/d' in the stack, not 'a'.
-- 
Duy
