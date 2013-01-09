From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: make default of "cleanup" option configurable
Date: Tue, 8 Jan 2013 23:29:52 -0800
Message-ID: <20130109072952.GC6503@elie.Belkin>
References: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 08:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsq7E-0005hV-B5
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 08:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab3AIHaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 02:30:02 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:62228 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab3AIHaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 02:30:00 -0500
Received: by mail-pa0-f41.google.com with SMTP id bj3so857567pad.0
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 23:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pudQTtrfUm62Krxv7vxkOHQLAf90ncLZkos1bTbgVEs=;
        b=WWXPCLHjZ10xtwoPsvFkCGr+pYgEAifN2I13QRYskQ2OKLtZnerHGGSsiDMLsJzOYd
         tFh3erITSJeKMqPH+DG62EgcmCSMP1HiAPJHMKzKIpa/KucLxkqHR3dei/zxNV/L47My
         KpoLOJ9s78dmx+V32pyCcY199dhkPigqtGYcT0K2cyXuxueUsiK+N2bsiAyuTSyocaNZ
         wsnrqerQrwuLIs7jauuxB60cYlvMVqlyv7CZmFL/+uATn2QZcUyTG7v9SsortyMmHKAc
         6e6bX7tGTPrybxpixIb+FvT3wVa1PDOLGgE/3NPKeaCHdYK3GQiPyYGrCSIhUUifMyfi
         0EQg==
X-Received: by 10.68.143.100 with SMTP id sd4mr197921125pbb.107.1357716598486;
        Tue, 08 Jan 2013 23:29:58 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id oi2sm41135413pbb.62.2013.01.08.23.29.55
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 23:29:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213029>

Hi,

Ralf Thielow wrote:

> The default of the "cleanup" option in "git commit"
> is not configurable. Users who don't want to use the
> default have to pass this option on every commit since
> there's no way to configure it.

Could you give an example?  I'm trying to get a sense of whether these
habitual --cleanup= passers would use --cleanup=verbatim or
--cleanup=strip.

I'm a bit worried that a setting like 'commit.cleanup = strip' would
be likely to break scripts.  Yes, scripts using "git commit" instead
of commit-tree while caring about detailed semantics are asking for
trouble, but I'm worried about importers, for example, which are
sometimes written by new git users.  Some scripts might assume that
"git commit" preserves the entire change description from their source
data, even when some lines happen to start by listing the ways the
author is #1.

I don't think that necessarily rules out this change, but:

 1. We need more of an explanation of the purpose than "this lets
    people type less".  What workflow does setting this option fit
    into?

 2. I would prefer to see a little thought about whether it's possible
    to avoid silently impacting scripts.  E.g., depending on the
    answer to (1), maybe supporting "verbatim" but not "strip" would be
    ok?  Or alternatively, maybe a search of public code repositories
    would reveal that new git users tend to write their importers in a
    way that this doesn't break.

As a side effect, the information gathered to answer (1) and (2) could
have the potential to make the user-level documentation more useful,
by adding context to the description of the configuration item.

[...]
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -103,7 +103,7 @@ static enum {
>  	CLEANUP_NONE,
>  	CLEANUP_ALL
>  } cleanup_mode;
> -static char *cleanup_arg;
> +const static char *cleanup_arg;

Style nit: storage class comes first, then the type.  Otherwise the
typename "const char *" is split up.

Hope that helps,
Jonathan
