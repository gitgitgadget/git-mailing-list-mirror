From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v15 5/7] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 21:33:19 +0200
Message-ID: <201108032133.19854.chriscool@tuxfamily.org>
References: <1312383811-7130-1-git-send-email-jon.seymour@gmail.com> <1312383811-7130-6-git-send-email-jon.seymour@gmail.com> <CAH3Anrrt-FPqWmDhv0ucQfGKmgVbGLFBE5Pf8ma1LWroydNWLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 21:33:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QohCA-0006Gm-Bb
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 21:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab1HCTda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 15:33:30 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:32880 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab1HCTd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 15:33:29 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5A2ACA627A;
	Wed,  3 Aug 2011 21:33:21 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <CAH3Anrrt-FPqWmDhv0ucQfGKmgVbGLFBE5Pf8ma1LWroydNWLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178612>

On Wednesday 03 August 2011 17:32:09 Jon Seymour wrote:
> On Thu, Aug 4, 2011 at 1:03 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
>         rm -f "$GIT_DIR/head-name" &&
> 
> > -
> > -       rm -f "$GIT_DIR/BISECT_START"
> > +       rm -f "$GIT_DIR/BISECT_START" &&
> > +       git update-ref -d BISECT_HEAD
> >  }
> 
> I'll reverse the order of the last two statements and restore the blank
> line...

Great!

It would be nice too if the "git update-ref" call that creates the ref in the 
first place was after the creation of the $GIT_DIR/BISECT_START file.
This way we start by creating the $GIT_DIR/BISECT_START file and we finish by 
deleting it.

That is change this:

...
+       test "$mode" != "--no-checkout" ||
+       git update-ref --no-deref BISECT_HEAD "$start_head" &&
        echo "$start_head" >"$GIT_DIR/BISECT_START" &&
 
into something like this:

        echo "$start_head" >"$GIT_DIR/BISECT_START" &&
+	{
+		test "$mode" != "--no-checkout" ||
+       	git update-ref --no-deref BISECT_HEAD "$start_head"
+	} &&
...

Thanks,
Christian.
