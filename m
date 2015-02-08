From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFD 0/3] worktree.* config keys and submodule and multiple
 worktrees
Date: Sun, 08 Feb 2015 09:36:43 -0800
Message-ID: <54D79EAB.6060301@web.de>
References: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 18:37:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKVn6-0004Og-4d
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 18:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbbBHRg6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 12:36:58 -0500
Received: from mout.web.de ([212.227.17.11]:61960 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752060AbbBHRg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 12:36:58 -0500
Received: from [192.168.7.132] ([50.204.239.148]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MXYS2-1Y5k513E1O-00WaEV; Sun, 08 Feb 2015 18:36:50
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:LRYqeP7UNLNikhXQNPWgfbgQYkcJ1BHACkIJXvTFvOKz+oEI5ti
 VKLR97V3oJDvdPTw/Yyb5S/Qzk7H99Qf9j0GwHcNlWgRTjNPOWTzAW5EH2XXF4x8tJHJDBi
 W6SamaqxL/dDudNwMpvhimIXp9hrqKD2rN0DDLCoJ5vSL8VI5ebmUWN4+Q5mQscn1HYhIcq
 SLZoXhJg1VY9rBe8jrEgA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263529>

Am 08.02.2015 um 05:16 schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
> 1/3 is a more complete version of a patch I posted earlier [1]. It
> makes sure that worktree.* config keys are stored in a different plac=
e
> than $GIT_DIR/config. This allows us to work around the core.worktree
> issue in multiple worktree setting.
>
> I think 1/3 and 2/3 are fine. 3/3 is probably not. It's more of a
> proof of concept. The tests pass, but there's no migration path for
> existing submodules. Submodules modified by new Git will confuse old
> Git because the old ones do not understand worktree.path (the
> replacement for core.worktree)

Yeah, breaking every submodule cloned with v1.7.9 or newer is not
the way to go. You'd still have to support the old configuration
name for a very long time.

I wonder if it's worth all the hassle to invent new names. Wouldn't
it be much better to just keep a list of per-worktree configuration
value names and use that inside the config code to decide where to
find them for multiple work trees. That would also work easily for
stuff like EOL-config and would push the complexity in the config
machinery and not onto the user.
