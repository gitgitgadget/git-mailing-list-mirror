From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Bugfix: undefined htmldir in config.mak.autogen
Date: Wed, 20 Feb 2013 18:42:59 +0800
Message-ID: <CANYiYbHpEd8kgv2nPvJgDvNLhzHbYJ8uN2gLNWWwCWvrVExpBA@mail.gmail.com>
References: <1be0a520b99fbfecd7255c1d26753015612856b3.1361272864.git.worldhello.net@gmail.com>
	<7v8v6j52qf.fsf@alter.siamese.dyndns.org>
	<7v4nh750v3.fsf@alter.siamese.dyndns.org>
	<CANYiYbF0C2qormAWNVhHm45TVQ6woECD7u1cCxxNuwyZxziNpw@mail.gmail.com>
	<512487CB.3050908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Christoph J. Thompson" <cjsthompson@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 11:43:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U879A-0007Bs-NC
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 11:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759230Ab3BTKnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 05:43:04 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:43087 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759192Ab3BTKnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 05:43:00 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn17so5967098wib.16
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=knWPH6pnenL/ytWKbH9Z7v0qN/9uExKMjlGaOvOCgMk=;
        b=xAv3yqRzHlXcjOKMtmvd/iVpD70p4JXpENDA+S75Lde4DRGf6SvrfC8o+tsgZVyvfZ
         qbAW3ClBVVp2NA8YMODEnV4+BfZpuGo/yDKMkCzfEbjU78aTVWKkMvuPrW7EPWd7O6/G
         HHcg/+wgO2fXKV/6vFxzeL6cRcaokMD5UHf5bU7C7HH+AHNHY7gl0uhHMaGGGsnNezP2
         Q1QIbMtxRaXlMAAbMhjy19oC19wOdP+zKoIM/qbQr4nvCYA0YZCkByTgSFHQ32XtCCyP
         osE5EFgscgQiNc+K0DIzWGM0u1cel/1rljcdHiABrtqPGFWMNOh1lxpCXvl3B5oEJmpn
         Icqg==
X-Received: by 10.194.24.197 with SMTP id w5mr27943369wjf.9.1361356979283;
 Wed, 20 Feb 2013 02:42:59 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Wed, 20 Feb 2013 02:42:59 -0800 (PST)
In-Reply-To: <512487CB.3050908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216701>

 2013/2/20 Stefano Lattarini <stefano.lattarini@gmail.com>:
> On 02/20/2013 02:39 AM, Jiang Xin wrote:
>>
>> [SNIP]
>>
>> I am not familiar with autoconf. After clone autoconf and check,
>> I cannot find a neat way to change "htmldir" default location to
>> use ${datarootdir} (just like mandir).
>>
> This one-line change should be enough to do what you want:
>
>   diff --git a/configure.ac b/configure.ac
>   index 1991258..2bfbec9 100644
>   --- a/configure.ac
>   +++ b/configure.ac
>   @@ -149,6 +149,8 @@ AC_CONFIG_SRCDIR([git.c])
>    config_file=config.mak.autogen
>    config_in=config.mak.in
>
>   +AC_SUBST([htmldir], ['${datarootdir}'])
>   +
>    GIT_CONF_SUBST([AUTOCONFIGURED], [YesPlease])
>

If changed like that, set:

     AC_SUBST([htmldir], ['${datarootdir}/doc/git-doc'])

In the generated "configure" file, this instruction will be inserted
after the option_parse block (not before), and will override what
the user provided by running "./configure --htmldir=DOCDIR".

BTW, add "docdir = @docdir@" to "config.mak.in", also let
"./configure --docdir=DIR" works properly.

-- 
Jiang Xin
