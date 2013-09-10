From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [Proposal] Clonable scripts
Date: Tue, 10 Sep 2013 15:15:55 +0530
Message-ID: <522EEA53.3020308@gmail.com>
References: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Niels Basjes <Niels@basjes.nl>
X-From: git-owner@vger.kernel.org Tue Sep 10 11:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJKWU-0003Ze-2s
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 11:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679Ab3IJJqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 05:46:00 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:63807 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab3IJJp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 05:45:58 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so7470701pad.30
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 02:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JG9tPRNSZH0nzsuOfo/QZ47xKnJeaF4AhlaYzxfMY48=;
        b=CmCfDELrDasrQ9HyOz6JhNd1zNAmKTTmM3+tg3vX4tZkk80Y6o4opDlfeOxdBQenJa
         wB8ZGtfROawq8GTkUQS0hGIaAkziNzSdNNphbxD8lEekK8b1hNx1PL5OIsiAUvX0osOa
         00ckqQFTQUnGZbCuQasogLBlsT6TdzkJvFePztIiNLQKJXKMQoyNcfja7CI8jLpSPW7M
         oYIC6LtBf0Qih1WZK5UggnbTZtlQbgw6ga02FfjY62ohdD3zWhpIQwsyBb4ji32oo52n
         v8ysQ8iqUXJOsOG5GJOess9bEOiOdX8ZVSGyXRHVbCJtVYCuFyLdwWKfNnTI+kG+DryM
         1kcQ==
X-Received: by 10.68.132.71 with SMTP id os7mr646162pbb.188.1378806357690;
        Tue, 10 Sep 2013 02:45:57 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id ht5sm21824543pbb.29.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 02:45:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234428>

On 09/10/2013 02:18 AM, Niels Basjes wrote:

> As we all know the hooks ( in .git/hooks ) are not cloned along with
> the code of a project.
> Now this is a correct approach for the scripts that do stuff like
> emailing the people responsible for releases or submitting the commit
> to a CI system.
> 
> For several other things it makes a lot of sense to give the developer
> immediate feedback. Things like the format of the commit message (i.e.
> it must start with an issue tracker id) or compliance with a coding
> standard.
> 
> Initially I wanted to propose introducing fully clonable (pre-commit)
> hook scripts.
> However I can imagine that a malicious opensource coder can create a
> github repo and try to hack the computer of a contributer via those
> scripts. So having such scripts is a 'bad idea'.
> 
> If those scripts were how ever written in a language that is build
> into the git program and the script are run in such a way that they
> can only interact with the files in the local git (and _nothing_
> outside of that) this would be solved.
> 
> Also have a builtin scripting language also means that this would run
> on all operating systems (yes, even Windows).
> 
> So I propose the following new feature:
> 
> 1) A scripting language is put inside git. Perhaps a version of python
> or ruby or go or ... (no need for a 'new' language)
> 
> 2) If a project contains a folder called .githooks in the root of the
> code base then the rules/scripts that are present there are executed
> ONLY on the system doing the actual commit. These scripts are run in
> such a limited way that they can only read the files in the
> repository, they cannot do any networking/write to disk/etc and they
> can only do a limited set op actions against the current operation at
> hand (i.e. do checks, parse messages, etc).
> 
> 3) For the regular hooks this language is also support and when
> located in the (not cloned!) .git/hooks directory they are just as
> powerful as a normal script (i.e. can control CI, send emails, etc.).
> 
> Like I said, this is just a proposal and I would like to know what you
> guys think.

I am not in favour of any idea like this.  It will end in some sort of
compromise (in both sense of the word!)

It has to be voluntary, but we can make it easier.  I suggest something
like this:

  - some special directory can have normal hook files, but it's just a
    place holder.

  - each hook code file comes with some meta data at the top, say
    githook name, hook name, version, remote-name.  I'll use these
    examples:

        pre-commit  crlf-check  1.1     origin

  - on a clone/pull, if there is a change to any of these code files
    when compared to the previous HEAD, and if the program is running
    interactively, then you can ask and setup these hooks.

    The purpose of the remote name in the stored metadata is that we
    don't want to bother updating when we pull from some other repo,
    like when merging a feature branch.

    The purpose of the version number is so you can do some intelligent
    things, even silently upgrade under certain conditions.

All we're doing is making things easier compared to what you can already
do even now (which is completely manual and instructions based).

I don't think anything more intrusive or forced is wise.

And people who say it is OK, I'm going to seriously wonder if you work
for the NSA (directly or indirectly).  Sadly, that is not meant to be a
joke question; such is life now.
