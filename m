From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 4/4] pathspec: allow querying for attributes
Date: Fri, 20 May 2016 11:15:48 -0700
Message-ID: <xmqqd1ogegtn.fsf@gitster.mtv.corp.google.com>
References: <20160519232323.12775-1-sbeller@google.com>
	<20160519232323.12775-5-sbeller@google.com>
	<xmqqbn41hbeq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:16:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3oxq-0004Ne-8m
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 20:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbcETSPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 14:15:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750800AbcETSPw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 14:15:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B96D1A6B7;
	Fri, 20 May 2016 14:15:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ezHY7DYos7gSwcvvZCmziFwcJtg=; b=Su+enU
	zmTzZIup99rOH/ry8L3TqWmtdPfTOqiiXAp2VGpzWjjXnJDrvH3mP++EQocQEXnM
	y+p0laxu2jQiru1/MrY7qMRR/826vggcChT0U8FxStxRxsADx2ZJ5hKP9mSA/oYv
	VQKHZspo8TOrvKG8/kuf8qniIh0ZWlPKjykQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gUaAIKYjhh923LeLpEQmVIZafFZce8RJ
	jOZq0/PGlafof5bkRb6pexBZRudMBGhk2jPlyW9MNj81e2TrPOOgefnMHYOCX+dT
	TsKt/SJWvOlvg+hn8/gs7UC6bc0F2U1s99ZxSxx3sOUy/1oHqzD1pai/Z2jRLBW4
	uKGWWGO43P4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 740C91A6B6;
	Fri, 20 May 2016 14:15:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F23371A6B5;
	Fri, 20 May 2016 14:15:49 -0400 (EDT)
In-Reply-To: <xmqqbn41hbeq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 19 May 2016 16:32:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E1A65268-1EB6-11E6-8DF6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295197>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +attr;;
>> +After `attr:` comes a space separated list of "attribute
>> +...
>> ++
>
> The text looks OK, but does it format well?

I didn't check this, but the remainder would look like this
squashable patch.

You seem to i18ngrep for "fatal" but we are using test_must_fail for
the exit status, so I am not sure if that adds much value, so the
additional tests here do nto use that pattern.

diff --git a/pathspec.c b/pathspec.c
index 693a5e7..0a02255 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -115,19 +115,19 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 		const char *attr = si->string;
 		struct attr_match *am = &item->attr_match[j];
 
-		attr_len = strcspn(attr, "=");
 		switch (*attr) {
 		case '!':
 			am->match_mode = MATCH_UNSPECIFIED;
 			attr++;
-			attr_len--;
+			attr_len = strlen(attr);
 			break;
 		case '-':
 			am->match_mode = MATCH_UNSET;
 			attr++;
-			attr_len--;
+			attr_len = strlen(attr);
 			break;
 		default:
+			attr_len = strcspn(attr, "=");
 			if (attr[attr_len] != '=')
 				am->match_mode = MATCH_SET;
 			else {
diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
index 5da1a63..060047a 100755
--- a/t/t6134-pathspec-with-labels.sh
+++ b/t/t6134-pathspec-with-labels.sh
@@ -160,4 +160,9 @@ test_expect_success 'abort on giving invalid label on the command line' '
 	test_i18ngrep "fatal" actual
 '
 
+test_expect_success 'abort on asking for wrong magic' '
+	test_must_fail git ls-files . ":(attr:-label=foo)" &&
+	test_must_fail git ls-files . ":(attr:!label=foo)"
+'
+
 test_done
