From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Make sure show_all_errors when using porcelain error messages
Date: Wed, 01 Sep 2010 19:04:36 +0200
Message-ID: <vpq39ttxumz.fsf@bauges.imag.fr>
References: <vpqeide0zkx.fsf@bauges.imag.fr>
	<1283321153-24745-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vsk1t7bn2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 19:12:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqqrY-000751-RC
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 19:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab0IARMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 13:12:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32870 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685Ab0IARMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 13:12:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o81H123u007420
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Sep 2010 19:01:02 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oqqjk-0003PE-Cq; Wed, 01 Sep 2010 19:04:36 +0200
In-Reply-To: <7vsk1t7bn2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 01 Sep 2010 07\:59\:29 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 01 Sep 2010 19:01:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o81H123u007420
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283965265.50411@3mXhh/HE791gzWX58UdlwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155063>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> opts.show_all_errors controls the number of errors that can be displayed,
>> and set_porcelain_error_msgs gives the format. But the formatting would
>> be incorrect if set_porcelain_error_msgs is called without setting
>> opts.show_all_errors.
>
> That makes it sound like a design bug of set_porcelain_error_msgs(), in
> that the caller _cannot_ choose to stop at the first error if it wants to
> use friendlier message than the plumbing one.

You're right that the caller cannot stop at the first error and get
friendly message, but I don't think this is a bug. As a user, I don't
see any reason not to want the complete list. We kept the
"show_all_errors = false" behavior to allow the slight performance
improvement of stopping at the first error, which may (but I'm not
even sure) benefit to scripts.

> But if that is (and I do not think it is such a bad thing if we decide
> that Porcelains have no option of stopping at the first error) then we
> should set opts.show_all_errors in the set_porcelain_error_msgs()
> function, and probably should rename the function to something
> saner.

Yes (actually, I send a quick patch to make sure this was the problem
of the OP, but the intention was to have a better one when I have
time. I forgot to add RFC in the title).

> How about making it
>
> 	int setup_unpack_trees_porcelain(struct unpack_trees_options *opt,
> 						const char *cmd);
>
> and possibly moving it from merge-recursive.c to unpack-trees.c?

Sounds good, yes. Will do (probably tomorrow).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
