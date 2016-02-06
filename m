From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] pack-objects: produce a stable pack when --skip is given
Date: Fri, 5 Feb 2016 16:48:13 -0800
Message-ID: <CAPc5daXmci5TTc0zqKe+izbrQ5XmHd75V=ZKjoWN8hMPTJPSTQ@mail.gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
 <1454662677-15137-3-git-send-email-pclouds@gmail.com> <xmqq1t8rdmky.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CkQPX4zqW39gpODSkU+habM7TGTJ85MU-S0UuNPk9SCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 02:00:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRrEm-0007sr-B4
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 02:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbcBFBAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 20:00:12 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35843 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcBFA7z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 19:59:55 -0500
X-Greylist: delayed 682 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2016 19:59:55 EST
Received: by mail-yw0-f195.google.com with SMTP id b6so2436373ywd.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 16:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YofBSC0nXl9yUKu17sp40WSnUDZuaQW5EHBfCssOaBk=;
        b=rAjgiWnhfraugsLboKofpSeLhu7FkUeUEKMOvlnM+LH+aEj0wSKYN2+BeMc4rheaUl
         4225+m2wVJZuZ0xW0LozzvX7umr5bgARUsrGmdspJx+lgqR0JmtZNW4S+Obwqah9yPUG
         rHa7eDFg0pByTTDxD1rd6jbFjdT/QAFZTNGkEhswSOgC+ZVZ2mbGSbzSFXDNmpVtY9VR
         VPUnrcdu15jh8WGPBP9WxWT5JrXMNUiUKJoA7c2e8AO3LtV+kiL6z0zG2XxfEh9ou7yN
         RY6+TwMJo4KkZhh/1S3Q4Wtk/Wl4tAoT97a+z0Q5sTMcX1sMzrSty0INqwQQtwHuffTF
         4hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=YofBSC0nXl9yUKu17sp40WSnUDZuaQW5EHBfCssOaBk=;
        b=Kl+k8mdxRrDuhOuAMRjBxwdoIh+e6kcDNGWUpE+9S1ZUbkpHwLGYw1A4RjsI0nFQqW
         mwV68S6w4fALjKegj/VTRUUei2bUHIFqtBI5hBz/F8lJ7ur+hZAssEErUEo/8JO6np4s
         EazDrCnK/YRv2Nhqo6hY9D80rLRv4aqzPdjr2aP/jIYCx+NjBQ0vyU6lCaKeXctd9aTB
         DPY99OX5hLsnHJz7tXVuahf8MKm3qPjbmB+mYNYmZOWqnWg3Igf/ApsJGC+XaH6JufGm
         K2O9AhgVFH6pmTRbQaSVUMZc2MbFyE+dKCAnYZ5JBXXyrxA0+k5hkuo3ID+py1fGp3eK
         IY1w==
X-Gm-Message-State: AG10YOTN+/SgXQruZipfpWfafXqqshsfvuog4ubAwlorSP8URX7iPCHvi+15NBCiebvcFihTAmQ0d0YKroFygQ==
X-Received: by 10.129.50.7 with SMTP id y7mr8094648ywy.305.1454719713211; Fri,
 05 Feb 2016 16:48:33 -0800 (PST)
Received: by 10.129.116.131 with HTTP; Fri, 5 Feb 2016 16:48:13 -0800 (PST)
In-Reply-To: <CACsJy8CkQPX4zqW39gpODSkU+habM7TGTJ85MU-S0UuNPk9SCw@mail.gmail.com>
X-Google-Sender-Auth: OzrLhAjj_6GxiPiqkS6pr34AgNU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285661>

> You noticed that tying the behavior only happens when the user asks
> for it, right? I don't expect people to do resumable fetch/clone by
> default. There are tradeoffs to make and they decide it, we offer
> options. So, it does not really tie our hands in the normal case.

You misread me. I do not want to see us having to add
"disable_this_feature = 1" next to that "delta_search_thread = 1"
in this block, and then supporting code to actually disable that
feature, only to support this block. You are declaring that "to
support this mode, we must always have a way to produce a
byte-for-byte identical output and keep supporting it forever".
