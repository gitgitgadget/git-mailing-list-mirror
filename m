From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 12 Feb 2009 13:04:00 -0800
Message-ID: <7vzlgrjrjz.fsf@gitster.siamese.dyndns.org>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
 <20090129035138.GC11836@coredump.intra.peff.net>
 <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com>
 <20090129113735.GA6505@coredump.intra.peff.net>
 <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
 <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com>
 <20090129115026.GB10792@coredump.intra.peff.net>
 <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com>
 <20090130045131.GB18655@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de>
 <7vr62j0wpc.fsf@gitster.siamese.dyndns.org>
 <7v3aekqhpo.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902121200420.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXikq-0008UB-ST
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113AbZBLVEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756637AbZBLVEK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:04:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbZBLVEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:04:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E2052AFF6;
	Thu, 12 Feb 2009 16:04:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C246E2AA64; Thu,
 12 Feb 2009 16:04:01 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0881F7C-F948-11DD-963C-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109652>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/builtin-clone.c b/builtin-clone.c
>> index f73029e..431c136 100644
>> --- a/builtin-clone.c
>> +++ b/builtin-clone.c
>> @@ -350,6 +350,18 @@ static struct ref *write_remote_refs(const struct ref *refs,
>>  	return local_refs;
>>  }
>>  
>> +static void install_branch_config(const char *origin, const char *local,
>> +				  const char *remote)
>
> I would have used a different order (local, origin, remote), but that's 
> okay, I guess.

Ok, here is an incremental that will be squashed.

 builtin-clone.c  |    7 ++++---
 t/t5601-clone.sh |   15 +++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 431c136..c338910 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -350,7 +350,8 @@ static struct ref *write_remote_refs(const struct ref *refs,
 	return local_refs;
 }
 
-static void install_branch_config(const char *origin, const char *local,
+static void install_branch_config(const char *local,
+				  const char *origin,
 				  const char *remote)
 {
 	struct strbuf key = STRBUF_INIT;
@@ -552,7 +553,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head = NULL;
 		option_no_checkout = 1;
 		if (!option_bare)
-			install_branch_config(option_origin, "master",
+			install_branch_config("master", option_origin,
 					      "refs/heads/master");
 	}
 
@@ -582,7 +583,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				      head_points_at->peer_ref->name,
 				      reflog_msg.buf);
 
-			install_branch_config(option_origin, head,
+			install_branch_config(head, option_origin,
 					      head_points_at->name);
 		}
 	} else if (remote_head) {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index fe287d3..44793f2 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -144,4 +144,19 @@ test_expect_success 'clone to an existing path' '
 	test_must_fail git clone src target-5
 '
 
+test_expect_success 'clone a void' '
+	mkdir src-0 &&
+	(
+		cd src-0 && git init
+	) &&
+	git clone src-0 target-6 &&
+	(
+		cd src-0 && test_commit A
+	) &&
+	git clone src-0 target-7 &&
+	# There is no reason to insist they are bit-for-bit
+	# identical, but this test should suffice for now.
+	test_cmp target-6/.git/config target-7/.git/config
+'
+
 test_done
