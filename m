From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH for maint] git-completion: fix zsh support
Date: Thu, 5 May 2011 18:25:03 -0500
Message-ID: <20110505232503.GA7507@elie>
References: <20110505185907.GD1377@goldbirke>
 <1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:25:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI7vN-0002cJ-1r
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 01:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab1EEXZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 19:25:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64458 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab1EEXZN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 19:25:13 -0400
Received: by iwn34 with SMTP id 34so2241441iwn.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HM9OBmbrNLc6gAycLdE9pU7xo4Fk/U2+daKKCfg2sQM=;
        b=aSQpqX1UIt6wyOmAWezU6GdhDfpz6rvc+H3Z4JDJWCIB712ZnrNE7KIPbqSKbJRDic
         30Kc/Mi6w1hdTB/N40hVNHqObYSI8ytsNuR1ujeniliEAH/W6mLcn+2SMLUjY1WTItBY
         cM2LNrVYdoNeGyKZFIsS+HxFT4IKF/Z9q6JHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iDILl6CyicUvdhYudz4f1WxngpUxOeNA5kSM73MoqGIhswFbnF9/NR/FRI8vg5eT7t
         lX4q+49xl+MbLfHrTR9bgEa0K1/R8XYS+IGE0FC6A6aGYyhoKTdejXpbY1YOeDZkP2yy
         opigr89sAkA+MIkmdlV8ucpXOcfaAAxB2yj+4=
Received: by 10.43.55.141 with SMTP id vy13mr1566842icb.477.1304637912163;
        Thu, 05 May 2011 16:25:12 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id 4sm1076662ibc.15.2011.05.05.16.25.09
        (version=SSLv3 cipher=OTHER);
        Thu, 05 May 2011 16:25:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172923>

Hi,

Felipe Contreras wrote:

> It turns out 'words' is a special variable used by zsh completion.
>
> There's probably a bug in zsh's bashcompinit:
> http://article.gmane.org/gmane.comp.shells.zsh.devel/22546
>
> But in the meantime we can workaround it by using 'typedef -h', which
> gets rid of any special meaning.

As I mentioned before (sorry to come in late; I assume you forgot to
cc the previous participants in the discussion?), I do not think this
is a good fix.

The point here is that 'words' is a special variable used by zsh
completion, and we are using facilities from zsh completion.  So
if you set 'typeset -h', then the zsh completion functions will
use _our_ copy of "words".

Now in practice our copy of words matches zsh's anyway, so nothing
goes wrong.  But that could easily change in the future.

> Currently zsh is completely broken after commit da48616 (bash: get
> --pretty=m<tab> completion to work with bash v4), which introduced
> _get_comp_words_by_ref() that comes from debian's bash_completion
> scripts

The bash_completion project does not originate in Debian fwiw; it
was originally from Ian Macdonald iirc and available from

  http://www.caliban.org/bash/index.shtml

and then it was abandoned.  The bash-completion project on alioth is
not Debian-specific, either.

Maybe simplest would be to use Szeder's fix + make the zsh version of
_get_comp_words_by_ref not overwrite "words" at all?

Hope that helps,
Jonathan
