From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Mon, 16 Jan 2012 22:18:39 +0100
Message-ID: <CABPQNSYjYUWdOm2uK5au_gBi8eYmo5q0e1g52nZoRqrC2TF9TA@mail.gmail.com>
References: <loom.20120112T193624-86@post.gmane.org> <4F1028AD.9080701@ira.uka.de>
 <4F106DDF.4040408@unclassified.de> <4F1085EC.9010708@ira.uka.de>
 <4F128AD0.5020101@unclassified.de> <4F1404E7.9040805@ira.uka.de> <4F14718B.80209@unclassified.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 22:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmtxd-0003QE-GL
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 22:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab2APVTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 16:19:21 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60787 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab2APVTU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 16:19:20 -0500
Received: by pbaa10 with SMTP id a10so784785pba.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Buydy2E28GpBm96v18m/+0vyrRYSLtNidL2tDRXOEcY=;
        b=QSGxCf/GrCyS+ntRThfXyqfwn7X2kx9+28WAtWP8J2t2gLnOm7WbpE4usSDREPwr6Q
         OPpay44zIA83NpS5I2VfcQZRYH3vlgCdX07WZr3O4NCy6/o7eyyvRwgM5HD2Z8EMdH4d
         L24GSyVFT98Opp3gOv/PrlCiu8JH9r1b346PE=
Received: by 10.68.75.136 with SMTP id c8mr29124662pbw.113.1326748760174; Mon,
 16 Jan 2012 13:19:20 -0800 (PST)
Received: by 10.68.83.73 with HTTP; Mon, 16 Jan 2012 13:18:39 -0800 (PST)
In-Reply-To: <4F14718B.80209@unclassified.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188654>

On Mon, Jan 16, 2012 at 7:50 PM, Yves Goergen
<nospam.list@unclassified.de> wrote:
> It's getting more weird. I believe that (msys)Git doesn't really know
> how the filesystem on its operating system works.

Git for Windows know how the file-system works, and tries to prevent
you from shooting yourself in the leg by being case-insensitive when
matching the index and the working copy. But there is an opt-out for
this, which is controlled by the configuration option core.ignorecase,
which Peff already asked about. This option is supposed to be enabled
by default on Windows.

What you are describing sounds like that option might have gotten
disabled somehow. But it might be something else, see below.

> I have made some more
> changes now and want to commit them. TortoiseGit reports the files
> Form1.Designer.cs and Form1.designer.cs (note the case difference) as
> modified and ready to commit. How is that supposed to work?

Very speculative comment: This might be a bug in TortoiseGit. Looking
at the sources, it seems they are using libgit2 to mess around with
the index; perhaps it's case-sensitivity code isn't as well tested as
Git for Windows'?

For instance, they do their own index and tree sorting, in an attempt
to be case sensitive:

http://code.google.com/p/tortoisegit/source/diff?spec=svnf151c0ddf205fa1fc1ff886b8cfc4af87d373b26&r=f151c0ddf205fa1fc1ff886b8cfc4af87d373b26&format=side&path=/src/Git/GitIndex.cpp
