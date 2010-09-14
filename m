From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] git-reset.txt: reset does not change files in target
Date: Mon, 13 Sep 2010 17:12:00 -0700
Message-ID: <7vpqwh9oa7.fsf@alter.siamese.dyndns.org>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
 <9669b7872536d2555d4b2c01560c552d97fdd81b.1284365021.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 14 02:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvJ8G-0000Wm-Ga
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 02:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab0INAMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 20:12:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab0INAMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 20:12:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CFF1AD6A4B;
	Mon, 13 Sep 2010 20:12:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2WHzCPv1ftgJRBNnzZUL5szlFME=; b=PPlNN1
	lc/c8B/p5YOchAyWyr/BDdjeLvyJ8gUv75z/JUuOAMdLUcIxTRTJ1ccvAIgTVqNB
	wpSQozquW+7T3pDo0pFcFbVdNw5RYWBn/Ygd26GNylrve3YQg9F/QGDlbQJQA/Z0
	LkiGLhxr2tQN7GY2XKCKGofE8HOpW/n+4aRnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y8wCg0k+SLTnX8sRaxeVe/tvHJxEWvmL
	60+6MLfNR4WdyzWUORkC661ukmxcoAZioR4PAf45f9TGoxtBEIvOeVQkEMUfmbFV
	fCsnHlqvGwcA9dHUMqWY2Iuziy3mPmQGJIz3gV8j2rhsIn9qIt0/yFx1/W/6Vjjc
	NABsCDX3qi0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C6CBD6A46;
	Mon, 13 Sep 2010 20:12:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6E6ED6A45; Mon, 13 Sep
 2010 20:12:01 -0400 (EDT)
In-Reply-To: <9669b7872536d2555d4b2c01560c552d97fdd81b.1284365021.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 13 Sep 2010 10\:06\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4F02686-BF94-11DF-988D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156153>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git-reset obviously cannot change files in an existing commit. Make it
> not sound as if it could: reset can change HEAD and, in that sense, can
> change which state a file in HEAD is in.
> ...
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 7d68b4c..8fb871c 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -295,7 +295,7 @@ file. For example, the first line of the first table means that if a
>  file is in state A in the working tree, in state B in the index, in
>  state C in HEAD and in state D in the target, then "git reset --soft
>  target" will put the file in state A in the working tree, in state B
> -in the index and in state D in HEAD.
> +in the index and set HEAD to target (which has the file in state D).

I would further suggest to make it clear that soft reset does not touch
either the index nor the working tree, e.g.:

    "git reset --soft target" will leave the file in the working tree in
    state A and the index in state B.  It moves the HEAD (i.e. the tip of
    the current branch, if you are on one) to "target" (which has the file
    in state D).
