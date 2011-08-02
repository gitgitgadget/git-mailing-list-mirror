From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/6] git-check-attr should work for relative paths
Date: Tue, 02 Aug 2011 15:02:01 -0700
Message-ID: <7vwrevcw12.fsf@alter.siamese.dyndns.org>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:02:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoN2V-0005vl-8T
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab1HBWCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 18:02:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45450 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755411Ab1HBWCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 18:02:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB6714EB2;
	Tue,  2 Aug 2011 18:02:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bjn9UL172JlAk5qInQ6sbPqkF9I=; b=jpeFeO
	o/G3EhSvHOg2lyTUiNMjNI2MJ0E/rKBZpDrp55PC9vNTNtteF05HVepA8kZtpnXO
	gCMMWgbLcPFDo3Eu9oyu3NrtfAfH327ezK2qVjZ+81ogzQDMnpSj6WctjzzRDDPV
	uT6ZV8o42mqH0UkAXy79XvdUmMe1Hjv7GxCjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oi7MfKAo9IXCv6w8ubj0LPP+tMim0QGB
	GbCVe20rOErKA3WeHvm5X+vcJFLIG/c6UnpEHsjkhuuEsapC/JBo0DJ4UxY6nICA
	Shbbzpabl6CxSdJDv+5MUKWOKY2pubsJLNocM1JAbVDtXmDDSdLHXuRtcEHOQLh2
	DGy0WzGxNNg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76DBB4EB0;
	Tue,  2 Aug 2011 18:02:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE72D4EAD; Tue,  2 Aug 2011
 18:02:02 -0400 (EDT)
In-Reply-To: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Thu, 28 Jul 2011 12:36:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D8FBC68-BD53-11E0-8007-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178516>

A minor compilation fix-up on top, to be squashed when the series is
re-rolled.

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 23a6e07..8155b3d 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -44,7 +44,7 @@ static void output_attr(int cnt, struct git_attr_value *check,
 static void check_attr(const char *prefix, int cnt,
 	struct git_attr_value *check, const char *file)
 {
-	const char *full_path =
+	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
 		if (git_checkattr(full_path, cnt, check))
diff --git a/test-path-utils.c b/test-path-utils.c
index 471406c..3bc20e9 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -36,10 +36,10 @@ int main(int argc, char **argv)
 	}
 
 	if (argc >= 4 && !strcmp(argv[1], "prefix_path")) {
-		int nongit_ok;
-		setup_git_directory_gently(&nongit_ok);
 		char *prefix = argv[2];
 		int prefix_len = strlen(prefix);
+		int nongit_ok;
+		setup_git_directory_gently(&nongit_ok);
 		while (argc > 3) {
 			puts(prefix_path(prefix, prefix_len, argv[3]));
 			argc--;
