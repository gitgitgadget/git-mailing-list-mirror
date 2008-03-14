From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Thu, 13 Mar 2008 18:35:32 -0800
Message-ID: <402c10cd0803131935g6cf2b224k6a36f75101a03f31@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <7vk5k9eqax.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 03:36:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZzmJ-0007MU-Uq
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 03:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbYCNCff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 22:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYCNCff
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 22:35:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:11949 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbYCNCfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 22:35:34 -0400
Received: by fg-out-1718.google.com with SMTP id e21so3622903fga.17
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 19:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=77/QEyhE+DlHZCNqmHBQnp/0fUm+XXHKp15AhstzzeM=;
        b=aUVBlD8U4r1AihJR2bcSrwPPY067j6zf+ThqmGU1RSsQLvuc1TQuQLNvMkaswY6t/VB7TQI8b6PwHOFdLBPmY3zPZM5f3HFd7ysNTbb24VN26TfeSO45e6gi4jLIlK8g8l7A0jZTo5wS2N5ibnQqq0KHEoZdCg45ZpbEzEC0DOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xinr3004Yb4Mp0JKUpyAXX/DJqWL/2zpiEdh+1TWVF5bK1UIBQMBxJU1KCCu8Km9urcXyI29TKj6GgFpsibrH8Td9bGmvdVN0GTr66P0WpfBa7IuMdyAnYEbgUtO5+cKeNrybT+1UHzCqOUAFd3uuOJObrKL3aMCovRiZvANc5A=
Received: by 10.86.80.5 with SMTP id d5mr10562379fgb.57.1205462132825;
        Thu, 13 Mar 2008 19:35:32 -0700 (PDT)
Received: by 10.86.31.7 with HTTP; Thu, 13 Mar 2008 19:35:32 -0700 (PDT)
In-Reply-To: <7vk5k9eqax.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77164>

On Mon, Mar 10, 2008 at 10:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Sverre Hvammen Johansen" <hvammen@gmail.com> writes:
>  >               --ff)
>  > -                     allow_fast_forward=t ;;
>  > +                     case "$2" in
>  > +                     allow|never|only)
>  > +                             fast_forward=$2 squash= no_commit= ; shift ;;
>  > +                     -*)
>  > +                             fast_forward=allow squash= no_commit= ;;
>  > +                     *)
>  > +                             die "available fast-forward strategies are: allow, newer, and only" ;;
>
>  How does this code parse "git merge --ff my_other_branch"?

git rev-parse (in git-sh-setup.sh) will rewrite this to "git merge
--ff -- my_other_branch".  However, it will also rewrite "git merge
--ff=only my_other_branch" to "git merge --ff only --
my_other_branch".  Options in the config file are parsed directly by
parse_config without these rewrites.  This means that second case
above is the case where --ff don't have any arguments.  First and last
case is the case where --ff have an argument.

-- 
Sverre Hvammen Johansen
