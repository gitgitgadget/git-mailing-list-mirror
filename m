From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Sun, 17 Aug 2008 21:30:46 +0100
Message-ID: <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com>
References: <20080808211318.GA4396@efreet.light.src>
	 <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com>
	 <20080817195839.GB4542@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Aug 17 22:31:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUoul-0007oH-3a
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbYHQUas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbYHQUas
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:30:48 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:62796 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbYHQUar (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:30:47 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2692989wfd.4
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KmWATFX5lweO2N5cINKR4cvqGlr8BSb93uqVrzUYwn0=;
        b=lzjl3dvjS7DxWDsr/VUqHOYSeZGV9xnB9tI0CKxYvDt2e2MtAHQ7K2hBd2edd1q3Pu
         ViS08uZCdgFEWvM4cpn5/xQiDKUnfaQwU/5A+mJAZKGUaK5Q0eMpzB4v0pJKj8itXCao
         TCMNLYYW8ltl6j9A/CRKf/rhKgvoLdo06JqKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MmGgcg32dX8Lpqs7oUJ1qAaeS+T32BPFplCB9ACvg5acKa9tuUa08VPSgjjKqDdjAP
         RkadIC4k4PIxPJjA/o9zFWqD7d2U6q/X8c4l9w3LFgkM5XdN03J/ppHw31P+WbBplC7Q
         QlfwQRbEv7IOWXRyDcmydp9Jp41eS+vVqegv0=
Received: by 10.114.133.1 with SMTP id g1mr4396992wad.149.1219005046861;
        Sun, 17 Aug 2008 13:30:46 -0700 (PDT)
Received: by 10.114.174.5 with HTTP; Sun, 17 Aug 2008 13:30:46 -0700 (PDT)
In-Reply-To: <20080817195839.GB4542@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92627>

On Sun, Aug 17, 2008 at 8:58 PM, Jan Hudec <bulb@ucw.cz> wrote:
>
> But as I said, I only have basic infrastructure and am currently looking at
> what to write tests for and how exactly that test should work. The detection
> of git vs. stgit branch (does not work for me)

This sounds as a bug. Could you elaborate on that please ?


BTW the test for a StGit repo is:

isStGIT = run("stg branch", &stgCurBranch); // slow command

in function Git::getRefs() , file git_startup.cpp


>
> Well, I somehow managed -- except I am not sure I dealed with the windows
> part correctly. What could be improved is maybe if you know how to signal
> a dependency between two projects. I currently rely on the top-level makefile
> always calling the subdirs in the order they are specified, but I fear
> portable recursive make does not really offer any better solution, so qmake
> can't really do that either.
>

Could the following help ?

http://lists.trolltech.com/qt4-preview-feedback/2004-10/thread00174-0.html

>
> Note: I think I found a bug in qmake here -- when you run qmake at top level,
> the makefile will call qmake in subdirectories to create makefiles there, but
> the rule has no dependencies, so it will not remake the makefiles when the
> .pro files change there.
>

I knew that. For my use I always delete Makefiles after modifying any
of *.pro files, I'm sure it exists a better way but honestly I didn't
investigate too much on this.

> Also I don't understand why you set 'MAKEFILE = qmake' in the src/src.pro --
> it does not seem to be respected, at least when I call it through the
> top-level qgit.pro (which I now have to when there are 3 subdirs).
>

>From http://doc.trolltech.com/4.0/qmake-variable-reference.html#makefile

MAKEFILE
This variable specifies the name of the Makefile which qmake should
use when outputting the dependency information for building a project.
The value of this variable is typically handled by qmake or qmake.conf
and rarely needs to be modified.

I annotated the src.pro file and I found that line belongs from the
very first version of src.pro, possibly copied from the Qt examples,
so it smells you are right and we could remove that.

Marco
