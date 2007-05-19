From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix "Use of uninitialized value" warning in git_feed
Date: Sat, 19 May 2007 04:08:40 +0200
Message-ID: <200705190408.40702.jnareb@gmail.com>
References: <1179535671566-git-send-email-jnareb@gmail.com> <7vtzu937t6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 04:08:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpENM-0001Cd-7o
	for gcvg-git@gmane.org; Sat, 19 May 2007 04:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbXESCIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 22:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbXESCIq
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 22:08:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:60168 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXESCIq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 22:08:46 -0400
Received: by ug-out-1314.google.com with SMTP id 44so634931uga
        for <git@vger.kernel.org>; Fri, 18 May 2007 19:08:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hjcztwwV2LbbEYxmZ/29EN+Drlpu4w316yppmd2UIYtDc4OG3+JazMbl3Sv6SxrUuUOFlIuEGoQdd2FzqQhbAXnDb7RWVlcr+r2teZDuh6Adm8S8R3JRKp/42xTk0sIU3148qJZiIkviFXCt2wj2Qm9chGMhz7rGL3yZfSE18n8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hSj0Omuw38CdKS6iN+xDR1KilaAy1n/wZ5AnuWMT1qvLMRxF7d79Tlbu62hb0xBjRxFdjUMHWlMS4j+oJVF+aheqZpGGrVyOAF6y/MC7zty4u/0K4v9WVpVGDnlQkU7Dqc3NY81/NXmCcGqF2bM2GRQA8M3wKEtqd1q5XGAK4sY=
Received: by 10.67.6.14 with SMTP id j14mr1452385ugi.1179540524494;
        Fri, 18 May 2007 19:08:44 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g1sm8243405muf.2007.05.18.19.08.43;
        Fri, 18 May 2007 19:08:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtzu937t6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47704>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Initial (root) commit has no parents, and $co{'parent'} is
>> undefined. Use '--root' for initial commit.
>>
>> This fixes "Use of uninitialized value in open at gitweb/gitweb.perl
>> line 4925." warning.
[...]
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -4923,7 +4923,8 @@ XML
>>  
>>  		# get list of changed files
>>  		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
>> -			$co{'parent'}, $co{'id'}, "--", (defined $file_name ? $file_name : ())
>> +			$co{'parent'} || "--root",
>> +			$co{'id'}, "--", (defined $file_name ? $file_name : ())
>>  			or next;
>>  		my @difftree = map { chomp; $_ } <$fd>;
>>  		close $fd
> 
> I do not think you would need to make --root conditional...

I need at last make $co{'parent'} conditional, i.e. at least 
"$co{'parent'} || ()" or equivalent (e.g. like for $file_name).
I cannot omit $co{'parent'} because parents might be rewritten;
feeds accept now path limiting. So why not this way?
-- 
Jakub Narebski
Poland
