From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH try 2] gitweb: Add option to put a trailing slash on pathinfo-style project URLs
Date: Mon, 15 Dec 2008 00:58:34 +0100
Message-ID: <200812150058.36038.jnareb@gmail.com>
References: <1229195421.3943.8.camel@mattlaptop2.local> <1229219030.3360.44.camel@mattlaptop2.local> <200812150020.53370.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 01:00:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC0sO-0007VJ-I4
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 00:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbYLNX6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 18:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbYLNX6j
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 18:58:39 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:54892 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbYLNX6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 18:58:38 -0500
Received: by ewy10 with SMTP id 10so2744689ewy.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 15:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VjwcF1hOlJZPXOccWIPqSxRs/zeZtKpb4ma3i3hpBS0=;
        b=xvhNj4eC9lwKBwhU28MU2SJiLwyRyV430YiLpwfd0K29f3Pwu2v6Cp72iECAUCJ5Zc
         lxEAsT6wPGe4sd5SH0IXWrGBKmvwxy2gAEIBKDF2jS5Da7ARBXdm4p8zrZ9DqbA6yy3O
         fa2z+Nns6EXdizudNUGVYfW2Qd3zOMii0ec+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DuFICWKKhFWAHONQz2KOd6n89KdDRHwdNf8ozCSx4J+2DTvBDV5Jx3l3QoJ3HaPTvr
         PbteNGEBvVBvoVITawptpYF/iruiQcic/PStw+c2RlVEasOy2wm6DIOwGUyoQKpM5ZzD
         T//l5bH8iqvba1goHR4HETdjIM+LVgdNeIWBU=
Received: by 10.210.125.13 with SMTP id x13mr3752105ebc.48.1229299116749;
        Sun, 14 Dec 2008 15:58:36 -0800 (PST)
Received: from ?192.168.1.11? (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id 3sm878015eyi.30.2008.12.14.15.58.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 15:58:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200812150020.53370.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103111>

On Mon, 15 Dec 2008, Jakub Narebski wrote:
> On Sun, 14 Dec 2008, Matt McCutchen wrote:
>> On Sat, 2008-12-13 at 13:47 -0800, Jakub Narebski wrote:

>>>> @@ -845,7 +850,12 @@ sub href (%) {
>>>>  		$href =~ s,/$,,;
>>>>  
>>>>  		# Then add the project name, if present
>>>> -		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
>>>> +		my $proj_href = undef;
>>>> +		if (defined $params{'project'}) {
>>>> +			$href .= "/".esc_url($params{'project'});
>>>> +			# Save for trailing-slash check below.
>>>> +			$proj_href = $href;
>>>> +		}
>>>>  		delete $params{'project'};
>>>>  
>>>>  		# since we destructively absorb parameters, we keep this
>>>> @@ -903,6 +913,10 @@ sub href (%) {
>>>>  			$href .= $known_snapshot_formats{$fmt}{'suffix'};
>>>>  			delete $params{'snapshot_format'};
>>>>  		}
>>>> +
>>>> +		# If requested in the configuration, add a trailing slash to a URL that
>>>> +		# has nothing appended after the project path.
>>>> +		$href .= '/' if ($use_pathinfo[1] && defined $proj_href && $href eq $proj_href);
>>>>  	}
>>> 
>>> The check _feels_ inefficient.  I think (but feel free to disagree) that
>>> it would be better to use something like $project_pathinfo, set it
>>> when adding project as pathinfo, and unset if we add anything else as
>>> pathinfo.
>> 
>> I considered doing that, but I decided that not having to litter the
>> preceding code with manipulation of $project_pathinfo outweighed
>> whatever negligible performance difference there might be.
> 
> On the other hand, with having boolean variable named for example
> $trailing_slash or $add_trailing_slash, you can set it to appropriate
> value by default (should project list URL: http://example.com/ have
> trailing slash), and at [almost] each 'delete $params{<param>}' either
> set it to true, or set it to false. This way it would be easy to
> extend to have trailing slash also for example for OPML link
> http://example.com/opml/ or not have it and use http://example.com/opml
> 
> I think it is not only more efficient, but is also more flexible.
> Admittedly it is also more complicated...

On the other hand you don't need such flexibility, so perhaps simpler
code (or at least less changes) outweights this issue...

-- 
Jakub Narebski
Poland
