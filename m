From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incompatible '+=' syntax in git-completion.bash
Date: Wed, 24 Jul 2013 08:31:01 -0700
Message-ID: <7v38r46klm.fsf@alter.siamese.dyndns.org>
References: <CAK6R3tz73t1HQ2AkeimFDGnmZbFT1PJ5idTbKt8QwsPOSaYqQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthew Wang <mattwyl@gmail.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 17:31:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2121-0002Bu-9n
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 17:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab3GXPbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 11:31:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230Ab3GXPbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 11:31:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EC923153C;
	Wed, 24 Jul 2013 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nwJR8P8KJlTrYsl4/lpbpukRJlo=; b=XdSvnE
	NEnEe2rd3Sk30Ni9khNhdReOLRM6iTZ0bUrEBWQFGDEuAAPzA2ucXJs0LhEqVXpW
	CAp4KmTJqjQQkw5gy07l3P3W0pfPyusI5gM9lXxnbZweS0Z+v8ZWcYEGPcGU/VOX
	hCht4JhZTqV2MiNqOAm0Tct1owD8Zl9FUsMYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uSA/OLo1lzBbyWM1Kce4HEG1PZKOOoq2
	5rhlB50JZh3oSA0nWKFMe2MTTGjYiyHNqAVBvNumoQhw6ndpTRm+jMLjnrs/sBQl
	nRWbuz5ky+O6Q/Qg6C3EhVrvulhGX+5wbxBOvydMAKTie+rANSBv8zbY6AkjhvcJ
	zn7Jkcvb9/w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 329E33153A;
	Wed, 24 Jul 2013 15:31:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F8C931537;
	Wed, 24 Jul 2013 15:31:03 +0000 (UTC)
In-Reply-To: <CAK6R3tz73t1HQ2AkeimFDGnmZbFT1PJ5idTbKt8QwsPOSaYqQg@mail.gmail.com>
	(Matthew Wang's message of "Wed, 24 Jul 2013 09:54:04 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CF64086-F476-11E2-BDC6-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231105>

Matthew Wang <mattwyl@gmail.com> writes:

> I noticed a change in commit 734b2f0 on
> contrib/completion/git-completion.bash which reverted a syntax fix for
> '+=' syntax [1], the syntax does not work for bash < 3.1.  As far as I
> know, bash 3.0.x is still widely used on some old servers, could
> someone add the fix back again?

Does anybody know of a reason why a[$#a+1]=$c notation should not be
used for zsh?  If there isn't, I think we should cherry-pick

    50c5885e (git-completion.bash: replace zsh notation that breaks
    bash 3.X, 2013-01-18)

by Brandon on top of 'master' or on 6bf931a5 (Merge branch
'fc/zsh-leftover-bits', 2013-06-02).

Thanks.

-- >8 --
From: Brandon Casey <drafnel@gmail.com>
Date: Fri, 18 Jan 2013 11:24:01 -0800
Subject: [PATCH] git-completion.bash: replace zsh notation that breaks bash 3.X

When commit d8b45314 began separating the zsh completion from the bash
completion, it introduced a zsh completion "bridge" section into the bash
completion script for zsh users to use until they migrated to the zsh
script.  The zsh '+=()' append-to-array notation prevents bash 3.00.15 on
CentOS 4.x from loading the completion script and breaks test 9902.  We can
easily work around this by using standard Bash array notation.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a4c48e1..2f99420 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2431,7 +2431,7 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 				--*=*|*.) ;;
 				*) c="$c " ;;
 				esac
-				array+=("$c")
+				array[$#array+1]="$c"
 			done
 			compset -P '*[=:]'
 			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-- 
1.8.3.4-995-g2e35dd8
