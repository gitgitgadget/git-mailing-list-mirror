From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git diff-tree --stdin doesn't accept two trees
Date: Tue, 05 Aug 2008 13:07:17 -0700
Message-ID: <7vwsivusy2.fsf@gitster.siamese.dyndns.org>
References: <20080805164839.GA3934@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 22:08:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQSpe-0000gy-Fn
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 22:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762270AbYHEUHb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 16:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763668AbYHEUHa
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 16:07:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763654AbYHEUH1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2008 16:07:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 564B5554C5;
	Tue,  5 Aug 2008 16:07:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9AFC6554C4; Tue,  5 Aug 2008 16:07:20 -0400 (EDT)
In-Reply-To: <20080805164839.GA3934@diana.vm.bytemark.co.uk> (Karl
 =?utf-8?Q?Hasselstr=C3=B6m's?= message of "Tue, 5 Aug 2008 18:48:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1DF5BF16-632A-11DD-B094-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91458>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> I'm trying to use diff-tree --stdin to diff several trees in one go.
> But I just get error messages when I feed it two space-separated tree=
s
> (one commit works fine):
>
>   $ echo $(git rev-parse HEAD^{tree}) $(git rev-parse HEAD^^{tree}) |=
 git diff-tree -p --stdin
>   error: Object 7bfd9971f77438858e412be0219ec78afb3ca46f not a commit
>
> This is at odds with the documentation:
>
>   --stdin::
>         When '--stdin' is specified, the command does not take
>         <tree-ish> arguments from the command line.  Instead, it
>         reads either one <commit> or a pair of <tree-ish>
>         separated with a single space from its standard input.
>
> I tried reading the code to figure out what's wrong, and as far as I
> can tell the code to do this is there, but seems to be protected by
> logic that aborts everything unless the whole input line is a valid
> commit. Or maybe I'm just confused ...

No, the documentation was made wrong during 1.2.0 timeperiod.

The feature of --stdin to take a commit and its parents on one line was
broken before that to support the common

	rev-list --parents $commits... -- $paths... |
        diff-tree --stdin -v -p

usage pattern by Porcelains.  For diff-tree to talk sensibly about
commits, it needs to see commits, not just trees.


=20
