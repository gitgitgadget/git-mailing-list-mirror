From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add basic test-script for git-submodule
Date: Wed, 30 May 2007 08:48:38 +0200
Message-ID: <8c5c35580705292348q74281f7eu15b3b61f45b2c6f5@mail.gmail.com>
References: <11802980992216-git-send-email-hjemli@gmail.com>
	 <7v7iqs6r6p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 08:48:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtHzC-0006Bn-CT
	for gcvg-git@gmane.org; Wed, 30 May 2007 08:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbXE3Gsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 02:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbXE3Gsj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 02:48:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:19832 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXE3Gsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 02:48:39 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1035640wah
        for <git@vger.kernel.org>; Tue, 29 May 2007 23:48:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X4Ch/MZ+upGc5iVQEPV+XCoRr8Yw7XyEzDQAqi8ccEWN2inypQk/t4SiGXea7pttBUOSCetdh39ZqWng3+0Nu5cmpo09/94PS5ZR8olsTXI4iGfkch9VYA5u5sEu2WHGPQcx0dOHzQdScgL9SYDGcxQsdrscq8roCD5dxKiYDs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J8EgYsEtGrNlv7qGm4jGoysW4G+pQVKikzty8nDA/PUe8VAfY/uygDmIr2xGG4cB5ENOrq0xnYb4hhOM6PUQTBODtXiOQ7Gzu9RiR1F+UcrNbW5IqR8BQ8rN8DNbvse95+iPAupmKCl2GfZWTLMmP4HRfJE9mc1L1B2ieTQv8uA=
Received: by 10.114.192.1 with SMTP id p1mr3800660waf.1180507718217;
        Tue, 29 May 2007 23:48:38 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 29 May 2007 23:48:38 -0700 (PDT)
In-Reply-To: <7v7iqs6r6p.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48747>

On 5/29/07, Junio C Hamano <junkio@cox.net> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > +# create a submodule repository
> > +mkdir lib && cd lib
> > +git-init >/dev/null
> > +echo a >a && git-add a && git-commit -q -m "submodule commit 1"
> > +git-tag -a -m "rev-1" rev-1
> > +rev1=$(git-rev-parse HEAD)
> > +cd ..
> > +
> > +# add submodule and other files to super repo
> > +echo a >a && echo z >z
> > +git-add a lib z && git-commit -q -m "super commit 1"
> > +
> > +# move submodule to another location, register repo url in .gitmodules
> > +mv lib .subrepo
> > +GIT_CONFIG=.gitmodules git-config module.lib.url ./.subrepo
>
> We typically try to catch malfunction even while setting up the test case.

Ok

>
> > +test_expect_success 'status is "missing"' \
> > +     'git-submodule status | grep "^-$rev1"'
> > +
> > +# make sure 'init' will not overwrite a regular file
> > +touch lib
> > +test_expect_failure 'init fails when path is used by a file' \
> > +     'git-submodule init'
>
> I am guilty for introducing "expect-failure", but it is usually
> a mistake to use it unless you are testing something very trivial.
>
> For example, for this case, you would want to make sure the
> command "git-submodule init" exits with non-zero status, but
> also you would want to make sure that it does not disturb the
> existing file "lib".

Would you prefer a patch on top of this version of the test-script or
on top of the later patch which uses .git/config to store submodule
url?

--
larsh
