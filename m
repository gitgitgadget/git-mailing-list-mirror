From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Fri, 27 Feb 2009 15:48:18 -0500
Message-ID: <76718490902271248p2de44082ka66645203c9683d4@mail.gmail.com>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>
	 <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net>
	 <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org>
	 <49A66057.1050501@drmicha.warpmail.net>
	 <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
	 <49A7C3A7.6060202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 21:49:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9eY-0005ne-Bm
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 21:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbZB0UsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 15:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755811AbZB0UsW
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 15:48:22 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:45616 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbZB0UsV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 15:48:21 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1258729rvb.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kI92ODZImrd+GhO+IVgeaLI3cUaU8hJkP0Uvi+F8cnc=;
        b=oxh630a8lvRlCJ39v48hY4CGpkuHqOsIEuI+qLDC8yLp+Xi/7aSpHtgXUwI+N2mKcY
         Ax7AbDlCZenlC0/1fofkoP7HpKp9yIvIC+BnnDKoMOetc/GMehUlJVjaztbNJUPRYNe4
         Fx+N0Rc0+MUw8VVSCCdBO6UuM27Ozs//ho04E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wi9b7/2jf07l7MF8JDEoI8Qls6rlco6IRTVzPLqfoqghfkbnVWmgiB/2tEQ8LY65LR
         bRHTcJvIIJZpsaJiMrX8LqYFtdK7bhLAE4BpEMBQUlaaZUSVJkrW2f2qqjBQPM4iOiw8
         j4i8tV01beKqla5mQVU5pHR+OOPYJScZwFU6w=
Received: by 10.141.89.13 with SMTP id r13mr1362822rvl.269.1235767698913; Fri, 
	27 Feb 2009 12:48:18 -0800 (PST)
In-Reply-To: <49A7C3A7.6060202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111711>

On Fri, Feb 27, 2009 at 5:42 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> bcc785f (git push: add verbose flag and allow overriding of default
> target repository, 2006-10-30) Linus introduces --repo.

So I still don't get why Linus introduced the option. I'm looking at
bcc785f:builtin-push.c and AFAICT, the following are exactly
equivalent:

$ git push [options]... <repo>
$ git push [options]... --repo=<repo>

Which is why I sent the original message that has spawned this saga. :-)

Here's the abbreviated code in question:

        const char *repo = "origin";    /* default repository */

        for (i = 1; i < argc; i++) {
                const char *arg = argv[i];
                if (arg[0] != '-') {
                        repo = arg;
                        i++;
                        break;
                }
                if (!strncmp(arg, "--repo=", 7)) {
                        repo = arg+7;
                        continue;
                }
        }
        set_refspecs(argv + i, argc - i);
        return do_push(repo);

--repo can be placed anywhere on the command line, but other than
that, it's identical in effect to specifying the repo as the first
non-dashed argument.

Or am I completely blind?

j.
