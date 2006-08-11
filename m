From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Different colours for tags and heads
Date: Fri, 11 Aug 2006 17:34:42 +0200
Organization: At home
Message-ID: <ebi81l$qu$1@sea.gmane.org>
References: <20060811151224.177110@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 11 17:35:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBZ2V-0006Fs-T1
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 17:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWHKPfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWHKPfF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 11:35:05 -0400
Received: from main.gmane.org ([80.91.229.2]:30184 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932101AbWHKPfC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 11:35:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GBZ28-0006Bg-84
	for git@vger.kernel.org; Fri, 11 Aug 2006 17:34:48 +0200
Received: from host-81-190-24-83.torun.mm.pl ([81.190.24.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Aug 2006 17:34:48 +0200
Received: from jnareb by host-81-190-24-83.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Aug 2006 17:34:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-83.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25230>

Thomas Kolejka wrote:

> Hello,
> 
> with the following patch there are different colours for tags
> and heads in gitweb. So you can easily differentiate between 
> them.
> 
> Commit ca9e3b124f6313187da641b5cd55100c4ade6a9a

Based on which branch? Master, next? Which commit?

By the way, please do not put "Hello," in the commit message
part of patch. You can put your comments (like which branch
and/or commit is the batch based on) either after "---" and
before the patch itself, or at the beginning and separate them
from the commit message by "+++" (this separator is supported
by git tools, but some people use "-- >8 --" 'scissors' separator).
git-format-patch helps in correct formatting, and adds diffstat.

You would also be most probably asked to sign your patches, i.e.
add
  Signed-off-by: Thomas Kolejka <Thomas.Kolejka@gmx.at>
line at the end of commit message.


I have send patch of similar nature:
  "[PATCH 5/5] gitweb: Change appereance of marker of refs pointing to given object"
  http://permalink.gmane.org/gmane.comp.version-control.git/24860
in which I split marker for refs poining to given object into
separate span elements. The patch was dropped because it followed
first version of "Great subroutine renames" patch.

I've planned on patch which does something similar to
yours, but in slightly different way: instead of two calls 
to git_get_referencing (format_mark_referencing[*1*] after rename)
and two calls to read_info_ref (git_get_references after rename)
in your patch, read_info_ref would always add full name, of
which first component is the type of the tag.

I am wondering if to do this like in my abovementioned patch,
putting references in single string, separated by ':' (':' cannot
be part of valid ref name), or use array (anonymous array reference
to be more exact). 


[*1*] Do you have better proposal for this name? Perhaps
format_referencing_marker, or just format_marker?

---
>  # format marker of refs pointing to given object
>  sub git_get_referencing {
> -     my ($refs, $id) = @_;
> +     my ($refs, $id, $class) = @_;
>  
>       if (defined $refs->{$id}) {
> -             return ' <span class="tag">' . esc_html($refs->{$id}) . '</span>';
> +             return " <span class=\"$class\">" . esc_html($refs->{$id}) . "</span>";
>       } else {
>               return "";
>       }
[...]
> -     my ($revlist, $from, $to, $refs, $extra) = @_;
> +     my ($revlist, $from, $to, $refs, $heads, $extra) = @_;
[...]
> -             #my $ref = defined $refs ? git_get_referencing($refs, $commit) : '';
> -             my $ref = git_get_referencing($refs, $commit);
> +             #my $ref = defined $refs ? git_get_referencing($refs, $commit, "tag") : '';
> +             my $ref = git_get_referencing($refs, $commit, "tag");
> +             my $head = git_get_referencing($heads, $commit, "head");

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
