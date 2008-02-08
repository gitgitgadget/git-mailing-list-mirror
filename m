From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 14:26:20 -0500
Message-ID: <9e4733910802081126r5bf19c95rec817a1b6648ee4d@mail.gmail.com>
References: <200802081828.43849.kendy@suse.cz>
	 <m3ejbngtnn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jan Holesovsky" <kendy@suse.cz>, git@vger.kernel.org,
	gitster@pobox.com
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 20:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNYsC-0002fI-SM
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 20:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbYBHT0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 14:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbYBHT0W
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 14:26:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:36191 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYBHT0V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 14:26:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so607118wah.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 11:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZdGqESrcMcJIIhRYCQy3oknB/DB7j9jDyWsojjWNZr4=;
        b=dJPbkwdgwERRd1fOU1UrFjQttdcvzjn1BmvimvG6xchVcaMg88CgXhJg8ImCRCLaploji3cTZWhJer7xyPTl5nYfHjded1EKo9oEY/ptm4XPjvqTFsnlT4U1lGMs0OXEUGfdfZr+gylbiGfUC5Tj+7kHuHOu2FiUsRwEc7Yj/60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W6DG66FNZsOM94cOpImgmA91e/DYCXPLi/DXztpBo1RK++KHxzj1aXhLKd+eU3EvKz1Y6TsSzZobEnkCDSbpT1vk50NvALL/hSX6u6g4hyD1RMz79soR/mQDq1t/p13iTq0mnMPDEdaEp7T886YGG3bPOQp+dAJhQK2qGDhqPOo=
Received: by 10.114.152.17 with SMTP id z17mr7522748wad.128.1202498780592;
        Fri, 08 Feb 2008 11:26:20 -0800 (PST)
Received: by 10.114.200.7 with HTTP; Fri, 8 Feb 2008 11:26:20 -0800 (PST)
In-Reply-To: <m3ejbngtnn.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73126>

On 2/8/08, Jakub Narebski <jnareb@gmail.com> wrote:
> Jan Holesovsky <kendy@suse.cz> writes:
> One of the reasons why 'lazy clone' was not implemented was the fact
> that by using large enough window, and larger than default delta
> length you can repack "archive pack" (and keep it from trying to
> repack using .keep files, see git-config(1)) much tighter than with
> default (time and CPU conserving) options, and much, much tighter than
> pack which is result of fast-import driven import.
>
> Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
> you would need machine with large amount of memory to repack it
> tightly in sensible time!

A lot of memory is 2-4GB. Without this much memory you will trigger
swapping and the pack process will finish in about a month. Note that
only one machine needs to have this kind of memory. It can be used to
make the optimized pack of the project history and mark it with .keep
files. It doesn't take a lot of memory to use the optimized packs,
only to make them.

There are some patches for making repack work multi-core. Not sure if
they made it into the main git tree yet. These patches work almost
linearly. A eight hour repack will take 2.5 hours on a quad core
machine.

There is very good chance your 1.5GB repo will turn into 300MB if it
is extremely packed. This is something you only need to do once, but
you'll probably end up doing it a dozen times trying to get it just
right.

-- 
Jon Smirl
jonsmirl@gmail.com
