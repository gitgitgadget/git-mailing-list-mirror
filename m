From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Tue, 5 Feb 2013 17:07:06 +0100
Message-ID: <CABPQNSbF8XTp8Biij6KPorq3-tSjLCbroU+G6skKWnngHRt8nQ@mail.gmail.com>
References: <cover.1358686905.git.john@keeping.me.uk> <7cd489e5b1b2578b1509232196cd6b21fd684843.1358686905.git.john@keeping.me.uk>
 <CAGdFq_jp3BrS0zgDpmiXGduwu_m4E2CCL+X32P-7T=z9Qk-wuQ@mail.gmail.com>
 <20130123194757.GQ7498@serenity.lan> <CAGdFq_jZDUxg7oTL7Z4v5ezYFPfJ8kZR6iHpESw6WnoDCeAy8w@mail.gmail.com>
 <7v622nhc0u.fsf@alter.siamese.dyndns.org> <CA+sFfMf2R6+qzrLR9rwhtcM=ABZ8aWUJw-3riF98B3XWVGm54w@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:08:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2l48-000816-W7
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab3BEQHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 11:07:48 -0500
Received: from mail-ia0-f175.google.com ([209.85.210.175]:64578 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933Ab3BEQHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 11:07:47 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so314127iaj.20
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 08:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4I3JwtqHgrOH004wVj/NLCZeLlUcOCT8bNJkGvtLWko=;
        b=RsKMjh8ZPV/yg7PRdGecrzp38jCWYLVWOBI94zoB4IJepvQJsiJb9m+gCT7MbeglI/
         dp9BoHnF/HH75jIRU65lecLEePc2L/f/d5yQeGkpxCtVX27DnSlnyNddRZQ3eoElocbT
         Hco2crfnLBb+rjgZbpSGYsXWEg5IeXuxnPqUmRBmvppfe0PiG1diVJ9xX04oKDK2myrJ
         ztfJQ2t5rQSePMsUbAZJeHae1R20TZTq7swe4cb67ja+CYiSp1pfG9LcwNUKkDmFtExX
         a6LbXmglfj3RskabjsHVWTRolod9GsvzTrb4FH+q2SOp5HjzHnRJC5teZ/A9n3tCEtmp
         BWTA==
X-Received: by 10.50.88.228 with SMTP id bj4mr13936481igb.85.1360080466900;
 Tue, 05 Feb 2013 08:07:46 -0800 (PST)
Received: by 10.64.14.161 with HTTP; Tue, 5 Feb 2013 08:07:06 -0800 (PST)
In-Reply-To: <CA+sFfMf2R6+qzrLR9rwhtcM=ABZ8aWUJw-3riF98B3XWVGm54w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215511>

On Fri, Jan 25, 2013 at 9:23 PM, Brandon Casey <drafnel@gmail.com> wrote:
> On Wed, Jan 23, 2013 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Sverre Rabbelier <srabbelier@gmail.com> writes:
>>
>>> On Wed, Jan 23, 2013 at 11:47 AM, John Keeping <john@keeping.me.uk> wrote:
>>>>> When did we last revisit what minimal python version we are ok with requiring?
>>>>
>>>> I was wondering if people would weigh in discussing that in response to
>>>> [1] but no one has commented on that part of it.  As another datapoint,
>>>> Brandon Casey was suggesting patching git-p4.py to support Python 2.4
>>>> [2].
>>>>
>>>> [1] http://article.gmane.org/gmane.comp.version-control.git/213920
>>>> [2] http://article.gmane.org/gmane.comp.version-control.git/214048
>>>
>>> I for one would be happy to kill off support for anything older than
>>> 2.6 (which had it's latest release on October 1st, 2008).
>>>
>>> Junio, how have we decided in the past which version of x to support?
>>
>> I do not think there was any conclusion.  $gmane/212215 claiming 2.4
>> support matters for RHEL 5.x users was the last on the topic as far
>> as I can tell, so it boils down to another question: do users on
>> RHEL 5.x matter?
>>
>> I can read from $gmane/212215 that users of the said platform can
>> safely keep using Python 2.4 under their vendor support contract
>> until 2017.  But let's focus on what do these users expect of their
>> system and software they run on it a bit.
>>
>> When they want to run a piece software that is not shipped with
>> RHEL, either by writing their own or by importing from elsewhere,
>> that needs 2.6 features, what are their options?
>>
>>  (a) The platform vendor optionally supplies 2.6 with or without
>>      support;
>>
>>  (b) The users can and do install 2.6 as /usr/local/bin/python2.6,
>>      which may even be community-supported, but the vendor does not
>>      support it; or
>>
>>  (c) The vendor terminates the support contract for users who choose
>>      to go (b).
>>
>> I think we can safely discard (c); if that is the case, the users on
>> the said platform will not choose to update Git either, so it does
>> not matter where the future versions of Git sets the lower bound of
>> Python version at.
>>
>> If we are not talking about the situation (c), then the users can
>> choose to use 2.6, and more importantly, Python being a popular
>> software, I would imagine that there are reputable sources of
>> prepackaged RPMs for them to do so without going too much hassle of
>> configuring, compiling and installing.
>>
>> Now how does the decision we make today for releases of Git that
>> haven't yet happened will affect these users?  As these versions of
>> newer Git were not shipped with RHEL 5.x, and also I am assuming
>> that Git is a more niche product than Python is, I would imagine
>> that it is very unlikely that the vendor gives it the users as an
>> optional package.  The users will have to do the same thing to be
>> able to use such versions of Git as whatever they do in order to use
>> Python 2.6.
>>
>> Given that, what the vendor originally shipped and officially
>> supports does not affect the choices we would make today for newer
>> versions of Git.  The users in a shop where additional third-party
>> software in /usr/local/bin is strictly forbidden, they are stuck
>> with the version of Git that the vendor shipped anyway, because they
>> won't be able to install an updated Git in /usr/local/bin, either.
>>
>> That is, unless installing 2.6 as /usr/local/bin/python2.6 (or if
>> you are really paranoid, /usr/local/only-for-git/bin/python2.6 where
>> nobody's $PATH points at) is impossible.
>>
>> So personally I do not think dropping 2.4 is a huge problem for
>> future versions of Git, but I'd like to hear from those working in
>> IT support for large and slow-moving organizations (aka RHEL 5
>> customers).
>
> I'm not really in the demographic that you asked to hear from, but
> I'll give my 2 cents anyway. :)
>
> Firstly, I defer to those with more knowledge and experience with
> python to decide which version should be the minimum version
> supported.  Python 2.6 seems to be the consensus and that's fine with
> me.
>
> With respect to older platforms like RHEL 5.X that don't ship with
> Python 2.6 or later, I suspect most people who work in an organization
> with a dedicated IT staff can request that a more recent version of
> python be installed.  So, I don't think a python 2.6 requirement (if
> there was one) would be a blocker for them, and I don't think it would
> be a major pain for the sysadmin to install.
>

Just a datapoint: I'm working with customers on RHEL 5.X that
unfortunately has an extremely lengthy (>3 months) process of
approving non-standard packages for install. Yeah, it's horrible, but
some times that's reality.

We are currently not using Git with that client, but we are in the
process of changing that. Said customer already have an exception for
all versions of Git.

I doubt this will end up being a problem in reality or not, but if it
will be, I'm sure it can be worked around out. I'm just pointing out
that the above suspicion might not be accurate.
