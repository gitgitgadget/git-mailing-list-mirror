From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] git clean: Don't automatically remove directories when
	run within subdirectory
Date: Tue, 15 Apr 2008 09:26:01 -0500
Message-ID: <20080415142601.GB10548@mediacenter>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net> <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com> <7v8wzgaoqy.fsf@gitster.siamese.dyndns.org> <20080414170643.GA10548@mediacenter> <48039FE5.5060309@broadpark.no> <20080415034417.GA2882@lintop> <48044C33.20006@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Berdal Haga <cjbhaga@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Apr 15 16:31:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlm7Z-0001iV-0I
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 16:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782AbYDOO0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 10:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756645AbYDOO0G
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 10:26:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:6964 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782AbYDOO0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 10:26:05 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1009362ywb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=7KaI1bU97Nh4mP7yZvr5EIHgjBmsFKLvmZcCIZM2qVo=;
        b=RltZ90KWOCCvEtoE8BgaZhcKRX8zaZSsBf/z281VAixuvWpK07vMilRzFTz32eAZH4FstEKhIIJPquvu+/7Vx/1+3hfWR2rHlFETZBqYGQk2rjZ1hJhgqvnbIoJdgiwNW8rfnlxnHvzbBa+UZlqAQrZ0vZBue9aSmuGJw80Lwbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=p4szcV/rX4/nnOo/z9M5JkgRVby4fusGUaZOGsqZTg2m7m+FxCjUYnavi81BI9/3FFO/OwuS9wqqYSIzSz+ftPWgCKNJo0h7jxo+Q3ZRGb1m6LvqOqj51hDMuOJm3RyXgLtmPcmpEymX7Gm5oaiUmo2CwcTth26YtBmsILSgv80=
Received: by 10.150.92.11 with SMTP id p11mr7865245ybb.36.1208269558618;
        Tue, 15 Apr 2008 07:25:58 -0700 (PDT)
Received: from @ ( [70.112.149.232])
        by mx.google.com with ESMTPS id a45sm1648614rne.1.2008.04.15.07.25.55
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 07:25:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48044C33.20006@broadpark.no>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79602>

On Tue, Apr 15, 2008 at 08:33:23AM +0200, Joachim Berdal Haga wrote:
> Shawn Bohrer wrote:
> > On Mon, Apr 14, 2008 at 08:18:13PM +0200, Joachim Berdal Haga wrote:
> >> I think that the best option would be to never remove a directory, even if
> >> given explicitly, unless -d is given. Because my gut feeling is that when a
> >> directory name is specified, it is most often meant as "clean inside the
> >> given directory", ie. as a path delimiter.
> > 
> > If there are no tracked files the only difference between the dir/ and
> > dir case is that the former will leave behind an empty directory.  So
> > the difference between too much and too little is of little importance.
> 
> No, check this out; note that only in the very last case dir/subdir/subfile
> would be removed.
> 
> $ git init; mkdir -p dir/subdir; touch dir/file dir/subdir/subfile
> Initialized empty Git repository in .git/
> $ touch dir/tracked-file; git add dir/tracked-file
> $ ~/src/git/git-clean -n dir/
> Would remove dir/file
> Would not remove dir/subdir/
> $ ~/src/git/git-clean -n dir
> Would remove dir/file
> Would not remove dir/subdir/
> $ git rm -f dir/tracked-file
> rm 'dir/tracked-file'
> $ ~/src/git/git-clean -n dir/
> Would remove dir/file
> Would not remove dir/subdir/
> $ ~/src/git/git-clean -n dir
> Would remove dir/

Ah of course, this is the behavior with my patch.  Before it would have
removed everything which is the same bug you initially reported :)

> > However,
> > 
> > git clean dir
> > Would not remove dir/
> > 
> > is a little strange.
> 
> Yes, although it could be made less strange by adding a short explanation,
> like "Would not remove dir/ (-d not given)". But I also think that the
> difference between "dir" and "dir/" is very (too?) subtle in this case and
> therefore should require explicit approval/action from the user.

Yeah, I don't know how I feel about this.  I do think that the behavior
with my current patch is technically correct, but you may be right that
a trailing slash is subtle.  In most cases I use my shell's tab
completion witch adds the trailing slash, and only remove it when
needed.  Additionally, I could argue that by default we require explicit
action to clean files by requiring -n or -f so hopefully users try -n
first (I do).

--
Shawn
