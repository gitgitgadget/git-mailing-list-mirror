From: Tobias Schulte <tobias.schulte@gliderpilot.de>
Subject: Re: [PATCH] git-svn: introduce --parents parameter for commands branch
 and tag
Date: Wed, 15 May 2013 21:51:40 +0200
Message-ID: <5193E74C.6000705@gliderpilot.de>
References: <1368476549-17886-1-git-send-email-tobias.schulte@gliderpilot.de> <20130515023547.GA21987@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 15 21:51:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uchjq-0002Vr-Em
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 21:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589Ab3EOTvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 15:51:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51529 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab3EOTvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 15:51:45 -0400
Received: from [192.168.178.26] (p54A16923.dip0.t-ipconnect.de [84.161.105.35])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Lb6lR-1UE4EW2c0X-00kOgN; Wed, 15 May 2013 21:51:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130515023547.GA21987@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:4fCVOSqGJEVQOdA5UqsA7f/lrbnvS6wu0qg+qP0/+KE
 fBVvwTWJjXaV+uAhMh/HFItzsGGi1oPLWPsQf+J6pePAjx8urP
 6A62ifzVinwtn+ntaUCKynaajzLDf+nXk3oKQzTe/tCKGehOls
 3nPEs8krkDIg8xbj9VXYETonSgO7MRtBCU8PzOEqMUteVHBg+U
 tP1DtCXfpjA9wmwG66PaMyNk54wPEPbpIBgLiH8KNTiElA4DRd
 vK4Qi08z9jY7j/aGRs4Ifz+guY0Po7Ws5v2GpHYz9LI8Ee1NQF
 RqOY0nPwboCSWldtgGBNj9e2/bpHdqE8Jp3JYNDHWOJ5FUlzmx
 ZDO6joGhFutLRawIJy9s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224446>

On 15.05.2013 04:35, Eric Wong wrote:
>> +	if (!eval{$ctx->ls($parent, 'HEAD', 0)}) {
>> +		mk_parent_dirs($ctx, $parent);
>> +		print "Creating parent folder ${parent} ...\n";
>> +		$ctx->mkdir($parent)
>> +			unless $_dry_run;
> 
> The newline is confusing, I prefer:
> 
> 		$ctx->mkdir($parent) unless $_dry_run;

In fact, this was a copy/paste from a few lines above

	print "Copying ${src} at r${rev} to ${dst}...\n";
	$ctx->copy($src, $rev, $dst)
		unless $_dry_run;

> Howeve :
> 
> 	if (!$_dry_run) {
> 		$ctx->mkdir($parent);
> 	}
> 
> May be preferred, too (especially for the non-Perl-fluent)

I am a non-Perl-fluent, as I come from the Java world with some
knowledge of C and C++. But to be able to create the patch I had to
gather some Perl knowledge, and by doing this, I learned enough to
understand, that there is more than one way, ... Especially the
constructs if (condition) foo(); vs foo() if (condition); and the same
for unless. And since the dry_run is the exception in this case, I think
unless is a valid choice -- and is used often in git-svn.perl. So I will
stick to it, but remove the newline.

> 
>> +++ b/t/t9167-git-svn-cmd-branch-subproject.sh
> 
>> +test_expect_success 'initialize svnrepo' '
>> +    mkdir import &&
>> +    (
>> +        (cd import &&
>> +        mkdir -p trunk/project branches tags &&
>> +        (cd trunk/project &&
>> +        echo foo > foo
>> +        ) &&
> 
> Tabs for all indentation, and indent consistently for subshells:
> 
> 	mkdir import &&
> 	(
> 		cd import &&
> 		mkdir .. &&
> 		(
> 			cd .. &&
> 			..
> 		)
> 	)
> 
> We use subshells + cd like this so it's easier to read/maintain.

Again, this was a copy/paste from t9128-git-svn-cmd-branch.sh. So this
file needs some cosmetics, too. And t9127... as well...

> 
> Thanks again, looking forward to applying v2.
> 

I will send v2 soon.

Tobias
