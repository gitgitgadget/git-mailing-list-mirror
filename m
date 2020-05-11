Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A63AC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E85E20708
	for <git@archiver.kernel.org>; Mon, 11 May 2020 16:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sAeZwREv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgEKQqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 12:46:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60753 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgEKQqp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 12:46:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA20AC9355;
        Mon, 11 May 2020 12:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PGGOWX3hfRPaTns/wFLO7HN0UUQ=; b=sAeZwR
        EvtClmuBb+pkWz6otgVq6TiDafDJ09FrMFFyE9xP22WqfbiwZSk9g/LzwKoYJr0x
        46ti98IXIJ45zjwQFVK8kM2jo8gmzkSxOKc/yQ4/RQhMACSG1hYIc4K6cDEFBoMA
        cZeKG8ZlcEun6CyOYrjZThe9bKFe5ETpv7y0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wr2AOi+Dutu4cL52Q6djSX/xvoz8RobU
        SkPizNkUgmww42A/vhqY/It/SAK4Ae+RKL8vSEUaQfNug/fmoai+NJLs2UyGFkaH
        4eG2wmVC7kqN34WoAtjNISDVGWOl46B9ih1ZBr88PRGsKIJgHXAI6osPy8qC4+BF
        YI0hIE42AQw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1C8DC9353;
        Mon, 11 May 2020 12:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 88F5FC9352;
        Mon, 11 May 2020 12:46:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     George Brown <321.george@gmail.com>, git@vger.kernel.org
Subject: Re* [PATCH] contrib/git-jump: cat output when not a terminal
References: <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
        <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
        <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
        <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
        <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
        <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
        <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
        <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
        <20200511143157.GA1415@coredump.intra.peff.net>
        <xmqqr1vqscuy.fsf@gitster.c.googlers.com>
        <20200511154226.GC1415@coredump.intra.peff.net>
Date:   Mon, 11 May 2020 09:46:34 -0700
In-Reply-To: <20200511154226.GC1415@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 11 May 2020 11:42:26 -0400")
Message-ID: <xmqqy2pyqv11.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA8F0770-93A6-11EA-B59D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 11, 2020 at 08:36:05AM -0700, Junio C Hamano wrote:
>
>> > So I'm OK to leave the status quo and let people use the GIT_EDITOR
>> > solution in this instance. But I'd also be happy to take a patch for
>> > "--no-editor" or similar if somebody wants to work it up.
>> 
>> I actually would support --no-editor.  One thing nobody noticed so
>> far is that "git-jump" is only compatible with editors that support
>> the "-q" option from the command line, and "cat" is not among them.
>
> Oh, good point. GIT_EDITOR='cat -- 2>/dev/null' works, but is rather
> obscure. :)

Lest we all forget...

-- >8 --
Subject: git-jump: just show the list with the "--no-editor" option

The "git jump" script (in contrib/) creates a list of interesting
places to be visited in an editor, and then open the editor to visit
the place.  Some editors, however, can read the list directly and
use it to visit these places (e.g. vim's quickfix list, or emacs's
find-grep/compilation buffer) and do not want "git jump" to invoke
a separate editor.

Users can _almost_ do this already by setting GIT_EDITOR to "cat",
except that "git jump" assumes that the editor it spawns support a
"-q" option from the command line, and unfortunately "cat" is not
among such editors.

Teach it the "--no-editor" option, which tells the command to show
the list it generated to its standard output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/git-jump/git-jump | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 931b0fe3a9..26a7159053 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -2,7 +2,7 @@
 
 usage() {
 	cat <<\EOF
-usage: git jump <mode> [<args>]
+usage: git jump [--no-editor] <mode> [<args>]
 
 Jump to interesting elements in an editor.
 The <mode> parameter is one of:
@@ -64,6 +64,18 @@ mode_ws() {
 	git diff --check "$@"
 }
 
+edit=yes
+
+while	case "$#,$1" in
+	0,*) break ;;
+	*,--no-editor) edit=no ;;
+	*,--*) usage >&2; exit 1 ;;
+	*) break ;;
+	esac
+do
+	shift
+done
+
 if test $# -lt 1; then
 	usage >&2
 	exit 1
@@ -75,4 +87,9 @@ tmp=`mktemp -t git-jump.XXXXXX` || exit 1
 type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
 "mode_$mode" "$@" >"$tmp"
 test -s "$tmp" || exit 0
-open_editor "$tmp"
+
+case "$edit" in
+yes)	open_editor "$tmp" ;;
+no)	cat "$tmp" ;;
+esac
+
