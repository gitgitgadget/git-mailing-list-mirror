From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive shell
Date: Mon, 11 Feb 2013 02:15:51 -0500
Message-ID: <CAE_TNi=EG6vziVObJ-a__smeOv7RgZ5R146eonD6M828H7ziNQ@mail.gmail.com>
References: <20130210212538.GA11720@elie.Belkin> <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org> <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin> <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin> <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin> <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin> <7vliavpc4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:16:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4ncy-00006W-1O
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab3BKHQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:16:13 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:49977 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab3BKHQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:16:12 -0500
Received: by mail-qa0-f53.google.com with SMTP id z4so1053072qan.12
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 23:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IX254Wy4tLS5+Qb27gOOxOQbUp/uwmDWscZ8Mnrl4j0=;
        b=cSbeE5lLlu6tDDJXEKVVJ1wC4Kv7QmIWuWFBvwUv5/YsV+rDu667NYbn/tt2Dy4+yO
         jmwqYcg8Wd5VcjXHxBFCeYSxSLJO5sDHwgsKSYkYeNuAo68wrvDOvIQ6uHR80kUyaslz
         rU+2XQyOTIWLHOf5IJub1ii63c7wp6966BNeLaRWizSb3QvrMykbCl0D71OqJbstb98K
         m1giuw8adi1ZzYRWp1psNcViLD0lPcdYVbsEXYon6WdLLcnKzavNMMLrS1ptYzkVm3Wy
         sIpu3W+wzVZwE9cYJXI4SesNHMqVNhikixLXDokrCZHnj93XJPtYEF3TzeJUbxsFgSYs
         +gYg==
X-Received: by 10.224.208.9 with SMTP id ga9mr5223803qab.1.1360566971755; Sun,
 10 Feb 2013 23:16:11 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 23:15:51 -0800 (PST)
In-Reply-To: <7vliavpc4q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216011>

On Mon, Feb 11, 2013 at 2:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> And for the remaining 20% of those who do not like the canned
> message but still do not need any custom command, I think it is way
> suboptimal to force them to create git-shell-commands directory for
> 47 users his host gives git-shell access to, and copy the "help"
> script to all of them, only to get a customized message.  It would
> help them quite a lot if you just called /etc/git/shell-disabled or
> some hook that generates a customized message; then there is no need
> to add any git-shell-commands directory and a "help" script every
> time he gets one new user, no?
>
> For those who _do_ want to give customized commands to their users,
> they can already have "help" script to give a friendly message.  It
> just felt silly to force sites to create the directory only to
> refuse an access to the "custom commands" feature, especially when
> the existence of that directory is a signal that the site may want
> to give its users an acess to that feature.

Again, would it not be more elegant and powerful to A) have the
shell-disabled message/hook/etc specified by git-config on some level,
be it /etc/gitconfig or ~/.gitconfig, and B) have Jonathan's patch
whereby ~/git-shell-commands/help returning non-zero closes the
connection? Have shell.c read for settings in the pattern:
        [shell "disabled"]
                message = "Hi, this is your server speaking. I've
replaced the usual message."
                command = "/path/to/some/command"
If shell.disabled.command is defined, don't bother with the message.
If it is not, but shell.disabled.message is, display that. If neither
of them are, display the default message, and make that one more
friendly.

Even if that was implemented, there is still an argument for
Jonathan's patch. For example, I'm building a server where
~/git-shell-commands/help does something interesting. But sometimes,
something fails. When that something fails, I want to close the
connection for whatever reason.

So, any reason not to have both (on top of making a better default message)?

--
Ethan Reesor (Gmail)
