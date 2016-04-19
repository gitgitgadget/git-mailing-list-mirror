From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 06/15] index-helper: add --detach
Date: Wed, 20 Apr 2016 06:50:54 +0700
Message-ID: <CACsJy8Bcb=-V0wc8En2SCSz8jPefEL4qibxJsLsTB-c94x9y3Q@mail.gmail.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com> <1461108489-29376-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:51:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asfQY-0005Ht-1U
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbcDSXv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:51:26 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:32812 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbcDSXvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:51:25 -0400
Received: by mail-lf0-f47.google.com with SMTP id e190so31166004lfe.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T5KJyIUsY5Hlb3OqDXwncUJZy/Zc3N/wIuPGzBLlJV0=;
        b=Y59vsX3qkYqSss8SYFuFGFwp8vALLqE3qSMO1P+3amimMYa3RRHUsblWFWHmCViBkq
         T0iVyyUOixcFHMQqtPKRX8Ld56B0INvAPHWFwLyhSysI6GqMROl2KOW8YOIVBXoFmlUy
         pCGJEMp6cB8U1FIPAtS5OWVrD4uoAyz9hGuPoNvahcgcQRKGsr0Pmv6yUhTK7LsEIp/V
         fv0IluQhRDXfkvekyz/WbqWjo5XqqsDpCLAH++Hj2/Nc5aAfPKvZ1lYUa7D4ToG96OEm
         RxHgaSet1icZEBhBkFjzrlRWg+DCPibTjpbj51yfaJ0GoiKpNIC01wf+31LJJL+yvIU8
         d7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T5KJyIUsY5Hlb3OqDXwncUJZy/Zc3N/wIuPGzBLlJV0=;
        b=TAmTgcL2Jg1B3nC2zX79HRs8xVXyThbHk8yh7PuGjXciNaE2jl9LYxMbzcay/R4onP
         U/+iJfXLrZgpR/d+7PJ8I5XYqdbyGT2LJilJQfR+iaY+neTgLIGUJjC/SFJVfU1yC+w4
         W0L8O8Sperhzl90RerQtok+8kQm7jGlGIolw/vpzMSA8fssab4vWsXTqXw0GgEoYKtt7
         GbupAJCBBWWRNDWAzbP6mQIwAFg0Diy98R2v66WpfWhpm63hM5qRkJq0KpCMDMejrSL8
         pxbNtN95G/hQXidMyfSU/31aA8DB/ptmphdbkXKbbzYOcyCO5C58LNkYYsxe/74W/mH4
         sHbQ==
X-Gm-Message-State: AOPr4FWf9PXSEkokpXgOcIxamGU5bRQYBAbwekQ3NRKaQvkJWbAgv0DXbeuFbT1dwzwIUlQAB916tt66sXeeNg==
X-Received: by 10.25.162.198 with SMTP id l189mr2318656lfe.162.1461109883591;
 Tue, 19 Apr 2016 16:51:23 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 19 Apr 2016 16:50:54 -0700 (PDT)
In-Reply-To: <1461108489-29376-7-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291970>

On Wed, Apr 20, 2016 at 6:28 AM, David Turner <dturner@twopensource.com> wrote:
> @@ -317,6 +320,8 @@ int main(int argc, char **argv)
>         if (fd < 0)
>                 die_errno(_("could not set up index-helper socket"));
>
> +       if (detach && daemonize(&daemonized))
> +               die_errno(_("unable to detach"));

At the least, I think we need to redirect both stdout and stderr to a
file, so we can catch errors. The watchman patch uses warning() to
report errors, for example. And there is always a chance of die().

Then we need to report the errors back. I faced the same problem with
daemonizing git-gc, but I'm not sure if we can do exactly the same
here like in commit 329e6e8 (gc: save log from daemonized gc --auto
and print it next time - 2015-09-19)
-- 
Duy
