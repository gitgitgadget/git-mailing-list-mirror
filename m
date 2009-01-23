From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver: run post-update hook *after* update.
Date: Fri, 23 Jan 2009 00:00:41 -0800
Message-ID: <7viqo61mfq.fsf@gitster.siamese.dyndns.org>
References: <1232144521-21947-1-git-send-email-stefan.karpinski@gmail.com>
 <1232144521-21947-2-git-send-email-stefan.karpinski@gmail.com>
 <d4bc1a2a0901222143i1a7dd051h1778dcb563120195@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 09:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQGzW-0007Vh-9P
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 09:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbZAWIAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 03:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbZAWIAt
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 03:00:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZAWIAs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 03:00:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 75B1E93509;
	Fri, 23 Jan 2009 03:00:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7884293507; Fri,
 23 Jan 2009 03:00:43 -0500 (EST)
In-Reply-To: <d4bc1a2a0901222143i1a7dd051h1778dcb563120195@mail.gmail.com>
 (Stefan Karpinski's message of "Thu, 22 Jan 2009 21:43:48 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F16EF81A-E923-11DD-BB21-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106851>

Stefan Karpinski <stefan.karpinski@gmail.com> writes:

> I know that this and the other patch I sent are completely trivial and
> uninteresting, but they would appear to be correct. Do I need to prod
> more to get them included or what? Did I submit them incorrectly?

If you spend the bandwidth to quote the whole patch, don't quote it, but
please use the same bandwidth to resend it --- that way, if the reason
your patch left unapplied was because your earlier submission was lost in
the noise or too heavy maintainer workload, it can be easily picked up.

Upon my cursory look the patch looks sane, even though it risks breaking
people's scripts that relied on the incorrect behaviour of running the
hook before the update is done, which is slightly worrysome.  Find out who
are knowledgeable in the area of the code you are touching, and Cc them to
ask their input.  "git shortlog -s -n git-cvsserver.perl" may help.

Please sign your patch.

Thanks.

Oh, and one more thing.  Please do not top post.

> On Fri, Jan 16, 2009 at 2:22 PM, Stefan Karpinski
> <stefan.karpinski@gmail.com> wrote:
>>
>> CVS server was running the hook before the update
>> action was actually done. This performs the update
>> before the hook is called.
>> ---
>>
>> Unless I'm severely misunderstanding the meaning of
>> a *post-update* hook, I think this is a no-brainer.
>>
>>  git-cvsserver.perl |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
>> index c1e09ea..d2e6003 100755
>> --- a/git-cvsserver.perl
>> +++ b/git-cvsserver.perl
>> @@ -1413,14 +1413,14 @@ sub req_ci
>>                close $pipe || die "bad pipe: $! $?";
>>        }
>>
>> +    $updater->update();
>> +
>>        ### Then hooks/post-update
>>        $hook = $ENV{GIT_DIR}.'hooks/post-update';
>>        if (-x $hook) {
>>                system($hook, "refs/heads/$state->{module}");
>>        }
>>
>> -    $updater->update();
>> -
>>     # foreach file specified on the command line ...
>>     foreach my $filename ( @committedfiles )
>>     {
>> --
>> 1.6.0.3.3.g08dd8
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
