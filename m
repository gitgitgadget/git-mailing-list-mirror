From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack.c: use of parse-options API
Date: Thu, 19 May 2016 09:58:55 -0700
Message-ID: <xmqq60uakmr4.fsf@gitster.mtv.corp.google.com>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<431335092.10912437.1463674220365.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 19 18:59:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3RHt-0007QU-VQ
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 18:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbcESQ7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 12:59:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755288AbcESQ67 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 12:58:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B52AF1B1DE;
	Thu, 19 May 2016 12:58:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vt/JxVy273qE9WXz+OkuFcZjkzw=; b=i0izTh
	jQYnBZpIWepd+mqUXkXOvY3NTQZYRjmvPRFR+jy+5zdQAKvcBw5IX9CxKlelmats
	zSAxB7LRRryjXWRm6rDxc72MvKhn4hJGEJ6UKpjaom3lBlfpkCj60gxztlcSazRl
	rsr38PhIcmTvLiPx/cYclMjUhZU0oOc3eBCoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pB0S3T35OjQbhydHo/1rVnmAGXwAR0gA
	9MoexkykuhddDYhVhgkc4RJ93mxY4zMl8Hmk4DjMZGB7BzPdqeK8vuc/QEHpwxzq
	atOxlPq5Wdgo+xxpnbsDWprkuBirjhEgt09F1x6cTLwCJfVfb0F011hYDYmYC/+E
	80EyIMR+qZc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB5BD1B1DC;
	Thu, 19 May 2016 12:58:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A1811B1DA;
	Thu, 19 May 2016 12:58:58 -0400 (EDT)
In-Reply-To: <431335092.10912437.1463674220365.JavaMail.zimbra@imag.fr>
	(Matthieu Moy's message of "Thu, 19 May 2016 18:10:20 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA605184-1DE2-11E6-9CB3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295074>

Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:

>> +	if (argc != 1)
>> +		usage_with_options(upload_pack_usage, options);
>>  
>> -	setup_path();
>> +	if (timeout)
>> +		daemon_mode = 1;
>>  
>> -	dir = argv[i];
>> +	setup_path();
>>  
>> +	dir = argv[0];
>
> Not a problem with your code, but the patch shows "setup_path()"
> as moved while it is not really. Maybe using "send-email
> --patience" or some other diff option could make the patch nicer.

Encouraging use of "send-email" with "--patience" is a losing
approach if your goal is to present more reviewable diff, isn't it?
Using "send-email" as if it is a front-end of "format-patch" means
you lose the opportunity for the final proof-reading (not just
finding typoes in the message, but the shape of diff, like you are
pointing out).

Using "format-patch --patience" or some other diff option, and pick
the best one to give to "send-email" would indeed be a way to do so.

> Not really important as it does not change the final state.

I wondered if this is an example of real-world fallout from
0018da1^2~1 (xdiff: implement empty line chunk heuristic,
2016-04-19), but it does not seem to be so.

What is happening is that Antoine's patch (which is slightly
different from what you quoted above) has trailing whitespace after
"setup_path();", so it indeed is the original setup_path(); is
removed, a few lines were inserted, argv[i] reference is removed
and then a totally different "setup_path();	" was added there.

With that whitespace-breakage corrected, the resulting patch ends
more like this:

+	if (argc != 1)
+		usage_with_options(upload_pack_usage, options);
 
-	if (i != argc-1)
-		usage(upload_pack_usage);
+	if (timeout)
+		daemon_mode = 1;
 
 	setup_path();
 
-	dir = argv[i];
-
+	dir = argv[0];
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
 
which is more reasonable.

So in the end, this was not "Not a problem with your code" ;-) It
was.
