From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's inconsistent command line options
Date: Wed, 26 Aug 2015 10:56:15 -0700
Message-ID: <xmqqio822atc.fsf@gitster.dls.corp.google.com>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
	<CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
	<xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
	<CAE1pOi3e8KS9x5yD7CZLESvhXy1oXmQEgUnEFjww7L6JOdZ1Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 19:56:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUevu-0006FX-GH
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 19:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbbHZR4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 13:56:18 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33774 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbbHZR4R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 13:56:17 -0400
Received: by pacti10 with SMTP id ti10so95290569pac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XvUv9d0QvgMbTfzW43+1blnnoQ0mzzuU1ohvDYvrG7s=;
        b=ktW7rw5W7NegPLhn7zFSccHRiSWJ1KY+jTMl1LKCWb8/VQWEwn7cEtygXLsGewoPes
         4VxCN0TrgVn6H96yK+duMWU09FBdhR3Zvp1MaUBwqtIJfiHJ/tes7/2Zi4XlVcJjaNpW
         KlZYjp0TzOlKwpInO/nX/ZjkSRh0eP3VD8+zAmwU8N+moTjnCxXKbXqYykvdlpJclsY4
         4IqpB8991wJB5PIdHJJKGVIyO1tVF8WlGa0cJyg4tbe8UbWwCGTB75hujJ8QnCbGyC4Q
         0eGZplJLCxVNtTC7flDSVWhP4T3o0YNYombvyUNUzHcKKgomC9b0xSAue1qHhcpS7AYn
         vB4Q==
X-Received: by 10.68.230.33 with SMTP id sv1mr72823469pbc.160.1440611777185;
        Wed, 26 Aug 2015 10:56:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id ts1sm25375341pbc.74.2015.08.26.10.56.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 10:56:16 -0700 (PDT)
In-Reply-To: <CAE1pOi3e8KS9x5yD7CZLESvhXy1oXmQEgUnEFjww7L6JOdZ1Jg@mail.gmail.com>
	(Hilco Wijbenga's message of "Tue, 25 Aug 2015 18:30:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276622>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> On 25 August 2015 at 16:43, Junio C Hamano <gitster@pobox.com> wrote:
>> I do not see a good way to do such a safe transition with command
>> words approach, *unless* we are going to introduce new commands,
>> i.e. "git list-tag", "git create-tag", etc.
>
> Perhaps we could introduce a more explicit notion (in .git/config) of
> a Git API version (or, perhaps more accurate, a Git CLI API version)?
> ...
> I think that from a user's point of view this could work quite well.
> Obviously, (worst case scenario) Git commands might have to support up
> to 3 APIs at the same time (previous [2], current [3], and future [4]
> for Git 3.x) so from a code maintenance POV it would certainly
> introduce complexity and probably some duplication of code. I'm
> hopeful it would be limited to CL argument processing but I suspect
> that when Git code calls other Git code (especially in the Bash based
> commands) there might be some more complexity there.
>
> Would something like that be feasible?

A bigger issue you need to think about is what to do to scripts
people have.  Your approach forces them to update a script to delete
a tag and do something else to say something silly like this:

	#!/bin/sh
        # My Script
	case "$(git config core.apiVersion)" in
        "" | 2)
		git tag -d "$1"
                do something else on "$1" using v2 API
                ;;

        3)
		git tag delete "$1"
                do something else on "$1" using v3 API
                ;;

	*)
        	echo >&2 "sorry, I do not know what Git you are using"
		exit 1
                ;;
	esac

So, it may be feasible to implement, but I do not think it would be
useful to do so.

Instead, if you really want to invent the multi-version world, you
would rather want to have something more like this:

	#!/bin/sh
        # My Script
	GIT_API_VERSION=2
	export GIT_API_VERSION

	git tag -d "$1"
        do something else on "$1" using v2 API

But notice that I said "if you really want to".  I personally think
it is a road to madness.
