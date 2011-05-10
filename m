From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 (for maint)] git-completion: fix regression in zsh
 support
Date: Tue, 10 May 2011 17:16:00 -0500
Message-ID: <20110510221600.GD1994@elie>
References: <1305030039-16044-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 00:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvDx-00009R-4H
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab1EJWQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 18:16:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62701 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab1EJWQG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:16:06 -0400
Received: by gwaa18 with SMTP id a18so2307790gwa.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zJG8klnv3YP3ggbKVhohE6KEd8+zUG0z160nN5ocgQQ=;
        b=nZq36zpuWqQ4/WXECFsXg3y74UXrDHT1urgAPbn5ZYdrbqKVEfLXnRfLIhfkSnk0T8
         ODi/ttDQNJhaUMLRx7rnACpush778Xg4jWlo5pPXyyJCZiunAd58YGtMtO9Igw3dN2sR
         cvSKq6HW8YPkRLEANlOz5pEWx7yEZ9FVsLoU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GZNZr9vgKhEZ04Ncp7smEbOeRbMCBik6+nyeS4WSMkrhzincBFl4+FQxIoSXyas3or
         xK5MPVoIp/Lo2aKoqOU5xe0Yr1goHIAgemhSNa0t54h/5G7FVrU/FQ/elmv55kohWnGK
         yK+owemNez5lJW+KYD43L7g3eW7KiHgm0gbJ0=
Received: by 10.151.130.7 with SMTP id h7mr6815578ybn.366.1305065764953;
        Tue, 10 May 2011 15:16:04 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id f8sm1935954ybn.8.2011.05.10.15.16.02
        (version=SSLv3 cipher=OTHER);
        Tue, 10 May 2011 15:16:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305030039-16044-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173371>

Felipe Contreras wrote:

> Right now zsh is quite broken; the completion doesn't notice when
> there's a subcommand. For example: "git log origi<TAB>" gives no
> completions because it would try to find a "git origi..." command. The
> issue would be gone in zsh 4.3.12, but for now we can workaround it by
> porting the same fix.
>
> The problem started after commit v1.7.4-rc0~11^2~2 (bash: get
> --pretty=m<tab> completion to work with bash v4), which introduced
> _get_comp_words_by_ref() that comes from bash-completion[1] scripts, and
> relies on the 'words' variable. However, it turns out 'words' is a

The _get_comp_words_by_ref function does not rely on but writes to the
'words' variable.  Aside from that, this is a nicer summary.

> special variable used by zsh completion. From zshcompwid(1):
[...]
> [2] http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=commitdiff;h=e880604f029088f32fb1ecc39213d720ae526aaa

I doubt this URL will last forever.  Why not just say commit
e880604f029088f32fb1ecc, or '"29140: hide the "words" special variable
so that it may be used as an ordinary variable by bash completions",
2011-05-04' which conveniently includes a mailing list reference?

Thanks for the fix and your patience with me.  To answer the sincere
questions I could find among your replies to v4:

 - I included the "completion: move private shopt shim for zsh to
   __git_ namespace" patch in the series as a reminder to Junio,
   since he had requested one.

 - "in no part of [compgen] does the zsh emulation make use of the
   'words' special variable" is just plain false.  compgen -F uses the
   'words' variable, and we are lucky to have not needed to use it
   yet.

 - I changed the comment because when I read the original, putting
   myself in the shoes of someone who didn't know the context, I found
   it confusing.  "work around bug in old versions of zsh" just leaves
   me wondering "What bug?  Is it a bug in the behavior of 'local',
   and are we working around it by using an alternate spelling?"  

   That said, I suppose the main point of a comment is to say
   "something important happens here", and a person can use 

	git log -S"workaround zsh's bug" -- contrib/completion/git-completion.bash

   to find out what exactly it is, so no harm done.
