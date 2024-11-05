Received: from mailrelay5-3.pub.mailoutpod3-cph3.one.com (mailrelay5-3.pub.mailoutpod3-cph3.one.com [46.30.212.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB220E028
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836763; cv=none; b=GLmrSYICpB4p4bdaDt6+jvQhm44k960e5PbaHkH6KaPD7UW2zAOggdKXTFiWNnxHyjZpGkvLZX3kkxt0NYx0dCm2Yu6bX6AzCbK1b4/3pYwaoYoBxcO5ZpQQLGfZtJCXxtNG1eQVokcU+3nob2DU805JQutW3Q9qQNdbC+Kti3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836763; c=relaxed/simple;
	bh=udAtXYL6/ITEzIFKcWqPtCixDi3ie6KOMSUNODj2AcU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lfG3ReeWcMNSX/M6HIDe0OdNyUx+sh4gN7vGsxBvmL2Xihi0CiaHrfR1Dsfyta8p9ecOdbglPGEV3gRq16nBwDdohrtLrlkbvBir0rgN/2RwENARd62Fi3Xh9QFNRmSFjXzS+B+Vi3YEHHBy5g0RmgIoz+DWvrOJoi2GHfKkhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxsi.org; spf=none smtp.mailfrom=maxsi.org; dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b=CpUrtZ04; dkim=permerror (0-bit key) header.d=maxsi.org header.i=@maxsi.org header.b=f1oFOEbv; arc=none smtp.client-ip=46.30.212.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxsi.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=maxsi.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b="CpUrtZ04";
	dkim=permerror (0-bit key) header.d=maxsi.org header.i=@maxsi.org header.b="f1oFOEbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=maxsi.org; s=rsa1;
	h=content-transfer-encoding:content-type:in-reply-to:references:cc:to:subject:
	 from:mime-version:date:message-id:from;
	bh=S+Zs8/sHND1emNnugFfwvqEMqfXTZECo2k92SP7siTs=;
	b=CpUrtZ04QY7JR0LXg18aiJ/GcMqin85LYwdFH4+fwoWPzovrmufheERdfphVX5eX+I55Soj/0ElmX
	 9OqTbH3qlCXJ/U3iCWA9MFBDAWH8f6X+Op67rGzMr7nEqYsTQzi/S9RbvtX+wiIWjiCyttkEXlaiEx
	 5FOxOsftdDp9WGjuqSBtaDDpDufa982OZoCz71t/+eFA6d2DZs/f3oWRkfcLPGQ9sLFHIerMFJRu0c
	 7erFwHh4l7ZExHNV1j/wJkYauvQeJ0Yei+C5dQCJIC1x+TzrjeBN/DIo4JzzOPR7scOeIQpoPlUdqD
	 IYBQVDbJBEUMTHX23crCtie1oY0qQJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=maxsi.org; s=ed1;
	h=content-transfer-encoding:content-type:in-reply-to:references:cc:to:subject:
	 from:mime-version:date:message-id:from;
	bh=S+Zs8/sHND1emNnugFfwvqEMqfXTZECo2k92SP7siTs=;
	b=f1oFOEbvvIJUeQBTpvxKg4gxvLXNt0xn4wAG9rPEfipA0C8kPcyUa1W4XXyYfXq9Azg+ndRM/+h19
	 JnjyDCYDw==
X-HalOne-ID: 483a8c0f-9bb0-11ef-beea-4d7e77a32f34
Received: from [192.168.87.156] (unknown [85.203.218.213])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 483a8c0f-9bb0-11ef-beea-4d7e77a32f34;
	Tue, 05 Nov 2024 19:58:10 +0000 (UTC)
Message-ID: <9b9ebfb7-9fe4-42fd-8dbc-2de85c5dbe16@maxsi.org>
Date: Tue, 5 Nov 2024 20:58:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH v2] Makefile: don't remove configure on distclean
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqldxxsf4p.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqldxxsf4p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

make distclean conventionally restores the extracted release tarball to
its original distributed contents by cleaning the source code for
distribution. However, the configure script is part of the distribution
and should not be removed. This behavior is creating problems on my
package infrastructure where configure-based packages have make
distclean run afterwards and then the subsequent git build fails.

Add reallyclean for development that also removes configure.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
Yeah -- I was thinking you'd want a reallyclean target or something,
but wasn't sure what to call it. Here's a version with reallyclean:

 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6f5986b66e..b8932e7c2b 100644
--- a/Makefile
+++ b/Makefile
@@ -3693,7 +3693,7 @@ artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
-.PHONY: dist-doc distclean
+.PHONY: dist-doc distclean reallyclean
 dist-doc: git$X
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
@@ -3723,11 +3723,13 @@ dist-doc: git$X
 ### Cleaning rules
 
 distclean: clean
-	$(RM) configure
 	$(RM) config.log config.status config.cache
 	$(RM) config.mak.autogen config.mak.append
 	$(RM) -r autom4te.cache
 
+reallyclean: distclean
+	$(RM) configure
+
 profile-clean:
 	$(RM) $(addsuffix *.gcda,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
-- 
2.45.2

