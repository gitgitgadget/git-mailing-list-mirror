From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 20:17:06 -0800
Message-ID: <20130211041706.GB15329@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:17:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4kpl-0003aI-Ci
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 05:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab3BKERO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 23:17:14 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:47883 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3BKERO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 23:17:14 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so2576225daj.8
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 20:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=IulRYFepL8+IWEWGfXQYsacpc9CZhmxq64y2xL+6qhM=;
        b=gg44AeAte1UgpWXWtfQwPp8EplaA7EW09WjFZRp607pCYsOaRQxogEboo+28XkcfyT
         k2H4ZrygpUM/jT2Rt3j0rP0D5cnQ1gKYBn3SmUULx4/sasNwFu8R45UhAl3742+fEwq+
         7sGlMSKhQ/4MDBKDzuK6C5/IM/tpduwsE68chIm3LdnPoNEEWfz0N4zFWRY+M2LchL7s
         n4g4lJ91uXgGvgImgMAR0oD6ANNyJ4T7eYAjGMtsfl/QfPp9AyAu5HWlTGr+ufk0+uO5
         Uug+NCcpZqjSKl5JxVmTfid5ZD4knmyN7F8c+DNZ8YcMAsC25j8WREngPprYEzzkSiZX
         rWEg==
X-Received: by 10.68.211.100 with SMTP id nb4mr15561800pbc.136.1360556233557;
        Sun, 10 Feb 2013 20:17:13 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id io6sm6314665pbc.24.2013.02.10.20.17.11
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 20:17:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215984>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> How about this?
>>
>> A patch on top could change the default "git-shell-commands is not
>> present" message if that seems worthwhile.
>
> Hmph.
>
> I wonder if rewording the message when git-shell-commmands directory
> is not there may be a better first step (which actually could be the
> last step)?

Maybe, but it's not a step that I'm interested in.  I don't think it
changes the desirability of the patch I sent.  They are independent.

[...]
> --- a/shell.c
> +++ b/shell.c
> @@ -162,9 +162,11 @@ int main(int argc, char **argv)
>  		/* Allow the user to run an interactive shell */
>  		cd_to_homedir();
>  		if (access(COMMAND_DIR, R_OK | X_OK) == -1) {
> -			die("Interactive git shell is not enabled.\n"
> +			die("The user has been recognized as '%s' but "
> +			    "interactive git shell is not enabled.\n"
>  			    "hint: ~/" COMMAND_DIR " should exist "
> -			    "and have read and execute access.");
> +			    "and have read and execute access.",
> +			    get_user_name());

Personally I don't think the hint should be here at all (it should be
obvious that git-shell(1) is the place to read about the login
behavior of an account with shell set to git-shell), but I don't mind
as long as it's possible to override the message.

Thanks,
Jonathan
