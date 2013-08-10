From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Feature Request: Support logic or shell execution to control
 values in .gitconfig
Date: Sat, 10 Aug 2013 13:19:32 -0700
Message-ID: <20130810201932.GA3031@elie.Belkin>
References: <CANY-LFJZazieg-7gLq1=pv=nkED81Gck4=95ffgZ6tGVgX5ffg@mail.gmail.com>
 <vpq1u64dx63.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morgan McClure <mcclure.morgan@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Aug 10 22:19:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Fda-0007tE-8w
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 22:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758778Ab3HJUTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 16:19:42 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:53303 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758728Ab3HJUTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 16:19:41 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so5558081pbc.16
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cVfUeezwRJzmMTsMwpFzIlvGuQr2lvPcS8u/ipo8DDs=;
        b=g+TnYO/Rl36Oax5RM9+NjlHARpwUBXvIe/PBqrip18y0EamV1gbT1kXSiRnwdSW948
         zhUAsvmU72gYlLjyXTKfra5nlvdn214+QqxDs6LmzfI3fiItRoTA58JbPu4t6y2zahf4
         UIwCu2OP/AS6cfKtvm97yQvdvHYlNe2wGYUThEK1GmTuFfzPvElZQENIUts4hzLK03XL
         pgbYvT7OIrhesZCGB77Y/uy3F2rm8cTljhBnuxXfa/fP2heXmRZL9kJ4UFiK4lNiqZRt
         jT2gFwyf7OnqKpLgdexmUKdMSVGpo0UGUOTjNUdY38jHME4BtHvkR01p1aJ0fQdFmQU5
         nGWA==
X-Received: by 10.68.251.234 with SMTP id zn10mr17138108pbc.188.1376165981036;
        Sat, 10 Aug 2013 13:19:41 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ss8sm30124050pab.6.2013.08.10.13.19.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 13:19:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpq1u64dx63.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232112>

Matthieu Moy wrote:

> That would mean executing SOMETEXTTOEXECUTE each time the config file is
> read. This raises two issues:
>
> * A security issue, as SOMETEXTTOEXECUTE could also be something
>   dangerous. It would not be much worse than the current situation (if
>   your config file is not trusted, then an attacker could put malicious
>   code in core.editor for example), but still increase the security
>   risk (as any command reading the config may trigger execution).

I don't think the security issue is too bad.  As you say, the
combination of control over core.pager and pager.config is already
pretty dangerous.

> * A performance issue with the current git implementation, as the config
>   file may be read many time for a single git execution.

This issue is harder.

>> Is this a feature others could get behind?
>
> I think it's unlikely that this ever be implemented. What I suggest
> instead is to edit/track/share template configuration files like
>
> ~/.gitconfig.in
> email = me@HOSTNAME@
>
> and then script something like sed -e "s/@HOSTNAME@/$(hostname)/" <
> ~/.gitconfig.in > ~/.gitconfig.

Yeah, substitution scripts like this are probably the simplest way to
go.  Maybe some day it will make sense for commands to check the
timestamp or checksum of <foo>.in to automatically regenerate <foo> on
the fly when <foo>.in and other inputs change, but that sounds like
more complication than it's worth for git to take on.

Other alternatives might be to do that on the filesystem level (a FUSE
filesystem or Hurd-style translator generating determining the read(2)
result for <foo> on the fly), the editor level (vi knowing to
regenerate <foo> when you save <foo>.in), or the session management
level (bash via ~/.profile or ~/.bashrc or pam-login regenerating
<foo> at the start of each interactive session).

I wish there were an standard way to deal with such tasks instead of
running an update script manually, but now I'm getting off topic.

Thanks,
Jonathan
