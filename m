Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B721B202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 02:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932394AbdJ0C5r (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 22:57:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53986 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932334AbdJ0C5q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 22:57:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D04FAF56E;
        Thu, 26 Oct 2017 22:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2EV9dKOVx2knBxIZLYxBpDKsmQc=; b=aVSGSn
        SaSeHdp9HPaXEHIe25brgd0/4BsOptlcw0wcxEM5bBi13fI+ia/2i+8A8YpCXTm0
        46Kcz5EYWQzbw3MSbOpAYwgQqZHvCgr6Byq94lxR+8n67Q/88+0rTIxWXsRWS+VT
        71dfE0lNvW+gvVDvJV+PqSZxyEdWfBnZOBriE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eDKGNWO3zPdCjWEVcJFWwyzxnEFD5Tyd
        IXQNkTnqNKyWDBl+oJcOCysqNN4lTiJi7loywkew8zXoxLMZyyv7mfIbbDT3ay60
        b9DKp0r5/mRhix39scEFGnLTG46lFJIzdt2v3pP+LkODLvhkSWmGYupgZEiXVl7q
        cEF5nmKa/Rs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34DA0AF56D;
        Thu, 26 Oct 2017 22:57:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92572AF56C;
        Thu, 26 Oct 2017 22:57:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/6] t0021/rot13-filter: add packet_initialize()
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
        <20171019123030.17338-5-chriscool@tuxfamily.org>
        <xmqqvaj8dlyz.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 27 Oct 2017 11:57:43 +0900
In-Reply-To: <xmqqvaj8dlyz.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 22 Oct 2017 10:12:36 +0900")
Message-ID: <xmqqr2tpcn6g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B1B5B5A-BAC2-11E7-A292-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It is fine to leave the original code broken at this step while we
> purely move the lines around, and hopefully this will be corrected
> in a later step in the series (I am responding as I read on, so I do
> not yet know at which patch that happens in this series).

Actually, I think you'd probably be better off if you fixed these
broken comparisions that does (@list1 eq @list2) very early in the
series, perhaps as [PATCH 0.8/6].  

I am sure Perl experts among us on the list can come up with a
cleaner and better implementation of compare_lists sub I am adding
here, but in the meantime, here is what I would start with if I were
working on this topic.

Thanks.

 t/t0021/rot13-filter.pl | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index ad685d92f8..9bf5a756af 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -107,21 +107,42 @@ sub packet_flush {
 	STDOUT->flush();
 }
 
+sub compare_lists {
+	my ($expect, @result) = @_;
+	my $ix;
+	if (scalar @$expect != scalar @result) {
+		return undef;
+	}
+	for ($ix = 0; $ix < $#result; $ix++) {
+		if ($expect->[$ix] ne $result[$ix]) {
+			return undef;
+		}
+	}
+	return 1;
+}
+
 print $debug "START\n";
 $debug->flush();
 
-( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
-( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
+compare_lists([0, "git-filter-client"], packet_txt_read()) ||
+	die "bad initialize";
+compare_lists([0, "version=2"], packet_txt_read()) ||
+	die "bad version";
+compare_lists([1, ""], packet_bin_read()) ||
+	die "bad version end";
 
 packet_txt_write("git-filter-server");
 packet_txt_write("version=2");
 packet_flush();
 
-( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
-( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
-( packet_txt_read() eq ( 0, "capability=delay" ) )  || die "bad capability";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+compare_lists([0, "capability=clean"], packet_txt_read()) ||
+	die "bad capability";
+compare_lists([0, "capability=smudge"], packet_txt_read()) ||
+	die "bad capability";
+compare_lists([0, "capability=delay"], packet_txt_read()) ||
+	die "bad capability";
+compare_lists([1, ""], packet_bin_read()) ||
+	die "bad capability end";
 
 foreach (@capabilities) {
 	packet_txt_write( "capability=" . $_ );
