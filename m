From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Wed, 22 Apr 2009 01:26:54 -0700
Message-ID: <20090422082652.GA32698@gmail.com>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de
To: Alex Riesen <raa.lkml@gmail.com>, gitster@poxbox.com
X-From: git-owner@vger.kernel.org Wed Apr 22 10:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwXpt-0001ww-8w
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 10:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748AbZDVI1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 04:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755732AbZDVI1G
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 04:27:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:53994 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615AbZDVI1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 04:27:03 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2801173rvb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 01:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C9QeBqx6SM1gJdYmzv4XGaN1OZK9ebMouURbIAYEGf4=;
        b=TwkL/Koa3gtJtWtFA0qfKKypYlQi7wh4VVvBvflVwt+nxdJ7XYe4CZrdu4vJONMSCK
         9H1ZqD7FzqUxENwAkf4G3O3BwniGrX1Ewzsk+lIXVFB2uGs8ls/BgBExCeHWmKXlGwvx
         O9faR39iFj3/ihOCsLqj1V9EzuosH2gICmUXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=G+BjJWw9zMGxu7uvQKWAg0wex43KSzCOYy502+b1lkNOx7RE0kvKwThBvtoMgk3+GQ
         efGe29Gt9crdi6BMO9iWUeUlVD5dItb+Xpul5/FBC1kAgVBY2IeA09V3rujfO1Oxv9EA
         2RZtboXdELAPg1x7oyzfkc8CI3f8BEwzSlxe0=
Received: by 10.114.195.19 with SMTP id s19mr4478919waf.10.1240388821873;
        Wed, 22 Apr 2009 01:27:01 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v25sm10586857wah.16.2009.04.22.01.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 01:27:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117181>

On  0, Alex Riesen <raa.lkml@gmail.com> wrote:
> In ActivetState Perl, exec does not wait for the started program. This
> breaks difftool tests and may cause unexpected behaviour: git difftool
> has returned, but the rest of code (diff and possibly the interactive
> program are still running in the background.

Thanks for keeping an eye on portability.

There's a tiny typo in the commit message (Active't'State) that
maybe you can tweak before applying?  ('you' being Junio)

For whatever it's worth,

Acked-by: David Aguilar <davvid@gmail.com>


> I usually don't care for exit code in a pure UI tool, so the kill signal
> is just ORed together with the real exit code just to provide indication
> of error.

This seems reasonable.  The exit code isn't very important in
the common 'show-me-the-diff' read-only scenario, and I wouldn't
expect anyone to rely on difftool being exactly exit-code
equivalent to git-diff.


> diff --git a/git-difftool.perl b/git-difftool.perl
> index 948ff7f..bd828c2 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -82,4 +82,5 @@ sub generate_command
>  }
> 
>  setup_environment();
> -exec(generate_command());
> +my $rc = system(generate_command());
> +exit($rc | ($rc >> 8));
> -- 
> 1.6.3.rc0.45.g63634

-- 
		David
