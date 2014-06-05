From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
Date: Thu, 05 Jun 2014 19:48:33 +1200
Message-ID: <539020D1.1090601@gmail.com>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com> <1401874256-13332-1-git-send-email-judge.packham@gmail.com> <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com> <20140604194216.GA4636@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mara.kim@vanderbilt.edu,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 09:48:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsSPj-0001dB-O7
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 09:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbaFEHsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 03:48:39 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:52592 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbaFEHsi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 03:48:38 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so745811pbc.9
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=azxe8nZc4ERl6/ny5qxwavm0QCfKf4nbDwFKW0LHsYM=;
        b=o4NWBWQL+9Mq11SngjwVhGdwjsIStQZJ6AYq2mYJ4dJAhn4X7oCM2/iPFvhSNAkoF2
         XXPitwkJXC5ktoW+VMGEj40p1mG3HSag2EV+lLjYbqgQsqtUNN9UkVtvyO4Qq9/VXCdj
         O/qnmq7ePG28Qhbv+fsDrkZAyHyVm4o6BLj9iK8QgdYbF86jTTkgY1Yn+CP72JbXgKGG
         0/X1NZlXS0wJTrG1hBDVjSOU0v0LVxrOZO1FXTMT2GIQRRdxNSzfdQUmoQHTUb1a3h1n
         gjDi3OZ8RDJHMacw+dCCg2hoTNeYiDaEdEdLP/U1xa+j1oVtskLoDER9OreIBhXH/fMR
         GXgw==
X-Received: by 10.68.78.66 with SMTP id z2mr74369387pbw.71.1401954518284;
        Thu, 05 Jun 2014 00:48:38 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id su8sm19336125pbc.72.2014.06.05.00.48.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 00:48:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140604194216.GA4636@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250821>

On 05/06/14 07:42, Heiko Voigt wrote:
> On Wed, Jun 04, 2014 at 10:24:06AM -0700, Junio C Hamano wrote:
>> Chris Packham <judge.packham@gmail.com> writes:
>>
>>> On 04/06/14 09:05, Junio C Hamano wrote:
>>>>> Also, going --recursive when the user did not want is a lot more
>>>>> expensive mistake to fix than not being --recursive when the user
>>>>> wanted to.
>>>>
>>>> Having said all that, I do not mean to say that I am opposed to
>>>> introduce some mechanism to let the users express their preference
>>>> between recursive and non-recursive better, so that "git clone"
>>>> without an explicit --recursive (or --no-recursive) can work to
>>>> their taste.  A configuration in $HOME/.gitconfig might be a place
>>>> to start, even though that has the downside of assuming that the
>>>> given user would want to use the same settings for all his projects,
>>>> which may not be the case in practice.
>>>
>>> And here's a quick proof of concept. Not sure about the config variable name
>>> and it could probably do with a negative test as well.
>>
>> I would be more worried about the semantics than the name, though;
>> re-read the part you quoted with extra stress on "has the downside".
>>
>> I think I heard the submodule folks (cc'ed) discuss an approach to
>> allow various submodules to be marked with "tags" with a new type of
>> entry in .gitmodules file in the superproject, and use these tags to
>> signal "by default, a new clone will recurse into this submodule".
>>
>> E.g. if projects standardized on "defaultClone" to mark such
>> submodules, then $HOME/.gitconfig could say
>>
>>     [clone]
>>         recursesubmodules = defaultClone
>>
>> Or the projects may mark platform specific submodules with tags,
>> e.g. a .gitmodules in a typical superproject might say something
>> like this:
>>
>>     [submodule "posix"]
>>     	path = ports/posix
>>         tags = linux obsd fbsd osx
>>     [submodule "windows"]
>>         path = ports/windows
>>         tags = win32
>>     [submodule "doc"]
>>     	path = documentation
>>         tags = defaultClone
>>
>> and then the user's $HOME/.gitconfig might say
>>
>>     [clone]
>>         recursesubmodules = defaultClone win32
>>
>> to tell a "git clone" of such a superproject to clone the top-level,
>> read its .gitmodules, and choose documentation/ and ports/windows
>> submodules but not ports/posix submodule to be further cloned into
>> the working tree of the superproject.
>>
>> Of course, if this kind of project organization proves to be useful,
>> we should try to standardize the set of tags early before people
>> start coming up with random variations of the same thing, spelling
>> the same concept in different ways only to be different, and if that
>> happens, then we could even give a non-empty default value for the
>> clone.recursesubmodules when $HOME/.gitconfig is missing one.
>>
>> Just a random thought.
> 
> I like this idea of specifying different "views" by giving tags. But
> does it rule out a boolean clone.recursesubmodules? For the simple case
> some people might not want to worry about specifying tags but just want
> to configure: "Yes give me everything". So if we were to do this I would
> like it if we could have both. Also because the option for clone is
> --recurse-submodules and our typical schema is that a configuration
> option is named similar so clone.recursesubmodules would fit here.

Maybe using a glob pattern would work.

The user might say

     [clone]
         recursesubmodules = x86*

And .gitmodules might say

     [submodule "foo"]
         tags = x86_64
     [submodule "bar"]
         tags = x86
     [submodule "frotz"]
         tags = powerpc

For the "Yes give me everything" case the user could say

     [clone]
         recursesubmodules = *

> 
> So either we do this "magically" and all valid boolean values are
> forbidden as tags or we would need a different config option. Further
> thinking about it: Maybe a general option that does not only apply to
> clone would suit the "views" use-case more. E.g. "submodule.tags" or
> similar.
> 
> Also please note: We have been talking about adding two configurations
> for submodules:
> 
> 	submodule."name".autoclone (IIRC)
> 
> I am not sure whether that was the correct name, but this option should
> tell recursive fetch / clone whether to automatically clone a submodule
> when it appears on a fetch in the history.
> 
> 	submodule."name".autoinit
> 
> And this one is for recursive checkout and tells whether an appearing
> submodule should automatically be initialized.
> 
> These options fullfill a similar use-case and are planned for the future
> when recursive fetch/clone and checkout are in place (which is not that
> far away). We might need to rethink these to incoporate the "views from
> tags" idea nicely and since we do not want a configuration nightmare.
> 
> Cheers Heiko
> 

I'm a little confused at how autoclone and autoinit differ. Aren't they
the same? i.e. when this module appears grab it by default. I see
autoupdate as a little different meaning update it if it's been
initialised. Also does autoinit imply autoupdate?

At $dayjob we have a superproject which devs clone this has submodules
for the important and/or high touch repositories. We have other
repositories that are normally build from a tarball (or not built at
all) but we can build them from external repositories if needed. The
latter case is painfully manual. If autoinit/autoupdate existed we'd
probably setup out projects with.

    [submodule "linux"]
        autoinit = true
	autoupdate = true
    [submodule "userland"]
        autoinit = true
	autoupdate = true
    [submodule "not-used-that-much"]
	autoupdate = true

We probably wouldn't make use of tags because we're building complete
embedded systems and generally want everything, even if we are doing
most of our work on a particular target we need to do builds for other
targets for sanity checks.
