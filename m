From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file with project owner name
Date: Tue, 29 Jan 2008 16:28:19 +0100
Message-ID: <200801291628.21026.jnareb@gmail.com>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <m3lk6898kg.fsf@localhost.localdomain> <20080129142550.GA25312@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Tue Jan 29 16:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJsOZ-0004qn-8W
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 16:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbYA2P2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 10:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbYA2P2d
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 10:28:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:64432 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbYA2P2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 10:28:31 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2118254fga.17
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=nuno446acdO3QdJ8r1OYODQYiaCpvTX4wIPiMzB123U=;
        b=QYTrGLu1Cikn8B1/QRY+wUuM5YHygTYdzdWvVkPU1HSZWvtQOpIco49ogabeYrPVOMQuZs13rJbGX8jpOf5IECvCPvlfhMvEwUTRLgtiIVcI2u9eAi9YiJRDDw9wrrKVNKWNTMgznpNHLgI0qF0c1/C4/Mdo7QdA0sxPFR7NtwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X2DMfE5zsL2XNa/7qxRHWu4MGnhTHerbl6I5CRWN3AVE7g7DGTjHvCVMgHEE530g2j5BN8CVk/YLBXCkZNftyFaNYPwxdcbpnR+CUm6TL2y8YSab7smlQK5qVn5UswMsK3YiI0x6/l9TsGDO8SOn6qASH937UcVqwqf+xlYs/1E=
Received: by 10.82.181.7 with SMTP id d7mr12402134buf.8.1201620508991;
        Tue, 29 Jan 2008 07:28:28 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.244.23])
        by mx.google.com with ESMTPS id q9sm9189378gve.10.2008.01.29.07.28.24
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Jan 2008 07:28:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080129142550.GA25312@c3sl.ufpr.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71980>

On Tue, 29 Jan 2008, Bruno Cesar Ribas wrote:
> On Tue, Jan 29, 2008 at 03:26:31AM -0800, Jakub Narebski wrote:
>> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
>> 
>>> This file ($projectroot/$project/owner) is good to have when we don't want to
>>> maintain a project  list AND when we share same SSH account for all projects,
>>> using ssh_acl for example.
>>>
>>> Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
>> 
>> This explanation is a bit too complicated; it explains farther
>> reasons, instead of immediate ones: you don't want to maintain project
>> list file, and all repository directories have to have the same owner
>> (for example when the same SSH account is shared for all projects,
>> using ssh_acl to control access instead).
> 
> I'm sorry about this complicated explanation.

It is not [that] bad description, but it could be better. Also, 80 columns
word wrap is good, but 72-76 would be even better :-)

>> Besides with new faster config reader we probably would want to allow
>> to use config file to set owner, instead of adding yet another file to
>> the repo area; see commit 0e121a2cd42d28bc4034feedf8a13c5a91f85bd3
>>   "gitweb: Use config file for repository description and URLs"
>> This would have the advantage that you could use system config
>> (/etc/gitconfig) to set fallback owner instead of relying on
>> filesystem.  I'm not sure what should be the preference, though:
>> gitweb.owner, then $GIT_DIR/owner, or vice versa?  I guess that
>> reading $GIT_DIR/owner should take preference, as it is needed also
>> for projects list page, where ordinary we didn't read individual
>> repositories configuration.
> 
> Reading $GIT_DIR/owner would be the preference, Maybe it can generate project
> list page faster when machine have high IO waits (WA).

Yes, I also think so. Two file reads (description + owner) should be
still faster than one running git-config, and parsing its output.

But I think if IO matters it is better to generate projects list; you
can even use gitweb for that, or you can simply add a line with URL
escaped project name (project path) relative to $projectroot, separated
by space from the URL escaped (URI-encoded) project owner.  See also
"Gitweb repositories" section in gitweb/INSTALL.  Adding projects is
rare event.
 
> Having gitweb.owner is good too, but as you said I don't need to read
> individual repositories configuration.
> 
> Having another file at the repo area is not a problem (my say). Sometimes
> having files appears to be more organized than having everything in one file
> (my say again).

By the way, I have forgot to ask you to add description of new 'owner'
file to "Per-repository gitweb configuration" section in gitweb/README

> I even made another patch about cloneURL, instead of looking for inside files
> and stuff, i made gitweb.conf a variable that says:
> - If i have a prefix path for HTTP,SSH,GIT[protocol]
> Then if this variable is set gitweb only mounts... like
> HTTPPREFIX="http://git.c3sl.ufpr.br/pub/scm"
> and gitweb sets it to $HTTPREFIX/$project
> 
> I made this because I don't want to set each project it's clone URL, so this 
> makes thing easier! What do you think?

I hope that this hack predates latest improvements to gitweb/README,
as you have just reimplemented GITWEB_BASE_URL build configuration
variable (only single base URL), and @git_base_url_list, which you
can set in gitweb config file (by default gitweb_config.perl).
 
If you have read current code carefully, you should notice that
currently gitweb generates URLs for repository in the following way:

 1. Per repository configuration:
    a. $projectroot/$project/cloneurl (one line perl URL)
    b. multivalued gitweb.url configuration variable in project config
 2. Global gitweb configuration
    a. $prefix/$project for each $prefix element in @git_base_url_list,
       which is set in gitweb_config.perl
 3. Build time defaults
    a. Single value in @git_base_url_list set using GITWEB_BASE_URL
       build configuration variable
 4. Otherwise it is not set (it is empty).

-- 
Jakub Narebski
Poland
