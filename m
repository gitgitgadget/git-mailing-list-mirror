From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 19 Mar 2010 12:09:23 -0700
Message-ID: <20100319190923.GA16758@spearce.org>
References: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com> <20100319143205.GB16211@spearce.org> <d411cc4a1003191208m38b7baf2mbb8f1ea288f90819@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 20:09:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NshZb-0005WO-MI
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 20:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab0CSTJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 15:09:27 -0400
Received: from mail-px0-f181.google.com ([209.85.216.181]:36958 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0CSTJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 15:09:26 -0400
Received: by pxi11 with SMTP id 11so929786pxi.16
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 12:09:26 -0700 (PDT)
Received: by 10.142.5.25 with SMTP id 25mr988013wfe.78.1269025766429;
        Fri, 19 Mar 2010 12:09:26 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm1209158iwn.6.2010.03.19.12.09.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 12:09:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d411cc4a1003191208m38b7baf2mbb8f1ea288f90819@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142635>

Scott Chacon <schacon@gmail.com> wrote:
> On Fri, Mar 19, 2010 at 7:32 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Scott Chacon <schacon@gmail.com> wrote:
> >> @@ -815,7 +815,18 @@ static int http_request(const char *url, void
> >> *result, int target, int options)
> >> ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ret = HTTP_OK;
> >> ?? ?? ?? ?? ?? ?? ?? else if (missing_target(&results))
> >> ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ret = HTTP_MISSING_TARGET;
> >> - ?? ?? ?? ?? ?? ?? else
> >> + ?? ?? ?? ?? ?? ?? else if (results.http_code == 401) {
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? if (user_name) {
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ret = HTTP_NOAUTH;
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? } else {
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? // it is neccesary to use getpass here because
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? // there appears to be no other clean way to
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? // read/write stdout/stdin
> >> + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? user_name = xstrdup(getpass("Username: "));
> >
> > No, getpass is needed here because its very likely stdin/stdout are
> > pipes to our parent process. ??So we instead need to use /dev/tty,
> > but that is non-portable. ??Using getpass() can at least be stubbed
> > on other platforms with a different implementation if/when necessary.
> 
> Should I roll a new patch for this?

Yea, you probably should since I think the comment could be improved.

-- 
Shawn.
