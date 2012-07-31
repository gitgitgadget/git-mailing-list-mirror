From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Tue, 31 Jul 2012 21:31:16 +0200
Message-ID: <2351904.F5IazNUWoD@flomedio>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <19477122.a5lMBqWgns@flomedio> <20120730165502.GB8515@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 21:31:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwIAU-0006oD-8l
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 21:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab2GaTbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 15:31:24 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58456 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab2GaTbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 15:31:21 -0400
Received: by bkwj10 with SMTP id j10so3449217bkw.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=+ahaTBEY/jkA/aTwP97E2IYs47zsOWPwvo4SC/8GN8w=;
        b=Zohjh9Oszn5sWuN+YHn1EULblYSz0VeQ7nl92Y0qIzJ9BMd+sNuMrtTDIYMr4gJMI1
         vuLaeqABupG1PBpHNroBtYw9bxeRnWH+u3RWFgyYhFDSPEtS+knn3aLvHO4QXobOE44g
         5gdZS4vaKpZWNOp6mNn5yx9/jXyqXCad+F2DrZwzZuixmXDfrSfyqFxmcIqYXvWBhI3L
         kO93ki+y75a7HnMuM+p4UCrltqEoO1kMy8kNt446+TRLoMjVUkKLwCT1qiJfzU6uSIh/
         SoZy2ERTCxj5xHk8pBk9Lu9bU3bUqdWsuoO/SEP/BUlfoFg8NlJCJXLB0gTVmiTgc9+j
         X0Lg==
Received: by 10.204.132.77 with SMTP id a13mr5690756bkt.99.1343763080078;
        Tue, 31 Jul 2012 12:31:20 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id 14sm597858bkw.15.2012.07.31.12.31.18
        (version=SSLv3 cipher=OTHER);
        Tue, 31 Jul 2012 12:31:19 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120730165502.GB8515@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202675>

On Monday 30 July 2012 11:55:02 Jonathan Nieder wrote:
> Florian Achleitner wrote:
> > Hm .. that would mean, that both fast-import and git (transport-helper)
> > would write to the remote-helper's stdin, right?
> 
> Yes, first git writes the list of refs to import, and then fast-import
> writes feedback during the import.  Is that a problem?

I haven't tried that yet, nor do I remember anything where I've already seen 
two processes writing to the same pipe.
At least it sounds cumbersome to me. Processes' lifetimes overlap, so buffering 
and flushing could mix data.
We have to use it for both purposes interchangably  because there can be more 
than one import command to the remote-helper, of course.

Will try that in test-program..
