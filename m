From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add "--expire <time>" option to 'git prune'
Date: Thu, 29 Nov 2007 15:35:22 +0100
Message-ID: <474ECE2A.9050700@viscovery.net>
References: <200711181225.52288.johannes.sixt@telecom.at> <7v3av3wg7h.fsf@gitster.siamese.dyndns.org> <200711182101.53936.johannes.sixt@telecom.at> <7v7ikfuxfk.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711290340470.27959@racer.site> <7vaboxy3va.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711291146090.27959@racer.site> <Pine.LNX.4.64.0711291419350.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pasky@suse.cz
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 15:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxkUX-0006AY-6x
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 15:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbXK2Of3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 09:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762158AbXK2Of2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 09:35:28 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26208 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760266AbXK2Of2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 09:35:28 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IxkTP-0005la-1m; Thu, 29 Nov 2007 15:34:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2627F546; Thu, 29 Nov 2007 15:35:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711291419350.27959@racer.site>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66537>

Johannes Schindelin schrieb:
> +test_expect_success 'prune --expire' '
> +
> +	BLOB=$(echo aleph | git hash-object -w --stdin) &&
> +	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
> +	test 20 = $(git count-objects | sed "s/ .*//") &&
> +	test -f $BLOB_FILE &&
> +	git reset --hard &&

Here you could throw in:

	git prune --expire=1.hour.ago &&
	test 20 = $(git count-objects | sed "s/ .*//") &&
	test -f $BLOB_FILE &&

to test that the object is not pruned (and the alternate --expire syntax).

> +	if touch -d "Jan 1 1970" $BLOB_FILE
> +	then
> +		git prune --expire 1.day &&
> +		test 19 = $(git count-objects | sed "s/ .*//") &&
> +		! test -f $BLOB_FILE
> +	else
> +		say "Skipping test due to non-working touch -d"
> +	fi

-- Hannes
