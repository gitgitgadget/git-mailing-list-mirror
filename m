From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive shell
Date: Mon, 11 Feb 2013 00:57:28 -0500
Message-ID: <CAE_TNim2wrL3SWxy_2ugyGmEFDngBJ8+z04y2tJFzMo4N8mUug@mail.gmail.com>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin> <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org> <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin> <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin> <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin> <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 06:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mP9-0000Xj-8D
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 06:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076Ab3BKF5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 00:57:50 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:57670 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3BKF5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 00:57:49 -0500
Received: by mail-qc0-f171.google.com with SMTP id d1so326209qca.16
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 21:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bRDDpB6bsiNCjtAH5Hp1h7DXJG/u3WaIz/HAgqCb17g=;
        b=fuovHXksr/9rD7+doHiYePYzJRNrgoZrGrWyMi1eIm/znSLaDQBUly5VXx+wNMZ3YM
         MZUrV8q3bEHiAj7HfvtSe0bD2lEyznuTXxVMgSzSp33g9M9+3frw4IgQK9fO+LElklx+
         FLVpBOruetDCnPLrj9c76wm2V3NMenAaxuf1zEuoF2jMSB6pCIeWLLLgr9ZR2VS738sM
         D2RF12FjFAN9L7wT/kuXtIB6ojOoT1zXKRjabaFgxPv2NApQuL/XepEs7fLIXgwKtzAZ
         ChTtOYS62gxQVkteKzyQOJxmf+eb2e+fgW9vHbQa2Y40i8wIrsaw6C9vEAGeEADN1shF
         /gAQ==
X-Received: by 10.224.180.212 with SMTP id bv20mr4879706qab.6.1360562268689;
 Sun, 10 Feb 2013 21:57:48 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 21:57:28 -0800 (PST)
In-Reply-To: <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215994>

On Mon, Feb 11, 2013 at 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Hmph, if that is the case, wouldn't it be a better direction to give
> a better help for majority of the case where git-shell is used as
> the login shell to allow push and fetch but not for interactive
> access at all?
>
> The first step in that direction may be to give a better canned
> message, followed by a mechanism (perhaps a hook) that lets a
> message customized for the site's needs, no?  Why should a site
> administrator create an otherwise empty directory for each and every
> user and add an executable in there that shows an error message,
> only to improve the default message because it is not friendly
> enough?

Jonathan made the following comment on the thread I started that lead
to this RFC:
> You can disable interactive logins by removing the
> ~/git-shell-commands/ directory.  Unfortunately that doesn't let you
> customize the message.  Perhaps it would make sense to teach shell.c
> to look for a
>
>        [shell]
>                greeting = 'Hi %(username)! You've successfully authenticated, but I do not provide interactive shell access.'
>
> setting in git's config file.

How is this for an alternative? Have shell.c look for
        [shell]
                missing_commands_directory = "Stuff is broke."
setting. If the setting is missing, then it prints the default message
(the current message). That way, there's a default setting, there can
be a system-wide message, there can be a user specific message, and
those messages can be set via `git-commit`.

--
Ethan Reesor
