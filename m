From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #02; Wed, 17)
Date: Sat, 20 Nov 2010 01:42:24 +0100
Message-ID: <201011200142.26522.jnareb@gmail.com>
References: <7v1v6je9g8.fsf@alter.siamese.dyndns.org> <m3mxp668cy.fsf@localhost.localdomain> <7v1v6icyb0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 20 01:42:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbXH-00066u-Ec
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab0KTAma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:42:30 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57041 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab0KTAm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:42:29 -0500
Received: by bwz15 with SMTP id 15so4462514bwz.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FdYBFsn8feNWTqTxuUIk3S9LIBuO1ZUuhexvbqlk49w=;
        b=lTRPZfGx9JGG0k3moIf0lC3N7fd//gerOglZ3cTYGd/hX8j7pOx35Nu1gg7HulRLP3
         KdDnSZOowoI/vOktmJ0J7euvxpfwqjL6Vr5OWxj7cxpIDFmgu58wkS5eJo/A4iL4tNbG
         bK/OjJ0+qRPc77Jakm7VovTYOcpgJeW3+lpz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=keNchAb5FsSTe5Ceg6A3Id6M6ZOC3DS/tkONulk9B+IcoxyaY8IKy4W+vy/mHMZBed
         Tju0fGyi5zmqdh15SsHVxMScmZX2SZBmd0YBTNEP8E7XlZsGngxTx7PfsIUf5WQQGtYv
         FYbZKgnewoir/D7l7UuQPn0LdRT7SlEidMxoc=
Received: by 10.204.64.80 with SMTP id d16mr2832298bki.181.1290213747832;
        Fri, 19 Nov 2010 16:42:27 -0800 (PST)
Received: from [192.168.1.13] (abwo119.neoplus.adsl.tpnet.pl [83.8.238.119])
        by mx.google.com with ESMTPS id g8sm1147439bkg.23.2010.11.19.16.42.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:42:26 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1v6icyb0.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161799>

On Thu, 18 Nov 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Sidenote: recently sent
>>
>>   gitweb: selectable configurations that change with each request
>>
>> practically reverts
>>
>>   gitweb: Move call to evaluate_git_version after evaluate_gitweb_config
>>
>> Just FYI.
> 
> Hmph, will have to look at it again.

A bit of history:

* c2394fe (gitweb: Put all per-connection code in run() subroutine, 2010-05-07)
  a0446e7 (gitweb: Add support for FastCGI, using CGI::Fast, 2010-05-07)
  those added run() and run_request(), separating "main" code of gitweb from
  code that is run once per requect (once per connection).

* 869d588 (gitweb: Move evaluate_gitweb_config out of run_request, 2010-07-05)
  among others moved evaluate_gitweb_config out of run_request() to run(),
  because I thought that gitweb config that changes per-request is vanishingly
  rare: it isn't (e.g. gitolite has parts that are per-request).

  evaluate_git_version was moved *together* with evaluate_gitweb_config.

* 7f425db (gitweb: allow configurations that change with each request, 2010-07-30)
  partially reverted commit 869d58... but forgot to move evaluate_git_version
  when moving evaluate_gitweb_config.  This didn't matter in most cases...
  except for test suite.

* 8ff76f4 (gitweb: Move call to evaluate_git_version after evaluate_gitweb_config,
  2010-09-26) fixed that issue, in a simplest way, by moving evaluate_git_version
  after evaluate_gitweb_config.


+ 0ac5f64 (gitweb: selectable configurations that change with each request,
  2010-11-18) in my 'gitweb/web' branch solves the issue in other way:
  evaluate_gitweb_config is run first time outside of run_request(), and on 
  subsequent requests in run_request() (by default).  So evaluate_gitweb_config
  is back before evaluate_git_version.  Hence there is no need to move 
  evaluate_git_version.

HTH.

>>> * jn/gitweb-time-hires-comes-with-5.8 (2010-11-09) 1 commit
>>>  - gitweb: Time::HiRes is in core for Perl 5.8
>>> 
>>> Looked reasonable.  Will merge to next.
>>
>> Thanks. With or without improvement to commit message?
> 
> I think what I pushed out has already been reworded.  Please check.

I have checked the version in 'pu' and it looks good.  Thanks.
 
>>> * jh/gitweb-caching (2010-11-01) 4 commits
>>>  . gitweb: Minimal testing of gitweb caching
>>>  . gitweb: File based caching layer (from git.kernel.org)
>>>  . gitweb: add output buffering and associated functions
>>>  . gitweb: Prepare for splitting gitweb
>>> 
>>> Temporarily ejected while I shuffled jn/gitweb-testing; will queue the
>>> latest back in pu or perhaps in next.
>>
>> The advantage of 'gitweb: File based caching layer (from git.kernel.org)'
>> is that it is tested in real-life on heavy load (assuming that 
>> git.kernel.org uses the same version as is/would be in pu/next).
>>
>> The disadvantage is that it is seriously messy code.  Something that I
>> wanted to improve in my rewrite.  This is only minimal fixup.
> 
> Which is exactly what we want at this point (I want to release 1.7.4 by
> the end-of-year holidays, which means a feature-freeze will have to start
> soon).  My understanding is that the serious messiness does not come from
> the caching layer.

Well... the capturing, caching and actual gitweb operations are quite
intermixed in J.H. patch.  I wanted to separate those issues, and have
them modularized in my rewrite[1], making it easy to use other caching engine
(tested with Cache::FileCache from Cache::Cache).  On the other hand 
intermixing allows capturing directly to cache file (although it is only
since v7), something that would be more difficult in my rewrite.

The Perl code of J.H. patch does not follow style of other parts of gitweb,
doesn't follow best practices (like e.g. using lexical filehandles instead
of globs), does include some code repetitions... all of which made me
attempt rewrite rather than fix it.

[1] http://repo.or.cz/w/git/jnareb-git.git
    http://github.com/jnareb/git
    'gitweb/cache-kernel-pu' branch

BTW. I didn't get any responses to "[RFC] Implementing gitweb output caching
- issues to solve".

-- 
Jakub Narebski
Poland
