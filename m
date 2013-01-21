From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 14:22:49 -0800
Message-ID: <20130121222248.GA3586@elie.Belkin>
References: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
 <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:23:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxPlv-0000sO-IC
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 23:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab3AUWW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 17:22:58 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:39593 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab3AUWW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 17:22:58 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so2203008pbc.7
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 14:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/IcaEJX3I3YeP3IV67xQBLGcuxZlbL36DF7EcTW9P3s=;
        b=fJaieeNgeD5sZ3IFnuO7dE03HB5HWLxiUykFgZh0Vlq8vNBKUuZtoQd4IfO1DwAqFI
         rfFHC97OPYF+PfnQ9Od/FjucplYBQTJN3DAvDyh0hZ5E3T9VW5IXoa5oub+W+mUOUcKm
         FtOkFd3BhikBEhI8BaQIq3UfNTYBgkZNQfsxKIqyHXtpQrhXZH5ZWZZZ707yIdpgAmTh
         O+I5kuPbOc7EDqCvztu0yIBHpTsig/IfAkIO/K42KQLcVuozwLKYsi3Y8igvO2TsxuNJ
         ArkS9JDlYdgBZKxDhE1+A2MviHtrN5Ga44EZaLhlttMJbqASMH38wlUK8OPqmes+7EnL
         PKaw==
X-Received: by 10.68.130.161 with SMTP id of1mr53458291pbb.32.1358806976763;
        Mon, 21 Jan 2013 14:22:56 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ho4sm9379403pbc.54.2013.01.21.14.22.54
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 14:22:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214166>

Hi,

Matthieu Moy wrote:

> The inconsistancy of 'git add -u' and 'git add -A' are particularly
> problematic since other 'git add' subcommands (namely 'git add -p' and
> 'git add -e') are tree-wide by default.
>
> Flipping the default now is unacceptable, so this patch starts training
> users to type explicitely 'git add -u|-A :/' or 'git add -u|-A .', to prepare
> for the next steps:

Thanks for tackling this.

> --- a/builtin/add.c
> +++ b/builtin/add.c
[...]
> +	if (option_with_implicit_dot && !argc) {
> +		/*
> +		 * To be consistant with "git add -p" and most Git
> +		 * commands, we should default to being tree-wide, but
> +		 * this is not the original behavior and can't be
> +		 * changed until users trained themselves not to type
> +		 * "git add -u" or "git add -A". For now, we warn and
> +		 * keep the old behavior. Later, this warning can be
> +		 * turned into a die(...), and eventually we may
> +		 * reallow the command with a new behavior.
> +		 */
> +		warning(_("The behavior of 'git add %s' with no path argument will change in a future\n"

Would it be possible to make this conditional on cwd not being at the
toplevel (the case where "git add -u :/" and "git add -u ." have
different behavior)?  E.g.,

		static const char *here[2] = { ".", NULL };
		if (prefix)
			warning(...);

Thanks,
Jonathan
