From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] Cached the git configuration, which is now noticibly faster on windows.
Date: Sat, 08 Nov 2008 02:13:32 -0800 (PST)
Message-ID: <m3mygaeda0.fsf@localhost.localdomain>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
	<1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
	<ee77f5c20811072119y65738f54o7e6792fb405c142c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "John Chapman" <thestar@fussycoder.id.au>, git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 11:14:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KykqG-0006na-86
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 11:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbYKHKNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 05:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbYKHKNg
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 05:13:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:4880 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbYKHKNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 05:13:35 -0500
Received: by nf-out-0910.google.com with SMTP id d3so801071nfc.21
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 02:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=rc6nVqNU2opTUGe0zhp6m4MZEV+TWrHOD+rzBOI6Q5A=;
        b=B+FgI3yHQ3ZtDdN+7wnkStJ/An2TBemAQvcxSuBRY5ALfV758XkIYwzgWkVeNRnSr1
         tbhbU2+nexV2vixfqUnBo/ndAHiSar2JMWyjjnfPIg8auNYxnNGNkkNBk5AI2+l5ImGC
         M4k3G6KuogOFPwFRYWx6JFuCCD6ZK9TP+7/Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=gZAzwrG7vh1bAl53E2YuJC4IgslO2KKoe/HcOfRlFgS4KkmtQg42LmkvB0L8QQSkuq
         Nb95t6dOY/vkTQOJRH6jTNBcMd3eTJMk4C6VJl2W8xg7dOrbguNmhEISZ/enYxRc50Lb
         tNkFv/pKDlhbMVNIH6306x5Uoy9ObMSyUhE1g=
Received: by 10.210.105.19 with SMTP id d19mr5067664ebc.5.1226139213531;
        Sat, 08 Nov 2008 02:13:33 -0800 (PST)
Received: from localhost.localdomain (abwx16.neoplus.adsl.tpnet.pl [83.8.247.16])
        by mx.google.com with ESMTPS id 5sm5397436eyh.2.2008.11.08.02.13.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Nov 2008 02:13:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA8ADTLd025709;
	Sat, 8 Nov 2008 11:13:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA8ADRA5025706;
	Sat, 8 Nov 2008 11:13:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ee77f5c20811072119y65738f54o7e6792fb405c142c@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100393>

"David Symonds" <dsymonds@gmail.com> writes:

> On Fri, Nov 7, 2008 at 7:22 PM, John Chapman <thestar@fussycoder.id.au> wrote:
> 
> > +_gitConfig = {}
> >  def gitConfig(key):
> > -    return read_pipe("git config %s" % key, ignore_error=True).strip()
> > +    if not _gitConfig.has_key(key):
> > +        _gitConfig[key] = read_pipe("git config %s" % key, ignore_error=True).strip()
> > +    return _gitConfig[key]
> 
> If this is truly a noticeable bottleneck on Windows, something like
> the following might be even better:  (completely untested!)
> 
> _gitConfig = None
> def gitConfig(key):
>   if _gitConfig is None:
>     lines = read_pipe("git config -l", ignore_error=True).readlines():
>     _gitConfig = dict([l.strip().split('=', 1) for l in lines])
>   return _gitConfig.get(key, None)

Wouldn't it be better to use "git config -l -z", split lines at "\0"
(NUL), and split key from value at first "\N" (CR)? This format was
meant for scripts.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
