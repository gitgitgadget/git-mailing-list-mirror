From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 10:49:20 +0200
Message-ID: <200808221049.21337.jnareb@gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com> <200808212332.07095.jnareb@gmail.com> <cb7bb73a0808220021w5d30d3c8i88ad85611035d2c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 10:50:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWSLy-0004rn-Ir
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 10:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbYHVIth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 04:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbYHVIth
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 04:49:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:38696 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbYHVItf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 04:49:35 -0400
Received: by ug-out-1314.google.com with SMTP id c2so80883ugf.37
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sPLNSJtJRicVkt3DctkCCD0NQ4u3TwXps7nUVxhDR6M=;
        b=oenCCA3z2naqnVNKAAt7eSA2F4GiTiqr9fP8rxApcyLl/EzjPENvorXGlNhYjbmzMQ
         LSACc0DjVM2ucJORHeEg3BBK+WOzDVhb30xpXaYu2gmDu//2n/QDB1OYIziawXneHnmc
         dkDKJS4A1oDMa3Hya044EdmnV05+hRNODh7sA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gyoKr+vJQIL1rzgDMTIbVxCWHQBAhg/4CBVB9tUChTwZZPJgsTCx6SDTKGh4ps9njq
         bBq1ghRgFEHLBTBUa5iCSEEi7mqbodhAaL7vXj936nO593DeMg9HQmtSdResnH32k0Jq
         wOV/0ZciHk+ONUQeliDxUW8mG3UX170wc3kCo=
Received: by 10.67.89.8 with SMTP id r8mr2299576ugl.87.1219394973645;
        Fri, 22 Aug 2008 01:49:33 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.249.91])
        by mx.google.com with ESMTPS id x23sm1613680ugc.59.2008.08.22.01.49.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 01:49:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0808220021w5d30d3c8i88ad85611035d2c5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93275>

On Fri, 22 Aug 2008, Giuseppe Bilotta wrote:

>>> --- a/gitweb/gitweb.css
>>> +++ b/gitweb/gitweb.css
>>
>>> +span.refs span a {
>>> +     text-decoration: none;
>>> +     color: inherit;
>>> +}
>>
>> Possible improvement:
>>
>> We would probably want to make this link discoverable, by adding
>> underline on :hover, like for other "hidden links" in gitweb (for
>> example in commitdiff view).
> 
> Can do that.

Additional idea: it would be nice to know if clicking on ref marker
would lead us to 'shortlog' view, or to 'tag' view; so perhaps we should
distinguish somehow indirect refs, for example using bold font-weight.
 
>>>                       my ($type, $name) = qw();
>>> +                     my $git_type = git_get_type($ref);
>>>                       # e.g. tags/v2.6.11 or heads/next
>>>                       if ($ref =~ m!^(.*?)s?/(.*)$!) {
>>>                               $type = $1;
>>
>> git_get_type calls 'git cat-file -t', so for each ref shown you make
>> *additional call* to git command (additional fork).  Not good, especially
>> that you can get information if a ref is a tag (indirect reference)
>> or not one can get from within git_get_references; which in turn
>> uses "git show-refs --dereference" and used to use either
>> "git peek-remote ." or ".git/info/refs" file.  If there is <name>^{},
>> then <name> is indirect reference: is a tag.
>>
>> As we display ref markers only for log-like views, marker can be tag
>> or can be "lightweight reference" and be only a commit (in theory
>> we could show ref markers also for tree and blob items, but it is not
>> important now).
> 
> By looking at git_get_reference() what I see is basically the use of
> the same field as $type in format_ref_marker(). I can probably use
> that, although it means that any future extensions to ref marker
> display will need to hack the routine too. (This would mean that the
> patch would be more similar to my original patch
> http://marc.info/?l=git&m=121769155017642&w=2 ).
> 
> If this is not what you're suggesting, then I'm afraid I don't fully
> grasp your idea.

No, that is not what I was suggesting.

What format_ref_marker() uses is not exactly 'type' of reference, but
more 'kind of' reference.  It is based on reference namespace, not
on type of object the reference is at (points to).  So code based
on this info (like your v3 patch) would fail on lightweight tag, i.e.
if there is ref in 'refs/tags' namespace which points directly to commit,
and not to tag object.

But 'git show-ref --dereference' _has_ information about whether
given reference points directly or indirectly to given object
($refs->{$id}), but currently we neither save it, nor use it.
For example we can have:

  781c1834f5419bdf81bb7f3750170ccd6b809174 refs/heads/maint
  ...
  124c62e8781a8f03ee0256bee78f7b392e3920af refs/stash
  ...
  89e6fcde639d65823e8113c307067441701ac74f refs/tags/Attic/gitweb/parse_rev_list
  b69a41a384d19fe253b9f4f34c9019ad96ca571d refs/tags/Attic/gitweb/patchset_body
  781c1834f5419bdf81bb7f3750170ccd6b809174 refs/tags/TEMP
  ...
  07cca3b30ee2b5d060e44e5b18d7c22929c63d1a refs/tags/v1.5.6.5
  781c1834f5419bdf81bb7f3750170ccd6b809174 refs/tags/v1.5.6.5^{}

Now in this example we have three refs pointing to commit object
781c1834: refs/heads/maint, refs/tags/TEMP and refs/tags/v1.5.6.5.
From those only refs/tags/v1.5.6.5 is (via) tag, even though TEMP
is in tags namespace.  Currently git_get_references() strips '^{}'
indirect reference marker from the output (from refname), and doesn't
make use of it.  One solution would be to not stip it in
git_get_references(), but leave it, and strip it and make use of
it (if ref ends with '^{}' it must be tag object) in format_ref_marker().

But that is just a proposal...
-- 
Jakub Narebski
Poland
