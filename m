From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 10:17:17 +0700
Message-ID: <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	 <Pine.LNX.4.64.0711271617350.27959@racer.site>
	 <20071128000731.GD9174@efreet.light.src>
	 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 04:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxZuG-0005Kk-L1
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 04:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757644AbXK2DRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 22:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757673AbXK2DRU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 22:17:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:24976 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757628AbXK2DRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 22:17:19 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1664659nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 19:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yqMlZeLkxUB91vlfkyAm2ZChKb9qPU/UvCWITuu7MjM=;
        b=XwpKW+116BqQv+cjKElfNAI0gsmbbQ5Us6CvPiv5txnKKc1BBeP+VH0xiJGzIfzUJ03m9ZmflCLnZXUQtLlHGcH+GRFtVfadSvg3KmtgcPfbUJwc7JNwSSRIBCBSII9WwwZwYosuUqQJmVkLGUz3g5FzWf6imWVYOPERqAEgcUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jra6AeGYqDnGxFLGULKkIhUATPy+v9Tac/ThL5sZIUTXD38BmvrVxQSCnsVsMsmxLxA8zcBQY09OEPaLJ1JMcquXxWJ+VWXBZ6tFEonHEPWLaxP3mEZXe7TaxciPRpqIxUpL/0hzlSU/OS7asQJtx/uyHfDPCYTUsNHx8zm27CE=
Received: by 10.86.54.3 with SMTP id c3mr3414373fga.1196306237561;
        Wed, 28 Nov 2007 19:17:17 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Wed, 28 Nov 2007 19:17:17 -0800 (PST)
In-Reply-To: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66496>

On Nov 29, 2007 6:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > On Nov 28, 2007 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> In case somebody is thinking about 36e5e70e0f40 (Start deprecating
> >> "git-command" in favor of "git command"), that is a somewhat different
> >> issue.  What Linus suggested is not installing git-foo link for built-in
> >> commands _anywhere_ on the filesystem.  Not just "out of user's PATH".
> >> That is not deprecating dash form but removing the support for it.  We
> >> need to give ample time for users to adjust to such a change.
> >
> > A little note on this one. I've been using git without builtin links
> > for a while with my git-box port. There are still some builtin fixups
> > needed. And because execv_git_cmd() always uses dash form, so it's
> > impossible to use vanilla git without builtin links.
>
> Thanks for a heads up.
>
> Would people agree with a rough roadmap like this?
>
>  - v1.5.4 will ship with gitexecdir=$(bindir) in Makefile.  But the
>    release notes for the version will warn users that:
>
>    (1) using git-foo from the command line, and
>
>    (2) using git-foo from your scripts without first prepending the
>        return value of "git --exec-path" to the PATH
>
>    is now officially deprecated (it has been deprecated for a long time
>    since January 2006, v1.2.0~149) and upcoming v1.5.5 will ship with
>    the default configuration that does not install git-foo form in
>    user's PATH.
>
>  - Post v1.5.4, start cooking gitexecdir=$(libexecdir)/git-core, aiming
>    for inclusion in v1.5.5, perhaps in Mar-Feb 2008 timeframe.
>
>  - The release notes for v1.5.5 will warn users that git-foo will be
>    removed in v1.6.0 for many commands and it will be merely an accident
>    if some of them still work.
>
>  - Post v1.5.5, start cooking the change that does not install hardlinks
>    for built-in commands, aiming for inclusion in v1.6.0, by the end of
>    2008.

There won't be a stage when only porcelain git-foos are in $(bindir)?
I could stop working on the relevant patch then.
-- 
Duy
