Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83086205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 01:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969201AbdAIBZG (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 20:25:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60525 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965017AbdAIBZF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 20:25:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3616D5F631;
        Sun,  8 Jan 2017 20:25:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UTYiwOmypNiCe2zDNivskuuofx8=; b=dksV4l
        nlVO3U8E6KxqgiarAJ2RE5b9yanV5QV+GikoyFNcpyhwKhJOKqF+sURgnfpNRgeO
        fnSUgd3F6/3AUamLHbD0+fZb/YRtX0vEW0c1CMNPdpqpOJzz6P3HQe8cjPu9/+xh
        Fr21MtpClDO0ESMTab96JzJW0rHtkhQcrFZ+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EaNrpa96Hx45Oultq6bJwjoM9ShdurRW
        rIpRT//0hPHIIY4KInOQ2VG5EK0Ipe06Z/0JX5+Mrj4IyZX5T5HpLcn/loTnXwf+
        /VqxsBvMdkNZs5Nib+KmQa2bKpM/Za9P/kNzC7SyNgvdnxpHUbFO+o4HNdjOIbYp
        8f3KaZ1mMsY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12D055F62F;
        Sun,  8 Jan 2017 20:25:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0F2F5F62D;
        Sun,  8 Jan 2017 20:25:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v4 1/4] Avoid Coverity warning about unfree()d git_exec_path()
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
        <cover.1483373635.git.johannes.schindelin@gmx.de>
        <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de>
        <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com>
Date:   Sun, 08 Jan 2017 17:25:00 -0800
In-Reply-To: <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com>
        (Stefan Beller's message of "Tue, 3 Jan 2017 12:11:25 -0800")
Message-ID: <xmqqy3ylyqhf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 713AADF6-D60A-11E6-B482-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jan 2, 2017 at 8:22 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> Technically, it is correct that git_exec_path() returns a possibly
>> malloc()ed string. Practically, it is *sometimes* not malloc()ed. So
>> let's just use a static variable to make it a singleton. That'll shut
>> Coverity up, hopefully.
>
> I picked up this patch and applied it to the coverity branch
> that I maintain at github/stefanbeller/git.
>
> I'd love to see this patch upstream as it reduces my maintenance
> burden of the coverity branch by a patch.

So with the above, are you saying "Dscho said 'hopefully', and I
confirm that this change does squelch misdiagnosis by Coverity"?

> If this patch is only to appease coverity (as the commit message eludes
> to) I think this may be a bad idea for upstream.  If this patch fixes an
> actual problem, then the commit message needs to spell that out.

That is true, and I see Peff pointed out another possible issue
around getenv(), but I think from the "one step at a time" point of
view, it is an improvement to call system_path() just once and cache
it in "static char *".  

How about explaining it like this then?

(only the log message has been corrected; diff is from the original).

commit c9bb5d101ca657fa466afa8c4368c43ea7b7aca8
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Mon Jan 2 17:22:33 2017 +0100

    git_exec_path: avoid Coverity warning about unfree()d result
    
    Technically, it is correct that git_exec_path() returns a possibly
    malloc()ed string returned from system_path(), and it is sometimes
    not allocated.  Cache the result in a static variable and make sure
    that we call system_path() only once, which plugs a potential leak.
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/exec_cmd.c b/exec_cmd.c
index 9d5703a157..eae56fefba 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -69,6 +69,7 @@ void git_set_argv_exec_path(const char *exec_path)
 const char *git_exec_path(void)
 {
 	const char *env;
+	static char *system_exec_path;
 
 	if (argv_exec_path)
 		return argv_exec_path;
@@ -78,7 +79,9 @@ const char *git_exec_path(void)
 		return env;
 	}
 
-	return system_path(GIT_EXEC_PATH);
+	if (!system_exec_path)
+		system_exec_path = system_path(GIT_EXEC_PATH);
+	return system_exec_path;
 }
 
 static void add_path(struct strbuf *out, const char *path)

