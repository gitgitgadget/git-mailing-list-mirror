From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/rfc] git-svn.perl: workaround assertions in svn library
 1.5.0
Date: Sat, 19 Jul 2008 18:27:36 -0700
Message-ID: <7vbq0tibuf.fsf@gitster.siamese.dyndns.org>
References: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org>
 <20080717140856.10213.qmail@c0f13986110104.315fe32.mid.smarden.org>
 <37fcd2780807171137m1c5a8197vc94b2a42ac53a297@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 03:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKNjH-0004qV-HK
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 03:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955AbYGTB1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 21:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754911AbYGTB1u
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 21:27:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbYGTB1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 21:27:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F1F3C32CF7;
	Sat, 19 Jul 2008 21:27:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8B58632CF6; Sat, 19 Jul 2008 21:27:43 -0400 (EDT)
In-Reply-To: <37fcd2780807171137m1c5a8197vc94b2a42ac53a297@mail.gmail.com>
 (Dmitry Potapov's message of "Thu, 17 Jul 2008 22:37:48 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 105007B8-55FB-11DD-ACBA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89149>

"Dmitry Potapov" <dpotapov@gmail.com> writes:

> On Thu, Jul 17, 2008 at 6:08 PM, Gerrit Pape <pape@smarden.org> wrote:
>>
>> Hi, while this commit fixed the selftests, it unfortunately is a
>> regression
>>
>>  http://thread.gmane.org/gmane.comp.version-control.git/87822/
>>  http://bugs.debian.org/490400
>
> This particular breakage is easy to fix:
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 3750e47..a5a5b1b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1226,7 +1226,7 @@ sub linearize_history {
>
>  sub find_file_type_and_diff_status {
>         my ($path) = @_;
> -       return ('dir', '') if $path eq '.';
> +       return ('dir', '') if $path eq '';
>
>         my $diff_output =
>             command_oneline(qw(diff --cached --name-status --), $path) || "";
>
> but it could be some other places in git-svn that may need correction too.
>
>>
>> I'm still not sure whether this is a git-svn problem, or actually a
>> problem in subversion 1.5.0
>
> Accordingly to SVN developers you do not use SVN API correctly,
> therefore you got assert. So, the problem in git-svn.
> http://svn.haxx.se/dev/archive-2008-01/0425.shtml

So what's the conclusion of this issue?

I'll just revert 2fe403e (git-svn.perl: workaround assertions in svn
library 1.5.0, 2008-07-06) for 1.6.0-rc0 unless I hear better
suggestions.
