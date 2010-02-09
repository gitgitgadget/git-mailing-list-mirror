From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Generate a warning message if we find an unrecognized
	option.
Date: Mon, 8 Feb 2010 21:17:31 -0800
Message-ID: <20100209051730.GA28599@gmail.com>
References: <4B70913F.7060809@winehq.org> <20100209004514.GB4065@coredump.intra.peff.net> <7vvde7z0kf.fsf@alter.siamese.dyndns.org> <20100209030151.GA5370@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeremy White <jwhite@winehq.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 06:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeiUi-0006KY-78
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 06:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab0BIFRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 00:17:40 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:63042 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab0BIFRk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 00:17:40 -0500
Received: by yxe31 with SMTP id 31so6456940yxe.21
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 21:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bj2W9SkoAWWm766xQhSHpmOq3kXsIr0MMjo7z9+8GQI=;
        b=xa7taG01vEMCOubT5+/d7Efq0zME5Yzjfmz2/6saPyS6apYqGbHFLdzRQoiapn7ZnU
         SVcnaaFbIe7y0k1jzBuesb57IIdgph4CRWGUQlbpREytxu+qeIUiorv4r9pyNvZETYN0
         Onz+0Yw43l7kJy0qk4MaJ2zmHifyS84FBNB34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wC3XpAbdrr+LzG5IeIaPgeJngUybevp9aYabfXAPeFwH5lUQ+D+6jBE+sjWLwlBsk3
         qeI0JVgdAfOywrr+Ws4pA/3pGxZeITo2zVbJUuDD/1nr/wCVAQGtPkm0m0+XkAnkWBz3
         iuP6rwo5chexvp8YbJjEziUKJs5LL92b8Q+Pc=
Received: by 10.100.224.19 with SMTP id w19mr1342090ang.208.1265692659136;
        Mon, 08 Feb 2010 21:17:39 -0800 (PST)
Received: from gmail.com ([12.183.88.10])
        by mx.google.com with ESMTPS id 22sm1721089ywh.15.2010.02.08.21.17.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 21:17:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100209030151.GA5370@coredump.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139363>

On Mon, Feb 08, 2010 at 10:01:51PM -0500, Jeff King wrote:
> On Mon, Feb 08, 2010 at 04:59:12PM -0800, Junio C Hamano wrote:
> 
> > > And obviously that is weighed against the ability to notice things like
> > > typos. But if we are going to start complaining about unknown config, we
> > > would probably do better to complain about _all_ unknown config, and not
> > > just this one subsection.

No, please, please no.


> So in practice I think you will get quite spotty coverage. Which isn't
> to say it isn't necessarily worth doing, but I am personally not very
> excited about working on it. I do like the suggestion of making it
> optional, so that people who don't care about having a portable config
> can have the benefit of sanity-checking their config.
> 
> I would rather have a "git config --lint" command, but that is even
> harder, since we are not even loading most of the subsystems which know
> about the valid config options. And it presupposes that people will
> bother to actually run such a lint command.

This runs up against the same issue you pointed out
earlier--that older versions of git cannot adequately lint
configs from newer versions.

There are also config variables from unknown git scripts outside
of git.git that happen to use the git-config mechanism because
it is convenient.  It would be unfortunate to punish those who
chose to make up their own config variables by warning them
that git doesn't know about them.

I have to wonder if this is a non-existent problem.

Config variables are one-shot things.  You set them and forget
about them.  When you set it you are usually pretty well aware
of whether it's typoed because it simply does't work.
color.ui is a perfect example.  If it's typoed, you don't need
'git config --lint' to tell you, you already know by virtue of
using the thing.

Maintaining 'git config --lint' would also be a PITA since we'd
then have to remember to update yet another place in addition to
code and documentation.  And who's to say what gets to be "in"
and what doesn't?  git-gui, for example, has its own [gui]
namespace.  git-p4 has its own [git-p4] namespace, but it
lives in contrib/, etc. etc.

This seems like a bad idea to me.

-- 
		David
