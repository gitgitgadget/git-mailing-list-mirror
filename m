From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Apr 2013, #08; Tue, 23)
Date: Wed, 24 Apr 2013 09:57:06 +0200
Message-ID: <51779052.8020507@viscovery.net>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org> <7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 09:57:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUuZu-0004vu-1X
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 09:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881Ab3DXH5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 03:57:17 -0400
Received: from so.liwest.at ([212.33.55.23]:32605 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757129Ab3DXH5P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 03:57:15 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UUuZf-0002KG-7p; Wed, 24 Apr 2013 09:57:07 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D97B61660F;
	Wed, 24 Apr 2013 09:57:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222234>

Am 4/23/2013 21:31, schrieb Junio C Hamano:
> * fc/transport-helper-error-reporting (2013-04-17) 9 commits
>   (merged to 'next' on 2013-04-22 at 5ba6467)
>  + transport-helper: update remote helper namespace
>  + transport-helper: trivial code shuffle
>  + transport-helper: warn when refspec is not used
>  + transport-helper: clarify pushing without refspecs
>  + transport-helper: update refspec documentation
>  + transport-helper: clarify *:* refspec
>  + transport-helper: improve push messages
>  + transport-helper: mention helper name when it dies
>  + transport-helper: report errors properly
> 
>  Update transport helper to report errors and maintain ref hierarchy
>  used to keep track of remote helper state better.
> 
>  Will merge to 'master'.

Please don't, yet. There is a new test case that fails on Windows. I'll
have to figure out a work-around.

In git-remote-testgit we have this code:

	before=$(git for-each-ref --format='%(refname) %(objectname)')

	git fast-import "${testgitmarks_args[@]}" --quiet

	after=$(git for-each-ref --format='%(refname) %(objectname)')

	# figure out which refs were updated
	join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") |
	while read ref a b
	do
		test $a == $b && continue
		echo "ok $ref"
	done

The failure is in the 'join' line: Bash on Windows does not implement
process substitution, and we do not have 'join'. This failing code exists
since 93b5cf9c (remote-testgit: report success after an import,
2012-11-28), but apparently, it did not matter so far.

-- Hannes
