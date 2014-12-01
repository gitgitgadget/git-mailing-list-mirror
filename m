From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/3] mailmap: use higher level string list functions
Date: Sun, 30 Nov 2014 16:47:40 -0800
Message-ID: <xmqq7fyctcur.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQ_4A-0LOgXXG5qLeHOev+g8KMq5osKz34AFijGuyRidQ@mail.gmail.com>
	<1416887054-27204-1-git-send-email-sbeller@google.com>
	<CAO2U3QjNua2HvJKLnq80mPFEp931yLzHKENKo-LHm4CFZWRhBA@mail.gmail.com>
	<CAPig+cRNuuDDBV0-TwANuiv+f_c1mfXp2Q4rF1Sj5mtJoLoqHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 01:47:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvF9d-0000Zt-RW
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 01:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbaLAArt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 19:47:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752069AbaLAArs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 19:47:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34E6F23653;
	Sun, 30 Nov 2014 19:47:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J5e7LPPp0XN9KQNWGHWvE/6rSeU=; b=cIvU9N
	ESZQbSvFUChXCIgKwBZkXJOojkrUDj7x0ncGTckmZEjhPekbsgk4Ta2GV3PCcy8g
	SS5UGkKDRH4E6heQqFRq0p31nZUlGJ/7A6d/VGlPAGXlcb0NpOSrvMIqwvpsh53l
	Ejw29xp3adHUusFAgXFM0CYK64GwGRhbrdMKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kgN7c2PI+dDtiaSFlDDQjO6GBa0rF+Bj
	BJXBO9d4o9qPE9GPfmvG0mYobyd4FjyIfd76YC2hovA7FTP9GB69SyTt9JOx0VWR
	AiGfVASGPljci6lWHyCkygFuTr0SOeufURIITrQSzs5ilWCVxDUeLQ6qWOzsVHje
	dU8oLY0qqx4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A99423652;
	Sun, 30 Nov 2014 19:47:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85DB523651;
	Sun, 30 Nov 2014 19:47:41 -0500 (EST)
In-Reply-To: <CAPig+cRNuuDDBV0-TwANuiv+f_c1mfXp2Q4rF1Sj5mtJoLoqHQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 27 Nov 2014 14:57:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7D8E128-78F3-11E4-B673-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260457>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Nov 27, 2014 at 1:44 PM, Michael Blume <blume.mike@gmail.com> wrote:
>> The variable index seems to be unused/uninitialized now -- it's still
>> printed in debug messages, but if I'm reading correctly, its contents are
>> going to be nonsense.
>
> Nice catch.

Let's do something like this squashed in, then.

 mailmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 3b00a65..cb26af0 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -90,8 +90,8 @@ static void add_mapping(struct string_list *map,
 	}
 
 	if (old_name == NULL) {
-		debug_mm("mailmap: adding (simple) entry for %s at index %d\n",
-			 old_email, index);
+		debug_mm("mailmap: adding (simple) entry for '%s'\n", old_email);
+
 		/* Replace current name and new email for simple entry */
 		if (new_name) {
 			free(me->name);
@@ -103,8 +103,7 @@ static void add_mapping(struct string_list *map,
 		}
 	} else {
 		struct mailmap_info *mi = xcalloc(1, sizeof(struct mailmap_info));
-		debug_mm("mailmap: adding (complex) entry for %s at index %d\n",
-			 old_email, index);
+		debug_mm("mailmap: adding (complex) entry for '%s'\n", old_email);
 		if (new_name)
 			mi->name = xstrdup(new_name);
 		if (new_email)
