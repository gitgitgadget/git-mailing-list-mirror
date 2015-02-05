From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 1/2] Fixes _is_git
Date: Thu, 5 Feb 2015 21:13:45 +1300
Message-ID: <CAFOYHZAerQWpeOPzD5D3gqKdWYvaCE3vB88Y_iD30eRF5MC2DQ@mail.gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
	<1422897883-11036-1-git-send-email-remirampin@gmail.com>
	<CAFOYHZBHoXC34gBu_Lx347f=-uUcVM1nHYT87SzxfeMa=KdFgw@mail.gmail.com>
	<54D0EEB9.1090803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	GIT <git@vger.kernel.org>
To: =?UTF-8?B?UsOpbWkgUmFtcGlu?= <remirampin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJHZP-0002z1-A7
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 09:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbbBEINq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2015 03:13:46 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:40869 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192AbbBEINp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2015 03:13:45 -0500
Received: by pdjy10 with SMTP id y10so6313923pdj.7
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 00:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Ro7ZzoVndkVmxzlDlpY5iSWsWt4AJEwQp4Nraj92Jqk=;
        b=xEOjrV6LZ6KyhS42ogx93upcOzRrDnHa9o625UB/OW8c+5Fl5KaLS2azSgWh2jBs2u
         gpFf2+RIY51eeRI6taN61UKZfGyxNiFyRh3paXPw1kvCNrbddqByMIRGKC5Yzw/cgVDH
         6tH+AyXGbs63GCwaMaueXmswYrrv4fmKgeZhc8cS3JkAfKXSb8pLr/umodTJ+ek8ZkUf
         vUm3ITX6YTSQfkjGfwn4hog+X2CxgHNimC3SRsI92H+kxWLpk/SS+7U8yKIL2b/Jfw5I
         map0PvLD/mrDkLCZV/wsFoG+2WHhJjXtpzABj472vOuBXPKZHUGWafq+5nh9xNuToAcP
         fO1A==
X-Received: by 10.70.44.132 with SMTP id e4mr3773729pdm.58.1423124025304; Thu,
 05 Feb 2015 00:13:45 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Thu, 5 Feb 2015 00:13:45 -0800 (PST)
In-Reply-To: <54D0EEB9.1090803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263365>

On Wed, Feb 4, 2015 at 4:52 AM, R=C3=A9mi Rampin <remirampin@gmail.com>=
 wrote:
> 2015-02-02 12:24 UTC-05:00, Remi Rampin <remirampin@gmail.com>:
>>>  proc _is_git {path} {
>>> +       if {[file isfile $path]} {
>>> +               set fp [open $path r]
>>> +               gets $fp line
>>> +               close $fp
>>> +               if {[regexp "^gitdir: (.+)$" $line line link_target=
]} {
>
> 2015-02-03 3:44 UTC-05:00, Chris Packham <judge.packham@gmail.com>:
>> It might be simpler to use one of the 'string' commands e.g. string
>> wordend "gitdir: " I also suspect the string functions would be fast=
er
>> than regexp but that probably doesn't matter.
>
> I want to check that the file actually begins with "gitdir: " and the=
n
> extract the path, so I'm not sure if using string functions is that
> simple/fast.

Makes sense.

>
>>> +                       return [_is_git [file join [file dirname $p=
ath] $link_target]]
>
>> Do we want to avoid pathological cases of infinite recursion? Someon=
e
>> would have to maliciously create such a situation.
>
> Limiting the recursion is very simple, but I'm not sure people are
> supposed to stumble on that. More importantly this probably calls for=
 a
> different error message, thus a new error result that I am not ready =
to
> implement. But it could be another patch.
> But I suppose I can add a simple "return 0" limit to the recursion if
> needed, let me know.

It'd have to be fairly intentional to cause any real problems. The one
thing I was thinking was to factor out the part that checks for HEAD
info objects etc into a __is_git that _is_git could call thus
eliminating recursion but I don't see it really being anything more
than a theoretical issue.
