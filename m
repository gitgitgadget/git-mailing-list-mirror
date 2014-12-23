From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 13:02:23 -0800
Message-ID: <xmqqr3vq13mo.fsf@gitster.dls.corp.google.com>
References: <20141223084536.GA25190@peff.net>
	<20141223201416.GA29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 22:05:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3WeT-00033t-Nh
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 22:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684AbaLWVFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 16:05:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756544AbaLWVFw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2014 16:05:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50ECF2A624;
	Tue, 23 Dec 2014 16:05:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FBRrkZY2FxQ2
	h7SUfIgDEn2ozs8=; b=f74gNnKuJodl+pyVXas+V43AWrBqG49+AFe4eb+GRYf1
	UOti9u5VXwjTW+BjOpVkP4TzIyL7ndPUXiicIPZ3pOcBII6Y9pM2LwtjIPeStSwm
	WB/RlmAxXjdRrB68QF1LZRRiv2aoaTIqAo/vXg5PuFHflKfgIQy5t5vqh78YJfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uLUvcb
	HprG12yeUexy8l4NhUCSKv6J8SzpgR+8So1YC3p9jIIX6DZ+uPOXu99Gu8f3aC4c
	62owcaoNMoD2OmYpSAyoW2M8xTVy1roBW7AOHNZPeWVyG/ekOR/xYbH8frsZIOC7
	oI2kd61W2/k8o7ojXjn4WmjeL8WSUmwrhiIpA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48BB12A623;
	Tue, 23 Dec 2014 16:05:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 661C52A578;
	Tue, 23 Dec 2014 16:02:25 -0500 (EST)
In-Reply-To: <20141223201416.GA29365@google.com> (Jonathan Nieder's message of
	"Tue, 23 Dec 2014 12:14:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FF101C40-8AE6-11E4-B1E2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261773>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +++ b/t/t1450-fsck.sh
> [...]
>> +		git fsck 2>err &&
>> +		cat err &&
>> +		! test -s err
>
> Nit: if this said
>
> 		test_line_count =3D 0 err
>
> then the error message would be more obvious when it fails with
> --verbose.

That's a good suggestion, I think.  This is meant to apply on top of
d08c13b, and we already had test_line_count back then.

So far I collected these follow-ups to squash into Peff's patch.



 t/t1450-fsck.sh |  3 +--
 utf8.c          | 15 ++++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5e42385..0279b2b 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -284,8 +284,7 @@ test_expect_success 'fsck allows .=C5=87it' '
 		printf "100644 blob $blob\t.\\305\\207it" >tree &&
 		tree=3D$(git mktree <tree) &&
 		git fsck 2>err &&
-		cat err &&
-		! test -s err
+		test_line_count =3D 0 err
 	)
 '
=20
diff --git a/utf8.c b/utf8.c
index 18a8f42..9c9fa3a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -630,8 +630,8 @@ int mbs_chrlen(const char **text, size_t *remainder=
_p, const char *encoding)
 }
=20
 /*
- * Pick the next char from the stream, folding as an HFS+ filename com=
parison
- * would. Note that this is _not_ complete by any means. It's just eno=
ugh
+ * Pick the next char from the stream, ignoring codepoints an HFS+ wou=
ld.
+ * Note that this is _not_ complete by any means. It's just enough
  * to make is_hfs_dotgit() work, and should not be used otherwise.
  */
 static ucs_char_t next_hfs_char(const char **in)
@@ -668,11 +668,6 @@ static ucs_char_t next_hfs_char(const char **in)
 			continue;
 		}
=20
-		/*
-		 * there's a great deal of other case-folding that occurs,
-		 * but this is enough to catch anything that will convert
-		 * to ".git"
-		 */
 		return out;
 	}
 }
@@ -685,6 +680,12 @@ int is_hfs_dotgit(const char *path)
 	if (c !=3D '.')
 		return 0;
 	c =3D next_hfs_char(&path);
+
+	/*
+	 * there's a great deal of other case-folding that occurs
+	 * in HFS+, but this is enough to catch anything that will
+	 * convert to ".git"
+	 */
 	if (c !=3D 'g' && c !=3D 'G')
 		return 0;
 	c =3D next_hfs_char(&path);
