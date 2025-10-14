Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA0313544
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444778; cv=pass; b=R+Sib/2/LXJeU4fvat9tR0DNDk80vheK0bSY58kUi1hrtyMZqzDyuiLNtx98UCEpNC91C9r+kfmwpKje/T22WlEYzPg+Gyik7WAMhT52W02G7Cr9lHuQV+TjEaGQgVU7mtKEzbYNINUiiAMD7480UjwVC7L9lW0nIT5BZgE3Ppk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444778; c=relaxed/simple;
	bh=GbfUgghimiAErWClwqbn3zw8PZ+aR/s73LbqHj7JBFk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z97BOOEqvtUU7CwVV2ljCtzmMyNHZHwvpmtFj3uNScHhWdK6u3nfLjny/pxMvKbkcSP1umsMYg5W25bZyIKWCVjGpDT8pvb8EG08S/fv1NyYFNDb7ZppWPj6OfzkJ156s/g25T7eM/acwahgfmxVaWTOHchIA2T40P86jr3GW6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Qk+g5+Cf; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Qk+g5+Cf"
ARC-Seal: i=1; a=rsa-sha256; t=1760444726; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N1YmgMAOWrZ8OUKsQHI1UMP1U/t0lMK9rZ20DcpTt9ut9KhyYkNPkMoJ9CY3s7ZQj3+iBPpB/7yHn3naPxP8LUTQleQE7X/2xju3lJF5MPMli0iSngdVNrleidCncVyW4XQV6OQph1oSqE+WhaLCC6hEdH8an5N/TL7ENmjNDts=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444726; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=tGa8lUUXMD+83ipZxvOdWEwQsijOxKapzqRcUOTsXN8=; 
	b=ig4DYB2Z3Pvt6CVfCcI4cAvsQhGn9UQNZowpVslVg40IPW6sdvbu+o1IRaLK0rMnbUO/OMcfEuMfC1fijRPHNBIYTmger9V2zUNJp4libi7HiVkFWMkTnCdTogtddizXWDvntZtY0ybwxoy75xJrIhAMrKcmLE0ljXqjigz4SNg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444726;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=tGa8lUUXMD+83ipZxvOdWEwQsijOxKapzqRcUOTsXN8=;
	b=Qk+g5+CfCGF4YRddL32UXzsJd4I2y96wRiIYwGbvHIhEAIVj9Y7s/yT6u53fx/He
	XbswC/92JwgK5W6yOxQPWL5qmI6tZl+xwp/TwXSk5MmOnnvJl2cGOWgfr0RpQDHjBLj
	iGoTu4DymQm1bdhxA9+sNFMambEHtf5+BEJe6Ct8=
Received: by mx.zohomail.com with SMTPS id 1760444724565233.5707481264045;
	Tue, 14 Oct 2025 05:25:24 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 06/29] interpret-trailers: buffer stdout output
Date: Tue, 14 Oct 2025 20:24:19 +0800
Message-ID: <20251014122452.1851103-7-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Simplified the non-in-place path in interpret_trailers
by writing the existing output strbuf directly to
stdout without creating a redundant temporary buffer.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/interpret-trailers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 2c8b6fc3b9..cdf39dbca8 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -122,7 +122,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		write_file_buf(file, out_buf.buf, out_buf.len);
 	else
-		fwrite(out_buf.buf, 1, out_buf.len, stdout);
+		strbuf_write(&out_buf, stdout);
 
 	strbuf_release(&in_buf);
 	strbuf_release(&out_buf);
-- 
2.51.0

