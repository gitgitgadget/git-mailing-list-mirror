From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0] fix branch.autosetupmerge and branch.autosetuprebase
Date: Wed, 2 Mar 2011 08:37:59 -0500
Message-ID: <AANLkTimzJreTtZUNO9GKUAEES9cSHDewaedNQHtJvWYn@mail.gmail.com>
References: <AANLkTi=Ei-Gr3=O0_dfaCekQ0+nB8v1kZYT7sTw-Ydm+@mail.gmail.com> <1jxhtdj.c6tsy3wnbmbjM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Dustin Sallings <dustin@spy.net>
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Wed Mar 02 14:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PumGB-0003Di-RV
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 14:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab1CBNia convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2011 08:38:30 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37351 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab1CBNi3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2011 08:38:29 -0500
Received: by iwn34 with SMTP id 34so5107384iwn.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 05:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=TkxXXOnTAGZbfOHljd1h87GA0QhxLHPJ2zj4/nOGSgU=;
        b=C4IFDnb5x/M6N/+6wQGTjOKyYIieArCpiEDTI4fyrmNl9U0tj+IJreAsoETP6WGeVG
         oIKlNhKzKnSqsxDfy6j4sVPrhf2J6MAhkBQ7DUtqzfaMumru3KYtb3z/zDB+EZ7X+vcb
         LwwXw3EroY+mwTEWejPYN2j5enwUf77HsFi3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cwiPMfN1bE/8MC96S5fwR4aalc4pQNuKRZ1SJScVM8S4HUqDsn46c9w0MRskIjhpQf
         UVEgTRuluIc1D2slwUbdXFNfaWPAhhNtyiG416Kqe7ZHAJh1w07A1KUdrOm/IQAus+8H
         Fi4aGRs/zVtqkt7U85IqjNrzqm8Ts9wASq9lA=
Received: by 10.231.37.70 with SMTP id w6mr7254853ibd.169.1299073109130; Wed,
 02 Mar 2011 05:38:29 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 2 Mar 2011 05:37:59 -0800 (PST)
In-Reply-To: <1jxhtdj.c6tsy3wnbmbjM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168311>

On Wed, Mar 2, 2011 at 2:30 AM, Stefan Haller <lists@haller-berlin.de> =
wrote:
> Jay Soffian <jaysoffian@gmail.com> wrote:
>
>> 99% of the time, I think you are doing one of the following:
>>
>> =C2=A0 $ git branch topic origin/master =C2=A0 =C2=A0# 1
>> =C2=A0 $ git branch topic master =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
# 2
>> =C2=A0 $ git branch topic some_other_topic # 3
>>
>> In the case of (1), you want origin/master to be configured as the
>> upstream for topic. In the case of (2), even though you are starting
>> at master, I'll bet you want the upstream to be origin/master. In th=
e
>> case of (3), even though you are starting at some_other_topic, I'll
>> bet you want topic to have the same configured upstream as
>> some_other_topic.
>
> Where I work, none of these is true. =C2=A0I guess these may be true =
for an
> open-source kind of setup, where one developer is working on a branch
> and then posts a patch series; however, in a corporate environment wi=
th
> a central repository and multiple developers collaborating on a topic
> branch, it's not. =C2=A0Our workflow is to branch a topic from master=
 (with
> --no-track), push the topic to the central repository

The person who creates topic from master would do the following:

  $ git branch topic origin/master
  $ git push --set-upstream origin topic

Creating topic would initially set its upstream to origin/master.
Specifying "--set-upstream" to push would reset topic's upstream from
origin/master to origin/topic.

Or they could create the topic remotely this way:

  $ git push origin origin/master:refs/heads/topic

> others pull the topic branch (with autosetuprebase=3Dalways)

So they'd do something like this:

  $ git fetch
  $ git checkout -b topic origin/topic

which would make origin/topic the upstream of topic, which I think is
exactly what you want.

> and contribute to it, and
> eventually it is merged back to master. =C2=A0We never want automatic
> rebasing onto master for topics.
>
> Which means that we only ever have upstream branches with the same na=
me
> as the local branch. =C2=A0I haven't seen a single exception yet, and=
 I wish
> there was a way to set autosetupmerge to "only_if_name_matches" or so=
me
> such.

I don't think my proposal makes your workflow more difficult.

>> 2. Deprecate branch.autosetuprebase. Pull's default action shouldn't
>> be specified when the branch is created. Rather, add a "pull.rebase"
>> boolean defaulting to false, and which is overridden per-branch by
>> branch.<name>.rebase.
>
> I like this part of the proposal though.

Thank you for the feedback.

j.
