From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Experimental TDB support for GIT REFS
Date: Fri, 27 Jun 2014 14:30:07 -0700
Message-ID: <CAL=YDWn-CGZGr5bXNTiZmzr4-w_8CERx3r2bmLWbczqJ0Sn7dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 23:30:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0diw-0003TA-PH
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 23:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbaF0VaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 17:30:09 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:33569 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbaF0VaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 17:30:08 -0400
Received: by mail-vc0-f172.google.com with SMTP id hy10so5627125vcb.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=nsQk0k0yMVPnaybcka26ghE7VzIOYy1IqY/8ECa25WI=;
        b=j235ZIpvo1ClcpyCFqdy9e7+CNQjRftWYr0QB6EwPDX1/jrRO1aLZo4ep19yzw5w0K
         P+PIRGwijh4GI8FILM3No8C7vkRiu8lHXjNShOn1JMd+LMQMZlsNtzOuoiTUzWfiWecs
         J4SsXO34DvNZoNHHN1rzVBW/CYMeTa4lRvC73QOKrmV+396irJA1aytMgQLco6bP13Sh
         NomOi2eb8PoglduZaWTMCqsRAgdRIHIpjfc73NWSELJLIldQi6fDKk8Om99UzlZVrx0G
         qxfFaPGBE5cJBOIPdL1nQGy5cRwNg3i5210MVH5sWWTLvASvM6k+JJLg6QoW6IY6LTlx
         ZQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=nsQk0k0yMVPnaybcka26ghE7VzIOYy1IqY/8ECa25WI=;
        b=kfeZu3yDmlWJ+trtBLmeHaYp0GPsdH7WK7gL3hsdFc7g2CHgZ3CXGuPgYIH+b3sOGX
         AUjg1NuQkVk+9ShJIGJ2x1UmLVJRemqGFxFxdMtb9NniQ0KaOOrbx/GvoXgqHnyath+Q
         bHhC/3//RLnkKxmAPipxtiRsDVhVINr84Yph1SdAo8PkC7vhCPIMdUztiz+Y7pS8fa5y
         AKOhexQ+CK7Sz9xp/jW1wwVQ14iY3NWP190Qe6/iMAE5cezKHff1yaN8Ygs03k2NbTWK
         pe//UhllPQTDPaTFYAgxTfkczcXG20sjen5+owcWQoQ3xgitfiO0LTtlnvG0Nr6PvVxZ
         2F6Q==
X-Gm-Message-State: ALoCoQnWtWK4+TNiXRUnVWUon1tiV7BLoFVhGL1jU8C6w/LKQC/VoZr1Ue+0+UAC63I4KyZ/FPdK
X-Received: by 10.221.64.20 with SMTP id xg20mr21927143vcb.3.1403904607542;
 Fri, 27 Jun 2014 14:30:07 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Fri, 27 Jun 2014 14:30:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252582>

List,

One of my ref transaction aims is to make define a stable public API
for accessing refs.
Once this is done I want to make it possible to replace the current
.git/refs/* model with a
different type of backend.
In my case I want to add support to store all refs and reflogs in a TDB database
but once we have a pluggable backend framework for refs, if someone
wants to store the refs
in a SQL database, that should be fairly trivial too.

There are a few series queued before this becomes possible, but is
anyone wants to test or play with my "git can use TDB database" you
can find an implementation of this at

https://github.com/rsahlberg/git/tree/backend-struct-tdb

Most everything works (except submodules) but the code needs more work.
It is also VERY LIKELY that the database schema WILL CHANGE so this is
only for testing
and you will need to blow the repo away and start all over again at some stage.
I.e. no production use.


To activate TDB support a new flag is added to the init-db and clone commands:

git init --tdb-repo-name=RONNIE .

This creates a new git repo and sets core.tdb_repo_name in the config.
This config variable tells git to dlopen and use libtdb instead of
using the files under .git/refs

repo-name=RONNIE is a string that identifies the repository and all
keys in the database is prefixed
with repo-name + '\0'

By default this will create the two database refs.tdb and logs.tdb in
the repositories .git directory
but it is also possible to store the databases somehwere else by
adding --tdb-repo-dir=/var/lib/git/
when creating the repo.

Since the keys in the database are prefixed with the repo name it is
even possible to store all the
refs for multiple independent repos in the same database :

- First repository
  $ cd <somewhere>
  $ git init-db --tdb-repo-name=MyFirstRepo --tdb-repo-dir=/var/lib/git

- Second repository
  $ cd <somewhere else>
  $ git init-db --tdb-repo-name=MySecondRepo --tdb-repo-dir=/var/lib/git


This can also be a solutions for platforms lacking case sensitive
filesystems where today two refs that only differ in case can not be
used.



The current prototype will still apply the naming collision rules that
the existing files backend has.
For example if you have a ref 'm'  you can not create another ref 'm/foo'.
I left those checks as is in order to not break compatibility between
the TDB backend and the current Files backend.


Please feel free to test this out. And comment.


regards
ronnie sahlberg
