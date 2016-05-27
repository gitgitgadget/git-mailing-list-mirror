From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/22] i18n: rebase-interactive: mark strings for translation
Date: Fri, 27 May 2016 09:58:04 -0700
Message-ID: <xmqqk2ifsajn.fsf@gitster.mtv.corp.google.com>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
	<1464031661-18988-15-git-send-email-vascomalmeida@sapo.pt>
	<xmqqpos8tpjo.fsf@gitster.mtv.corp.google.com>
	<57481CA0.5080801@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 27 18:58:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6L5S-0002PZ-CQ
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 18:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbcE0Q6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 12:58:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754539AbcE0Q6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 12:58:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0D141F7C0;
	Fri, 27 May 2016 12:58:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qH9D8+YewteDRkKZiwLemdkXclE=; b=Nw4h8r
	xSpE18Q2CXB8BK7OVseTvikQf7VegX+/NeSk9WuVn/XpYtk3/HeTLaeZENd+n3+8
	iwQ86ec+ZBLj24iyQ7mV9IifjGEtfPeoxd24OfMGwHqIPAT47FP2WTTjdtp+QseZ
	1WF6kCHJ9hl+92MmQhTkgc8D7UMie6TwvO5MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XYjlPUxTqaW5gu07/JtOKohwKxPA7hfu
	Xmi63yjvIw6HJWjJM6xGt/WFcrBLm85xeeLIXwtiRDNpNJBT/FqspTjfIPdmlxoM
	VpdOC0vMyDzdphvXbar63wsoHtU0sfZ15PYJJopDIyTlRep4EgPcz4qkrFkOSw+1
	gs/CGqVu9FA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D68021F7BE;
	Fri, 27 May 2016 12:58:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 380D81F7BD;
	Fri, 27 May 2016 12:58:06 -0400 (EDT)
In-Reply-To: <57481CA0.5080801@sapo.pt> (Vasco Almeida's message of "Fri, 27
	May 2016 10:08:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2EB978F8-242C-11E6-9718-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295768>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>>>  is_empty_commit() {
>>> -	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
>>> -		die "$1: not a commit that can be picked")
>>> -	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
>>> +	sha1=$1
>>> +	tree=$(git rev-parse -q --verify "$sha1"^{tree} 2>/dev/null ||
>>> +		die "$(eval_gettext "\$sha1: not a commit that can be picked")")
>>> +	ptree=$(git rev-parse -q --verify "$sha1"^^{tree} 2>/dev/null ||
>>>  		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
>>>  	test "$tree" = "$ptree"
>>>  }
>> 
>> Both of the two callsites of this function use the variable $sha1,
>> and at least one of them uses that variable after this function
>> returns, but they pass it as the first parameter to this function,
>> so the assignment added by this patch does not break them, which is
>> good.
>> 
> I didn't know that. I can change sha1=$1 to local_sha1=$1 or _sha1=$1 (I
> don't know what is the convention here) if that is safer, avoiding using
> the bash-ism "local" keyword, and preventing future distractions.

I do not think it is necessary to do any of the changes for this
one, which is only used locally in this file.  They just need to be
careful when they add or modify the callers.

Even if it is renamed $local_sha1, they will still need to be
careful anyway, because the only way they _can_ break or be broken
by your patch is when they somehow decide to pass something that is
not called $sha1 to this function, i.e. they would be changing the
callsite---which they must be doing for a reason and would also
involve change to the code what happens after this function returns.
If they start using $local_sha1 there, they would be broken if you
renamed it today, and if they use $sha1 there, they would be broken
if you didn't---so they have to be careful and check what this one
clobbers _anyway_.  

IOW, a solution that clobbers _some_ variable cannot be made safer
by renaming.  The callers always have to be careful not to be
affected.

You could do something like this, though.  I _think_ the original
that calls "die" inside $() is broken anyway, so it probably is a
good change regardless.

 git-rebase--interactive.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9d2bfb7..b5113d6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -222,8 +222,10 @@ has_action () {
 }
 
 is_empty_commit() {
-	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null ||
-		die "$1: not a commit that can be picked")
+	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null) || {
+		sha1=$1
+		die "$(eval_gettext "\$sha1: not a commit that can be picked")"
+	}
 	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null ||
 		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
 	test "$tree" = "$ptree"
