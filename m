From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7800 test failure
Date: Tue, 24 May 2016 10:36:39 -0700
Message-ID: <xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
	<vpqk2ijs8p2.fsf@anie.imag.fr>
	<xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
	<CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 24 19:36:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5GG7-0001Br-NK
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 19:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbcEXRgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 13:36:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932569AbcEXRgn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 13:36:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC0141E966;
	Tue, 24 May 2016 13:36:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p3AQNEebLIWPYrRn6x1DwsyTMF0=; b=svv37J
	oV1UD6qXTaS80I99vmj4eOur+AfNzP2PTYHhnuL9MiPRKlqz5WcByXYy2y6TMKjD
	JztjcJNr6vy4lVFmlnQ/AX/0iqgldESbiAzL/xuMC9bB+oVS671AQKNviG2/M9lh
	Z4FN8fGfyQmMQQwbo7xx2mpk6M78xg2RfobYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pk6Dl1MQnQqXgO/JbxyuJTjbkVaqUsDO
	Ai8n2LkxrXh28zmB9gFBPmgIYyNTNUxvv2y3/nqB+EO2JQ6d4ZDeWve7z/0CVTsF
	9nDj32JKk6dkon5kvIOy1LEL9y73oolBMt4vNo3Sv8VhuTV+XG4v8fiLwdnUATYB
	p5fwOecL0tI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A37671E965;
	Tue, 24 May 2016 13:36:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11EDB1E964;
	Tue, 24 May 2016 13:36:41 -0400 (EDT)
In-Reply-To: <CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
	(Armin Kunaschik's message of "Tue, 24 May 2016 19:20:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 133CEC7A-21D6-11E6-BA9E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295509>

Armin Kunaschik <megabreit@googlemail.com> writes:

>> I wouldn't allow it in our scripted Porcelain, but the environment
>> of our test scripts are under our control, so I do not think it is a
>> problem ("ls piped to sed" has been an established idiom before
>> readlink(1) was widely accepted, by the way).
>
> I think so too. Maybe I can improve the sed expression a bit, but
> it will never be a universal readlink replacement. But it doesn't have to.
> It's defined locally for this one test only and it does the specific job.
>
>>> It would be acceptable as a fall-back if readlink is not present, but
>>> shouldn't activate the "ls" hack by default.
>>
>> Yup.
>
> Ok, how can this be implemented within the test environment?

I actually think an unconditional check like this is sufficient.

 t/t7800-difftool.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 7ce4cd7..f304228 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -442,15 +442,16 @@ run_dir_diff_test 'difftool --dir-diff with unmerged files' '
 	test_cmp expect actual
 '
 
-write_script .git/CHECK_SYMLINKS <<\EOF
-for f in file file2 sub/sub
-do
-	echo "$f"
-	readlink "$2/$f"
-done >actual
-EOF
-
 test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
+
+	write_script .git/CHECK_SYMLINKS <<-\EOF &&
+	for f in file file2 sub/sub
+	do
+		echo "$f"
+		ls -ld "$2/$f" | sed -e "s/.* -> //"
+	done >actual
+	EOF
+
 	cat >expect <<-EOF &&
 	file
 	$PWD/file
