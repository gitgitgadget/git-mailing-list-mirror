Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE33C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 03:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E6720704
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 03:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CGDZcFRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKVDol (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:44:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57417 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKVDol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 22:44:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57B3F8F62C;
        Thu, 21 Nov 2019 22:44:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MsUDG1RQTt27qvtR3Kvj+27BbD0=; b=CGDZcF
        Ru2fn34Yhpob+DZ3JvvpKPXemTQXfVyHBoqx7AEhuwwYbneUv2VYQc4uYko/UPWJ
        bpbuRu2agu7WEdoou75hUdd/NC+NQwJU7TMgbVq15W75XbQTQsXTMsUXufjPbFgZ
        jjbP5xIgDvDf3EMgWhi6Tn/eZo6E3szsgrRV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=siLMX+FzthxrJhsCOta5+lWOFht79+Ep
        Ydjgmdjw8vHCFu2Qh59n829XwOQ10Ev/nBnMr3xrRjjNvh1fHWHm7V0JlvH8ugsT
        R7lJzDbBCClKlEyQnR0wPl/WLlqqNXdpGJ64RcKk6OQPOaNlS2Ho8PJT+ASh4mNa
        pI3b+BI28/M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FC638F62A;
        Thu, 21 Nov 2019 22:44:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 845498F627;
        Thu, 21 Nov 2019 22:44:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gpg-interface: limit search for primary key fingerprint
References: <20191116180655.10988-1-hji@dyntopia.com>
        <20191116180655.10988-2-hji@dyntopia.com>
        <xmqqtv712145.fsf@gitster-ct.c.googlers.com>
        <87d0dkbyxb.hji@dyntopia.com>
        <xmqqsgmg7hyf.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 22 Nov 2019 12:44:34 +0900
In-Reply-To: <xmqqsgmg7hyf.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 22 Nov 2019 11:39:20 +0900")
Message-ID: <xmqqeey07exp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6768D2B2-0CDA-11EA-92EB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Hans Jerry Illikainen <hji@dyntopia.com> writes:
>
>> On Mon, Nov 18 2019, Junio C Hamano wrote:
>> ...
>>> A short helper
>>>
>>> 	static void replace_cstring(const char **field,
>>> 				    const char *line, const char *next)
>>> 	{
>>> 		free(*field);
>>> 		if (line && next)
>>> 			*field = xmemdupz(line, next - line);
>>> 		else
>>> 			*field = NULL;
>>> 	}
>>>
>>> may have quite a lot of uses in this function, not only for this
>>> field.
>>
>> Implemented.  I wasn't sure whether to do it in a separate commit or
>> not, but #git-devel suggested that I do; so that's what I did.
>
> If such a refactoring helped the readability of _existing_ code that
> can also use this helper, then I agree it is the right approach to
> make that into a separate prelimimary commit.

I did not expect the "how about doing it along this line...?"
suggestion written in my MUA without even compilation testing would
work well, and acually I do not think the above would work without
further tweaks on the types.  Wouldn't some of the fields this
helper works on be of type "char *"?

Perhaps something like this squashed in...

 gpg-interface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 4269937b83..b481b0811b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -105,7 +105,7 @@ static struct {
 	{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
 };
 
-static void replace_cstring(const char **field, const char *line,
+static void replace_cstring(char **field, const char *line,
 			    const char *next)
 {
 	free(*field);
@@ -120,7 +120,6 @@ static void parse_gpg_output(struct signature_check *sigc)
 {
 	const char *buf = sigc->gpg_status;
 	const char *line, *next, *limit;
-	const char **field;
 	int i, j;
 	int seen_exclusive_status = 0;
 
@@ -158,6 +157,8 @@ static void parse_gpg_output(struct signature_check *sigc)
 				}
 				/* Do we have fingerprint? */
 				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
+					char **field;
+
 					next = strchrnul(line, ' ');
 					replace_cstring(&sigc->fingerprint, line, next);
 
