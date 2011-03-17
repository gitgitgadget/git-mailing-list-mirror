From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH] pretty.c: Make user defined format honor color option
Date: Thu, 17 Mar 2011 09:39:51 +0000
Message-ID: <1300354791.3269.19.camel@wpalmer.simply-domain>
References: <4D81C741.8060108@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Egerer <thomas.egerer@secunet.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 10:41:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q09hX-00038f-0m
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 10:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab1CQJkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 05:40:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54633 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab1CQJj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 05:39:57 -0400
Received: by wya21 with SMTP id 21so2561492wya.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=BRwxp1c3G2zakrMvUNsRnHU6UhdusZDLkXwIPDhypaQ=;
        b=MB5dXiX+krv3rD3zGUKqEXZ37j8jcA/hPHRsCdduah8g9Sxh8vqpB+W703lQBX+xr1
         T81tvIdrKUF+BGh4v4K2IuKGgsgL220syN2GKbR+KBaFYlQj7kjodVagC2Dg+0qZw/Hq
         gOuaSRv8zac6dyRxZkd3pcXDqlR5zg854ivY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Z2qTCIfXOzLDyzcmBXBvpiJ17d/tBW9f05kkF11MKgBHkZ9BrRr/U6r/ihQWV4KA/Z
         bSAVvCNitlAmxStyPyZdnbC8+y8rgGRclwdq8wI83i5qtFZFk87612dZuS++JB4VgoSd
         WlMeviI00dNGgToW7ZRz2C6vlkp5n+p056Q/8=
Received: by 10.227.149.73 with SMTP id s9mr1146697wbv.156.1300354796537;
        Thu, 17 Mar 2011 02:39:56 -0700 (PDT)
Received: from [192.168.2.64] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id bd8sm528816wbb.18.2011.03.17.02.39.52
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 02:39:53 -0700 (PDT)
In-Reply-To: <4D81C741.8060108@secunet.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169227>

On Thu, 2011-03-17 at 09:33 +0100, Thomas Egerer wrote:
> This patch fixes that the pretty-formats tformat and format ignore
> git's color option.

It is my understanding that this is intentional, the logic being: If you
normally don't want color, but have specified it directly on the
command-line, you probably want color.

It is arguable that this logic does not hold for format aliases, of
course. (and personally I've never agreed with the above logic anyway)

iirc, there are a couple of other places beyond log-tree.c which need to
propagate COLOR_DIFF into the pretty context if you want to respect the
colour option in user-specified formats. Skimming my own diffs:
rev-list.c and shortlog.c

Of course, explicitly propagating "diff_opts" settings like this just
shows off how poorly named these things are if we're going to use them
for this sort of thing. That's probably a place for another patch,
though.

I've got a patch to add support for conditional formats, including such
things as: %(opt-color: %Cred%h%Creset, %h). I'm currently in the
process of re-rolling just the "long options" part of that into
something more-manageable, but honestly that's the bulk of the change,
so if that gets accepted then adding %(opt-color...) would be pretty
trivial.

--Will
