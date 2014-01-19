From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Sun, 19 Jan 2014 08:00:02 +0100
Message-ID: <CAHGBnuMDyxapRdfRN2PuHE5ULeGUft7J-EroXcxjpzzn3Kpi7Q@mail.gmail.com>
References: <52C5A039.6030408@gmail.com>
	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
	<xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
	<52C5D0AB.7050309@gmail.com>
	<xmqqha9mozvc.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1401022212150.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 19 08:00:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4mN5-0007m3-Mo
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 08:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbaASHAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 02:00:06 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:65227 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbaASHAE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 02:00:04 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so4942923qcy.26
        for <git@vger.kernel.org>; Sat, 18 Jan 2014 23:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fyFy61/S3q7xQrACocftOqfV1OW0KboRrDgHxdiF/kk=;
        b=vUhGOtpN2f7EfAr4FsCgT8NTuiYxQkhE+LzPhq72yUBMbo6m+rBMGPR/MJeSl+gNyP
         MD1ltJ0/Pz7fzE3u+pnJA0NoNxWUakA4OFTHXmOM8w0u5UioeVKd/zzxMBqRRa+q/hfB
         UPQGJ4ypzp7+38aKu55olFRwalE3jfQE3fFi4nL9Ua6HXFgxLiw+7z11eldGwKCqczw1
         NrupYJIS+REr/io9lDcetCtJMUEgFYEeRz03DOEflTSPGlUc/oBC8yDaqon01m/xIKD/
         9RhwFenHLp88MrAYYRUQ32ZUOhqo/HywfakKzGC0Gz0PxIRkqXt6OC1+jXdbR48073i2
         FB0w==
X-Received: by 10.140.48.172 with SMTP id o41mr16916007qga.16.1390114802678;
 Sat, 18 Jan 2014 23:00:02 -0800 (PST)
Received: by 10.96.22.229 with HTTP; Sat, 18 Jan 2014 23:00:02 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1401022212150.1191@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240672>

On Thu, Jan 2, 2014 at 10:19 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> and parsed to be stuffed into trees), it is fine to do so as long as all
>> the codepaths understands the new world order, but my earlier "git grep"
>> hits did not tell me that such a change is warranted.
>
> You call safe_create_leading_directories() with an argument that is
> supposed to be the final path, correct? So what exactly is wrong with
> safe_create_leading_directories() creating all the directories necessary
> so that we can write to the path afterwards, *even* if that path is
> interpreted in a platform-dependent manner (as one would actually expect
> it to)?
>
> Last time I checked we did not make a fuss about
> safe_create_leading_directories() interpreting the argument in a
> case-insensitive fashion on certain setups, either. So it is not exactly a
> new thing that the paths are interpreted in a platform-dependent manner.

Sorry for the late reply. I just want to add that on top of that, I
would expect any function called *safe*_create_leading_directories()
in a cross-platform project like Git (yes, effectively Git has become
a cross-platform project by now) to gracefully handle
platform-specific input. In other words, I would expect the word
"safe" to be applied not only to the output (the creation of the
directory hierarchy with any missing parent directories) but also to
the input (the arguments to the function).

-- 
Sebastian Schuberth
