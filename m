From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: [PATCH] t1503: Fix arithmetic expansion syntax error when using
 dash
Date: Wed, 22 Sep 2010 12:15:37 -0700
Message-ID: <7viq1xsi7a.fsf@alter.siamese.dyndns.org>
References: <4C98EF25.4070700@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, jon.seymour@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Sep 22 21:15:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyUnK-0006Y6-MN
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 21:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073Ab0IVTPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 15:15:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944Ab0IVTPr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 15:15:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56902D6157;
	Wed, 22 Sep 2010 15:15:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=11RDqzCGtQbrymHoewSC+h1N8f8=; b=yYZ4tB
	we4O4jXJyIZgy9ifXJ2zCTy7V6P3nAkHLz3N7pDtGbIEfpGTqnQ0tf23RPoiTxkb
	aoTMzEPGHjrs4sPP0sgDZEhmacjtdq1QPhXFRnWpVjSwxR9ZMy3qaB6jHLA/6bu7
	7GqXant8o5qtQ6yRrTGqB4LJWkKyaYPIdYE2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KAK6UYpdG4o/6+RUBHnUPOh0IJlNkWE9
	rOsfVVNXudY3zBd357fb2dkWTMRR0yX4ERHF/yg7MYZR5I+tB+zO2ZW9BB3RqIlG
	7n7ZdOxSadclMzzGIdFwlQhcKWpv3oimGf3dq679XbqOlAPGLgP272+IPzbMPJeD
	qeX3/OiCJRM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 248B0D6156;
	Wed, 22 Sep 2010 15:15:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E51DD6153; Wed, 22 Sep
 2010 15:15:39 -0400 (EDT)
In-Reply-To: <4C98EF25.4070700@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue\, 21 Sep 2010 18\:45\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB777F22-C67D-11DF-B381-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156827>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On systems which have dash as /bin/sh, such as Ubuntu, the final
> test (master@{n} for various n) fails with a syntax error while
> processing an arithmetic expansion. The syntax error is caused by
> using a bare name ('N') as a variable reference in the expression.
>
> In order to avoid the syntax error, we spell the variable reference
> as '$N' rather than simply 'N'.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Thanks.

POSIX wants shells to support both "N" and "$N" and requires them to yield
the same answer to $((N)) and $(($N)), but we should aim for portability
in a case like this, especially when the price we pay to do so is so
small, i.e. a few extra dollars.

By the way, on my box, I get this:

    $ ls l /bin/dash
    -rwxr-xr-x 1 root root 104024 2008-08-26 02:36 /bin/dash*
    $ dpkg -l dash | grep '^ii'
    ii  dash              0.5.4-12          POSIX-compliant shell
    $ /bin/dash -c 'N=20 ; echo $(( N + 3 ))'
    23

I just left it vague by saying "e.g. older dash" in below, but we may want
to be more precise in the documentation.

-- >8 --
CodingGuidelines: spell Arithmetic Expansion with $(($var))

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index b8bf618..2cdd76f 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -43,6 +43,10 @@ For shell scripts specifically (not exhaustive):
 
  - We use Arithmetic Expansion $(( ... )).
 
+ - Inside Arithmetic Expansion, spell shell variables with $ in front
+   of them, as some shells do not grok $((x)) while accepting $(($x))
+   just fine (e.g. older dash).
+
  - No "Substring Expansion" ${parameter:offset:length}.
 
  - No shell arrays.
