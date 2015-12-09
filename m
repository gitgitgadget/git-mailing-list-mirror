From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Wed, 9 Dec 2015 17:08:27 +0100
Message-ID: <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Taylor Braun-Jones <taylor@braun-jones.org>
X-From: git-owner@vger.kernel.org Wed Dec 09 17:09:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6hId-0006Xb-5n
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 17:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbbLIQI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 11:08:59 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33380 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbbLIQI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 11:08:58 -0500
Received: by lfaz4 with SMTP id z4so37709499lfa.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 08:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P33Tbqo6VNGNs1GmkN/V8ns/FtuH+IvJXzqFuAke644=;
        b=h2vvqgnw2Vl8Fzgg2a601ZniuGCfsrdDrRQHxI5rUO66+4MYhTrHkCg8pG7v77fJ8S
         gVVEqcXbdosljmfHqHOqQ3mSA/uL8H9VpPq0n6rU8UtLsNrelkZawJ8HX5cOtWxnNqW9
         /RPjkEyYSm2UMT0DiOz0RubKlKOpPiHtNOVg2neV7nxvZdSHAnnLLM2DhniuPfur2/op
         QoGrwOPYtGF3Dw7+nmmwkGUkppAgr5ZPopyf/d9ZOTZLq06GXLRdWhiA7NNs3pi1EIHd
         ZKsqNEQn3OuNLrdg7/iBFqCvEXbEF3j+7H6Npm66eJ3O3DpFQCX9BUStk/gV45GPlmKt
         ukVw==
X-Received: by 10.25.137.84 with SMTP id l81mr2641745lfd.45.1449677337049;
 Wed, 09 Dec 2015 08:08:57 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 9 Dec 2015 08:08:27 -0800 (PST)
In-Reply-To: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282193>

On Wed, Dec 2, 2015 at 9:10 PM, Taylor Braun-Jones
<taylor@braun-jones.org> wrote:
> My use case it running git clone inside a docker container with
> `docker run --user $(id -u):$(id -g) --volume /foo:/foo ...`. I want
> all /foo/* file creation/access from inside the Docker container to be
> done as the current uid/gid of the host system.
>
> Steps to reproduce:
>
> mkdir /tmp/docker-git
> cat > /tmp/docker-git/Dockerfile <<EOF
> FROM ubuntu
> RUN apt-get update && apt-get install -y git-core
> EOF
> docker build -t git /tmp/docker-git/
> docker run --user $(id -u):$(id -g) git git clone
> https://github.com/git/git.git /tmp/git
> # fatal: unable to look up current user in the passwd file: no such user

It probably helps if you could get the stack trace to this message
(printed from function xgetpwuid_self). I haven't checked if my
personal laptop has docker to reproduce this.. In general we won't ask
passwd if the user specifies name/email in the config file. But I
still don't see why git-clone needs that info in the first place.
-- 
Duy
