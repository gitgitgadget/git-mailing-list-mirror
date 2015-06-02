From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: git branch <refspec>
Date: Tue, 2 Jun 2015 20:22:31 +1000
Message-ID: <CAOsGNSQistVzM5vqueOUku9ZOR5dTOFJEtb8X1VwRezLr692Gw@mail.gmail.com>
References: <CAOsGNSTtWnawxmpL7SByUBZ-XUNdDd5nKNuudGQi-S3BjCHcdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 12:23:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzjLC-0005SF-8x
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 12:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbbFBKWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 06:22:34 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34328 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbbFBKWc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 06:22:32 -0400
Received: by obew15 with SMTP id w15so124595446obe.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=QH0MJAH3rnM7JxYXMLG0P7+fzfsIm5CmGNuqgCyVHzk=;
        b=L9mou7QMxQiD60lf6ZgKi80SNEwsucEvPs6appLm7wSQaDgXB8dyOdoF1iC4lexuua
         k/JFPfmHKNPqCDNO/XS1biVzFHNYgJLPBE/r2BdwZOmv0aIp785WDmVacXBHElPw0DVF
         lKsDdC3Uy0myt0fGSfcmQ0MN2nm6SU9zSb20cmNb8yrn9q4GellnPLaTL9sRVim6EciK
         xOd0RDXxZwruJODVWVCQXXaiB4b96OWH1PiQDCcwflyXA0S3jKz/U+TEJryQKKJ4+t5c
         FslzjsKInNO1Hr6chZgD+TDT5H+tIOc8wpithE3LEKkRs0D/sK3DbGSw5PWyAgwD0yeX
         56mw==
X-Received: by 10.60.176.37 with SMTP id cf5mr22114333oec.19.1433240551905;
 Tue, 02 Jun 2015 03:22:31 -0700 (PDT)
Received: by 10.182.121.198 with HTTP; Tue, 2 Jun 2015 03:22:31 -0700 (PDT)
In-Reply-To: <CAOsGNSTtWnawxmpL7SByUBZ-XUNdDd5nKNuudGQi-S3BjCHcdg@mail.gmail.com>
X-Google-Sender-Auth: jdkQLN4MN6wb5GotA-K7RJooC2I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270518>

On 6/2/15, Zenaan Harkness <zen@freedbms.net> wrote:
> <refspec> - git's guilty little secret. Let's milk the guilt.
>
> git branch <refspec> ought work in a similar way to
> git fetch <refspec>
>
> One syntax to rule them all. Or something.
>
> I just learned how git fetch uses refspecs and how this can just as
> well apply to tags to create "remote tags" (refs/rtags/remote_name/*),
> finally grokking the ridiculously simple yet powerful refspec concept
> - it really is generic.
>
> And now combining two remotes such as postgresql and postgresql-xc
> (which share substantial code and parent commits), or (a bit out of
> date now, but) the openmoko-kernel and linux mainline, becomes
> simpler/saner when "inventing" rtags as explained here:
> http://stackoverflow.com/questions/22108391/git-checkout-a-remote-tag

Regarding this stackoverflow article and "rtags", what I'm now doing
is, for postgresql mainline "origin" and postresql-xc "pgxc" remotes:
[remote "origin"]
  url = git://git.postgresql.org/git/postgresql.git
  fetch = +refs/*:refs/*
  fetch = +refs/*:refs/remotes/origin/*
[remote "pgxc"]
  url = https://github.com/postgres-x2/postgres-x2.git
  fetch = +refs/*:refs/remotes/origin/*

so that origin is my normal --mirror, but also with origin and pgxc
having everything (!) under refs/remotes/$name/*

This allows for those who want multiple related remotes in the one
mirror to include 'interesting' refs from each remote in a way that
does not clash, e.g. github's refs/pull/* pull requests.

This only leads to the "how to minimize typing without extra
porcelain", and of course a symlink here can help:
cd refs/
ln -s remotes r

or perhaps even better :
ln -s remotes/* .

Using +refs/*:refs/remotes/origin/*  feels better than e.g.:
refs/rtags/origin/*
refs/rpull/origin/*
refs/rtags/pgxc/*
refs/rpull/pgxc/*
refs/blah?/origin/*
refs/blah?/pgxc/*
althogh these forms might simplify porcelain (e.g. tab completion)
which needs to work with all refs of a particular 'type'.

Zenaan
