From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file with project owner name
Date: Fri, 1 Feb 2008 14:18:57 +0100
Message-ID: <200802011418.59862.jnareb@gmail.com>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <200801292236.19630.jnareb@gmail.com> <47A09ED2.6070407@iksz.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Nagy =?utf-8?q?Bal=C3=A1zs?= <js@iksz.hu>
X-From: git-owner@vger.kernel.org Fri Feb 01 14:19:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKvo1-0001VK-VI
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 14:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139AbYBANTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2008 08:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755186AbYBANTM
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 08:19:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:16840 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbYBANTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 08:19:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so745849ugc.16
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 05:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=dny4ngexSNjk3/tDDaJQjPOi9qk1nLYaLvmZwzFbQVU=;
        b=c7fTMepQrSeSsrVeES0G5l+W6FP2HfFIlRf0DRlOWmbSKum2gRBNvJPL57MRmmw/XmHlaykiunQicfRuX6MsZZ/UzgHabM54nMS1TY2eub/aLoH6GMV4bXfgzNgk38QinrfWqVXzycWr8VEbMP7J3jKnQKO4ThkKvJphhnAjo5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=k3DM9Fte3eUcqEPqEHY+D1myvGSe8Gs3CHN9yloaWmJmUjCAbOsyoTegvU6/FgB8TWbay2Sp3sd/YSGl7YpdKkT+NO5N4kDloVbkbLzKr2g5rgZjxnSYbdQcODl/0dLVsOsRIjLA4wuZ2zevHsgWt7isin+9Rd2Uca3D/BceoyM=
Received: by 10.67.115.6 with SMTP id s6mr5430380ugm.71.1201871946292;
        Fri, 01 Feb 2008 05:19:06 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.248.93])
        by mx.google.com with ESMTPS id c1sm3743023ugf.72.2008.02.01.05.19.03
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Feb 2008 05:19:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <47A09ED2.6070407@iksz.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72172>

On Wed, 30 Jan 2008, Nagy Bal=C3=A1zs wrote:
> Jakub Narebski wrote:
>> Nagy Bal=C3=A1zs wrote:
>>  =20
>>> Are you talking about I/O of an all-in CGI script? =20
>>>    =20
>>
>> I am talking there between I/O difference between situation
>> (configuration) when $projects_list is a directory (default),
>> or is a file. If $projects_list is a directory, gitweb scans
>> directory structure to find git repositories, which for large
>> number of repositories might take time, even with filesystem
>> cache, and with depth of searching bound by $project_maxdepth.
>> Add to that finding symbolic name of the owner of repository
>> directory, or (with the patch) reading a file per repo with repo
>> owner.
>>  =20
> We have two configurable options here: $projectroot and $projects_lis=
t. =20
> If $projects_list is a directory, we'll end up using a directory to g=
et=20
> project list info, and using another one to actually handle the=20
> projects.  In small repo area it's safe to have $projects_list empty.=
 =20
> This is why I reference $projects_list as a file.

Besides the fact that using $projects_list file can speed up generating
'projects_list' page, it can also be used to either just restrict
visibility of certain projects (some projects will be not visible
in the projects list page, but will be still available when provided
with project name), or restrict/refuse access (if GITWEB_STRICT_EXPORT
aka $strict_export is true, only files shown in projects list page
would be available to browse; it can be further restricted using
"export-ok" mechanism).

You can use $projects_list pointing to directory with symlinks to
selected repositories residing under $projectroot for that. So it
is not only $projects_list a file, or $projects_list undef (and fallbac=
k
to $projectroot and $projects_list as directory). $projects_list as
a directory different from $projectroot has sense in some cases too.

> If $projects_list is a file, we'll rely on a file which was generated=
=20
> some time ago and can't reflect the latest changes of $projectroot (b=
ut=20
> see below).

Creating projects is a rare event. You cannot do this remotely with git
tools only. So I think it would be not very difficult and not very
suprising to use some script to add new project, script which would
ensure proper project configuration, perhaps setup proper SSH keys, and
regenerate $projects_list file if it is what gitweb is using.

[...]
>>> What if this script creates the $projects_list file, for example wh=
en=20
>>> the $projectroot's mtime changes?  We can even hold mtime info for =
every=20
>>> project's config file.
>>>    =20
>>
>> I don't understand what you wanted to say here. $projects_list file
>> lists only project path (project name) and project owner.
>>  =20
> I mean it would be better to add this kind of metadata like descripti=
on=20
> and owner's shoesize to config instead of a raw file.  I understand r=
ow=20
> files are easier to read but reading a single cache file adn doing so=
me=20
> stat()s are much easier.  I can think of $project_lists as a cache fi=
le=20
> name, which can be maintained by gitweb.cgi, and these mtime values=20
> could be saved to $project_list to verify entries' validity.

Err... I think that having some kind of cache for 'projects_list' page
is a separate issue than using $projects_list file for a list
(and owners) of projects.

Besides I'd rather opt for the other side of spectrum: instead of
gitweb checking for freshness of a 'cache', regenerate the cache
or just delete it when you know that contents change: from a script
adding a repository, from a script renaming or changing description
or an owner of repository, from a script deleting repository or
removing it from a list, from a post-update / post-receive hook if
the cached info includes last change, etc.
=20
> All we have to do is to maintain $project_list to be up to date.  The=
=20
> best would be to have a separate projectlist maintainer script which=20
> handles two scenarios:
>=20
> 1| repo addition/deletion
> 2| repo config changes
>=20
> I don't have solution for the first scenario which would be a speed=20
> improvement in gitweb.cgi, this is why I suggest to put $project_list=
=20
> updater to a separate script.  The second scenario could be handled b=
y=20
> gitweb.cgi though, but it would be mere code duplication.

I was thinking about gitconfig file, but with limited syntax to be
easily parseable from Perl, like git-cvsserver does, put in $projectroo=
t,
e.g. $projectroot/gitconfig, which would contain parts of repo config
relevant to 'projects_list' page.  It would use gitweb.<repo>.<key>
syntax, where <key> is one of owner, description, and perhaps url.

Or we could put it in gitweb_config.perl file, in the form of parsed
config hash... well, it should be fairly easy to combine those two
approaches with current code: use %config hash, and fill it from
$projectroot/gitconfig if not set.

Of course you would have the usual danger when dealing with data
duplication, naley that they would get out of sync. And usual danger
dealing with caches, that the validating needed and other system
caches would make it perform *worse* than without cache.

--=20
Jakub Narebski
Poland
