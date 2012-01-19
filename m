From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT
 defined
Date: Wed, 18 Jan 2012 18:12:25 -0600
Message-ID: <20120119001225.GA13975@burratino>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <7vfwfervt9.fsf@alter.siamese.dyndns.org>
 <20120118195438.GA18892@blimp.dmz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 01:12:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnfcY-0003U7-0o
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 01:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab2ASAMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 19:12:37 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49444 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753988Ab2ASAMg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 19:12:36 -0500
Received: by obcva7 with SMTP id va7so7967011obc.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 16:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O6MMPxJNcKmzbFlNtZ7w9FAc9/3YXOZTtwcmRzjiMDo=;
        b=C9nL3oW/fKDLskA5qFIDbOc8bPaCxTgjtoJzxBBJyfwFBoYS0BiwqWZo9mSyL4Daea
         +mbx2GsHyyKB8iyKWlRUXt1+eD79yJUn0h5twwXMB015DIbbz2Yq/1VGaMtERPVw10jX
         XcdCvFEe3sOEKUHcgP3Vj1rz5+01Q40qkZKlE=
Received: by 10.50.193.229 with SMTP id hr5mr24830744igc.15.1326931956099;
        Wed, 18 Jan 2012 16:12:36 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z22sm94429146ibg.5.2012.01.18.16.12.35
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Jan 2012 16:12:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120118195438.GA18892@blimp.dmz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188779>

Hi,

Alex Riesen wrote:

> [Subject: i18n: disable i18n for shell scripts if NO_GETTEXT define]
>
> Otherwise the i18n is used in the scripts even with NO_GETTEXT set.
> It is very unexpected.

Sounds like a good idea.  Quick comments:

[...]
> --- a/git-sh-i18n.sh
> +++ b/git-sh-i18n.sh
> @@ -16,61 +16,44 @@ else
>  fi
>  export TEXTDOMAINDIR
>  
> -if test -z "$GIT_GETTEXT_POISON"
> +GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
> +if test -n "@@NO_GETTEXT@@$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
> +then
> +	: no probing necessary
> +elif test -n "$GIT_GETTEXT_POISON"
>  then
> -	if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh >/dev/null 2>&1
> -	then
> +elif test -n type gettext.sh >/dev/null 2>&1
> +then

I like the unindenting.  Alas, I get

	1: test: type: unexpected operator

I suspect this should just say "elif type gettext.sh >/dev/null 2>&1".

The rest looks good.  Thanks for writing it.
