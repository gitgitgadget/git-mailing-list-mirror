From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v3 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Fri, 25 Jan 2013 12:23:56 -0800
Message-ID: <CA+sFfMf2R6+qzrLR9rwhtcM=ABZ8aWUJw-3riF98B3XWVGm54w@mail.gmail.com>
References: <cover.1358686905.git.john@keeping.me.uk>
	<7cd489e5b1b2578b1509232196cd6b21fd684843.1358686905.git.john@keeping.me.uk>
	<CAGdFq_jp3BrS0zgDpmiXGduwu_m4E2CCL+X32P-7T=z9Qk-wuQ@mail.gmail.com>
	<20130123194757.GQ7498@serenity.lan>
	<CAGdFq_jZDUxg7oTL7Z4v5ezYFPfJ8kZR6iHpESw6WnoDCeAy8w@mail.gmail.com>
	<7v622nhc0u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:24:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Typox-000649-Em
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 21:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab3AYUX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 15:23:59 -0500
Received: from mail-vc0-f172.google.com ([209.85.220.172]:54210 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab3AYUX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 15:23:57 -0500
Received: by mail-vc0-f172.google.com with SMTP id l6so598664vcl.3
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=zKYPQRvgJUFEBQA/W75vePD0pRMgDSuAjOe4w08iuwM=;
        b=uoP/+cePatzvUkVEEFojnpzXrPvLHCVUpO6j7Hk3SWKy+J0yHlMPF8UeCJF+w4/0Vh
         wJNddF8Z6TyFOqKstPrtyqoVR+E04rtmPNfuHI3bKHtgMmNwUzQoaAngLFHC4Tp/DXmZ
         tEyMH0xjCVmEgkTQ8S6tcCdcqhlE9UkQhJOtyfHspzBXBMd2TKmnBT7lIPfq/mM5djuR
         E++GYsVaYJfvd73zqhTP8C1S8Sv8urYMNIFKxD6Fn36YpnYyrKHeJaYyko/fNiHh7Rnq
         MwxoLqjN2QAT97w6zjgWJ1PfzVahdTECFzT4m13JJ0XYgGqy/ZlVzH1OU+1mzkiHqWDx
         jYyQ==
X-Received: by 10.52.22.194 with SMTP id g2mr1967080vdf.91.1359145436437; Fri,
 25 Jan 2013 12:23:56 -0800 (PST)
Received: by 10.58.216.1 with HTTP; Fri, 25 Jan 2013 12:23:56 -0800 (PST)
In-Reply-To: <7v622nhc0u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214577>

On Wed, Jan 23, 2013 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>
>> On Wed, Jan 23, 2013 at 11:47 AM, John Keeping <john@keeping.me.uk> wrote:
>>>> When did we last revisit what minimal python version we are ok with requiring?
>>>
>>> I was wondering if people would weigh in discussing that in response to
>>> [1] but no one has commented on that part of it.  As another datapoint,
>>> Brandon Casey was suggesting patching git-p4.py to support Python 2.4
>>> [2].
>>>
>>> [1] http://article.gmane.org/gmane.comp.version-control.git/213920
>>> [2] http://article.gmane.org/gmane.comp.version-control.git/214048
>>
>> I for one would be happy to kill off support for anything older than
>> 2.6 (which had it's latest release on October 1st, 2008).
>>
>> Junio, how have we decided in the past which version of x to support?
>
> I do not think there was any conclusion.  $gmane/212215 claiming 2.4
> support matters for RHEL 5.x users was the last on the topic as far
> as I can tell, so it boils down to another question: do users on
> RHEL 5.x matter?
>
> I can read from $gmane/212215 that users of the said platform can
> safely keep using Python 2.4 under their vendor support contract
> until 2017.  But let's focus on what do these users expect of their
> system and software they run on it a bit.
>
> When they want to run a piece software that is not shipped with
> RHEL, either by writing their own or by importing from elsewhere,
> that needs 2.6 features, what are their options?
>
>  (a) The platform vendor optionally supplies 2.6 with or without
>      support;
>
>  (b) The users can and do install 2.6 as /usr/local/bin/python2.6,
>      which may even be community-supported, but the vendor does not
>      support it; or
>
>  (c) The vendor terminates the support contract for users who choose
>      to go (b).
>
> I think we can safely discard (c); if that is the case, the users on
> the said platform will not choose to update Git either, so it does
> not matter where the future versions of Git sets the lower bound of
> Python version at.
>
> If we are not talking about the situation (c), then the users can
> choose to use 2.6, and more importantly, Python being a popular
> software, I would imagine that there are reputable sources of
> prepackaged RPMs for them to do so without going too much hassle of
> configuring, compiling and installing.
>
> Now how does the decision we make today for releases of Git that
> haven't yet happened will affect these users?  As these versions of
> newer Git were not shipped with RHEL 5.x, and also I am assuming
> that Git is a more niche product than Python is, I would imagine
> that it is very unlikely that the vendor gives it the users as an
> optional package.  The users will have to do the same thing to be
> able to use such versions of Git as whatever they do in order to use
> Python 2.6.
>
> Given that, what the vendor originally shipped and officially
> supports does not affect the choices we would make today for newer
> versions of Git.  The users in a shop where additional third-party
> software in /usr/local/bin is strictly forbidden, they are stuck
> with the version of Git that the vendor shipped anyway, because they
> won't be able to install an updated Git in /usr/local/bin, either.
>
> That is, unless installing 2.6 as /usr/local/bin/python2.6 (or if
> you are really paranoid, /usr/local/only-for-git/bin/python2.6 where
> nobody's $PATH points at) is impossible.
>
> So personally I do not think dropping 2.4 is a huge problem for
> future versions of Git, but I'd like to hear from those working in
> IT support for large and slow-moving organizations (aka RHEL 5
> customers).

I'm not really in the demographic that you asked to hear from, but
I'll give my 2 cents anyway. :)

Firstly, I defer to those with more knowledge and experience with
python to decide which version should be the minimum version
supported.  Python 2.6 seems to be the consensus and that's fine with
me.

With respect to older platforms like RHEL 5.X that don't ship with
Python 2.6 or later, I suspect most people who work in an organization
with a dedicated IT staff can request that a more recent version of
python be installed.  So, I don't think a python 2.6 requirement (if
there was one) would be a blocker for them, and I don't think it would
be a major pain for the sysadmin to install.

My only opinion is that if we can avoid breaking older platforms
fairly easily, we should do so.  If there is someone out there
building git packages (e.g. EPEL) for RHEL 5.X or anything else, I
imagine that one less dependency makes installing and supporting the
package that much easier.

So, my comments shouldn't be taken to suggest that git should support
any particular version of python.  That decision should be made by
those who are willing to support whatever version they feel strongly
about.

-Brandon
