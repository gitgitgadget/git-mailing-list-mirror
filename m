From: David Aguilar <davvid@gmail.com>
Subject: Re: [BUG] difftool falls back to normal diff when used during merge resolution
Date: Mon, 28 Nov 2011 03:16:27 -0800
Message-ID: <2814991420316381881@unknownmsgid>
References: <CAHWJSOSB768hWsNqrR559wef3-k_yZ=TjS_mxfj3TxXdgwm5iQ@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148a)
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Turski <yacoob@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 12:16:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUzCM-0004IT-Mg
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 12:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab1K1LQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 06:16:31 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63883 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1K1LQb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 06:16:31 -0500
Received: by ywa9 with SMTP id 9so2766021ywa.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 03:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:from:in-reply-to:mime-version:date:message-id:subject:to
         :cc:content-type;
        bh=FQtFSbaB4J2vhqrhWZsUAMXGmhcg9tX8oclhMorYIIg=;
        b=H0InokseBNGJFTLImBEo7p426KyT3O6OyOLoyb1eXMSUrt8/pGsWv6o9uuzUuNT0b3
         JHts2ekO9tEaEnnzbNC+s700Pzh9DTJLcpMMgjhXeRH3WhL57UZ6el8D3ymlxUXGPZxz
         UJcBme+w/0SxHfPOTE5swu5twTaXxlOGjB2+g=
Received: by 10.100.28.29 with SMTP id b29mr323625anb.126.1322478990820; Mon,
 28 Nov 2011 03:16:30 -0800 (PST)
In-Reply-To: <CAHWJSOSB768hWsNqrR559wef3-k_yZ=TjS_mxfj3TxXdgwm5iQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186011>

On Nov 27, 2011, at 10:09 AM, Jakub Turski <yacoob@gmail.com> wrote:

> Hello there,
>
> Just found this behavior, and after a chat on IRC it looks to me like
> an actual bug. I have 'git difftool' configured to use vimdiff - and
> it worked fine. Despite that config, git still falls back to plain
> diff when I launch difftool mid-way through merge conflict resolution.
>
> Here's a reproducable testcase (w/ version 1.7.7.3)
>
> $ mkdir a; cd a; git init; echo A>A; git add A; git commit -m A; git
> branch alt; echo AA>A; git commit -am AA; git checkout alt; echo B>A;
> git commit -m B; git commit -am B; git checkout master; git merge alt;
> git difftool -t vimdiff A
>
> Results:
> http://pastie.org/2929336

I think this is an unfortunate case where the implementation leaks
into the user experience.

I haven't checked, but I'm pretty sure this is because
GIT_EXTERNAL_DIFF has no affect when the conflicts exist.

git mergetool can be used in this situation.

We could do a check up front in difftool to see whether conflicts
exist and exit with an error message. The difftool script is quite
small and basically a very thin wrapper around git diff, though, so I
do hesitate before making it more complicated.

anyways, try "git mergetool".
-- 
            David
