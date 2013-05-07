From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] shorten_unambiguous_ref(): Allow shortening refs/remotes/origin/HEAD to origin
Date: Tue, 07 May 2013 14:31:28 -0700
Message-ID: <7vy5bqiij3.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-2-git-send-email-johan@herland.net>
	<7vy5bsq9m9.fsf@alter.siamese.dyndns.org>
	<CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 07 23:31:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpUB-000293-Et
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab3EGVbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:31:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab3EGVbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:31:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8709D1CB44;
	Tue,  7 May 2013 21:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z+EcwbBxdU3lQRl1zlEqueOmfPs=; b=HG5MDy
	jLVJI/IljI8zu4o+eZl056ykg8DNdz7TEcpPcbCSN3wlZErV/RtiM13FuNSx3GlH
	vEH/8n2Jnui4kaLbES/ZOg+rseS+9o4Vl4CwMA8H3+nysKulfOa26e4cExbVHnyx
	RNhYgh7lNCRN71ho86fzrO9oOVKR3jfw8Hlxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vo5maXtpoY8ISOA2uV+DNCkFZfNxH2hK
	Li+2hLWFkEfC3oZ5nGK0LLtU1nrjmImO5Mm3vc48ia3jHxm5dmuD/TRPQwP5/SgL
	YhoMtwZa/1SV//8d80HEN8xoOO3E/EkrV8Lcucmk+nnzp53FoKrn7cqc98c9ZA/g
	g2n9zd31xNo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AFC81CB41;
	Tue,  7 May 2013 21:31:30 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C21511CB3A;
	Tue,  7 May 2013 21:31:29 +0000 (UTC)
In-Reply-To: <CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
	(Johan Herland's message of "Tue, 7 May 2013 20:49:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B0113FE-B75D-11E2-BB1B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223603>

Johan Herland <johan@herland.net> writes:

> On Mon, May 6, 2013 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>
>>> ... there is AFAICS _no_ way for sscanf() - having
>>> already done one or more format extractions - to indicate to its caller
>>> that the input fails to match the trailing part of the format string.
>>
>> Yeah, we can detect when we did not have enough, but we cannot tell
>> where it stopped matching.
>>
>> It is interesting that this bug has stayed so long with us, which
>> may indicate that nobody actually uses the feature at all.
>
> I don't know if people really care about whether
> "refs/remotes/origin/HEAD" shortens to "origin/HEAD" or "origin". I'm
> guessing that people _do_ depend on the reverse - having "origin"
> expand into "refs/remotes/origin/HEAD", so we probably cannot rip out
> the "refs/remotes/%.*s/HEAD" rule altogether...

Oh, no doubt about that reverse conversion.

The real reason nobody cared about refs/remotes/origin/HEAD is that
nobody sane has anything but non-symbolic ref there.  Your t1514
does this:

	...
	git update-ref refs/master master_d &&
	test_commit master_e
	git update-ref refs/remotes/origin/HEAD master_e &&
	...

Nowhere in the set-up sequence, you see anything that does

	git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/master

or any other branch we copied from the remote.

And the shortening is done after dereferencing the synbolic ref.
Because of this, refs/remotes/origin/HEAD usually resolves to
origin/master, not origin.

 t/t1514-rev-parse-shorten-unambiguous-ref.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1514-rev-parse-shorten-unambiguous-ref.sh b/t/t1514-rev-parse-shorten-unambiguous-ref.sh
index fd87ce3..556ad16 100755
--- a/t/t1514-rev-parse-shorten-unambiguous-ref.sh
+++ b/t/t1514-rev-parse-shorten-unambiguous-ref.sh
@@ -76,4 +76,11 @@ test_expect_success 'shortening refnames in loose mode' '
 	test_shortname refs/tags/master loose tags/master master_c
 '
 
+test_expect_success 'shortening is done after dereferencing a symref' '
+	git update-ref refs/remotes/frotz/master master_e &&
+	git symbolic-ref refs/remotes/frotz/HEAD refs/remotes/frotz/master &&
+	test_shortname refs/remotes/frotz/HEAD strict frotz/master master_e &&
+	test_shortname refs/remotes/frotz/HEAD loose frotz/master master_e
+'
+
 test_done
