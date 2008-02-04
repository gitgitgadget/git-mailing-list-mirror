From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's name.
Date: Mon, 4 Feb 2008 15:00:48 +0100
Message-ID: <200802041500.49682.jnareb@gmail.com>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br> <200802010117.08295.jnareb@gmail.com> <20080204133542.GA8197@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Mon Feb 04 15:02:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM1tW-0004my-Dh
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 15:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756410AbYBDOBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 09:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756546AbYBDOBO
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 09:01:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:35201 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410AbYBDOBE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 09:01:04 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1151934ugc.16
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 06:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=b8R9NCXdLLvjJMQ8MDUlgMhYcIevVPAHfScMtZkT53g=;
        b=OZmBNN7/OG+Sq0EiM6zGQkCCDc+JVB+1OdG1B2cadpuPFyUGFEVdxhDYKHmNuv/0h114kx5A+G3aQIGHdUiM9b2zg2TwiNBatvLwqbiULjc7Jsg6AiwW5q+F597hfGUXIiqijX+QEC6kpm0qwLNvUIiKIDx9SWDz7S4cuC7oH+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VrCRqeTl5LlcLiU5r9ZnLytK2XWgIHP84NP1K/jAc955KBWToHS4l8wGFsIUMwjddHJVPUM6t+M8cGCn3xchGHltV+tXLAbUqEBA+IQV79N3gGxs75CYqHNKfS3g5KrQPEBWen21p9ulH6BArqvH8g/uv8P5QvcqgPx6lxDTsxs=
Received: by 10.78.175.14 with SMTP id x14mr12270395hue.7.1202133659740;
        Mon, 04 Feb 2008 06:00:59 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.201])
        by mx.google.com with ESMTPS id 2sm1271318nfv.38.2008.02.04.06.00.55
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Feb 2008 06:00:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080204133542.GA8197@c3sl.ufpr.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72504>

On Mon, 4 Feb 2008, Bruno Cesar Ribas wrote:
> On Fri, Feb 01, 2008 at 01:17:07AM +0100, Jakub Narebski wrote:
>><snip> 
>> Note that some of info is needed for 'projects_list' view, and some only
>> for the 'summary' view.

>> Currently for 'projects_list' view we have, when $projects_list is
>> a directory (this includes situation when it is undef, and fallbacks
>> to $projectroot):
>>  1. Call git-for-each-ref to get last modification time
>>  2. Read $git_dir/description file for description (which is generated
>>     by default template, so is usualy present, if in useless form),
>>     fallback to git-config / reading $git_dir/config, gitweb.description
>>  3. Check owner of $git_dir (stat + getpwuid)
>> 
>> With the addition of $git_dir/owner and gitweb.owner we would have
>>  3'. Read $git_dir/owner file, usually not present,
>>      fallback to gitweb.owner (which means reading and parsing
>>      repo config!),
>>      fallback to $git_dir owner (stat + getpwuid)
>> so after consideration I think that adding gitweb.owner is a bit of
>> a stupid idea from performance point of view, at least till we have
>> 'projects_list' caching. Only $git_dir/owner would be better.
> 
> Unless we parse config only once for each project. We can create a small
> cache with all gitweb conf. Then each time we ask
> git_get_project_config('bla') we check if we alread had parsed it, if parsed 
> get in a small hash table.

If you have read gitweb.perl current code more carefully, or browsed
"git log -- gitweb" output, you would notice that since b201927a

  gitweb: Read repo config using 'git config -z -l'

gitweb does just that. Reads whole repo config using "git config -z -l"
(this additionally includes support for user and system git
configuration files; also git config file format has some hairy corners)
into hash lazily, then uses this hash.

But this is once per repo, which for 'projects_list' might be too much,
especialy for the operating systems where fork is slow. I'd rather go
in opposite direction and add support for providing description in
'projects_list' file.

> We could even check if we are generating project list then we can store only
> description and owner. (this sounds ugly)

This doesn't buy us much, because description and owner migh be in the
last lines of repo config, so we have to read whole config file in full.

Note that if I understand this correctly variable initialization,
including %config and $config_file are generated anew for each request.
Besides, as it is now, viewing some project view would flush out
projects_list %config, etc.

>> Another solution would be using $projectroot/.gitconfig, with simplified
>> syntax easy parseable by Perl, with gitweb.<repo path>.<config>, where
>> <config> is limited to 'description', 'owner' and 'url', and 
>> gitweb.description for fallback description, gitweb.owner for fallback
>> owner and owner for set of repositories, gitweb.baseurl for base URLs
>> (gitweb.<repo>.url = gitweb.baseurl/<repo>).
> 
> This sounds good.  Having this small, simple file would make things better.
> But we will have another file inside repository, having all in config would
> be cleaner [i guess]. If we parse config file only once per project might be
> good.
 
I think that it would be better to separate gitweb configuration
(in gitweb_config.perl) fro [cached] repositories configuration
(in gitconfig or .gitconfig). 

-- 
Jakub Narebski
Poland
