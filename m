From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-remote - Unset core.origin when deleting the	default
 remote
Date: Tue, 15 Jan 2008 00:02:45 -0500
Message-ID: <478C3E75.2030801@gmail.com>
References: <478A3284.1000102@gmail.com> <1200241631-3300-1-git-send-email-mlevedahl@gmail.com> <1200241631-3300-2-git-send-email-mlevedahl@gmail.com> <20080114110512.GA12723@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.org, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 15 06:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEdxG-00081Q-UE
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 06:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbYAOFCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 00:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbYAOFCu
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 00:02:50 -0500
Received: from hs-out-0708.google.com ([64.233.178.241]:28381 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750806AbYAOFCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 00:02:49 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2166578hsz.5
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 21:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=jX1NnwVYTuAH6vNepAfl287WD+1ApbJq2e/YpQhfhyk=;
        b=U01AzQc6O47jKF9S1jGBp+rkVtHIVViMxA4Xv+OzgpuR60zvE3QwvFA1Ck0t1ZOTohHzPcHlP1cPrIFXDYie53VREPwq+p8vBSBuRZNJK10lVnRbsKYOGG55G/sRm6+hdHfqysQR7gYpJaOwLOgaY2uKYqkvbb5XZYMN56MJp2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=X4uNnVRdcJfvCA30hE1eJQVCXDnqu4+2Vv31dPg3hR+q/47SJ6jr9ZJosrUbzHrC5xBAsGO1CicUoph3fzD6WHN8/9iPjxSEvAZSkArGUDHOQeUTT4mpYBZw0X4Nf3D+CvIwx3WtulcD7Bt3W2docRSB7xfvjqQpmNupwBEA1hA=
Received: by 10.150.201.13 with SMTP id y13mr2801114ybf.53.1200373368308;
        Mon, 14 Jan 2008 21:02:48 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id h36sm25653016wxd.29.2008.01.14.21.02.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 21:02:46 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20080114110512.GA12723@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70500>

Jeff King wrote:
> On Sun, Jan 13, 2008 at 11:27:08AM -0500, Mark Levedahl wrote:
>
>   
>> --- a/git-remote.perl
>> +++ b/git-remote.perl
>> @@ -328,6 +328,11 @@ sub rm_remote {
>>  
>>  	$git->command('config', '--remove-section', "remote.$name");
>>  
>> +	my $defremote = $git->config("core.origin");
>> +	if (defined $defremote && $defremote eq $name) {
>> +	       $git->command("config", "--unset", "core.origin");
>> +	}
>> +
>>     
>
> I'm not sure I see the use case that this helps.
>   
Just being thorough: the man page claims that "git remote rm foo" 
removes all mention of remote foo.

>     Alternatively, when adding a remote, if it is the _only_ remote (or
>     perhaps if the current core.origin doesn't exist), we could set
>     core.origin which would automagically cover the latter two cases.
>     Although it feels a little too DWIM.
>
> -Peff
>   
I suspect anything done in this case is going to suffer from DWIM-itis 
in some conditions. I can't offer a better argument than the one above.

Mark
