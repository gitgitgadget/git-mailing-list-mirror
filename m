From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/7] gitweb: Support comparing blobs with different names
Date: Sun, 29 Apr 2007 23:35:49 +0200
Message-ID: <200704292335.50102.jnareb@gmail.com>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at> <a209e0308fc80ef0623baef8dca49e61b7bafaab.1176659094.git.mkoegler@auto.tuwien.ac.at> <20070416201813.GA2592@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Apr 30 01:26:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiImY-00052y-1I
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 01:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161548AbXD2X0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 19:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161552AbXD2X0P
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 19:26:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:60674 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161548AbXD2X0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 19:26:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1186458uga
        for <git@vger.kernel.org>; Sun, 29 Apr 2007 16:26:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G/vEq2hE6L2WsYktMok++wIRyv3Fkf59gE9F3yRVsr8/CbJyoQMO3DABJpZ5W4AmO8ieeea1k4axXPpf+W8k5SbCJJky/GDVBxVJpNcjAAM6nJb3AK300Ns5tEJsnDMH78Jpzpb8eWX+QsmeARp4+lK5n8Z1wxXkVleSHF9yl1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m89nhc6Uhe6IBBCuruQscsaanAMSwinP+L2+GLuK+YS/j8potcODesU9H+D8HL9PHBzC5nebn/XD7Gn5Fxe2emGeCKlJuV36aZDHjFSX6I68icXF+fV2Ip36f1LNphThQyi+si9U8MZOepFJvjt6FpORiWLmwm8OLX9idyBPA1A=
Received: by 10.66.224.3 with SMTP id w3mr3999044ugg.1177889172397;
        Sun, 29 Apr 2007 16:26:12 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e1sm5640636ugf.2007.04.29.16.26.06;
        Sun, 29 Apr 2007 16:26:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070416201813.GA2592@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45848>

On Monday, 16 April 2007, Martin Koegler wrote:

> Currently, blobdiff can only compare blobs with different file
> names, if no hb/hpb parameters are present.
> 
Not true. Since commit 5ae917acdf40444945271e5e014cda37e202504e

  "gitweb: Support comparing blobs (files) with different names"

git_blobdiff ('blobdiff' view) suports comparing arbitrary blobs
(also with different file names) when no hp/hpb parameters are
present (although there would be no mode change information),
but supports comparing blobs with different file names in presence
of hp/hpb parameters, provided that it is proper rename diff.

Since this commit you can select rename diff which is part of
'commitdiff' view as a 'blobdiff' view, correctly.

> This patch adds support for comparing two blobs specified by any
> combination of hb/f/h and hpb/fp/hp.
>
But it used to lose mode change information. This info should be
I think in commit message.

Because your work on including mode changes for git-diff with
<tree-ish>:<path-to-blob> extended SHA-1 syntax (thanks a lot!)
I guess that you would want to rewrite this patch.
 
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
> New version, as I found a bug in the expiration handling code.
> 
> I unified all blobdiff variants and added support for comparing blobs
> with different names.
> 
> If h/hp parameter are missing, I need to generate them with
> git_get_hash_by_path, as the are needed for the html header, which is
> generated before parsing the git-diff output.

git_get_hash_by_path uses git-ls-tree but it does not catch all the info;
perhaps git_get_info_by_path would be called for here.

> I currently ignore all mode changes, as they are part of the tree. I
> don't think that displaying a mode change message justifes two call to
> git-ls-tree for each blob diff (Currently it only calls git-ls-tree
> for each missing h/hp parameter).

That is not a problem now, thanks to your patches... although it would
be nice to have subroutine which would get the difftree information
from extended git diff header (if it is possible).

> +	my $expires = '+1d';
> +	# non-textual hash id's can be cached
> +	if (defined $hash && $hash !~ m/^[0-9a-fA-F]{40}$/) {
> +		$expires = undef;
> +	} elsif (defined $hash_parent && $hash_parent !~ m/^[0-9a-fA-F]{40}$/) {
> +		$expires = undef;
> +	} elsif (defined $hash_base && $hash_base !~ m/^[0-9a-fA-F]{40}$/) {
> +		$expires = undef;
> +	} elsif (defined $hash_parent_base && $hash_parent_base !~ m/^[0-9a-fA-F]{40}$/) {
> +		$expires = undef;
> +	}

Usually gitweb _changes_ $expires to '+1d' when appropriate, instead
of defaulting to '+1d' and undefining it. But this might be the matter
of style consistency, and personal preferences: one complicated boolean
expression or set of if ... elsif ... conditionals.

The idea is that both TO and FROM are to be immutable; this means
either $hash_parent (or $hash_parent_base) being full SHA-1 and having
filename defined, or if appropriate "parent" hash is not present (because
"parent" hash has precedence over blob hash) it means that $hash
(or $hash_parent) being full SHA-1.

[...]  
> +	if (defined $hash_parent_base && defined $file_parent && !defined $hash_parent) {
> +	    $hash_parent = git_get_hash_by_path($hash_parent_base, $file_parent);
> +	}
[...]
> +	# open patch output
> +	open $fd, "-|", git_cmd(), "diff", @diff_opts,
> +	$hash_parent, $hash, "--"
> +		or die_error(undef, "Open git-diff failed");

You would most probably use now "$hash_base:$file_name" instead of $hash
if $hash_base is defined, i.e.

  defined $hash_base ? "$hash_base:$file_name" : $hash

and similarly for $hash_parent parameter now that <tree>:<path> form
respects mode changes information.

-- 
Jakub Narebski
ShadeHawk on #git
Poland
