From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sun, 16 Nov 2008 02:13:42 +0100
Message-ID: <200811160213.43343.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <200811150059.14515.jnareb@gmail.com> <cb7bb73a0811150204v15463275sf63098b819c6d259@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 02:15:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1WEA-0002jP-Nw
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 02:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYKPBNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 20:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbYKPBNr
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 20:13:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:23134 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYKPBNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 20:13:46 -0500
Received: by ug-out-1314.google.com with SMTP id 39so169025ugf.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 17:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Cw5D7/twE3nHRYtBLjQ9iHB7dDzitkmZem5T9TqTzOQ=;
        b=JU1VJzNWE6VzLdGESCPyPkrdVmIhFdeu5nKTdGk3CVVgY/5zmK6+qfJmj1KKi+q5xd
         w50A7DTpu/pDmuGQPuAi1yRQZJ+C6YJEBKL1X0VpjBouxKlxsm6iq2F+vfR0DetIvQCE
         VydFS6V1+Ok9sKMSWeLsjErqDKXnZ3isdPrRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Yqv+M7wY29/omF9nsIAMBoG65mgKZnvsB9yOC5Jb+KVDI1mu3NO+Um2lwSJL+KLFzs
         oVmL1NH2VvlCfM1xiafFDibDPlNIXLKPk/zikmLU0zpYKwcrV4I/1XU8t06+WpfQ5qb4
         Dw3fBy4Nrl4OygiaCO8hrIpRj1+zLSFQx7my8=
Received: by 10.210.71.11 with SMTP id t11mr2609787eba.57.1226798024537;
        Sat, 15 Nov 2008 17:13:44 -0800 (PST)
Received: from ?192.168.1.11? (abwb4.neoplus.adsl.tpnet.pl [83.8.225.4])
        by mx.google.com with ESMTPS id 5sm1739510eyf.8.2008.11.15.17.13.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 17:13:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0811150204v15463275sf63098b819c6d259@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101107>

On Sat, 15 Nov 2008, Giuseppe Bilotta wrote:
> On Sat, Nov 15, 2008 at 12:59 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:
>>
>>> The purpose of this function is to split a headlist into groups
>>> determined by the leading part of the refname, and call git_heads_body()
>>> on each group.
>>
>> What is the reason of this patch? Is it to split remote-tracking
>> branches ('remotes' references) into remotes, and group them by
>> the remote repository name?
>>
>> If it is true, then first: you should have wrote the _reason_ behind
>> this patch and not only what it does in this commit message. And use
>> better summary (commit title / subject of this patch).
>>
>> Second, this patch wouldn't do what you want from it if there are
>> remotes with '/' in name.  I for example use "gsoc2008/gitweb-caching"
>> for Lea Wiemann repository with her GSoC 2008 work on adding caching
>> to gitweb.  Because there are many ways to specify remotes due to
>> backwards compatibility (and simplicity, as some for example prefer
>> old 'branches/' way to specify remotes), namely config, files under
>> '.git/remotes', and (from Cogito) files in '.git/branches', you would
>> have to either reimplement/reuse parts of git-remote (there is old Perl
>> implementation in contrib/examples), or use "git remote" or
>> "git remote -v" command output[1].
> 
> The initially intended purpose for this patch was to group remote
> heads by remotes, but an interesting side-effect of doing it this way
> was that it allowed to group _local_ heads too, by using the
> stuff/morestuff syntax. For example, I could group gitweb/pathinfo and
> gitweb/allheads together (although I disabled this grouping for local
> heads in the patchset).

I'm not sure if it would be that useful. How many people have _many_
stuff/morestuff branches for some values of stuff/? The convention of
<initials>/<topic> of topic branches in git.git doesn't usually lead
to many branches with the same <initials>/ prefix.

> 
> However, as you remark, the current patch fails to achieve even its
> intended purpose, so it looks like going the 'git remote' way would be
> the right way to find at least the grouping keys: this has the benefit
> of allowing us to retrieve the remote URL as well by using 'git remote
> -v', although it has the underside of require one additional git call.

Now I thought about it a bit, I think your solution has merit. 

Splitting by remotes is hard and difficult to do right, especially if
you consider than 'remote' prefix doesn't need to have anything in
common with names (common prefix) of refs/remotes/* remote-tracking
branches used. It is fairly easy to do it right in common case, but
hard in uncommon one.

So perhaps the idea of using first dirname as a kind of category for
remotes is a good idea. And usually it would be also remote name.

But it really needs explanation in commit message... and quite a bit
of commit squashing.

> 
> It would also probably be a good idea to separate the actual head
> grouping from the display of the grouped head lists. I wonder if Perl
> has a 'tree' data structure that could be used to store the grouped
> head lists ...

Hash of hashes (well, hash references), see perldsc(1)?

> 
> Ah yes, the code in this patch I was never actually really satisfied
> with, hopefully I can rewrite it more sensibly with the adittional
> experience I've accumulated this year.

Code... well, perhaps... commit messages also matter.

> 
>>> +
>>> +     # Split @$headlist into a hash of lists
>>> +     map {
>>> +             my %ref = %$_;
>>> +             $ref{'hname'} = $ref{'name'};
>>> +             if ($ref{'name'} =~ /\//) {
>>> +                     $ref{'name'} =~ s!^([^/]+)/!!;
>>
>> As I said, this would fail on for example "gsoc2008/gitweb-caching"
>> remote...
> 
> Would you say that in this case we want 'gsoc2008/gitweb-caching' as
> the group head, or would you rather have nested groups [gsoc2008
> [gitweb-caching [branches in gsoc2008/gitweb-caching] [etc]] ? I must
> say that I think the latter would be quite interesting, but I _am_ a
> little afraid we could turn up with way too much nested groups ...

Now I think that having [gsoc2008] subgroup here might be a good
thing...

-- 
Jakub Narebski
Poland
