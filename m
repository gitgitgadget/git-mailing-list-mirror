Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616C91FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbcHWR7P (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:59:15 -0400
Received: from photon.quantumfyre.co.uk ([95.85.33.242]:38791 "EHLO
        photon.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbcHWR7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:59:14 -0400
X-Greylist: delayed 1384 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Aug 2016 13:59:13 EDT
Received: from localhost (localhost [127.0.0.1])
        by photon.quantumfyre.co.uk (Postfix) with ESMTP id 82D0F1B5BEB;
        Tue, 23 Aug 2016 18:36:07 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at quantumfyre.co.uk
Received: from photon.quantumfyre.co.uk ([127.0.0.1])
        by localhost (photon.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id AZq3bW-0cKgy; Tue, 23 Aug 2016 18:36:03 +0100 (BST)
Received: from photon.quantumfyre.co.uk (localhost [127.0.0.1])
        by photon.quantumfyre.co.uk (Postfix) with ESMTP id C12021B5BEA;
        Tue, 23 Aug 2016 18:36:03 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 18:36:03 +0100
From:   Julian Phillips <julian@quantumfyre.co.uk>
To:     Lucian Smith <lucianoelsmitho@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Alfred Perlstein <alfred@freebsd.org>,
        git@vger.kernel.org, git-owner@vger.kernel.org
Subject: Re: git-svn bridge and line endings
In-Reply-To: <CAHLmBr3Yn1tVhijmgRwd8hyxgasdc2VtfNi6pYP5FbEHjjb3Vw@mail.gmail.com>
References: <CAHLmBr2CRzt58RB+_YmnXcyost-R5=Ff51tALf1xh0kGk+frDw@mail.gmail.com>
 <CAHLmBr1JHjjp66Er-2e6Yu+3zjrhT82Da-O8fj6_OoPtEPz8eg@mail.gmail.com>
 <20160823030721.GA32181@starla>
 <5e17164f-f669-70c2-de78-25287ab59759@freebsd.org>
 <20160823055418.GA5990@whir>
 <CAHLmBr3Yn1tVhijmgRwd8hyxgasdc2VtfNi6pYP5FbEHjjb3Vw@mail.gmail.com>
Message-ID: <501dc45544c5582379df21a758d3be6c@quantumfyre.co.uk>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/1.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/08/2016 17:14, Lucian Smith wrote:
> Thanks for the quick responses!
> 
> My situation is that the git side is entirely whatever github.org is
> running; presumably the latest stable version?  They provide a URL for
> repositories hosted there that can be accessed by an SVN
> client--somewhere on github is the 'git-svn bridge' (as I understand
> it): something that receives SVN requests, translates them to
> git-speak, and replies with what SVN expects.

The ability to use a Subversion client is functionality provided by 
GitHub, and not native to git itself.  So unless someone for the 
appropriate GitHub team happens to read this thread I expect there isn't 
much we can do to help.  I don't know if they've even provided any real 
detail of how they implemented the bridge.

> There is indeed a .gitattributes file in the repository, but the SVN
> client doesn't know what to do with it.  My hope was that something in
> the bridge code, that translated SVN requests to git and back, could
> take the SVN request, "Please give me this file; I'm on Windows" look
> at the .gitattributes file in the repository, and hand out a file with
> CR/LF's in it.  Conversely, when SVN tells git "Here is the new
> version of the file to check in," the bridge could look at the file,
> realize it had CR/LF's in it, look at the .gitattributes file to know
> if it needed to be converted, and then convert it appropriately.
> 
> I can imagine a full-blown bridge that could even translate the SVN
> EOL propset back and forth appropriately, but I'm not sure if going
> that far is necessary and/or helpful.
> 
> I don't know if this is the right mailing list for that particular bit
> of software, but it at least seemed like a good place to start.  Thank
> you!

Supported properties are listed here: 
https://help.github.com/articles/subversion-properties-supported-by-github/

You'll need to ask GitHub to implement support for the svn:eol-style 
property I expect.

Might be easier to just use Tortoise Git?

> -Lucian
> 
> On Mon, Aug 22, 2016 at 10:54 PM, Eric Wong <e@80x24.org> wrote:
>> Alfred Perlstein <alfred@freebsd.org> wrote:
>>> I hadn't anticipated there be to translation between svn props and
>>> .gitattributes, it sounds a bit messy but possible, that said, is it
>>> not possible to commit .gitattribute files to the svn repo?  Even in
>>> FreeBSD land such small token files are permitted.
>> 
>> I'm not sure if an automatic translation is necessary or
>> desired (because of a corruption risk).
>> 
>> Perhaps Lucian can clarify the situation for his repo.
>> 
>>> As far as documenting svn-properties, most of the properties are
>>> used on the Subversion side either by subversion itself, or by
>>> scripts in the subversion repository.  Perhaps a blurb "see the
>>> subversion documentation and/or your local subversion
>>> administrator's guide for properties and their uses." would suffice?
>> 
>> Yes, perhaps with a workable example Lucian can use today with
>> any git v2.3.0 or later.
>> 
>> Thanks for the quick response!
>> 
>>> Opinions?  Happy to look into it.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Julian
