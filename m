Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 11584 invoked by uid 107); 4 Oct 2009 15:34:10 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 11:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022AbZJDPZi (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 11:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756902AbZJDPZi
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 11:25:38 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:36937 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbZJDPZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 11:25:37 -0400
Received: by bwz6 with SMTP id 6so1986225bwz.37
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 08:24:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=Ed+P/K5dyT8Z+D5tQwvubW6jQ0qL5IbxGk5QM3Vllkk=;
        b=fj7IhTymtjrgVDXGE/PKHBRs8v5A1V8fDjgUAmx1YXcSsDxqyafZpKb+c6XS383VHs
         CzrvjnWQkwRpi+sU91F9Hr506/sslkNfLw7OmyZSyHkRP8tkmnSzME0ppMoQ4jK6fokB
         JLCXKzT40JW++62STh27rAb/79DoEo4t6vTTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=USIsCYcqQdNdb34wPVjbBB+Q4VGjLaAqkAU0Md/macDwlexd4LROR/XDCma9U9LMYG
         fqJ7hO0kmMTTodDnPrC6v6827splDrw7VcurnzbWSH4MIxmoZ9mLrOdtWliwGlT9ZhzC
         Fnzm7y0undwK0GI2YhOVDNRuVjiCgsY3tyuJA=
Received: by 10.204.5.75 with SMTP id 11mr3100100bku.20.1254669895788;
        Sun, 04 Oct 2009 08:24:55 -0700 (PDT)
Received: from ?192.168.1.13? (abwi38.neoplus.adsl.tpnet.pl [83.8.232.38])
        by mx.google.com with ESMTPS id 12sm4567172fks.38.2009.10.04.08.24.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 08:24:52 -0700 (PDT)
From:	Jakub Narebski <jnareb@gmail.com>
To:	Eugene Sajine <euguess@gmail.com>
Subject: Re: Git push over git protocol for corporate environment
Date:	Sun, 4 Oct 2009 17:25:39 +0200
User-Agent: KMail/1.9.3
Cc:	git@vger.kernel.org
References: <00163623ac5d75929b0474e66b96@google.com>
In-Reply-To: <00163623ac5d75929b0474e66b96@google.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200910041725.39992.jnareb@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, 1 Oct 2009, Eugene Sajine wrote:

> Thanks to everybody for prompt answers!

You are welcome!

> There is one thing I'm still missing though. Do I understand correctly that  
> if a person has an ssh access (account) to the host in internal network,  
> then this won't be enough for him to be able to push to the repo? Should we  
> still go through the hassle of managing the ssh keys for each particular  
> user who is supposed to have push access?

Yes, it is enough to push (and fetch) via SSH protocol.

Nevertheless it is better to use key-based authentication, or to be more
exact passwordless authentication, so that you are asked for ssh key
password (if there is one set for given key) only once when adding it
to ssh agent (c.f. ssh-add, ssh-agent, and keychain).  Otherwise you 
would need to give password over and over (well, I think git uses one
or two connections for fetch / push, so it shouldn't be much of an 
issue).

Also you can have SSH key shared via networked filesystem...


Conversely, on the other hand side many git management tool require to
setup only single SSH account, and distinguish between users based on 
keys they use.

> 
> I believe the answer is yes and that's why I'm leaning towards pulls and  
> pushes over git protocol. There is no solution yet which would be as  
> effective and simple to maintain. Using git protocol will not add security,  
> but it won't be worse than existing CVS or any other centralized version  
> control security model. As soon as security comes into play, then we will  
> need some other solution, but currently i didn't see anything that would be  
> easy to sell to the company.

Git protocol is anonymous and unauthenticated, so you can't (I think)
make any ACL with it.  CVS pserver was not secure, but CVS tunnelled over
SSH, or used over SSH was.


Gitosis, Gitolite, SCuMD, repo are all git management tools.  
GitHub:FI, Gitosis, Girocco (with github), InDefero are all git hosting
tools (with web interface both for repo browsing and for administration).
Gerrit is git based review board.


> Github is cool, but FI is way too expensive and very hard to sell.
> 
> Gitorious is even better!! for corporate use, i think, because of its team  
> oriented approach, but... man... I would kill for java implementation or  
> anything as simple as that!!

Gitorious is roughly GitHub equivalent, as it is also git hosting
software (a web application).

Both SCuMD and (I think) Gerrit are in Java; SCuMD is SSH server and/or
git repository management tool in early stages of development,  Gerrit
is multi-repo management web app and (mainly) review board.

> As i see It is impossible to install in   
> network without internet access, and the amount of dependencies which you  
> have install/pre-install is enormous. I read somewhere ruby on rails is fun  
> to develop with, but is a nightmare to deploy and maintain, and it seems to  
> be true. Come on, guys!! Look at the Hudson CI - one war file containing  
> everything you need, application starts from command line "java -jar  
> hudson.war" and runs on any port you specify. Time to start from download  
> to having first build is less the 10 min!!! If there are gitorious guys -  
> please, think about it and don't forget to share the profit;)!

I don't know what are tricks that Rubyists use to ease deployment, but
take a look at things such as Gems and Capistrano.

> 
> I think Cgit can be something competitive - although i failed to run it  
> yet, having some issues with build...and as all other web based stuff, you  
> should implement something in order to create and set up bare repos on the  
> server automatically (even probably edit the config file via script) to  
> avoid a mess and to avoid one guy spending his time adding and configuring  
> repos... Probably we will and up using gitweb as it at least knows to scan  
> a folder for git repos...although it also gives me troubles installing...  
> both with cgit and gitweb are conducted under cygwin, so probably this is  
> the real problem with them;)

Both cgit (which is written in C) and gitweb (which is single Perl script,
plus CSS and two images) are git web interfaces.  They do not have
features for managing repositories, nor for managing access to git 
repositories.

Girocco, which is git hosting software that http://repo.or.cz uses to
manage git repositories, uses (enhanced) gitweb for web interface.

> 
> I think that this is what is missing right now in order for git to get  
> rocket start and spread inside companies: secure and easy to maintain  
> mainline hosting.

Paraphrasing known quote: Git development community have no plans for
world domination; it would be purely accidental side-effect ;-))

Spread inside companies is not a goal; best possible tool for OSS
development is.

> 
> Probably all my frustration comes from lack of experience - so, while i  
> will continue to work on it, i would really appreciate any advice,  
> especially about experience using git not for open source and not in 3  
> person's team.

You didn't mention trying Gitosis or Gitolite, which are I think most
commonly used tool for managing git repositories (well, Gitosis is 
anyway).  Gitosis is even mentioned in "Pro Git" book (http://progit.org).

See e.g. "Hosting Git repositories, The Easy (and Secure) Way"
http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way
(from http://git.or.cz/gitwiki/BlogPosts)


[cut rest of reply; please do not toppost, and remove parts of reply
you are not responding to].
-- 
Jakub Narebski
Poland
