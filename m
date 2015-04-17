From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log -L: improve error message on malformed argument
Date: Fri, 17 Apr 2015 13:38:15 -0700
Message-ID: <xmqqh9sepk20.fsf@gitster.dls.corp.google.com>
References: <1429195387-20573-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Apr 17 22:38:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjD1r-0005aQ-AQ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 22:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbDQUiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 16:38:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751664AbbDQUiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 16:38:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB00048DD1;
	Fri, 17 Apr 2015 16:38:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lfw/RpPGM8FMDL4/RXT4mAjQbaw=; b=hKiGDO
	qmWuIjNQ1xErrjmgWKJ32gGZjTWVW9JUBiXx1IRH9GEvKdT7whbPZarUEuu9L0hx
	oAr+qkeXnhimbTlp29Zxx8V186C8A85lN6edoI/UiYVczYCdbK9ITWOHjBDN8Gxq
	XxWafoN8Fk9kkDBVZxmlKVhZBuWEe3SCpMD3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RklfAHaxfkT47NqdZtoIU+5ZfooLC7/P
	JG4pZCCLZbtQyUOD2UJM2f1wH8zv2q1b1nCrAS2p63DS0Q+eKHtQlSgxfPQVvDmE
	1S5amc9Ri4VbrzcoBZN9yKCoU4IL1cLo348AgP2LrRzjKBf+yk+dHo2z6s0AU6Le
	6XIIfztRUFQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3FAA48DCF;
	Fri, 17 Apr 2015 16:38:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CEAE48DCE;
	Fri, 17 Apr 2015 16:38:16 -0400 (EDT)
In-Reply-To: <1429195387-20573-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 16 Apr 2015 16:43:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACCBB65A-E541-11E4-A8C2-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267387>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The old message did not mention the :regex:file form.
>
> To avoid overly long lines, split the message into two lines (in case
> item->string is long, it will be the only part truncated in a narrow
> terminal).
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  line-log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/line-log.c b/line-log.c
> index a490efe..e725248 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -575,7 +575,8 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
>  
>  		name_part = skip_range_arg(item->string);
>  		if (!name_part || *name_part != ':' || !name_part[1])
> -			die("-L argument '%s' not of the form start,end:file",
> +			die("invalid -L argument '%s'.\n"
> +			    "It should be of the form start,end:file or :regex:file.",
>  			    item->string);
>  		range_part = xstrndup(item->string, name_part - item->string);
>  		name_part++;

I actually think "start,end:file" is more correct than your updated
text.

By adding :regex:file as a possibility, you are hinting that 'start'
and 'end' are *not* regular expressions but numbers, but

    $ git log -L'/^int main/,/^}/:git.c'

is a perfectly fine way to specify start (i.e. the first line that
matches '^int main') and end (i.e. the first line that matches '^}'
after that).  Perhaps rephrase it as :funcname:file to avoid giving
false impression to the other one, and use Eric's suggestion on top?

    die("-L argument not 'start,end:file' or ':funcname:file': %s",
	item->string);

With the matching update to tests, here is what I'll queue on top of
this patch for now, but please send in objections and improvements.

Thanks.

 line-log.c          | 3 +--
 t/t4211-line-log.sh | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/line-log.c b/line-log.c
index 5d4cb7c..51d9f7c 100644
--- a/line-log.c
+++ b/line-log.c
@@ -543,8 +543,7 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 
 		name_part = skip_range_arg(item->string);
 		if (!name_part || *name_part != ':' || !name_part[1])
-			die("invalid -L argument '%s'.\n"
-			    "It should be of the form start,end:file or :regex:file.",
+			die("-L argument not 'start,end:file' or ':funcname:file': %s",
 			    item->string);
 		range_part = xstrndup(item->string, name_part - item->string);
 		name_part++;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 426a828..edd5ed3 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -40,14 +40,14 @@ canned_test "-L 24,+1:a.c simple" vanishes-early
 canned_test "-L '/long f/,/^}/:b.c' move-support" move-support-f
 
 test_bad_opts "-L" "switch.*requires a value"
-test_bad_opts "-L b.c" "argument.*not of the form"
-test_bad_opts "-L 1:" "argument.*not of the form"
+test_bad_opts "-L b.c" "argument not .start,end:file"
+test_bad_opts "-L 1:" "argument not .start,end:file"
 test_bad_opts "-L 1:nonexistent" "There is no path"
 test_bad_opts "-L 1:simple" "There is no path"
-test_bad_opts "-L '/foo:b.c'" "argument.*not of the form"
+test_bad_opts "-L '/foo:b.c'" "argument not .start,end:file"
 test_bad_opts "-L 1000:b.c" "has only.*lines"
 test_bad_opts "-L 1,1000:b.c" "has only.*lines"
-test_bad_opts "-L :b.c" "argument.*not of the form"
+test_bad_opts "-L :b.c" "argument not .start,end:file"
 test_bad_opts "-L :foo:b.c" "no match"
 
 test_done
-- 
2.4.0-rc2-183-g70401ab
