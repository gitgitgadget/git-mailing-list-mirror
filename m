From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: add --reflog-message=<pattern> to grep reflog
 messages
Date: Wed, 26 Sep 2012 12:28:59 -0700
Message-ID: <7va9wctwg4.fsf@alter.siamese.dyndns.org>
References: <1348661565-30484-1-git-send-email-pclouds@gmail.com>
 <7vpq58ubbx.fsf@alter.siamese.dyndns.org>
 <CACsJy8D=OPtbuygjSFx+Wcwo=hgq2RsumgeNzpNk-4QGH1CVdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:29:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxIL-0001N1-MR
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725Ab2IZT3I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2012 15:29:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60479 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757257Ab2IZT3G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:29:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA48F8F22;
	Wed, 26 Sep 2012 15:29:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d0VGT4NGnxy/
	8R+3V9cyZlHJeNY=; b=sL+eY9ISaLF9r31vG9iAROheZr66GDMlSHykQeCeO/rZ
	9vSxcFaegDElZepEBeXZeIDjKVxjX5QPqx81VIJCfITsBMph5CFryqVy3Zu1M3oy
	LzhvLuuilPgTlndPobHOeBBHQ5twW1txA9A09LjFucqQ6FMNbLEpJ4gw7gJoSa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VYNMZK
	yJx8Rgq+upGtT5lO+a9QkTQYwTlRwqcakAfjjxIpCNuJT8yHCtp/zzxpvIpl35yk
	LvyUtWq6jZ/+mfWV7XnRzG0dCJqTqTxc3Upn4IqsyNevJ32A1piLXQkPqJftRed3
	OTKn93xO0TgUDXhlgQYSGhQykupvLh046gHpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B76028F21;
	Wed, 26 Sep 2012 15:29:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD33A8F20; Wed, 26 Sep 2012
 15:29:03 -0400 (EDT)
In-Reply-To: <CACsJy8D=OPtbuygjSFx+Wcwo=hgq2RsumgeNzpNk-4QGH1CVdg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 26 Sep 2012 21:15:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E5AD786-0810-11E2-B803-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206431>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Sep 26, 2012 at 9:07 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> Both "git log" and "git reflog show" recognize this option.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>
>> How well does it interact with --grep and/or --all-match?
>
> Good point. It currently works like and operator. But people might
> expect to combine them in different ways.

The current commit_match() runs grep_buffer() on commit->buffer.  It
probably makes sense to instead notice from opt that we are running
log with "-g", prepare a temporary strbuf and add in the reflog
message to the string in commit->buffer, and run grep_buffer() on
that temporary strbuf on it.

I personally think it is sufficient ot just reuse --grep on
concatenation of commit->buffer with "Reflog message: checkout:
moving from as/check-ignore to pu".

If you really want to go fancier, you could add --grep-reflog option
that behaves like the existing --author and --committer options to
add "header match" elements to the grep expression, splice a fake
"reflog " header to the string copied from commit->buffer, e.g.
prepare something like this in your temporary strbuf:

    tree b4429f218782165faf101ccb0f4ba1cdd6d1d349
    parent de5cd03876e546d6d264ab28a01daa978f3eae78
    parent b378e5a25658e07e6d0c0f4db79e87cb21de5489
    author Junio C Hamano <gitster@pobox.com> 1348616180 -0700
    committer Junio C Hamano <gitster@pobox.com> 1348616180 -0700
    reflog checkout: moving from as/check-ignore to pu

    Merge branch 'jk/lua-hackery' into pu

    * jk/lua-hackery:
      Minimum compilation fixup
      Makefile: make "lua" a bit more configurable
      add a "lua" pretty format
      add basic lua infrastructure
      pretty: make some commit-parsing helpers more public

that way, you can take advantage of the existing logic used for the
author/committer match that matches only in the commit object
header.

Again, I personally doubt the fancier option is worth it, but the
starting point may look something like this.

 revision.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git c/revision.c w/revision.c
index ae12e11..b0f4d5b 100644
--- c/revision.c
+++ w/revision.c
@@ -2212,8 +2212,20 @@ static int commit_match(struct commit *commit, s=
truct rev_info *opt)
 {
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
-	return grep_buffer(&opt->grep_filter,
-			   commit->buffer, strlen(commit->buffer));
+
+	if (opt->reflog_info) {
+		int retval;
+		struct strbuf buf =3D STRBUF_INIT;
+		strbuf_addf(&buf, "reflog %s\n", opt->reflog_info->message);
+		strbuf_addstr(&buf, commit->buffer);
+		retval =3D grep_buffer(&opt->grep_filter,
+				     buf.buf, buf.len);
+		strbuf_release(&buf);
+		return retval;
+	} else {
+		return grep_buffer(&opt->grep_filter,
+				   commit->buffer, strlen(commit->buffer));
+	}
 }
=20
 static inline int want_ancestry(struct rev_info *revs)
