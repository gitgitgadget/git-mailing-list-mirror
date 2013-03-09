From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Segfault in git 1.8.1.5
Date: Sat, 09 Mar 2013 22:13:29 +0100
Message-ID: <1362863609.29502.4.camel@localhost>
References: <2078462.OF4zRmv4ar@pablohp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Strasser Pablo <strasserpablo@bluewin.ch>
X-From: git-owner@vger.kernel.org Sat Mar 09 22:14:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UER5c-0005is-M1
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 22:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab3CIVNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 16:13:34 -0500
Received: from mail-we0-f169.google.com ([74.125.82.169]:63605 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab3CIVNe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 16:13:34 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so2397625wey.28
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 13:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version
         :content-transfer-encoding:x-gm-message-state;
        bh=TvULBe1F2RV9cNEknMGZXy7rI1Y12SeIaUsQ73SkBfk=;
        b=X8kkfTUYamVTZa9hTamzP5Uqseln+fh2crFxwfWgPgNf6QeumoHIAHXTijVIHDzHNg
         eszJuwLvkvEHmP9j7oC3oiQU7mA8Fs+hKm7A/Mr4rKNKUai+PEwvjqQ3ZTcghGtpoYsl
         QYKRql5G9azHrl491OeKvOHKywcB+sk/QcyrOkeHjDdEw1xaW8tqkTe7ipEGTDq1Pu+6
         ljrgRHtzfXKhxwRq6r76yjhKslR918b4xHVg9NAogXlJOMNNfbJXYauViciYuzJtZ1dS
         hTFV3cH1MNXQINOzEyf3nS8RDyNVMzKNWj2DrSa5PUri0JAPoQf/gxsRgVQG2gbbJ7op
         NtZw==
X-Received: by 10.180.105.229 with SMTP id gp5mr5088817wib.10.1362863612623;
        Sat, 09 Mar 2013 13:13:32 -0800 (PST)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPS id q2sm7103581wiz.8.2013.03.09.13.13.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 13:13:31 -0800 (PST)
In-Reply-To: <2078462.OF4zRmv4ar@pablohp>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
X-Gm-Message-State: ALoCoQkQfHJxDfePe1c2hZDcKRMYeeu3ZEKaQ/V0AZPosnR4f3Lsgn/D4j58x4qEWSoGc1EnfwSB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217763>

On za, 2013-03-09 at 21:16 +0100, Strasser Pablo wrote:
> Hello,
> 
> I segfault with the following command:
> 
> git checkout HEAD~1
> git branch -u origin/master
> 
> I think it's because i'm in detached head.
> A error message like cannot use this command in would be a better responce 
> than a segfault.

Confirmed.

dennis@lightning:/tmp/hacks$ gdb --args ~/code/git/git branch -u origin/master
(gdb) run
Starting program: /home/dennis/code/git/git branch -u origin/master
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/i386-linux-gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
cmd_branch (argc=0, argv=0xbfffec08, prefix=0x0) at builtin/branch.c:886
886			if (!ref_exists(branch->refname))
(gdb) bt
#0  cmd_branch (argc=0, argv=0xbfffec08, prefix=0x0) at builtin/branch.c:886
#1  0x0804c26c in run_builtin (argv=0xbfffec08, argc=3, p=0x819f3f4 <commands.21695+84>) at git.c:273
#2  handle_internal_command (argc=3, argv=0xbfffec08) at git.c:435
#3  0x0804b656 in run_argv (argv=0xbfffeb74, argcp=0xbfffeb70) at git.c:481
#4  main (argc=3, argv=0xbfffec08) at git.c:556

But it's already been fixed by 8efb889: branch: segfault fixes and
validation. 
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
