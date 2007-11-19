From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Mon, 19 Nov 2007 23:29:44 +0100
Message-ID: <200711192329.44905.jnareb@gmail.com>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site> <200711192204.26772.jnareb@gmail.com> <7vfxz1naq0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:30:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuF88-0008Ht-6j
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbXKSW3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbXKSW3s
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:29:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:24891 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbXKSW3r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 17:29:47 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1563536nfb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=DY+jrx/09b1OtWNc2g6POCXJSBt7uws+JbOw082WnJw=;
        b=Gm7IQWf+eqMulgrRbU04har4rryTd8l+SfcHBINKGlpD6IGr4BYxFmeaP7Ucd1AbiTQxgbIYAM3uil3MVQB2vRmP7lxL1PfqG2jrAwTgC6HE/+YHtEdE4yETTQ6Kv1QNtwQCwag9T6yAydAWIKwAl3u1RvzA8NAI9lhVPInj0JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iwhxXKLZ3Ke7JZ4Xezjaa9IZT/2bMLJB3jAqNvp1hx5YRdxpdDAkem9/wmrn+lEBTzcX6KTreUV7aKW5iUmI7outaTOvjf/NOotGYomOwRi4+VePRy+17ZekrfQrewyifRtw7A+3mdEyYDlq+VPNhGxPFpMnkURervQUftRZTbA=
Received: by 10.86.26.11 with SMTP id 11mr5473683fgz.1195511386103;
        Mon, 19 Nov 2007 14:29:46 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.246])
        by mx.google.com with ESMTPS id e20sm7477255fga.2007.11.19.14.29.44
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Nov 2007 14:29:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfxz1naq0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65510>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano wrote:

>>> IOW, make these: 
>>> 
>>> 	$ git push HEAD
>>>     $ git push next
>>> 
>>> push the obvious thing to the default remote, I _think_ we can
>>> achieve the same effect as --current and a bit more.
>>
>> The only problem would be when there is conflict between remote name and 
>> branch name...

What about idea of using "--" to separate remote from branchname?

> Yes.  *If* we were to do that fallback it has to be something
> like this:
> 
>  (1) does $0 look like remote and $1..$n look like a refspec?  If
>      so do not fallback;

By "look like remote" you mean that there is [remote "$0"] section
in config (I guess that we can not support old .git/remotes/<remote>
configuration for _new_ features, especially that there exist script
converting to new way of configuring remotes, contrib/remotes2config.sh)
 
>  (2) Do we have branch.$current.remote?  If not, we cannot
>      fallback so error out.

Do not fallback to "origin"?

>  (3) otherwise, does $0 look like a refspec?  If so, try insert
>      it before the params, treating $0..$n all refspecs.

You mean $0 is existing branch, or of the form branch:<whatever>?
Or should we forbid remote names containing ':'?

>> BTW. what would happen for "git push branch1 branch2" if branch1 has 
>> different remote than branch2?
> 
> Read my example more carefully.  It says "push HEAD" and "push
> next" while on 'pu' and it takes branch.pu.remote.

Somehow I missed that $current means _current branch_ (branch we are on,
which defines default remote). 

-- 
Jakub Narebski
Poland
