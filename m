From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 17:35:13 +0200
Message-ID: <200807181735.15278.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <200807180149.18565.jnareb@gmail.com> <48809D31.5030008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 17:36:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJs0Y-00074e-Ah
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 17:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYGRPfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 11:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYGRPfe
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 11:35:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:29027 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbYGRPfd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 11:35:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so170386fgg.17
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=M0KB44GiEHSlmtFB3oj4/NjnHAIKZOKztK4ka4HCJsw=;
        b=aj4/4xMjgXgjGjjH5yDh63D0Dsxl0x2fnh4iaejjPQ8K88h8Qu5GfsJYuVhXaFvDRT
         nz3pgck3xWN/OeeJ1CUDWqCs/hmZ4Y8GikuJ+I3luumDQ5d00bOAFcwF9Y293/7Dr1kI
         VL6O0aKfWiFvF6cQQEbj+rFcS3XwFLdTdCvZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fCBGW11lZemFJQQoHfe3WrLd0LlzozGqs3CfW2sA0u/+/C58RhIoJzoz1sEY7oNkLk
         frYDHExDqDewCCQGAP/onF9TgpG4KiOx1Tni/C47iFUc3hATC0AhXLnZOPz/aBdlNu8i
         DVZSZ7Q91JF8azgvVTTnhhWh8li5KhgJZyNuU=
Received: by 10.86.1.1 with SMTP id 1mr496448fga.61.1216395331470;
        Fri, 18 Jul 2008 08:35:31 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.220.24])
        by mx.google.com with ESMTPS id e20sm2619788fga.1.2008.07.18.08.35.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 08:35:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48809D31.5030008@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89048>

Lea Wiemann wrote:
> Jakub Narebski wrote:

>>>>> +=item $commit->message
>> 
>> I'd rather then have _git_ convert it to UTF=8 for us (using 
>> --encoding=<encoding> option to git-log/git-rev-list)
> 
> Yeah, I guess the API should actually decode it.  You wouldn't want to
> have the message in UTF-8 but in Unicode (I suggest you read man
> perlunitut if you haven't done so).

You mean perluniintro(1) here, isn't it?

Besides if decoding is done in Perl API, we can convert it simply
to Perl internal form (which, IIUC, in modern Perl is UTF-8 and
marked as such).

> We cannot have git do the decoding, 
> since (apart from the fact that it doesn't smell right) it isn't
> guaranteed to emit valid UTF-8 [...]

Well, if that is the case then Perl API has to do conversion, that
is the only sensible way.

>> It is (much) better than forking git-cat-file for each commit shown
>> on the list; nevertheless I think that it would be better to use git-log
>> to generate list (or Git::Revlist) of Git::Commit objects.  It is one
>> fork less, but what more important you don't have to access repository
>> twice for the very same objects.
> 
> You're confused; it's not one fork less, it's a write to a pipe less.
> (Pleeeease look at the code before you write something.  It's there, in
> this very thread.)  And I don't believe the "access the repository
> twice" thing is anywhere near an actual issue.  To summarize, you're
> asking me to (a) write code and (presumably) (b) add something to the
> interface of a public API, based on some (most probably faulty)
> assumptions about performance?  You should really read
> <http://c2.com/cgi/wiki?PrematureOptimization>.

Code is there, in gitweb, in parse_commits subroutine, or rather in
parse_commit_text subroutine.

[cut]

But I can agree that possible (and possibly minuscule) performance
improvement is not worth introducing new API and complicating (I think)
gitweb code.
 
>> I think that _not using_ Git::Cmd (or somesuch) API results in botched,
>> horrible API
>>   our $git_version = $repo_root->repo(directory => 'dummy')->version;
>> (Unless it is not needed any longer, or not used any longer; if it is
>> so, then perhaps implementing Git::Cmd as generic wrapper around git
>> commands, hiding for example ActivePerl hack, could be left for later).
> 
> It isn't used any longer -- I really suggest you read the whole thread
> before replying. ;-)

O.K.  Still I think that putting cmd_output and other in Git::Repo
is not a good API. I'd rather route calling git commands via Git or
Git::Cmd object (but Git::Repo would have Git/Git::Cmd object which
automatically adds '--git-dir=<path>', and possibly also
'--work-dir=<path>').

By the way, would you prefer if I commented on 3/3 patch as it is now,
taking into account what I remember from discussion on this and 2/3
patch (latter only as relevant), or would you rather I wait for next
round (next version) of patches?
 
>>> I wouldn't -- see my blurb about error handling at the top of my reply
>>> to Petr (<487BD0F3.2060508@gmail.com>).  You're not supposed to pass
>>> anything that you didn't get from get_sha1 into Git::Commit or
>>> Git::Tag constructors, or your error handling is invariably broken.
>> 
>> I can understand this simpler, although less than optimal, and geared
>> mainly towards gitweb needs.
> 
> FTR, yes it is simpler, but no, it is not really geared toward gitweb
> needs, and it's definitely not "less than optimal" in the sense of being
> worse than the exception-based error handling Git.pm does.  Trust on me
> on this one. ;-)

[...]

>> Why do you _need_ name_rev, if you are not to include git-describe
>> equivalent?
> 
> I needed it for gitweb.  As I said, I'm not trying to create a complete
> API.  A describe_rev (or so) method can be added later, if and when it's
> needed.  (As I said, I don't think writing APIs without at least one use
> case is a good idea anyway.)

Errr... I guess I misspoke. I should not say 'geared toward gitweb
needs', as perhaps it is 'created according [at least somewhat] to
what gitweb would need'.
 
-- 
Jakub Narebski
Poland
