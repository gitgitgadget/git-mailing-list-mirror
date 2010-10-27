From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] GIT-VERSION-GEN: make use of git describe --dirty
Date: Wed, 27 Oct 2010 07:28:53 -0700 (PDT)
Message-ID: <m3sjzriuc2.fsf@localhost.localdomain>
References: <cover.1287746107.git.misfire@debugon.org>
	<4CC1745C.70506@debugon.org> <20101022151140.GC9224@burratino>
	<4CC2D3B4.5030607@debugon.org> <4CC7D9CA.1080609@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Wed Oct 27 16:29:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB6zs-0002N9-Nw
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933400Ab0J0O24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 10:28:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45547 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933392Ab0J0O2z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:28:55 -0400
Received: by bwz11 with SMTP id 11so628105bwz.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=3JgAFwvMeDZUKkgOXtzvq02ZT/oDYYAPADa9K4bXWkM=;
        b=IOpdNzXB1YJH9qX0Pu54XmwQQtl39wFynUtXhBIpjQXNrz8hSTIcvLtJJNuFGEYDaL
         hAruHC/tJ+IFlcq0jrW8OuTBpUrNw/t3tqcvdT8Iqd9kx1vQghT3rcpCXF+dANCKrw7V
         3HoFDWbsYPo+fT/ZMilqVnBIymWX1xKqsj3BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Oxcs3FMcLFOUNf+TkfhVdTnKwjghFwHQcEPrxbkwzWI89SPcDXrlpfVmaoENzoIjdQ
         BZQdIMY1IMDR9j1dG6g2OxX2qLf1OeWnMgwChJqPDcLEoiW8ICHH7sbUi5O5IkCKNwum
         6beCT/A9BPIpASgNsRadU/I8m/pcCRUocR6fI=
Received: by 10.204.72.144 with SMTP id m16mr796427bkj.39.1288189734348;
        Wed, 27 Oct 2010 07:28:54 -0700 (PDT)
Received: from localhost.localdomain (abvr250.neoplus.adsl.tpnet.pl [83.8.215.250])
        by mx.google.com with ESMTPS id a25sm7019088bks.8.2010.10.27.07.28.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:28:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9RESK0I026203;
	Wed, 27 Oct 2010 16:28:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9RERw9X026199;
	Wed, 27 Oct 2010 16:27:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4CC7D9CA.1080609@debugon.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160038>

Mathias Lafeldt <misfire@debugon.org> writes:
> Mathias Lafeldt wrote:

> > diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> > index d441d88..5c226f6 100755
> > --- a/GIT-VERSION-GEN
> > +++ b/GIT-VERSION-GEN
> > @@ -16,6 +16,10 @@ elif test -d .git -o -f .git &&
> >         case "$VN" in
> >         *$LF*) (exit 1) ;;
> >         v[0-9]*)
> > +               # As of Git v1.6.6, we can use "git describe --dirty" to
> > +               # determine if the working tree is dirty. However, to still
> > +               # have nice version numbers when building Git with older
> > +               # versions of git installed, we keep using plumbing.
> >                 git update-index -q --refresh
> >                 test -z "$(git diff-index --name-only HEAD --)" ||
> >                 VN="$VN-dirty" ;;
> > 
> 
> Any feedback would be welcome.

I like it, also because people who use GIT-VERSION-GEN from git
repository as inspiration would get to know more modern technique.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
