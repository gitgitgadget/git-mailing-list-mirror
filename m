From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/6] path: Make the 'get_st_mode_bits' symbol a file static
Date: Mon, 29 Apr 2013 23:53:08 +0100
Message-ID: <517EF9D4.50105@ramsay1.demon.co.uk>
References: <517C1BF9.2050604@ramsay1.demon.co.uk> <7vip36qxui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:33:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxZI-0000Ck-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569Ab3D2XdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 19:33:09 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:51169 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932368Ab3D2XdH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:33:07 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 21F63384082;
	Tue, 30 Apr 2013 00:33:06 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 5AF09384081;
	Tue, 30 Apr 2013 00:33:05 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 30 Apr 2013 00:33:04 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vip36qxui.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222880>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> On MinGW, sparse issues an "'get_st_mode_bits' not declared. Should
>> it be static?" warning. The MinGW and MSVC builds do not see the
>> declaration of this function, within git-compat-util.h, due to it's
>> placement within an preprocessor conditional. (So, one solution would
>> be to simply move the declaration to the top level of the header.)
> 
> Well, the idea was that the user of this function in path.c will
> call get_st_mode_bits(), and whatever platform that provides a
> replacement implementation would do
> 
> 	#define get_st_mode_bits(a,b) cygwin_get_st_mode_bits((a),(b))
> 
> so that the calling site in path.c will end up calling that
> replacement implementation.  So if anything get_st_mode_bits()
> declaration may want to go at the _end_ (not top) after including
> all the compatibility crufts.
> 
> We could make the declaration static to path.c, but then nobody
> other than path.c would be able to make use of it in the future,
> and we'll have the same discussion when somebody wants to hoist the
> declaration to git-compat-util.h, no?

I don't have a problem with keeping the declaration in git-compat-util.h
(after moving it so that the MinGW and MSVC builds can see it, of course)
if you would rather do that.

However, I'm always a little wary when I hear someone say "this may be
useful to others in the future, so lets do X to make it easier ...".
I have noticed that, much more often than not, that future user never
does materialise ... ;-)

Having said that ...

Back in 2011, when I was trying to fix t7606-merge-custom.sh (see
commit b8a9733377, "help.c: Fix detection of custom merge strategy
on cygwin", 16-06-2011), I had a patch that looked very similar to
the solution Torsten has arrived at here! (The main difference was
that I called stat() rather than lstat() to get the mode bits).

I decided to go with the simpler solution in commit b8a9733377.

ATB,
Ramsay Jones
