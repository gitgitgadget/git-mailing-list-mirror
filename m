From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug: --ext-diff ignored with --cc in git log
Date: Fri, 11 Mar 2016 10:20:42 -0800
Message-ID: <xmqqziu4anb9.fsf@gitster.mtv.corp.google.com>
References: <E1adi8q-0005NJ-4G@smtp.tt-solutions.com>
	<xmqqlh5qc698.fsf@gitster.mtv.corp.google.com>
	<E1aeCRp-0005Jn-C1@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vadim Zeitlin <vz-git@zeitlins.org>
X-From: git-owner@vger.kernel.org Fri Mar 11 19:27:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeRmE-0000BC-0t
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 19:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbcCKSUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 13:20:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751608AbcCKSUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 13:20:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04FBB4A2FA;
	Fri, 11 Mar 2016 13:20:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MOxzsau3hyDlWTYiOICXYnupY+0=; b=kj7cqE
	8RHYslsiXjX3zJoyJLhvv3grQOJPODuQZnUG70Eq2ZRmjpVbajVieQKyHWor7pwf
	67j3Ldj6YFKlgdo4gV2nLEYkZpuizJQrstXTmcRZXt8rgR9/B6E2T9FExRoThPV+
	3KaNdDtCokQ+5v2QR4Mvh4pcs6LLytTP3nMb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fOq9srZaq5kFkxAJR6pR3luKWG8X0fWa
	HkO+lBhjjtwdRo53EDgemX1n5YDdAi2Lot9yQ91Rz6dRTTyf27C4NlEc1PoCq3Pm
	rv5mKXk5L/XT9Xi3flKdTJTDnDh1J74a7IpvL+/XH2Jo1qn0e3xStvIzPxd9A6aQ
	zLx/zRnl/hM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0E314A2F9;
	Fri, 11 Mar 2016 13:20:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 768764A2F7;
	Fri, 11 Mar 2016 13:20:43 -0500 (EST)
In-Reply-To: <E1aeCRp-0005Jn-C1@smtp.tt-solutions.com> (Vadim Zeitlin's
	message of "Fri, 11 Mar 2016 03:04:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7AB6540-E7B5-11E5-AF32-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288696>

Vadim Zeitlin <vz-git@zeitlins.org> writes:

> On Thu, 10 Mar 2016 14:33:55 -0800 Junio C Hamano <gitster@pobox.com> wrote:
>
> JCH> Vadim Zeitlin <vz-git@zeitlins.org> writes:
> JCH> 
> JCH> > I.e. the
> JCH> > command "git log --ext-diff -p --cc" still outputs the real diff even for
> JCH> > the generated files, as if "--ext-diff" were not given. ...
> JCH> > Is the current behaviour intentional? I see it with all the git versions I
> JCH> > tried (1.7.10, 2.1.0, 2.7.0 and v2.8.0-rc1), but I don't really see why
> JCH> > would it need to work like this, so I hope it's an oversight and could be
> JCH> > corrected.
> JCH> 
> JCH> I think this is "intentional" in the sense that "--cc" feature is
> JCH> fundamentally and conceptually incompatible with "--ext-diff".
>
>  Thank you for your reply, Junio, I hadn't realized that --cc was dependent
> on textual diff output format before, but now I understand why it can't
> respect --ext-diff.

Having established that, I should also add that "--cc fundamentally
is incompatible with --ext-diff" does not justify that
"--cc when given with --ext-diff just ignores and uses the usual
diff".

An equally (or even more) valid consequence could have been to
disable "--cc" processing for paths that would trigger an external
diff driver.  After all, the user told us that the contents would
not compare well with the usual "diff"; we know that "--cc" output
that summarizes the usual diff output is useless.

What we show instead is an interesting thing to think about.

For example, we _could_ also ignore what external diff driver
produces in this case (as we know it won't be producing an
appropriate input to the "--cc" post-processing), and pretend
as if comparing an old version of foo.sln with a new version of
foo.sln produced a diff like this:

    diff --git a/foo.sln b/foo.sln
    index d7ff46e,b829410
    --- a/foo.sln
    +++ b/foo.sln
    @@ 1,1 @@
    -d7ff46ec4a016c6ab7d233b9d4a196ecde623528  - generated file
    +b829410f6da0afc14353b4621d2fdf874181a9f7  - generated file

then you might see in a merge that merges two versions of foo.sln
and result in another version of foo.sln in your "--cc" output a
hunk that is like this:

    diff --cc foo.sln
    index d7ff46e,6c9aaa1..b829410
    --- a/foo.sln
    +++ b/foo.sln
    @@@ 1,1 @@@
    - d7ff46ec4a016c6ab7d233b9d4a196ecde623528  - generated file
     -6c9aaa1ae63a2255a215c1287e38e75fcc5fc5d3  - generated file
    ++b829410f6da0afc14353b4621d2fdf874181a9f7  - generated file

which would at least tell you that there was a merge, and if the
merge took the full contents of the file from one of the commits and
recorded as the result of the merge, then you wouldn't see them in
the "--cc" output.

It happens that the above is fairly easily doable with today's Git
without any modification.  Here is how.

(1) Have this in your .git/config

    [diff "uninteresting"]
    	textconv = /path/to/uninteresting-textconv-script

(2) Mark your .sln paths as uninteresting in your .gitattributes

    *.sln	diff=uninteresting

(3) Have this textconv filter in /path/to/uninteresting-textconv-script

    #!/bin/sh
    printf "%s generated file\n" "$(sha1sum <"$1")"
