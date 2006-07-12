From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: remove perl from git-commit.sh
Date: Wed, 12 Jul 2006 14:23:07 +0200
Message-ID: <81b0412b0607120523t34cfb92bs872f6d45b1b48759@mail.gmail.com>
References: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
	 <20060712114805.GD13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 12 14:23:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0dkH-0003Bk-T4
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 14:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWGLMXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 08:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWGLMXK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 08:23:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:38297 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750827AbWGLMXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 08:23:09 -0400
Received: by wr-out-0506.google.com with SMTP id 58so105731wri
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 05:23:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CsXac64CMirbJOC2j24eBka/aMziOiDsSsLiDcJq/sqsAnJV8CNSMYSVaeScp/Pcz0dU6yAlMXsBrWnFR5G/D3RILXkNpnxNVpvCfwccn/qcUrS20Lyt5wNlK1AD4RtP+QOyScMDkEpOs4+iBzz16IF726aqmgD/KJokJmk2+dE=
Received: by 10.82.109.9 with SMTP id h9mr68752buc;
        Wed, 12 Jul 2006 05:23:08 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Wed, 12 Jul 2006 05:23:07 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060712114805.GD13776@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23779>

On 7/12/06, Petr Baudis <pasky@suse.cz> wrote:
> BTW, why people so often want to keep stuff like the following from
> commit messages?

Well, strictly speaking it isn't the description of what the patch does.

> > than having to constantly patch git-commit.sh for binmode
> > or perl path (Windows has no stable tool set, and perl
> > for instance often resides "somewhere").
>
> ...but I would prefer much better if we could actually fix the problem.
> I'm not sure what "patching for binmode" takes but it sounds that we

ActiveState Perl normally replaces \n in the output with \r\n, which is
annoying, as the rest of git does output \n verbatim.

> should do it for the other Perl scripts anyway. If Cygwin usually really
> doesn't have stable Perl path, you could special-case PERL_PATH in

It's not cygwin. It's an organization typical for windows environements:
stinky trash can.

> Makefile for Cygwin to be just "perl" (or perhaps that's the issue only
> for non-source packages so you might want to simply set PERL_PATH to
> perl when building those).

I did. I didn't mention it because the patch was about the binmode.
sh is from cygwin here, so just removing this one dependency helps
a lot. I will change other scripts as soon as they get problematic.

Another small problem is with windows pathnames (activestate perl
expects _windows_ path, but allows forward slashes in it: c:/a/b/c).
I have calls to cygpath (converts cygwin path to windows and vice
versa) all over (not everywhere, just clone, rerere, mv, shortlog and
fmt-merge-msg. The tools that were important to me) just to deal
with this. It's a horribly unstable and poorly tested and breaks from
time to time but it mostly works. As I saw no complaints here about
the same problem I have never submitted the changes. Maybe I am
just unlucky to have to deal with windows so often.
