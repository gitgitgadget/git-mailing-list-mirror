From: Junio C Hamano <gitster@pobox.com>
Subject: Re: blame vs annotate?
Date: Wed, 03 Sep 2008 11:10:41 -0700
Message-ID: <7v8wu9cd7i.fsf@gitster.siamese.dyndns.org>
References: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 20:12:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kawpe-0001uv-Lq
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 20:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbYICSKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 14:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbYICSKt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 14:10:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbYICSKs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 14:10:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B1CFF5A3C7;
	Wed,  3 Sep 2008 14:10:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AE41B5A3C6; Wed,  3 Sep 2008 14:10:43 -0400 (EDT)
In-Reply-To: <57518fd10809030943i35af222fw82cf591c737b8c04@mail.gmail.com>
 (Jonathan del Strother's message of "Wed, 3 Sep 2008 17:43:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A19FFE60-79E3-11DD-B549-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94831>

"Jonathan del Strother" <maillist@steelskies.com> writes:

> What's the difference between 'git blame' & 'git annotate'?  The
> output is practically identical - it's not obvious when you would use
> one over the other

In short, don't use git-annotate unless you are an ancient script that was
written before git-blame was written.  They are functionally equivalent,
uses the same blame assigning engine, and the only difference is the
default output format, and blame knows how to mimick annotate output.

History.

The first implementation was called git-annotate that was implemented in
Perl.

    c65e898 (Add git-annotate, a tool for assigning blame., 2006-02-20)

A competing implementation in C was done and was called git-blame:

    cbfb73d (Add git-blame, a tool for assigning blame., 2006-02-21)

They competed for a while but it became more and more apparent that blame
was a better implementation.  After blame learned to mimick annotate
output, which some scripts depended on, Perl implementation was retired,
but the name git-annotate was left as a backward compatibility alias:

    f789e34 (Remove git-annotate.perl and create a builtin-alias for git-blame, 2006-10-09)

Then as an experiment, a reimplementation of blame in C, confusingly
codenamed git-pickaxe, was started, to detect code movements across and
within files:

    cee7f24 (git-pickaxe: blame rewritten., 2006-10-19)

This had the same output format as git-blame, also with compatibility
output format implemented for the older git-annotate.  After it matured,
it took over the original git-blame name.

    acca687 (git-pickaxe: retire pickaxe, 2006-11-08)
