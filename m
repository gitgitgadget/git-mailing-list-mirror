From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Tue, 15 Jan 2013 10:44:24 +0100
Message-ID: <50F524F8.5090803@drmicha.warpmail.net>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com> <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky> <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com> <50F40316.7010308@drmicha.warpmail.net> <7v1udnbmyz.fsf@alter.siamese.dyndns.org> <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com> <7vpq1755jb.fsf@alter.siamese.dyndns.org> <7vip6z54rh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 10:45:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv34n-0003Qx-An
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 10:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245Ab3AOJob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 04:44:31 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59192 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756196Ab3AOJoY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 04:44:24 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8A102207FF;
	Tue, 15 Jan 2013 04:44:23 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 15 Jan 2013 04:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ILcvhpU6mwsu31AXz69p2/
	rBmuU=; b=eV3HKAazO2paMzUe5G4qQejhkHehiiNhAi+0hTFMQOLHVobtgljyWP
	LKejCn0ObLWrzscCEwQ4T+meXI5lertFmw99/DVbW7K182dCzujav8UoFvaHoImQ
	zq3LR6iEFWGwHOM8+x7cQc7SFzP6QGOFDBLsO1Sh/X4A7nGwYnXlc=
X-Sasl-enc: l+ITWXnOZos0ugRD9ados1//eYDY9W6Zsm8JEgqvfu/1 1358243063
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BEB7A4825D9;
	Tue, 15 Jan 2013 04:44:22 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7vip6z54rh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213628>

Junio C Hamano venit, vidit, dixit 15.01.2013 07:39:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Jardel Weyrich <jweyrich@gmail.com> writes:
>>
>>> If you allow me, I'd like you to forget about the concepts for a minute, and focus on the user experience.
>>> Imagine a simple hypothetical scenario in which the user wants to push to 2 distinct repositories. He already has cloned the repo from the 1st repository, thus (theoretically) all he needs to do, is to add a new repository for push. He then uses `remote set-url --add --push <2nd-repo>` (which I personally thought would suffice). However, if he tries to push a new commit to this remote, it would be pushed _only_ to the 2nd-repo.
>>
>> The primary reason behind push-url was that
>>
>>  (1) usually you push to and fetch from the same, so no pushUrl is
>>      ever needed, just a single Url will do (this is often true for
>>      cvs/svn style shared repository workflow); and
>>
>>  (2) sometimes you want to fetch from one place and push to another
>>      (this is often true for "fetch from upstream, push to my own
>>      and ask upstream to pull from it" workflow), and in that case
>>      you want pushUrl in addition to Url.  Most importantly, in this
>>      case, you do *NOT* want to push to Url.  You only push to
>>      pushUrl.
>>
>> Setting *one* pushURL is a way to say "That URL I fetch from is
>> *not* the place I want to push (I may not even be able to push
>> there); when I say 'push', push there instead".  Your proposed
>> semantics will make it impossible to arrange such an asymmetric
>> setting.
> 
> Now I think I finally see where that misunderstanding comes from.
> It is "remote -v" that is misdesigned.
> 
>     $ git clone ../there here
>     $ cd here
>     $ git remote -v
>     origin /var/tmp/there (fetch)
>     origin /var/tmp/there (push)
> 
> This is totally bogus.  It should report something like this:
> 
>     $ git remote -v
>     origin /var/tmp/there (fetch/push)
> 
> Then after running "git remote set-url --push origin ../another" we
> should see
> 
>     $ git remote -v
>     origin /var/tmp/there (fetch)
>     origin /var/tmp/another (push)
> 
> which would make it clear that the original fetch/push came from the
> (1) usuall you push and fetch from the same place so there is only
> one setting, and the two lines came from the (2) sometimes you need
> a separate places to fetch from and push to.

Yes, that is one big source of misunderstanding. Cleaning up remote -v
would help, along with the man page.

Also there is a conceptual confusion: pushurl is meant to push to the
same repo using a different url, e.g. something authenticated
(https/ssh) for push and something faster/easier for fetch.

It never was meant to push to several repos. That is what "remotes" are
for, and it would help if we could push to a remote group (which is
difficult because of refspecs etc.) easily.

That being said, I don't mind changing the behaviour of set-url.

> At this point, if you say "set-url --push origin ../third", then
> "another" will disappear and gets replaced by "third"; if you
> instead say "set-url --add --push origin ../third", then we will see
> two (push) lines, in addition to one (fetch), making it clear that
> you are still in (2) above, fetching from and pushing to different
> places, and having two places to push to.
> 
> I misread your response
> 
>     From: Jardel Weyrich <jweyrich@gmail.com>
>     Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
>     Date: Sat, 12 Jan 2013 06:09:35 -0200
>     Message-ID: <CAN8TAOvP_HX6BEK86aYoX-kVqWDmsbyptxTT2nk+fx+Ut1Tojg@mail.gmail.com>
> 
> where you showed that there was only remote.origin.url (and no
> pushurl) in the first step, and somehow thought you had a
> remote.origin.pushurl in the first place.
> 
