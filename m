From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sat, 15 Nov 2008 11:04:06 +0100
Message-ID: <cb7bb73a0811150204v15463275sf63098b819c6d259@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811150059.14515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 11:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1I1y-0000vD-M1
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 11:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbYKOKEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 05:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYKOKEJ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 05:04:09 -0500
Received: from ik-out-1112.google.com ([66.249.90.181]:62091 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbYKOKEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 05:04:08 -0500
Received: by ik-out-1112.google.com with SMTP id c29so1463349ika.5
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 02:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MH6unMFNDwW3JYXNj2fdjfZ3b+qlkuOgFB/BdHGsp/w=;
        b=xMprgGDBnipQ4tVRZsUzQWtdFFp08+/RgEs5yAZifwcafJggz2C6SZrTBg/WJ33F5C
         1xL/+rIX8K8apP9e1vgRjZIUwgR0PrIhQobTW+wQLf2jJgJhB39lgu5eenxxHlE9xmDd
         /O6jcYJPOLnjyhw0PuHJ3LM/i8pe/LHUQd3aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=INi4NEaWsrENBEkK4q9oBgEsEl62ahseU49Krfm16/6NM7gcUhBQsXbsPZhEmiLZ/A
         WZT0xe1irUjxq0xD2eAvLx/rsMTWmAgzAABTXX95RdZ/Xhz701hZV6LI4hiycwJC6kF0
         fZQ8wZzWFKMjBlzZ5HEff8WLQR0Jmvx8/Ukgs=
Received: by 10.210.87.14 with SMTP id k14mr1986313ebb.159.1226743446244;
        Sat, 15 Nov 2008 02:04:06 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sat, 15 Nov 2008 02:04:06 -0800 (PST)
In-Reply-To: <200811150059.14515.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101054>

On Sat, Nov 15, 2008 at 12:59 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:
>
>> The purpose of this function is to split a headlist into groups
>> determined by the leading part of the refname, and call git_heads_body()
>> on each group.
>
> What is the reason of this patch? Is it to split remote-tracking
> branches ('remotes' references) into remotes, and group them by
> the remote repository name?
>
> If it is true, then first: you should have wrote the _reason_ behind
> this patch and not only what it does in this commit message. And use
> better summary (commit title / subject of this patch).
>
> Second, this patch wouldn't do what you want from it if there are
> remotes with '/' in name.  I for example use "gsoc2008/gitweb-caching"
> for Lea Wiemann repository with her GSoC 2008 work on adding caching
> to gitweb.  Because there are many ways to specify remotes due to
> backwards compatibility (and simplicity, as some for example prefer
> old 'branches/' way to specify remotes), namely config, files under
> '.git/remotes', and (from Cogito) files in '.git/branches', you would
> have to either reimplement/reuse parts of git-remote (there is old Perl
> implementation in contrib/examples), or use "git remote" or
> "git remote -v" command output[1].

The initially intended purpose for this patch was to group remote
heads by remotes, but an interesting side-effect of doing it this way
was that it allowed to group _local_ heads too, by using the
stuff/morestuff syntax. For example, I could group gitweb/pathinfo and
gitweb/allheads together (although I disabled this grouping for local
heads in the patchset).

However, as you remark, the current patch fails to achieve even its
intended purpose, so it looks like going the 'git remote' way would be
the right way to find at least the grouping keys: this has the benefit
of allowing us to retrieve the remote URL as well by using 'git remote
-v', although it has the underside of require one additional git call.

It would also probably be a good idea to separate the actual head
grouping from the display of the grouped head lists. I wonder if Perl
has a 'tree' data structure that could be used to store the grouped
head lists ...

Ah yes, the code in this patch I was never actually really satisfied
with, hopefully I can rewrite it more sensibly with the adittional
experience I've accumulated this year.

>> +
>> +     # Split @$headlist into a hash of lists
>> +     map {
>> +             my %ref = %$_;
>> +             $ref{'hname'} = $ref{'name'};
>> +             if ($ref{'name'} =~ /\//) {
>> +                     $ref{'name'} =~ s!^([^/]+)/!!;
>
> As I said, this would fail on for example "gsoc2008/gitweb-caching"
> remote...

Would you say that in this case we want 'gsoc2008/gitweb-caching' as
the group head, or would you rather have nested groups [gsoc2008
[gitweb-caching [branches in gsoc2008/gitweb-caching] [etc]] ? I must
say that I think the latter would be quite interesting, but I _am_ a
little afraid we could turn up with way too much nested groups ...


-- 
Giuseppe "Oblomov" Bilotta
