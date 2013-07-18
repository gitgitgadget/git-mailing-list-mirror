From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Git counterpart to SVN bugtraq properties?
Date: Thu, 18 Jul 2013 15:32:51 +0200
Message-ID: <51E7EE83.5020905@syntevo.com>
References: <51E69612.6020201@syntevo.com> <20130717133357.GB2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jul 18 15:33:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzoKK-0005qk-Ek
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 15:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758994Ab3GRNc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 09:32:56 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:58449 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758989Ab3GRNcz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 09:32:55 -0400
Received: from [217.91.110.92] (helo=[192.168.93.202])
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1UzoKC-0002Ni-Gq; Thu, 18 Jul 2013 15:32:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130717133357.GB2337@serenity.lan>
X-Enigmail-Version: 1.5.1
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230692>

On 17.07.2013 15:33, John Keeping wrote:
> On Wed, Jul 17, 2013 at 03:03:14PM +0200, Marc Strapetz wrote:
>> I'm looking for a specification or guidelines on how a Git client should
>> integrate with bug tracking systems. For SVN, one can use
>> bugtraq-properties [1] to specify e.g. the issue tracker URL or how to
>> parse the bug ID from a commit message. AFAIU, there is nothing
>> comparable for Git [2]? If that's actually the case, is someone
>> interested in working out a similar specification for Git?
>>
>> [1] http://code.google.com/p/tortoisesvn/source/browse/tags/version_1.2.0/doc/issuetrackers.txt
>>
>> [2] http://stackoverflow.com/questions/17545548
> 
> The Git way to record the issue ID as a footer in the commit message.
> See for example [1].  Although I'm not aware of any standard for naming
> this footer.

I wasn't aware of that and probably I'm not the only one. For instance,
we are using JIRA and typical commit messages look like

 SG-1234: fix something

 More details on what has been fixed ...

So the issues ID is present in the first line. This has the advantage
that every GUI client will display it, as usually the short version of
the commit message (which is used everywhere) reaches up to the first
dot or LF. Hence it's pretty easy to display a hyperlink for the
"SG-1234" part. bugtraq properties allow to define whether the issue ID
should be appended to the top or bottom of the commit message. So looks
like such an option makes sense for Git as well.

> In terms of recording the URL and other data, I think you'd want a
> dotfile in the repository (perhaps .bugzilla).  This shoudld probably be
> in the gitconfig format, like .gitmodules.

Having such a file sounds reasonable for storing the defaults, though
let's call it .bugtraq or have some other more general name. Similar to
.gitmodules, it makes sense to have the actual properties stored in
$GIT_DIR/config which can be "initialized" from this .bugtraq file. The
arguments are the same as for submodules: URLs stored in .bugtraq might
need to be changed, depending on the client location (firewall/proxy...).

Or we could just have $GIT_DIR/config properties *optionally*,
overriding the .bugtraq properties, as for most users the default
configuration will work fine anyway.

> I think "all" it needs is to draw up a spec for the names of keys and
> format of their values, along with the format of footer(s) identifying
> issues associated with a commit and to persuade UI developers to support
> it... ;-)

I'll try to compose something here. But I'm wondering how we could
attract a couple of developers or users to join in this discussion?

-Marc
