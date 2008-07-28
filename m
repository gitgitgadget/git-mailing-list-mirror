From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t7001-mv.sh: Propose ability to use git-mv on
 conflicting entries
Date: Sun, 27 Jul 2008 18:21:19 -0700
Message-ID: <7vzlo2x0q8.fsf@gitster.siamese.dyndns.org>
References: <20080727134142.GA10151@machine.or.cz>
 <20080727134704.27534.86520.stgit@localhost>
 <7v4p6ayfmw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 28 03:22:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHRd-0007JO-R6
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758601AbYG1BV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758315AbYG1BV1
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:21:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758239AbYG1BV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:21:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 30E3239796;
	Sun, 27 Jul 2008 21:21:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 866E539792; Sun, 27 Jul 2008 21:21:21 -0400 (EDT)
In-Reply-To: <7v4p6ayfmw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jul 2008 18:13:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7EDBB6B6-5C43-11DD-AD98-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90392>

Junio C Hamano <gitster@pobox.com> writes:

>> +# Rationale: I cannot git mv around a conflicted file. This is unnecessary
>> +# restriction in case another part of conflict resolution requires me to
>> +# move the file around.
>
> Yes, I would agree this is a reasonable thing to support.  Something like
> this patch, perhaps.
> ...

Just in case if somebody is inclined to test the patch and polish it into
a shape good enough for inclusion...

> @@ -177,7 +177,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  				} else
>  					bad = "Cannot overwrite";
>  			}
> -		} else if (cache_name_pos(src, length) < 0)
> +		} else if (((pos = cache_name_pos(src, length)) < 0) &&
> +			   strcmp(active_cache[-1 - pos]->name, src))

There is a bug here; "-1 - pos" needs to be checked against active_nr
before strcmp().
