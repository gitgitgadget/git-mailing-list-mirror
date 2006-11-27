X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Show remote branches on gitweb
Date: Mon, 27 Nov 2006 20:26:09 +0100
Organization: At home
Message-ID: <ekfe15$a48$1@sea.gmane.org>
References: <loom.20061124T210559-701@post.gmane.org> <ek7jsp$j83$1@sea.gmane.org> <loom.20061127T200958-750@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 27 Nov 2006 19:25:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 54
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32441>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gom5t-0006JT-Vv for gcvg-git@gmane.org; Mon, 27 Nov
 2006 20:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758525AbWK0TYm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 14:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758524AbWK0TYm
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 14:24:42 -0500
Received: from main.gmane.org ([80.91.229.2]:22703 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758525AbWK0TYl (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 14:24:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gom5o-0006He-26 for git@vger.kernel.org; Mon, 27 Nov 2006 20:24:40 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 20:24:40 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 27 Nov 2006
 20:24:40 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Pazu wrote:

> Jakub Narebski <jnareb <at> gmail.com> writes:
> 
>> > Is there any way to do it? I'm using git-svn to track a remote
>> > subversion repository, and it would be very nice to browse the
>> > history for a remote branch for which I didn't start a local
>> >branch yet.
>> 
>> Planned, not implemented yet.
> 
> Probably not a technically correct solution, but the following changes did the
> trick for me.
> 
> 
> --- a/gitweb.cgi      2006-11-23 11:02:34.000000000 -0200
> +++ b/gitweb.cgi      2006-11-27 10:09:56.000000000 -0200
> @@ -1428,8 +1431,7 @@
>  
>       open my $fd, '-|', git_cmd(), 'for-each-ref',
>               ($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
> -             '--format=%(objectname) %(refname) %(subject)%00%(committer)',
> -             'refs/heads'
> +             '--format=%(objectname) %(refname) %(subject)%00%(committer)'
>               or return;
>       while (my $line = <$fd>) {
>               my %ref_item;
> @@ -1440,6 +1442,7 @@
>               my ($committer, $epoch, $tz) =
>                       ($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
>               $name =~ s!^refs/heads/!!;
> +             $name =~ s!^refs/remotes/!!;
>  
>               $ref_item{'name'}  = $name;
>               $ref_item{'id'}    = $hash;
> 
> 
> 
> I've just changed the git_get_heads_list function to let 'for-each-ref'
> return all top refs instead of just those in refs/heads, and added a line to
> remove 'refs/remotes/' from the remote branch names.
> 
> Again, probably not the right solution, but now I have remote branches listed
> under "heads", and that's all I really need.

What about tags (refs/tags/), which shouldn't be here?

Besides, it is quick'n'dirty solution; I'm not against having it as a patch
in git mailing list archives, but I'd rather not have it there.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

