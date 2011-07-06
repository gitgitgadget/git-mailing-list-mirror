From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Wed, 06 Jul 2011 06:59:53 -0700 (PDT)
Message-ID: <m3r5634ijc.fsf@localhost.localdomain>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
	<20110702104313.GA10245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Al Haraka <alharaka@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 06 16:00:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeSe3-0006zd-HV
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 16:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab1GFN74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 09:59:56 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:62889 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab1GFN7z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 09:59:55 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so111521fxd.11
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :message-id:lines:user-agent:mime-version:content-type;
        bh=WT5gLLWYcSFvtI62kVOn4dND+GaRtN7wTQMGPhujHII=;
        b=BnLUQKvO+Lce/nSCnfSTm/K6mEI8sy6kgnEaKfTpRyP2/ps/5/98b8VPLlKJ6nIzuX
         +QARuSEQJOzbxcoTM6+RAEtuMeHc7HHKwJspWWBMZz37kNA9n2CvfDs7avJFVoe+DjRX
         9+dhbscw58O0G2PpAB6ZQxhzkkOwcAVoXVgco=
Received: by 10.223.145.2 with SMTP id b2mr13184354fav.99.1309960794472;
        Wed, 06 Jul 2011 06:59:54 -0700 (PDT)
Received: from localhost.localdomain (abvw74.neoplus.adsl.tpnet.pl [83.8.220.74])
        by mx.google.com with ESMTPS id q14sm6037903faa.27.2011.07.06.06.59.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 06:59:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p66DxK87011610;
	Wed, 6 Jul 2011 15:59:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p66Dx4Zx011600;
	Wed, 6 Jul 2011 15:59:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176703>

Jeff King <peff@peff.net> writes:

> On Sat, Jul 02, 2011 at 12:50:12PM +0300, Al Haraka wrote:
> 
> > So, I tried different variations of this, specifically for repos.
> > Now, I have tried it globally as that was tedious and it was not
> > working anyway. That works some of the time if I try commands over the
> > console (git log  -p for quick testing), but never in Gitweb.  It
> > continues to only say they are differing binary files.  Does Gitweb
> > 1.7.5 support the use of this?  Is there something special I must do?
> > Below is my current config:
> 
> The default gitweb configuration doesn't allow textconv (or external
> diff) for security reasons; it would mean repo owners could execute
> arbitrary commands as the gitweb user.
> 
> If that's OK for your site, you can probably enable it with:
> 
>   push @diff_opts, '--allow-textconv';
> 
> I don't know that anybody has tested that, though. It will use textconv
> _everywhere_ in gitweb, including the "format-patch" invocation for
> showing raw patches of commits. It might make sense in the long run for
> gitweb to have another variable like @diff_opts that is used for
> human-readable output (e.g., the HTML output, but not anything you might
> import to a tool).

Actually I think neither git-format-patch (which is used by 'patch'
and 'patches' views), not git-diff-tree (used by 'commitdiff' and
'blobdiff' views, and their *_plain versions) supports --textconv,
and that it is supported only by git-diff.  But you better check that.

Nb documentation as of 1.7.5 is entirely unhelpful.  Only git-cat-file
is documented as using --textconv... though this option is examined
in diff.c, and there is test for git-blame supporting it.


By the way, I don't know if git read .gitattributes file (which
defines textconv... unless you use per repository instance
.git/info/attributes) from tree for given commit, or only from working
area.  

git-chec-attr (official script API) can check only state of
gitattributes in working area.


So I don't think that gitweb can support textconv in diffs; it should
be quite easy to add suppport for --textconv in 'blob' view, ...

... but it wouldn't be in gitweb 1.7.5 ;-)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
