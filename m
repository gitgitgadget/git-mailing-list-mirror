From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 14:16:48 +0100
Message-ID: <CAJ-05NOyQu7pfY7jwKTJ2ZS_h9pBtnyeMAxJVzjC7R0kVoLUBw@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<20130530114808.GD17475@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 30 15:17:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui2j5-0000hv-A4
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab3E3NQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 09:16:50 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:60133 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3E3NQt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 09:16:49 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so512317obb.11
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=YaUzPejA99zH4TRA7I8qgERqNYX7A4M7T9Zh35YZB/s=;
        b=ltjo5vD/Uz6LhyX0NpIqQWBTy+8A/anTiEWbwTOHuKd8aHm0P2aIlH/LcDJVyNfStP
         sIz01YQIdtfVeCxHj4IoWWjTcPJULKRhA7edP1QWqpwHtOcEX+v2k0enLBH4T2qb6VGh
         lJvJfdg01DfNLtNlIXAWHCZblv1kqMC/CVD1vQnhwjxSRbtc0xV0sOhobgbr9CUdbcui
         iBnARiOrvVu8naqq+v2MB9fBkMLPTE5nrKzSnJZzfbF/yb46gpl+tSVswzSSuet4NV27
         nwwDvQuua5EKMP8DKvVkZ/I7+3qLb7pkQbB2sZkpO3UbxhyU99f0P4FJpwrl+kxkdXY5
         iRnw==
X-Received: by 10.182.81.34 with SMTP id w2mr4057220obx.8.1369919808551; Thu,
 30 May 2013 06:16:48 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Thu, 30 May 2013 06:16:48 -0700 (PDT)
In-Reply-To: <20130530114808.GD17475@serenity.lan>
X-Google-Sender-Auth: Dki_tJgvMls2dUfaWbIyy2hfRrg
X-Gm-Message-State: ALoCoQnCHbZhwvDHAnfnrrrsbaQ3p5vcisgeGtEbXbjFZNcAohT+7NHKSUU5vTOySzx5TpIsu/1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225984>

> You may find that performance improves if you repack with "git gc
--aggressive".

It seems that increases the time to get to where it wants to:

14:12 ajb@sloy/x86_64 [work.git] >time /usr/bin/git --no-pager
describe --long --tags --debug
searching to describe HEAD
 lightweight       10 ajb-build-test-5224
 lightweight       41 ajb-build-test-5222
 annotated        146 vnms-2-1-36-32
 annotated        155 vnms-2-1-36-31
 annotated        174 vnms-2-1-36-30
 annotated        183 vnms-2-1-36-29
 lightweight      188 vnms-2-1-36-28
 annotated        193 vnms-2-1-36-27
 annotated        206 vnms-2-1-36-26
 annotated        215 vectastar-4-2-83-5
traversed 223 commits
more than 10 tags found; listed 10 most recent
gave up search at 2b69df72d47be8440e3ce4cee91b9b7ceaf8b77c
ajb-build-test-5224-10-gfa296e6

real    0m14.658s
user    0m12.845s
sys     0m1.776s

On 30 May 2013 12:48, John Keeping <john@keeping.me.uk> wrote:
> On Thu, May 30, 2013 at 11:38:32AM +0100, Alex Benn=C3=A9e wrote:
>> One factor might be the size of my repo (.git is around 2.4G). Could
>> this just be due to computational cost of searching through large
>> packs to walk the commit chain? Is there any way to make this easier
>> for git to do?
>
> What does "git count-objects -v" say for your repository?
>
> You may find that performance improves if you repack with "git gc
> --aggressive".



--=20
Alex, homepage: http://www.bennee.com/~alex/
